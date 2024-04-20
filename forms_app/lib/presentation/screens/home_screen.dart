import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          ListTile(
            title: const Text('Cubits'),
            subtitle: const Text('Simple gestor state'),
            trailing: const Icon(Icons.arrow_forward_ios_rounded),
            onTap: () => context.push('/cubits'),
          ),

          ListTile(
            title: const Text('BLoc'),
            subtitle: const Text('Big gestor state'),
            trailing: const Icon(Icons.arrow_forward_ios_rounded),
            onTap: () => context.push('/bloc'),
          ),

          // Here we start the sesion 21
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Divider()
          ),

          ListTile(
            title: const Text('Register'),
            subtitle: const Text('Handling Form'),
            trailing: const Icon(Icons.arrow_forward_ios_rounded),
            onTap: () => context.push('/register'),
          ),

        ],
      ),
    );
  }
}