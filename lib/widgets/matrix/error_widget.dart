import 'package:flutter/material.dart';

import 'package:talktsy/utils/error_reporter.dart';

class TalktsyErrorWidget extends StatefulWidget {
  final FlutterErrorDetails details;
  const TalktsyErrorWidget(this.details, {super.key});

  @override
  State<TalktsyErrorWidget> createState() => _TalktsyErrorWidgetState();
}

class _TalktsyErrorWidgetState extends State<TalktsyErrorWidget> {
  static final Set<String> knownExceptions = {};
  @override
  void initState() {
    super.initState();

    if (knownExceptions.contains(widget.details.exception.toString())) {
      return;
    }
    knownExceptions.add(widget.details.exception.toString());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ErrorReporter(context, 'Error Widget').onErrorCallback(
        widget.details.exception,
        widget.details.stack,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.orange,
      child: Placeholder(
        child: Center(
          child: Material(
            color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
