import 'package:flutter/material.dart';
import '../models/task.dart';
import '../theme/app_colors.dart';

class TaskFormScreen extends StatefulWidget {
  const TaskFormScreen({super.key});

  @override
  State<TaskFormScreen> createState() => _TaskFormScreenState();
}

class _TaskFormScreenState extends State<TaskFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();

  DateTime? _selectedDate;
  String? _dateError;

  int? _selectedPriority;
  String? _priorityError;

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  void _selectPriority(int value) {
    setState(() {
      _selectedPriority = value;
      _priorityError = null;
    });
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now,
      firstDate: DateTime(now.year - 1),
      lastDate: DateTime(now.year + 5),
      locale: const Locale('es'),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
        _dateError = null;
      });
    }
  }

  void _submit() {
    final isFormValid = _formKey.currentState!.validate();
    final isDateValid = _selectedDate != null;
    final isPriorityValid = _selectedPriority != null;

    setState(() {
      _dateError = isDateValid ? null : 'Selecciona una fecha límite';
      _priorityError = isPriorityValid ? null : 'Selecciona una prioridad';
    });

    if (!isFormValid || !isDateValid || !isPriorityValid) {
      return;
    }

    final newTask = Task(
      title: _titleController.text.trim(),
      dueDate: _selectedDate!,
      priority: _selectedPriority!,
    );

    Navigator.pop(context, newTask);
  }

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    return '$day/$month/${date.year}';
  }

  Widget _buildPriorityButton(int value) {
    final isSelected = _selectedPriority == value;
    return GestureDetector(
      onTap: () => _selectPriority(value),
      child: CircleAvatar(
        radius: 24,
        backgroundColor:
            isSelected ? AppColors.uniandesBlue : Colors.grey[300],
        foregroundColor: isSelected ? Colors.white : AppColors.uniandesBlue,
        child: Text(
          '$value',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nueva tarea')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Título de la tarea',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'El título es obligatorio';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? 'Sin fecha seleccionada'
                          : 'Fecha: ${_formatDate(_selectedDate!)}',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton.icon(
                    onPressed: _pickDate,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.uniandesBlue,
                      foregroundColor: Colors.white,
                    ),
                    icon: const Icon(Icons.calendar_month),
                    label: const Text('Elegir fecha'),
                  ),
                ],
              ),
              if (_dateError != null)
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(
                    _dateError!,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                      fontSize: 12,
                    ),
                  ),
                ),
              const SizedBox(height: 20),
              Text(
                'Prioridad (1 a 5)',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [1, 2, 3, 4, 5]
                    .map((value) => _buildPriorityButton(value))
                    .toList(),
              ),
              if (_priorityError != null)
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(
                    _priorityError!,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                      fontSize: 12,
                    ),
                  ),
                ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.uniandesYellow,
                    foregroundColor: AppColors.uniandesBlue,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text('Guardar tarea'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
