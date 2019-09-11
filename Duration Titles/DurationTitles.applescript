var of = Application('OmniFocus');

var doc = of.defaultDocument;

var today = new Date();
var dueDate = new Date(today.setDate(today.getDate()+7));
var taskList = [];
var flattenedTasks = doc.flattenedTasks.whose({effectivelyCompleted: false, effectivelyDropped: false});

flattenedTasks().forEach(function(task){
  var splitString = task.name().split(" || ");
  var unit = "";
  if (task.estimatedMinutes() !== null) {
    if (task.estimatedMinutes() > 1){
      unit = " || " + task.estimatedMinutes() + " mins";
    } else {
      unit = " || 1 min";
    }
  }
  var newTitle = splitString[0] + unit;
  task.name = newTitle;
});

of.synchronize();