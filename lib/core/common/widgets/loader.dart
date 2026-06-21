// import 'package:flutter/material.dart';

// class Loader extends StatelessWidget {
//   const Loader({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return const Center(child: CircularProgressIndicator(),);

//   }

// }
import 'package:flutter/material.dart';

class Loader extends StatefulWidget {
  const Loader({super.key});

  @override
  State<Loader> createState() => _LoaderState();
}

class _LoaderState extends State<Loader>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RotationTransition(
        turns: controller,
        child: const FlutterLogo(size: 60),
      ),
    );
  }
}