import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:magic/src/core/core.dart';

class BootloaderScreen extends StatefulWidget {
  const BootloaderScreen({Key? key}) : super(key: key);

  @override
  State<BootloaderScreen> createState() => _BootloaderScreenState();
}

class _BootloaderScreenState extends State<BootloaderScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 3), () {
        GoRouter.of(context).goNamed("landing");
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Image.asset(
          Assets.logoPng,
          height: size.width * 0.4,
        ),
      ),
    );
  }
}
