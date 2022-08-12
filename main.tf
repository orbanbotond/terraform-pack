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
  name   = var.app_name
  region = var.app_region
  stack      = "heroku-20"

  buildpacks = [
    "heroku/nodejs",
    "heroku/ruby"
  ]
}

module "key-value-store" {
  source = "./modules/key-value-store"

  app  = heroku_app.application.id
  plan = var.redis_plan
}

module "relational-db" {
  source = "./modules/database/relational/postgres"

  app  = heroku_app.application.id
  plan = var.postgres_plan
}

module "messagebus" {
  source = "./modules/message-bus/karafka"

  app  = heroku_app.application.id
  plan = var.messagebus_plan
}

module "logging" {
  source = "./modules/loging"

  app  = heroku_app.application.id
  plan = var.logging_plan
}

# Build code & release to the app
resource "heroku_build" "build" {
  app = heroku_app.application.id

  source {
    # url = var.source_code_github_url
    path = "."
  }
}

# Launch the app's web process by scaling-up
resource "heroku_formation" "web_dyno" {
  app        = heroku_app.application.id
  type       = "web"
  quantity   = var.web_dyno_count
  # professional
  # size       = "Standard-1x"
  # hobby
  # size       = "Hobby"
  # Free
  size       = var.web_dyno_plan
  depends_on = [heroku_build.build]
}
