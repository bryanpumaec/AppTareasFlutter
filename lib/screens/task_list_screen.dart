import 'package:flutter/material.dart';
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

  Future<void> _addTask() async {
    final newTask = await Navigator.push<Task>(
      context,
      MaterialPageRoute(builder: (context) => const TaskFormScreen()),
    );

    if (newTask != null) {
      setState(() {
        _tasks.add(newTask);
      });
    }
  }

  void _showTaskInfo(Task task) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Tarea: ${task.title} • Fecha: ${task.formattedDate} • Prioridad: ${task.priority}',
        ),
        backgroundColor: AppColors.uniandesBlue,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tareas Uniandes')),
      body: _tasks.isEmpty
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
                  margin:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: AppColors.priorityColor(task.priority),
                      foregroundColor: Colors.white,
                      child: Text(
                        '${task.priority}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
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
