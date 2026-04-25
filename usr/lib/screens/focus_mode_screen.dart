import 'dart:async';
import 'package:flutter/material.dart';

class FocusModeScreen extends StatefulWidget {
  const FocusModeScreen({super.key});

  @override
  State<FocusModeScreen> createState() => _FocusModeScreenState();
}

class _FocusModeScreenState extends State<FocusModeScreen> {
  static const int _defaultStudyTime = 25 * 60; // 25 minutes in seconds
  int _timeLeft = _defaultStudyTime;
  bool _isRunning = false;
  Timer? _timer;
  
  void _startTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }
    setState(() {
      _isRunning = true;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeLeft > 0) {
          _timeLeft--;
        } else {
          _timer!.cancel();
          _isRunning = false;
          _showBreakDialog();
        }
      });
    });
  }

  void _pauseTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }
    setState(() {
      _isRunning = false;
    });
  }

  void _resetTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }
    setState(() {
      _isRunning = false;
      _timeLeft = _defaultStudyTime;
    });
  }

  void _showBreakDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Great Job! 🎉'),
        content: const Text('You completed your focus session. Time for a short 5-minute break.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {
                _timeLeft = 5 * 60; // 5 min break
                _startTimer();
              });
            },
            child: const Text('Start Break'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _resetTimer();
            },
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }

  String get _timerString {
    int minutes = _timeLeft ~/ 60;
    int seconds = _timeLeft % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Focus Mode'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Stay Focused',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w500,
                    ),
              ),
              const SizedBox(height: 48),
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 250,
                    height: 250,
                    child: CircularProgressIndicator(
                      value: _timeLeft / _defaultStudyTime,
                      strokeWidth: 12,
                      backgroundColor: Colors.grey[200],
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  Text(
                    _timerString,
                    style: const TextStyle(
                      fontSize: 64,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 64),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FloatingActionButton.large(
                    heroTag: 'reset_btn',
                    onPressed: _resetTimer,
                    backgroundColor: Colors.grey[200],
                    elevation: 0,
                    child: const Icon(Icons.refresh, color: Colors.black54),
                  ),
                  FloatingActionButton.large(
                    heroTag: 'play_pause_btn',
                    onPressed: _isRunning ? _pauseTimer : _startTimer,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    child: Icon(
                      _isRunning ? Icons.pause : Icons.play_arrow,
                      size: 36,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Icon(Icons.info_outline, color: Theme.of(context).colorScheme.secondary),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Pomodoro Technique: Focus for 25 mins, then take a 5 min break to maximize retention.',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
