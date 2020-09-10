import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gregdoucette/model/intake_model.dart';
import 'package:gregdoucette/utilities/show-toast-msg.dart';
import 'package:gregdoucette/widgets/greg_text-field.dart';
import 'custom-timepicker.dart';

class AddIntakeSheet extends StatefulWidget {
  final IntakeModel intake;
  AddIntakeSheet({this.intake});
  @override
  _SortBottomSheetState createState() => _SortBottomSheetState();
}

class _SortBottomSheetState extends State<AddIntakeSheet> {
  var formKey = GlobalKey<FormState>();
  static int defaultDailyIntake = 10;
  var calories = TextEditingController.fromValue(TextEditingValue(text: defaultDailyIntake.toString()));
  TimeOfDay timeOfDay = TimeOfDay.now();
  var description = TextEditingController();
  bool autoValidate = false;

  @override
  void initState() {
    super.initState();
    if(widget.intake!=null){
      calories.text = widget.intake?.calories?.toString();
      description.text = widget?.intake?.description ?? '';
      timeOfDay = TimeOfDay.fromDateTime(widget.intake.time);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child:  Wrap(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:8.0,vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(widget.intake == null ? "Add Intake" : "Update Intake",style: TextStyle(color: Colors.primaries[0],fontWeight: FontWeight.bold,fontSize: 15),),
                ),
                FlatButton(
                  splashColor: Colors.grey.shade200,
                  child: Text("Cancel",style: TextStyle(color: Colors.primaries[0]),),
                  onPressed: ()=> Navigator.pop(context),

                ),
              ],),
          ),
          Divider(),
          CustomTimePicker(
            time: widget.intake!=null ? TimeOfDay.fromDateTime(widget.intake?.time) : null,
            onChanged: (TimeOfDay time){
              timeOfDay = time;
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Calories consumed",style: TextStyle(
                    fontWeight: FontWeight.bold
                  ),),
                ),
                GregTextField(
                  controller: calories,
                  context:context,
                  onlyNumbers: true,
                  keyboardType: TextInputType.number,
                  prefix: FlatButton.icon(
                    padding: EdgeInsets.all(0),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: CircleBorder(),
                    icon: Icon(Icons.remove),
                    label: SizedBox(),
                    onPressed: (){
                      FocusScope.of(context).requestFocus(FocusNode());
                      FocusScope.of(context).requestFocus(FocusNode());
                      var val = int.parse(calories.text);
                      if(val>1 && val!=10){
                        setState(() {
                          calories.text = (val - 10).toString();
                        });
                      }
                    },
                  ),
                  suffix: FlatButton.icon(
                    padding: EdgeInsets.all(0),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: CircleBorder(),
                    label: SizedBox(),
                    icon: Icon(Icons.add),
                    onPressed: (){
                      FocusScope.of(context).requestFocus(FocusNode());
                      FocusScope.of(context).requestFocus(FocusNode());
                      var val = int.parse(calories.text);
                      setState(() {
                        calories.text = (val + 10).toString();
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(8, 8, 8, MediaQuery.of(context).viewInsets.bottom),
            child: GregTextFormField(
              label: 'Description',
              controller: description,
              context:context,
              validator: (String val) => val.isEmpty ? 'Please enter some description' : null,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: RaisedButton.icon(
                  color: Color(0xFFD40504),
                  textColor: Colors.white,
                  onPressed: () {
                    int val = int.parse(calories.text);
                    if(val.isNegative){
                      showToastMsg("Cannot be negative",true);
                      return;
                    }
                    if(val==0){
                      showToastMsg("Cannot be zero",true);
                      return;
                    }
                    if(val >6000){
                      showToastMsg("Cannot exceed 6000",true);
                      return;
                    }

                    var now = DateTime.now();
                    Navigator.pop(context, IntakeModel(
                      calories: int.parse(calories.text),
                      description: description.text,
                      time: DateTime(now.year,now.month,now.day,timeOfDay.hour,timeOfDay.minute)
                    ));

                    // if(formKey.currentState.validate()){
                    //
                    // } else {
                    //   setState(() {
                    //     autoValidate=true;
                    //   });
                    // }
                    // CustomNavigator.navigateTo(context, HomePage());

                  }, icon: Text(widget.intake == null ? "Add Intake" : "Update Intake"), label: Icon(CupertinoIcons.check_mark_circled)),
            ),
          ),
        ],
      ),
    );
  }
}

