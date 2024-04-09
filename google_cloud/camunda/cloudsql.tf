resource "google_sql_database_instance" "camunda-db" {
  name             = "camunda-db-postgres"
  database_version = "POSTGRES_11"
  region           = local.config.region

  settings {
    # Very small instance for testing.
    tier = "db-f1-micro"
    ip_configuration {
        ipv4_enabled = true
    # Drata: Ensure that SQL database instance is not publicly accessible by giving it a private IP. Define [google_sql.sql_database_instance.settings.ip_configuration.private_network] to use private IPs while connecting to SQL database instance
    }
  }
}

resource "google_sql_user" "user" {
  name     = "camunda"
  instance = google_sql_database_instance.camunda-db.name
  password = "futurice"
}

resource "google_sql_database" "database" {
  name     = "camunda"
  instance = google_sql_database_instance.camunda-db.name
}
