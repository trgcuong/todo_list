import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_list/utils/common_widgets.dart';
@TestOn('ios')
void main(){

  testWidgets('Show LoadingView correctly on iOS', (tester) async{

    await tester.pumpWidget( const MaterialApp(
      home: Scaffold(body:  LoadingView(isIOS: true),),
    ));
    expect(find.byType(LoadingView), findsOneWidget);
    expect(find.byType(CupertinoActivityIndicator), findsOneWidget);
  });

  testWidgets('Show LoadingView correctly on macOS', (tester) async{

    await tester.pumpWidget( const MaterialApp(
      home: Scaffold(body:  LoadingView(isIOS: true),),
    ));
    expect(find.byType(LoadingView), findsOneWidget);
    expect(find.byType(CupertinoActivityIndicator), findsOneWidget);
  });

  testWidgets('Show LoadingView correctly on other platform', (tester) async{

    await tester.pumpWidget( const MaterialApp(
      home: Scaffold(body:  LoadingView(),),
    ));
    expect(find.byType(LoadingView), findsOneWidget);
    expect(find.byType(CupertinoActivityIndicator), findsOneWidget);
  });
}