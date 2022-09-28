# Pin npm packages by running ./bin/importmap

pin 'application', preload: true
pin 'bulma-calendar', to: 'https://ga.jspm.io/npm:bulma-calendar@6.1.18/dist/js/bulma-calendar.js'
pin 'calendar'
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
