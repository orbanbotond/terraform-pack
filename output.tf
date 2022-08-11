output "app_url" {
  value       = heroku_app.application.web_url
  description = "Application URL"
}
