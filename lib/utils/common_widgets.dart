import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/resources/colors.dart';
class LoadingView extends StatelessWidget {
  final bool? isIOS;
  final bool? isMacOS;

  const LoadingView({Key? key, this.isIOS, this.isMacOS}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if ((isIOS ?? Platform.isIOS) || ( isMacOS ?? Platform.isMacOS)) {
      return const CupertinoActivityIndicator();
    }
    return Container(
      color: Colors.transparent,
      width: 20,
      height: 20,
      child: const CircularProgressIndicator(
        strokeWidth: 2,
        valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
      ),
    );
  }
}
