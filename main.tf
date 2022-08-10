provider "heroku" {}

resource "heroku_app" "example" {
  name   = "learn-terraform-heroku-ob"
  region = "us"
}

resource "heroku_addon" "postgres" {
  app  = heroku_app.example.id
  plan = "heroku-postgresql:hobby-dev"
}

resource "heroku_addon" "redis" {
  app  = heroku_app.example.id
  plan = "rediscloud:30"
  # region = "europe"
}

# resource "heroku_addon" "cloudkarafka" {
#   app  = heroku_app.example.id
#   plan = "cloudkarafka:ducky"
# }

# resource "heroku_addon" "mariadb" {
#   app  = heroku_app.example.id
#   plan = "jawsdb-maria:kitefin"
# }

resource "heroku_build" "example" {
  app = heroku_app.example.id

  source {
    path = "./app"
  }

  lifecycle {
    create_before_destroy = true
  }
}

variable "app_quantity" {
  default     = 1
  description = "Number of dynos in your Heroku formation"
}

# Launch the app's web process by scaling-up
resource "heroku_formation" "web_dyno" {
  app        = heroku_app.example.id
  type       = "web"
  quantity   = var.app_quantity
  # professional
  # size       = "Standard-1x"
  # hobby
  # size       = "Hobby"
  # Free
  size       = "Free"
  depends_on = [heroku_build.example]
}

# resource "heroku_formation" "worker_dyno" {
#   app        = heroku_app.example.id
#   type       = "worker"
#   quantity   = var.app_quantity
#   # professional
#   # size       = "Standard-1x"
#   # hobby
#   # size       = "Hobby"
#   # Free
#   size       = "Free"
#   depends_on = [heroku_build.example]
# }