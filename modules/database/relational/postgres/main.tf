terraform {
  required_providers {
    heroku = {
      source = "heroku/heroku"
      version = "~> 4.6"
    }
  }
}

provider "heroku" {}

resource "heroku_addon" "postgres" {
  app  = var.app
  plan = "heroku-postgresql:${var.plan}"
}
