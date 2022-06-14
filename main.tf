module "image" {
  source   = "./image"
  for_each = local.deployment
  image_in = each.value.image
}

module "container" {
  source            = "./container"
  for_each          = local.deployment
  count_in          = each.value.container_count
  name_in           = each.key
  image_in          = module.image[each.key].image_out
  int_port_in       = each.value.internal
  ext_port_in       = each.value.external
  container_path_in = each.value.container_path
  # host_path_in      = "${path.cwd}/noderedvol" # path.cwd with string interpolation will provide the full path for the current directory.
}