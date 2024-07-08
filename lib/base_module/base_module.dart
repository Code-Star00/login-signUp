import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class BaseScreen<T extends BaseViewModel> extends StatelessWidget {
  const BaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      create: (context) {
        final vm = createViewModel(context);
        vm.initContext(context);
        return vm;
      },
      lazy: setLazyInit,
      builder: (BuildContext context, Widget? child) => buildScreen(context),
    );
  }

  @protected
  Widget buildScreen(BuildContext context);

  @protected
  bool get setLazyInit => false;

  @protected
  T vm(BuildContext context) => Provider.of<T>(context, listen: false);

  @protected
  T vmR(BuildContext context) => context.read<T>();

  @protected
  T vmW(BuildContext context) => context.watch<T>();

  @protected
  S vmS<S>(BuildContext context, S Function(T) selector) {
    return context.select((T value) => selector(value));
  }

  @protected
  T createViewModel(BuildContext context);
}

abstract class BaseConsumer<T extends BaseViewModel> extends StatelessWidget {
  const BaseConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<T>(
      builder: (context, value, child) => buildScreen(context, value),
    );
  }

  @protected
  Widget buildScreen(BuildContext context, T data);

  @protected
  bool get setLazyInit => false;

  @protected
  T vm(BuildContext context) => Provider.of<T>(context, listen: false);

  @protected
  T vmR(BuildContext context) => context.read<T>();

  @protected
  T vmW(BuildContext context) => context.watch<T>();

  @protected
  S vmS<S>(BuildContext context, S Function(T) selector) {
    return context.select((T value) => selector(value));
  }

  @protected
  T createViewModel(BuildContext context);
}

abstract class BaseView<T extends BaseViewModel> extends StatelessWidget {
  const BaseView({super.key});

  @protected
  T vm(BuildContext context) => Provider.of<T>(context, listen: false);

  @protected
  T vmR(BuildContext context) => context.read<T>();

  @protected
  T vmW(BuildContext context) => context.watch<T>();

  @protected
  S vmS<S>(BuildContext context, S Function(T) selector) {
    return context.select((T value) => selector(value));
  }
}

abstract class BaseViewModel extends ChangeNotifier {
  BaseViewModel() {
    onInit();
  }

  late BuildContext context;

  @override
  void dispose() {
    onDispose();
    super.dispose();
  }

  @protected
  void onInit() {}

  @protected
  void onDispose() {}

  void initContext(BuildContext contextArg) {
    context = contextArg;
  }
}
