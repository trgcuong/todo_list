import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_log.dart';

class AppBlocObserver extends BlocObserver{
  @override
  void onChange(BlocBase bloc, Change change) {
    AppLog.i(change);
    super.onChange(bloc, change);
  }
  @override
  void onEvent(Bloc bloc, Object? event) {
    AppLog.i(event);
    super.onEvent(bloc, event);
  }
}