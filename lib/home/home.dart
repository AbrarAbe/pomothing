import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/theme_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isRunning = false;
  int _remainingSeconds = 25 * 60;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: _remainingSeconds),
    );
    _controller.addListener(() {
      if (_controller.isCompleted) {
        setState(() {
          _isRunning = false;
          _remainingSeconds = 25 * 60;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startStopTimer() {
    setState(() {
      if (_isRunning) {
        _controller.stop();
      } else {
        _controller.duration = Duration(seconds: _remainingSeconds);
        _controller.reverse(
          from: _remainingSeconds == 0 ? 1.0 : _controller.value,
        ); // Start from current value
      }
      _isRunning = !_isRunning;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pomodoro Timer'),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_4),
            onPressed: () {
              themeProvider.toogleTheme();
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 200,
                  height: 200,
                  child: CircularProgressIndicator(
                    value: _controller.value,
                    strokeWidth: 10,
                    backgroundColor: colorScheme.primary,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      colorScheme.primaryContainer,
                    ),
                  ),
                ),
                Text(
                  '${(_remainingSeconds ~/ 60).toString().padLeft(2, '0')}:${(_remainingSeconds % 60).toString().padLeft(2, '0')}',
                  style: const TextStyle(fontSize: 30),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (!_isRunning) {
                  _remainingSeconds =
                      (_controller.duration?.inSeconds ?? 0) *
                              (1 - _controller.value)
                          as int;
                } else {
                  _remainingSeconds =
                      (_controller.duration?.inSeconds ?? 0) *
                              (1 - _controller.value)
                          as int;
                }
                _startStopTimer();
              },
              child: Text(_isRunning ? 'Stop' : 'Start'),
            ),
          ],
        ),
      ),
    );
  }
}
