# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "jquery", to: "https://cdn.jsdelivr.net/npm/jquery@3.x.x/dist/jquery.min.js"
pin "bootstrap-datepicker", to: "https://unpkg.com/bootstrap-datepicker@1.10.0/dist/js/bootstrap-datepicker.min.js"
pin "flatpickr", to: "https://cdn.jsdelivr.net/npm/flatpickr@latest/dist/flatpickr.min.js"