resource "time_static" "main" {
  triggers = {
    expiration_start_date = var.expiration_start_date
  }
}