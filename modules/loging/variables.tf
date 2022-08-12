# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# You must provide a value for each of these parameters.
# ---------------------------------------------------------------------------------------------------------------------

variable "plan" {
  description = "Name of the Logging plan to use"
  default     = "choklad"
  type        = string
}

variable "app" {
  description = "Name of the Heroku app to which to attach the Logging add-on"
  type        = string
}
