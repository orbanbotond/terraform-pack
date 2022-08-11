terraform {
  required_providers {
    heroku = {
      source = "heroku/heroku"
      version = "~> 4.6"
    }
  }
}

provider "heroku" {}

resource "heroku_addon" "cloudkarafka" {
  app  = var.app
  plan = "cloudkarafka:${var.plan}"
}
