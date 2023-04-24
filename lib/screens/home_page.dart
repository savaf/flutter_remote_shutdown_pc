import 'dart:io';
import 'package:flutter/material.dart';
// import 'package:process/process.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Flutter Remote PC Shutdown')),
        body:
            _buildBody() // This trailing comma makes auto-formatting nicer for build methods.
        );
  }

  Future<void> apagarLaptop(BuildContext context) async {
    // Script de AppleScript para apagar la laptop en macOS
    // with administrator privileges
    String appleScript = 'do shell script "shutdown -h now"';

    // Mostrar un diálogo de confirmación al usuario
    bool confirmar = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Apagar Laptop'),
          content: const Text(
              'La laptop se apagará en 10 segundos. ¿Desea continuar?'),
          actions: [
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: const Text('Aceptar'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );

    if (confirmar == true) {
      // Ejecutar el comando osascript con el script de AppleScript
      await Process.run('osascript', ['-e', appleScript]);

      // // Mostrar un mensaje de confirmación al usuario
      // await showDialog(
      //   context: context,
      //   builder: (context) {
      //     return AlertDialog(
      //       title: Text('Apagar Laptop'),
      //       content: Text('La laptop se apagará en 10 segundos.'),
      //       actions: [
      //         TextButton(
      //           child: Text('Cancelar'),
      //           onPressed: () {
      //             Navigator.of(context).pop();
      //           },
      //         ),
      //       ],
      //     );
      //   },
      // );

      // // Esperar 10 segundos antes de apagar el dispositivo
      // await Future.delayed(Duration(seconds: 10));

      // Apagar la laptop
      await Process.run('osascript', ['-e', appleScript]);
    }
  }

  Widget _buildBody() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Center(
        child: Material(
          color: Colors.white,
          child: Center(
            child: Ink(
              decoration: const ShapeDecoration(
                color: Colors.black87,
                shape: CircleBorder(),
              ),
              child: IconButton(
                icon: const Icon(Icons.power_off),
                color: Colors.white,
                onPressed: () {
                  print('Bluetooth button pressed');
                  // Process.run('sudo shutdown', ['-s', 'now']);
                  apagarLaptop(context);
                },
              ),
            ),
          ),
        ),
      ),
      // Stack(children: [
      //   Container(
      //     child: Column(
      //       children: <Widget>[
      //         Material(
      //           color: Colors.white,
      //           child: Center(
      //             child: Ink(
      //               decoration: const ShapeDecoration(
      //                 color: Colors.black87,
      //                 shape: CircleBorder(),
      //               ),
      //               child: IconButton(
      //                 icon: const Icon(Icons.wifi_tethering),
      //                 color: Colors.white,
      //                 onPressed: () {
      //                   print('Bluetooth button pressed');
      //                 },
      //               ),
      //             ),
      //           ),
      //         ),
      //         Text('Wifi or'),
      //         const Divider(
      //           color: Colors.grey,
      //           height: 20,
      //           thickness: 1,
      //           indent: 20,
      //           endIndent: 0,
      //         ),
      //         Expanded(
      //           child: Container(
      //             decoration: BoxDecoration(
      //               borderRadius: BorderRadius.circular(10),
      //               color: Colors.deepOrangeAccent,
      //             ),
      //           ),
      //         ),
      //       ],
      //     ),
      //   )
      // ]),
    );

    // Column(
    //   children: <Widget>[
    //     Expanded(
    //       child: Container(
    //         decoration: BoxDecoration(
    //           borderRadius: BorderRadius.circular(10),
    //           color: Colors.deepPurpleAccent,
    //         ),
    //       ),
    //     ),
    //     const Divider(
    //       color: Colors.grey,
    //       height: 20,
    //       thickness: 1,
    //       indent: 20,
    //       endIndent: 0,
    //     ),
    //     Expanded(
    //       child: Container(
    //         decoration: BoxDecoration(
    //           borderRadius: BorderRadius.circular(10),
    //           color: Colors.deepOrangeAccent,
    //         ),
    //       ),
    //     ),
    //   ],
    // );
  }
}
