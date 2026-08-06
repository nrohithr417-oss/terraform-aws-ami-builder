########################################
# EC2 Image Builder Component
########################################

resource "aws_imagebuilder_component" "software_installation" {
  name        = local.image_component_name
  platform    = "Linux"
  version     = var.component_version
  description = "Installs and configures required DevOps software"

  data = yamlencode({
    name          = "InstallDevOpsTools"
    description   = "Install Docker, Docker Compose, Terraform, Nginx, Certbot, OpenSSL, and SSM Agent"
    schemaVersion = 1.0

    phases = [
      {
        name = "build"

        steps = [
          {
            name      = "UpdateOperatingSystem"
            action    = "ExecuteBash"
            onFailure = "Abort"

            inputs = {
              commands = [
                "export DEBIAN_FRONTEND=noninteractive",
                "apt-get update -y",
                "apt-get upgrade -y"
              ]
            }
          },
          {
            name      = "InstallBasePackages"
            action    = "ExecuteBash"
            onFailure = "Abort"

            inputs = {
              commands = [
                "export DEBIAN_FRONTEND=noninteractive",
                "apt-get install -y ca-certificates curl gnupg lsb-release unzip jq software-properties-common apt-transport-https"
              ]
            }
          },
          {
            name      = "InstallDocker"
            action    = "ExecuteBash"
            onFailure = "Abort"

            inputs = {
              commands = [
                "install -m 0755 -d /etc/apt/keyrings",
                "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg",
                "chmod a+r /etc/apt/keyrings/docker.gpg",
                "echo \"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo $VERSION_CODENAME) stable\" > /etc/apt/sources.list.d/docker.list",
                "apt-get update -y",
                "apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin",
                "systemctl enable docker",
                "systemctl start docker"
              ]
            }
          },
          {
            name      = "InstallTerraform"
            action    = "ExecuteBash"
            onFailure = "Abort"

            inputs = {
              commands = [
                "curl -fsSL https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg",
                "echo \"deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(. /etc/os-release && echo $VERSION_CODENAME) main\" > /etc/apt/sources.list.d/hashicorp.list",
                "apt-get update -y",
                "apt-get install -y terraform"
              ]
            }
          },
          {
            name      = "InstallNginxAndSSLTools"
            action    = "ExecuteBash"
            onFailure = "Abort"

            inputs = {
              commands = [
                "export DEBIAN_FRONTEND=noninteractive",
                "apt-get install -y nginx certbot python3-certbot-nginx openssl",
                "systemctl enable nginx",
                "systemctl start nginx"
              ]
            }
          },
          {
            name      = "ConfigureSSMAgent"
            action    = "ExecuteBash"
            onFailure = "Abort"

            inputs = {
              commands = [
                "if command -v snap >/dev/null 2>&1; then snap install amazon-ssm-agent --classic || true; fi",
                "if systemctl list-unit-files | grep -q amazon-ssm-agent; then systemctl enable amazon-ssm-agent; systemctl start amazon-ssm-agent; fi",
                "if systemctl list-unit-files | grep -q snap.amazon-ssm-agent.amazon-ssm-agent.service; then systemctl enable snap.amazon-ssm-agent.amazon-ssm-agent.service; systemctl start snap.amazon-ssm-agent.amazon-ssm-agent.service; fi"
              ]
            }
          },
          {
            name      = "ApplyBasicHardening"
            action    = "ExecuteBash"
            onFailure = "Abort"

            inputs = {
              commands = [
                "sed -i 's/^#\\?PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config",
                "sed -i 's/^#\\?PasswordAuthentication.*/PasswordAuthentication no/' /etc/ssh/sshd_config",
                "chmod 600 /etc/ssh/sshd_config",
                "systemctl restart ssh || systemctl restart sshd",
                "apt-get autoremove -y",
                "apt-get clean",
                "rm -rf /var/lib/apt/lists/*",
                "rm -rf /tmp/*"
              ]
            }
          }
        ]
      },
      {
        name = "validate"

        steps = [
          {
            name      = "ValidateInstalledSoftware"
            action    = "ExecuteBash"
            onFailure = "Abort"

            inputs = {
              commands = [
                "docker --version",
                "docker compose version",
                "terraform version",
                "nginx -v",
                "certbot --version",
                "openssl version",
                "systemctl is-enabled docker",
                "systemctl is-enabled nginx"
              ]
            }
          }
        ]
      },
      {
        name = "test"

        steps = [
          {
            name      = "TestServices"
            action    = "ExecuteBash"
            onFailure = "Abort"

            inputs = {
              commands = [
                "systemctl is-active docker",
                "systemctl is-active nginx",
                "curl --fail --silent http://localhost >/dev/null",
                "terraform version >/dev/null",
                "docker compose version >/dev/null"
              ]
            }
          }
        ]
      }
    ]
  })

  tags = local.common_tags
}