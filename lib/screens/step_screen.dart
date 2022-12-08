import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wit/app_data.dart';
import 'package:wit/constants/textInputStyle.dart';
import 'package:wit/screens/create_recipe.dart';
import 'package:wit/models/step.dart';

class StepScreen extends StatefulWidget {
  StepModel step;
  int index;
  StepScreen(this.step, this.index);

  @override
  State<StepScreen> createState() => _StepScreenState();
}

class _StepScreenState extends State<StepScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController instructionController = TextEditingController();
  TextEditingController personalTouchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    titleController.text = this.widget.step.stepName;
    instructionController.text = this.widget.step.stepInstruction;
    personalTouchController.text = this.widget.step.personalTouch;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Column(
              children: [
                Text("New Step"),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: titleController,
                    decoration:
                        kTextInputStyle.copyWith(hintText: "Name of Step"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: instructionController,
                    keyboardType: TextInputType.multiline,
                    minLines: 10,
                    maxLines: 20,
                    decoration:
                        kTextInputStyle.copyWith(hintText: "Step Instruction"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: personalTouchController,
                    keyboardType: TextInputType.multiline,
                    minLines: 5,
                    maxLines: 10,
                    decoration:
                        kTextInputStyle.copyWith(hintText: "Personal Touch"),
                  ),
                ),
                FloatingActionButton.extended(
                    onPressed: () {
                      List<StepModel> stepsNew =
                          Provider.of<AppData>(context, listen: false).steps;
                      StepModel newStep = StepModel(
                          titleController.text,
                          instructionController.text,
                          personalTouchController.text);
                      (this.widget.index != -1)
                          ? stepsNew[this.widget.index] = newStep
                          : stepsNew.add(newStep);
                      Provider.of<AppData>(context, listen: false)
                          .updateSteps(stepsNew);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CreateRecipe()));
                    },
                    label: Icon(
                      Icons.check,
                      color: Colors.lightGreenAccent,
                      size: 40,
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
