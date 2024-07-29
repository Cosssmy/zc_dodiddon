import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../screens/all_tasks.dart';
import '../theme/theme.dart';
import '../screens/profile.dart'; // Импортируем ProfilePage

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    TaskPage(),
    Text('Сегодня'),
    Text('Выполнено'),
    ProfilePage(), // Заменяем Text на ProfilePage
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Функция для показа диалогового окна
  void _showAddTaskDialog() {
    // Контроллеры для ввода данных
    final _titleController = TextEditingController();
    final _descriptionController = TextEditingController();
    final _deadlineController = TextEditingController();
    DateTime? _selectedDeadline;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Добавить задачу'),
          content: Form(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: 'Название задачи',
                  ),
                ),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Описание',
                  ),
                ),
                // Поле для ввода дедлайна
                TextFormField(
                  controller: _deadlineController,
                  decoration: const InputDecoration(
                    labelText: 'Дедлайн',
                  ),
                  readOnly: true,
                  onTap: () async {
                    // Вызов showDateTimePicker
                    _selectedDeadline = await showDateTimePicker(context);
                    // Обновление контроллера дедлайна
                    if (_selectedDeadline != null) {
                      _deadlineController.text = DateFormat('dd.MM.yy HH:mm')
                          .format(_selectedDeadline!);
                    }
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Закрыть диалоговое окно
              },
              child: const Text('Отмена'),
            ),
            TextButton(
              onPressed: () {
                // Обработать ввод данных и добавить задачу
                // ... (добавить задачу с использованием _titleController, _descriptionController, _selectedDeadline)
                Navigator.of(context).pop(); // Закрыть диалоговое окно
              },
              child: const Text('Добавить'),
            ),
          ],
        );
      },
    );
  }

  // Функция для показа диалогового окна выбора даты и времени
  Future<DateTime?> showDateTimePicker(BuildContext context) async {
    final ThemeData datePickerTheme = ThemeData.light().copyWith(
      colorScheme: ColorScheme.light(
        primary: Color.fromARGB(255, 224, 177, 255),
        onPrimary: Colors.black,
        surface: Colors.white,
        onSurface: Colors.black,
      ),
      dialogBackgroundColor: Colors.white,
    );

    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: datePickerTheme,
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(pickedDate),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: datePickerTheme,
            child: child!,
          );
        },
      );

      if (pickedTime != null) {
        return DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
      }
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              DoDidDoneTheme.lightTheme.colorScheme.primary,
              DoDidDoneTheme.lightTheme.colorScheme.secondary,
            ],
          ),
        ),
        child: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.task_alt),
            label: 'Задачи',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Сегодня',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle),
            label: 'Выполнено',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Профиль',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
