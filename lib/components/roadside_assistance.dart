import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RoadsideAssistance extends StatefulWidget {
  const RoadsideAssistance({super.key});

  @override
  State<RoadsideAssistance> createState() => _RoadsideAssistanceState();
}

class _RoadsideAssistanceState extends State<RoadsideAssistance> {
  int currentStep = 0;

  final batteryCode = TextEditingController();
  final customerName = TextEditingController();
  final customerSurname = TextEditingController();
  final email = TextEditingController();
  final carPlate = TextEditingController();
  final phoneNumber = TextEditingController();

  OnStepContinue() {
    final isLastStep = currentStep == getSteps().length - 1;
    if (isLastStep) {
      //send data to the server
    } else {
      setState(() => currentStep += 1);
    }
  }

  OnStepCancel() {
    currentStep == 0 ? null : setState(() => currentStep -= 1);
  }

  OnStepTapped(int step) {
    setState(() => currentStep = step);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stepper(
      type: StepperType.horizontal,
      steps: getSteps(),
      currentStep: currentStep,
      onStepCancel: () => OnStepCancel(),
      onStepContinue: () => OnStepContinue(),
      onStepTapped: (step) => OnStepTapped(step),
      controlsBuilder: (context, controlsDetails) {
        final isLastStep = currentStep == getSteps().length - 1;
        return Container(
            margin: const EdgeInsets.only(top: 50),
            child: Row(
              children: [
                Expanded(
                    child: ElevatedButton(
                        onPressed: OnStepContinue,
                        child: Text(isLastStep ? 'BİTTİ' : 'DEVAM ET'))),
                const SizedBox(
                  width: 12,
                ),
                if (currentStep != 0)
                  Expanded(
                      child: ElevatedButton(
                          onPressed: OnStepCancel, child: const Text('GERİ'))),
              ],
            ));
      },
    ));
  }

  List<Step> getSteps() => [
        Step(
            state: currentStep > 0 ? StepState.complete : StepState.indexed,
            isActive: currentStep >= 0,
            title: const Text(''),
            content: Column(
              children: <Widget>[
                TextFormField(
                  controller: batteryCode,
                  decoration: const InputDecoration(labelText: 'Akü Kodu'),
                ),
              ],
            )),
        Step(
            state: currentStep > 1 ? StepState.complete : StepState.indexed,
            isActive: currentStep >= 1,
            title: const Text(''),
            content: Column(
              children: <Widget>[
                TextFormField(
                  controller: customerName,
                  decoration: const InputDecoration(labelText: 'Müşteri Adı'),
                ),
                TextFormField(
                  controller: customerSurname,
                  decoration:
                      const InputDecoration(labelText: 'Müşteri Soyadı'),
                ),
                TextFormField(
                  controller: email,
                  decoration: const InputDecoration(labelText: 'E-Posta'),
                ),
                TextFormField(
                  controller: phoneNumber,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration: const InputDecoration(
                      labelText: 'Telefon  (ör: (5XX)XXX XXXX)'),
                ),
                TextFormField(
                  controller: batteryCode,
                  decoration: const InputDecoration(
                      labelText:
                          'Ne olduğunu bilemediğim kaydırmalı boşluk'), // CONTROLLER DEĞİŞMELİ
                ),
                TextFormField(
                  controller: carPlate,
                  decoration: const InputDecoration(
                      labelText: 'Araç Plaka'), //CONTROLLER DEĞİŞMELİ
                ),
              ],
            )),
        Step(
            state: currentStep > 2 ? StepState.complete : StepState.indexed,
            isActive: currentStep >= 2,
            title: const Text(''),
            content: Column(
              children: <Widget>[
                TextFormField(
                  controller: batteryCode,
                  decoration: const InputDecoration(labelText: 'Akü Kodu'),
                ),
              ],
            ))
      ];
}
