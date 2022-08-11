# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# You must provide a value for each of these parameters.
# ---------------------------------------------------------------------------------------------------------------------

variable "app_name" {
  description = "Name of the Application"
  type        = string
}

variable "app_region" {
  description = "Region of the Application"
  default     = "eu"
  type        = string
}

variable "redis_plan" {
  description = "Name of the Redis plan"
  default     = "30"
  type        = string
}

variable "postgres_plan" {
  description = "Name of the Postgres plan"
  default     = "hobby-dev"
  type        = string
}

variable "messagebus_plan" {
  description = "Name of the MessageBus plan"
  default     = "ducky"
  type        = string
}

variable "web_dyno_plan" {
  description = "Name of the Dyno plan"
  default     = "Free"
  type        = string
}

variable "web_dyno_count" {
  default     = 1
  description = "Number of dynos in your Heroku formation"
}

variable "source_code_github_url" {
  type     = string
  description = "The url of the source code"
}
