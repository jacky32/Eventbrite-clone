import bulmaCalendar from "bulma-calendar";

const startDateElement = document.querySelector("#start_date");
const endDateElement = document.querySelector("#end_date");

const startDateValue = startDateElement.value;
const endDateValue = endDateElement.value;

const convertToDate = (value) => {
  const convertedDate = value.slice(0, 10) + "T" + value.slice(11, 19);
  return new Date(convertedDate);
};

const isValidDate = (d) => {
  return d instanceof Date && !isNaN(d);
};

const startDate = convertToDate(startDateValue);
const endDate = convertToDate(endDateValue);

// get yesterday's date
const today = new Date(Date.now());
const yesterday = new Date();
yesterday.setDate(today.getDate() - 1);

let calendars;
if (isValidDate(endDate)) {
  calendars = bulmaCalendar.attach('[type="datetime"]', {
    dateFormat: "dd/MM/yyyy",
    headerPosition: "top",
    weekStart: 1,
    minuteSteps: 1,
    validateLabel: "Save",
    minDate: yesterday,
    disabledDates: [yesterday],
    startDate: startDate,
    startTime: startDate,
    endDate: endDate,
    endTime: endDate,
    isRange: true,
    showTodayButton: false,
  });
} else {
  calendars = bulmaCalendar.attach('[type="datetime"]', {
    dateFormat: "dd/MM/yyyy",
    headerPosition: "top",
    weekStart: 1,
    minuteSteps: 1,
    validateLabel: "Save",
    minDate: yesterday,
    disabledDates: [yesterday],
    startDate: startDate,
    startTime: startDate,
    isRange: true,
    showTodayButton: false,
  });
}

// Loop on each calendar initialized
calendars.forEach((calendar) => {
  calendar.on("save", () => {
    startDateElement.value = calendar.startDate;
    endDateElement.value = calendar.endDate;
  });
  calendar.on("hide", () => {
    calendar.save(); //sometimes saves twice
  });
});
