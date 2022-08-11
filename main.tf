terraform {
  required_providers {
    heroku = {
      source = "heroku/heroku"
      version = "~> 4.6"
    }
  }
}

provider "heroku" {}

resource "heroku_app" "application" {
  name   = "learn-terraform-heroku-ob"
  region = "us"

  buildpacks = [
    "heroku/nodejs",
    "heroku/ruby"
  ]
}

module "key-value-store" {
  source = "./modules/key-value-store"

  app  = heroku_app.application.id
  plan = "30"
}

module "relational-db" {
  source = "./modules/database/relational/postgres"

  app  = heroku_app.application.id
  plan = "hobby-dev"
}

module "messagebus" {
  source = "./modules/message-bus/karafka"

  app  = heroku_app.application.id
  plan = "ducky"
}

variable "app_quantity" {
  default     = 1
  description = "Number of dynos in your Heroku formation"
}

# Launch the app's web process by scaling-up
resource "heroku_formation" "web_dyno" {
  app        = heroku_app.application.id
  # type       = "worker"
  type       = "web"
  quantity   = var.app_quantity
  # professional
  # size       = "Standard-1x"
  # hobby
  # size       = "Hobby"
  # Free
  size       = "Free"
}
