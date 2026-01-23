// toast.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:global_repository/src/screen_adaptor/view_metric.dart';
import 'package:global_repository/src/widgets/safearea_fix.dart';

@Deprecated('Use Toast.show instead')
void showToast(
  String message, {
  Duration duration = const Duration(milliseconds: 1000),
}) {
  Toast.show(
    message,
    duration: duration,
  );
}

class Toast {
  static void show(
    String message, {
    Duration duration = const Duration(milliseconds: 1000),
  }) {
    final overlay = ToastOverlayHost.overlay;
    if (overlay == null) {
      throw FlutterError('ToastOverlayHost not mounted');
    }

    final entry = ToastEntry(message: message).build();

    overlay.insert(entry);

    Future.delayed(duration).then((_) {
      Future.delayed(const Duration(milliseconds: 800), () {
        entry.remove();
      });
    });
  }
}

class ToastEntry {
  ToastEntry({required this.message});

  final String message;

  OverlayEntry build() {
    return OverlayEntry(
      builder: (context) {
        final width = MediaQuery.of(context).size.width;

        return Positioned(
          bottom: context.w(64),
          width: width,
          child: SafeAreaFix(
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(context.w(12)),
                child: Material(
                  color: const Color(0xff303030),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.w(16),
                      vertical: context.w(8),
                    ),
                    child: Text(
                      message,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: context.w(16),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class ToastOverlayHost extends StatefulWidget {
  const ToastOverlayHost({super.key, required this.child});

  final Widget child;

  static OverlayState? overlay;

  @override
  State<ToastOverlayHost> createState() => _ToastOverlayHostState();
}

class _ToastOverlayHostState extends State<ToastOverlayHost> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ToastOverlayHost.overlay ??= Overlay.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Overlay(
      initialEntries: [
        OverlayEntry(
          builder: (_) => widget.child,
        ),
      ],
    );
  }
}
