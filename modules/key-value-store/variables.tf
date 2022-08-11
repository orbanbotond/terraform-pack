# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# You must provide a value for each of these parameters.
# ---------------------------------------------------------------------------------------------------------------------

variable "plan" {
  description = "Name of the Heroku Redis plan to use"
  type        = string
}

variable "app" {
  description = "Name of the Heroku app to which to attach the Redis add-on"
  type        = string
}
