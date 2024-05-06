// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener("DOMContentLoaded", function() {
  setTimeout(function() {
    document.querySelectorAll('.alert').forEach(function(alert) {
      alert.style.display = 'none';
    });
  }, 3500);
});