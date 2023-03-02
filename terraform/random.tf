resource "random_string" "random_str_5" {
  length      = 5
  special     = false
  lower       = true
  upper       = false
  min_numeric = 5
}
