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
  minuteSteps: 1,
  validateLabel: "Save",
  minDate: yesterday,
  disabledDates: [yesterday],
  startDate: today,
  startTime: today,
  isRange: true,
  showTodayButton: false,
});

// Loop on each calendar initialized
calendars.forEach((calendar) => {
  const startDateElement = document.querySelector("#start_date");
  const endDateElement = document.querySelector("#end_date");
  calendar.on("save", () => {
    startDateElement.value = calendar.startDate;
    endDateElement.value = calendar.endDate;
  });
  calendar.on("hide", () => {
    calendar.save(); //sometimes saves twice
  });
});
