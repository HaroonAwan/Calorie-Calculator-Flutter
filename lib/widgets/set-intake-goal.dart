// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:gregdoucette/utilities/show-toast-msg.dart';
// import 'greg_text-field.dart';
//
// class SetIntakeGoal extends StatefulWidget {
//   @override
//   _SetIntakeGoalState createState() => _SetIntakeGoalState();
// }
//
// class _SetIntakeGoalState extends State<SetIntakeGoal> {
//
//   TextEditingController selectedCalories = TextEditingController.fromValue(TextEditingValue(text: 800.toString()));
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: GregTextField(
//             controller: selectedCalories,
//             context:context,
//             onlyNumbers: true,
//             keyboardType: TextInputType.number,
//             prefix: FlatButton.icon(
//               padding: EdgeInsets.all(0),
//               materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//               shape: CircleBorder(),
//               icon: Icon(Icons.remove),
//               label: SizedBox(),
//               onPressed: (){
//
//                 var val = int.parse(selectedCalories.text);
//                 if(val > 800 && val <= 6000){
//                   setState(() {
//                     selectedCalories.text = (val - 10).toString();
//                   });
//                 }
//
//               },
//             ),
//             suffix: FlatButton.icon(
//               padding: EdgeInsets.all(0),
//               materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//               shape: CircleBorder(),
//               label: SizedBox(),
//               icon: Icon(Icons.add),
//               onPressed: (){
//                 var val = int.parse(selectedCalories.text);
//                 if(val < 6000){
//                   setState(() {
//                     selectedCalories.text = (val + 10).toString();
//                   });
//                 }
//
//               },
//             ),
//           ),
//         ),
//         Builder(
//           builder: (ctx) =>
//               SizedBox(
//                 width: MediaQuery.of(context).size.width,
//                 child: RaisedButton.icon(
//                     color: Color(0xFFD40504),
//                     textColor: Colors.white,
//                     onPressed: () async {
//                       int calories = int.parse(selectedCalories.text);
//                       if(calories<800){
//                         showToastMsg("Your daily caloric intake cannot be less than 800",true);
//                         return;
//                       }
//                       if(calories.isNegative){
//                         showToastMsg("Your daily caloric intake cannot be negative",true);
//                         return;
//                       }
//                       if(calories==0){
//                         showToastMsg("Your daily caloric intake cannot be zero",true);
//                         return;
//                       }
//                       if(calories>6000){
//                         showToastMsg("Your daily caloric intake cannot exceed 6000",true);
//                         return;
//                       }
//                       await setCalorieGoal(calories);
//                       // CustomNavigator.pushReplacement(context, HomePage());
//                     }, icon: Text("Let's Start"), label: Icon(CupertinoIcons.forward)),
//               ),
//         ),
//       ],
//     );
//   }
// }
