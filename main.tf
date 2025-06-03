module "tools" {
  source         = "./app"
  for_each       = var.tools
  instance_type  = each.value["instance_type"]
  tag_name       = each.key

}