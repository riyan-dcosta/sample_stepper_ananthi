import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WidgetValueLoader<T> extends ConsumerWidget {
  final ProviderBase<AsyncValue<T>> value;
  final Widget Function(T) data;
  final Widget Function() loadingBuilder;
  final Widget Function(Object?, StackTrace?)? errorBuilder;

  const WidgetValueLoader({
    super.key,
    required this.value,
    required this.data,
    required this.loadingBuilder,
    this.errorBuilder,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue = ref.watch(value);

    return asyncValue.when(
      data: data,
      loading: () => const CircularProgressIndicator(),
      error: (error, stackTrace) {
        if (errorBuilder != null) {
          return errorBuilder!(error, stackTrace);
        } else {
          // Handle the error here.
          // For example, you could show a dialog to the user with the error message.
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Error'),
                content: Text(error.toString()),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('OK'),
                  ),
                ],
              ));
          return Text('Error: $error');
        }
      },
    );
  }
}
