import 'package:hive/hive.dart';
import 'package:salakhana_project/Model/task.dart';

class TaskController {

  // =========================
  // Hive Box Access
  // =========================
  Box<Task> get box => Hive.box<Task>('taskBox');

  // List of tasks for CURRENT USER ONLY
  List<Task> todolist = [];

  // stores logged in user email
  String currentUserEmail = "";

  // =========================
  // FILTERED VIEWS
  // =========================

  List<Task> get habitTasks =>
      todolist.where((t) => t.isHabit).toList();

  List<Task> get normalTasks =>
      todolist.where((t) => !t.isHabit).toList();

  // =========================
  // LOAD USER DATA
  // =========================
  void loadData(String userEmail) {

    // save current logged in user
    currentUserEmail = userEmail;

    // load ONLY tasks for this user
    todolist = box.values
        .where((t) => t.userEmail == userEmail)
        .toList();
  }

  int _getRealIndex(Task task) {
    return box.values.toList().indexOf(task);
  }

  // =========================
  // ADD TASK
  // =========================
  void addTask(Task task) {

    box.add(task);

    // reload tasks for same user
    loadData(task.userEmail);
  }

  // =========================
  // UPDATE TASK
  // =========================
/*  void updateTask(Task updatedTask, String userEmail) {

    final allTasks = box.values.toList().cast<Task>();
    final userTasks =
        allTasks.where((task) => task.userEmail == userEmail).toList();
    final realIndex = allTasks.indexOf(userTasks[updatedTask]);

    box.putAt(realIndex, updatedTask);

    // reload data for same user
    loadData(userEmail);
  }*/

  void updateTask(Task oldTask, Task updatedTask, String userEmail) {

    final index = _getRealIndex(oldTask);

    box.putAt(index, updatedTask);

    loadData(userEmail);
  }

  // =========================
  // DELETE TASK
  // =========================
  void deleteTask(Task task, String userEmail) {
    final index = _getRealIndex(task);

    box.deleteAt(index);
    loadData(userEmail);
  }

  // TOGGLE DONE

  void toggleTask(Task task, String userEmail) {
    final index = _getRealIndex(task);

    task.isDone = !task.isDone;

    if (task.isHabit) {
      task.lastCompletedDate =
          task.isDone ? DateTime.now() : null;
    }

    box.putAt(index, task);

    loadData(userEmail);
    
  }
  // RESET HABITS DAILY
  void resetHabits() {

    final today = DateTime.now();
    final allTasks =
    box.values.where((t) => t.userEmail == currentUserEmail).toList();

    for (int i = 0; i < allTasks.length; i++) {

      final task = allTasks[i];

      // reset ONLY current user's habits
      if (task.isHabit && task.userEmail == currentUserEmail) {

        final last = task.lastCompletedDate;

        final isDifferentDay =
            last == null ||
            last.day != today.day ||
            last.month != today.month ||
            last.year != today.year;

        if (isDifferentDay) {

          task.isDone = false;

          box.putAt(i, task);

        }
      }
    }

    loadData(currentUserEmail);
  }

}