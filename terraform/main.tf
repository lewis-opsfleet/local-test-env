provider "vault" {
  address = "http://127.0.0.1:8200"
  version = "~> 2.9.0"
}

resource "vault_mount" "database" {
  path                      = "database"
  type                      = "database"
}

resource "vault_database_secret_backend_connection" "mysql" {
  allowed_roles = ["service-write", "dev-read"]
  backend       = vault_mount.database.path
  name          = "postgres-secret-backend"

  // Needed as SSL is disabled on postgres Docker container
  verify_connection = false

}