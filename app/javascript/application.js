// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import bulmaCalendar from "bulma-calendar";

// get tommorow's date
const today = new Date(Date.now());
const tommorow = new Date();
const yesterday = new Date();
yesterday.setDate(today.getDate() - 1);
tommorow.setDate(today.getDate() + 1);

const calendars = bulmaCalendar.attach('[type="datetime"]', {
  dateFormat: "dd/MM/yyyy",
  headerPosition: "top",
  weekStart: 1,
  minuteSteps: 15,
  minDate: yesterday,
  disabledDates: [yesterday],
  startDate: tommorow,
  endDate: tommorow,
  isRange: true,
  showTodayButton: false,
});

// Loop on each calendar initialized
calendars.forEach((calendar) => {
  calendar.on("save", () => {
    console.log(calendar.startDate);
    console.log(calendar.endDate);
  });
  calendar.on("hide", () => {
    calendar.save(); //sometimes saves twice
  });
});

// To access to bulmaCalendar instance of an element
const element = document.querySelector("#my-element");
if (element) {
  // bulmaCalendar instance is available as element.bulmaCalendar
  element.bulmaCalendar.on("select", (datepicker) => {
    console.log(datepicker.data.startDate());
    console.log(datepicker.data.endDate());
  });
}
