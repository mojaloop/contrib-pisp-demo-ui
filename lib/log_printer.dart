import 'package:logger/logger.dart';

class SimpleLogPrinter extends LogPrinter {
  SimpleLogPrinter(this.className);

  final String className;
  @override
  void log(Level level, dynamic message, dynamic error, StackTrace stackTrace) {
    final color = PrettyPrinter.levelColors[level];
    final String emoji = PrettyPrinter.levelEmojis[level];
    println(color('$emoji $className - $message'));
  }
}

Logger getLogger(String className) {
  return Logger(printer: SimpleLogPrinter(className));
}
