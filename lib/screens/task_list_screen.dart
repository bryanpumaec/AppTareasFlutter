import 'package:flutter/material.dart';
import '../db/task_database.dart';
import '../models/task.dart';
import '../theme/app_colors.dart';
import 'task_form_screen.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final List<Task> _tasks = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final tasks = await TaskDatabase.instance.getTasks();
    setState(() {
      _tasks
        ..clear()
        ..addAll(tasks);
      _isLoading = false;
    });
  }

  Future<void> _addTask() async {
    final newTask = await Navigator.push<Task>(
      context,
      MaterialPageRoute(builder: (context) => const TaskFormScreen()),
    );

    if (newTask != null) {
      final savedTask = await TaskDatabase.instance.insertTask(newTask);
      setState(() {
        _tasks.insert(0, savedTask);
      });
    }
  }

  void _showTaskInfo(Task task) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 1),
        content: Text(
          'Tarea: ${task.title} • Fecha: ${task.formattedDate} • Prioridad: ${task.priority}',
        ),
        backgroundColor: Colors.lightGreen,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tareas Uniandes | Bryan Puma')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _tasks.isEmpty
              ? const Center(
                  child: Padding(
                    padding: EdgeInsets.all(24),
                    child: Text(
                      'No hay tareas registradas.\nToca el botón + para agregar una.',
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: _tasks.length,
                  itemBuilder: (context, index) {
                    final task = _tasks[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor:
                              AppColors.priorityColor(task.priority),
                          foregroundColor: Colors.white,
                          child: Text(
                            '${task.priority}',
                            style:
                                const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        title: Text(task.title),
                        subtitle: Text(
                          'Fecha: ${task.formattedDate} • Prioridad: ${task.priority}',
                        ),
                        onTap: () => _showTaskInfo(task),
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTask,
        tooltip: 'Agregar tarea',
        child: const Icon(Icons.add),
      ),
    );
  }
}
