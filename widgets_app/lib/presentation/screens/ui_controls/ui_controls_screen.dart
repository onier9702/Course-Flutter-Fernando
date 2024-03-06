import 'package:flutter/material.dart';

class UiControlScreen extends StatelessWidget {

  static const name = 'ui_controls_screen';

  const UiControlScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ui Controls'),
      ),
      body: const _UiControlsView(),
    );
  }
}

class _UiControlsView extends StatefulWidget {

  const _UiControlsView();

  @override
  State<_UiControlsView> createState() => _UiControlsViewState();
}

enum Transportation { car, plane, boat, submarine }

class _UiControlsViewState extends State<_UiControlsView> {

  bool isDeveloper = true;
  Transportation selectedTransportation = Transportation.car;
  bool orderBreakfast = false;
  bool orderLunch = false;
  bool orderDinner = false;

  @override
  Widget build(BuildContext context) {

    return ListView(
      physics: const ClampingScrollPhysics(), // avoid reboot jumping at the end
      children: [
        
        SwitchListTile( // switch that are inside a list and can change true or false on list click
          title: const Text('Developer mode'),
          subtitle: const Text('Aditional controls'),
          value: isDeveloper, // pass the value form
          onChanged: (value) => setState(() {
            isDeveloper = !isDeveloper;
          }),
        ),

        ExpansionTile(
          title: const Text('Vehicle to transport'),
          subtitle: Text('You choose by ${selectedTransportation.name}'),
          children: [

            RadioListTile(
              title: const Text('By car'),
              subtitle: const Text('Tripe in a car'),
              value: Transportation.car, // help you link the value selected with the current value
              groupValue: selectedTransportation,
              onChanged: (value) => setState(() {
                selectedTransportation = Transportation.car;
              })
            ),
            RadioListTile(
              title: const Text('By plane'),
              subtitle: const Text('Tripe in a plane'),
              value: Transportation.plane, // help you link the value selected with the current value
              groupValue: selectedTransportation,
              onChanged: (value) => setState(() {
                selectedTransportation = Transportation.plane;
              })
            ),
            RadioListTile(
              title: const Text('By boat'),
              subtitle: const Text('Tripe in a boat'),
              value: Transportation.boat, // help you link the value selected with the current value
              groupValue: selectedTransportation,
              onChanged: (value) => setState(() {
                selectedTransportation = Transportation.boat;
              })
            ),
            RadioListTile(
              title: const Text('By submarine'),
              subtitle: const Text('Tripe in a submarine'),
              value: Transportation.submarine, // help you link the value selected with the current value
              groupValue: selectedTransportation,
              onChanged: (value) => setState(() {
                selectedTransportation = Transportation.submarine;
              })
            ),

          ],
        ),

        CheckboxListTile(
          title: const Text('Do you want to include breakfast?'),
          value: orderBreakfast,
          onChanged: (value) => setState(() {
            orderBreakfast = !orderBreakfast;
          })
        ),
        CheckboxListTile(
          title: const Text('Do you want to include lunch?'),
          value: orderLunch,
          onChanged: (value) => setState(() {
            orderLunch = !orderLunch;
          })
        ),
        CheckboxListTile(
          title: const Text('Do you want to include dinner?'),
          value: orderDinner,
          onChanged: (value) => setState(() {
            orderDinner = !orderDinner;
          })
        ),

      ],
    );
  }
}
