locals {
  triggers = (length(var.triggers) > 0 ? var.triggers : { always_run = timestamp() })
}

module "shell-escape" {
  source  = "Invicton-Labs/shell-escape/null"
  version = "0.1.0"
  
  string = <<EOF
#!/bin/bash
cd ${var.working_dir}
${var.command}
EOF
}

resource "random_string" "this" {
  keepers = local.triggers

  length  = 16
  special = false
}

locals {
  script  = module.shell-escape.unix
  file    = "${random_string.this.result}.sh"
}

resource "null_resource" "this" {
  triggers = local.triggers
  
  provisioner "local-exec" {
    command = "echo \"${local.script}\" > ./${local.file}"
  }
  provisioner "local-exec" {
    command = "chmod +x ${local.file}"
  }
  provisioner "local-exec" {
    command = "./${local.file}"
  }
  provisioner "local-exec" {
    command = "rm ./${local.file}"
  }
}