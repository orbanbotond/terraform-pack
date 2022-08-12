terraform {
  required_providers {
    heroku = {
      source = "heroku/heroku"
      version = "~> 4.6"
    }
  }
}

provider "heroku" {}

resource "heroku_addon" "papertrail" {
  app  = var.app
  plan = "papertrail:${var.plan}"
}
