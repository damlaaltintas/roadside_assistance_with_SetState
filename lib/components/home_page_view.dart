import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'button_widget.dart';

class RoadsideAssistance extends StatefulWidget {
  const RoadsideAssistance({super.key});

  @override
  State<RoadsideAssistance> createState() => _RoadsideAssistanceState();
}

class _RoadsideAssistanceState extends State<RoadsideAssistance> {
  int currentStep = 0;
  
  static List<String> list = <String>['One', 'Two', 'Three', 'Four'];
  String dropdownValue = list.first;

  var maskFormatter = new MaskTextInputFormatter(
      mask: '(###) ###-##-##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  var maskFormatter2 = new MaskTextInputFormatter(
      mask: '####-###',
      filter: {
        "#": RegExp(
          r'[0-9]',
        )
      },
      type: MaskAutoCompletionType.lazy);

  final batteryCode = TextEditingController();
  final customerName = TextEditingController();
  final customerSurname = TextEditingController();
  final email = TextEditingController();
  final carPlate = TextEditingController();
  final phoneNumber = TextEditingController();

  OnStepContinue() {
    final isLastStep = currentStep == getSteps().length - 1;
    if (isLastStep) {
       null;//send data to the server
    } else {
      setState(() => currentStep += 1);
    }
  }

  OnStepCancel() {
    currentStep == 0 ? null : setState(() => currentStep -= 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 700,
        child: Stepper(
          type: StepperType.horizontal,
          steps: getSteps(),
          currentStep: currentStep,
          onStepCancel: () => OnStepCancel(),
          onStepContinue: () => OnStepContinue(),
          controlsBuilder: (context, controlsDetails) {
            final isLastStep = currentStep == getSteps().length - 1;
            return Container(
              alignment: Alignment.bottomCenter,
                margin: const EdgeInsets.only(top: 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (isLastStep)
                      TweenAnimationBuilder<Duration>(
                          duration: const Duration(seconds: 5),
                          tween: Tween(
                              begin: const Duration(seconds: 5),
                              end: Duration.zero),
                          onEnd: () {
                            print('Timer ended');
                            OnStepContinue();
                          },
                          builder: (BuildContext context, Duration value,
                              Widget? child) {
                            final myMinutes = value.inMinutes;
                            final mySeconds = value.inSeconds % 60;
                            return Column(
                              children: [
                                Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 5),
                                    child: Text('$myMinutes:$mySeconds',
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30)
                                            )
                                          ),
                                          if (!isLastStep)
                                          Row(
                                            children: [
                                            Container(
                                              width: 70,
                                              child: ButtonWidget(
                                              text: 'GERİ', 
                                              onClicked: OnStepCancel),
                                            ),
                                            Spacer(),
                                            Container(
                                              width: 70,
                                              child: ButtonWidget(
                                                text: (isLastStep ? 'BİTTİ' : 'DEVAM ET'), 
                                                onClicked: OnStepContinue,),
                                            )
                                             ]
                                          )

                      //         Row(
                      // children: [
                      //   if (currentStep != 0)
                      //     Expanded(
                      //       child: Align(
                      //         alignment: Alignment.bottomCenter,
                      //         child: ElevatedButton(
                      //               style: ElevatedButton.styleFrom(elevation: 3),
                      //               onPressed: OnStepCancel,
                      //               child: const Text('GERİ')),
                      //         ),
                      //     ),
                      //   Expanded(
                      //     child: Align(
                      //       alignment: Alignment.bottomCenter,
                      //       child: ElevatedButton(
                      //           style: ElevatedButton.styleFrom(elevation: 3),
                      //           onPressed: Duration.secondsPerMinute == 0 ? null : OnStepContinue,
                      //           child: Text(isLastStep ? 'BİTTİ' : 'DEVAM ET')),
                      //     ),
                      //   ),
                      //],
                    //),
                              ],
                            );
                          }),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                            ButtonWidget(
                                            text: 'GERİ', 
                                            onClicked: OnStepCancel),
                                            Spacer(),
                                            ButtonWidget(
                                              text: (isLastStep ? 'BİTTİ' : 'DEVAM ET'), 
                                              onClicked: OnStepContinue,)
                                             ]
                                          )
                  ],
                ),
            );
          },
        ),
      ),
    );
  }

  List<Step> getSteps() => [
        Step(
            state: currentStep > 0 ? StepState.complete : StepState.indexed,
            isActive: currentStep >= 0,
            title: const Text(''),
            content: Column(
              children: <Widget>[
                TextFormField(
                  inputFormatters: <TextInputFormatter>[
                    maskFormatter2,
                  ],
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
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(
                        r"^[[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?]+"))
                  ],
                  controller: email,
                  decoration: const InputDecoration(labelText: 'E-Posta'),
                ),
                TextFormField(
                  controller: phoneNumber,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                    maskFormatter,
                  ],
                  decoration: const InputDecoration(
                      labelText: 'Telefon  (ör: (5XX)XXX XXXX)'),
                ),
                Container(
                  width: double.infinity,
                  child: DropdownButtonHideUnderline(
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButton<String>(
                        value: dropdownValue,
                        icon: const Icon(Icons.arrow_downward),
                        elevation: 16,
                        style: const TextStyle(color: Colors.blue),
                        underline: Container(
                          height: 2,
                          color: Colors.blue,
                        ),
                        onChanged: (String? value) {
                          // This is called when the user selects an item.
                          setState(() {
                            dropdownValue = value!;
                          });
                        },
                        items:
                            list.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                const Divider(
                  thickness: 1,
                  color: Colors.black54,
                ),
                TextFormField(
                  textCapitalization: TextCapitalization.characters,
                  controller: carPlate,
                  decoration: const InputDecoration(labelText: 'Araç Plaka'),
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
