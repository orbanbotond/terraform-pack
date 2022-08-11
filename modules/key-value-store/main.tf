terraform {
  required_providers {
    heroku = {
      source = "heroku/heroku"
      version = "~> 4.6"
    }
  }
}

provider "heroku" {}

resource "heroku_addon" "redis" {
  app  = var.app
  plan = "rediscloud:${var.plan}"
}
