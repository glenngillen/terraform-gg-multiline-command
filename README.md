# Multiline Command

Ever want to use the `local-exec` provisioner with Terraform, but you want 
to chain multiple lines of commands together? This is the module for you!

## Usage

```hcl
module "build" {
  source            = "glenngillen/multiline-command/gg"
  version           = "1.0.2"

  working_dir = "my/build/dir"
  command     = <<EOF
echo "hello world"
cd foo/bar
ls -al
EOF

}
```
