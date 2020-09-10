// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:gregdoucette/widgets/greg_text-field.dart';
//
// class NumberInputField extends GregTextField {
//   NumberInputField({
//     Widget prefix,
//     Widget suffix,
//     String label,
//     TextInputType keyboardType,
//     BuildContext context,
//     TextEditingController controller,
//     bool onlyNumbers = false,
//     Function(String) validator
// }): super(
//         controller: controller,
//         context:context,
//         onlyNumbers: true,
//         keyboardType: TextInputType.number,
//         prefix: FlatButton.icon(
//           padding: EdgeInsets.all(0),
//           materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//           shape: CircleBorder(),
//           icon: Icon(Icons.remove),
//           label: SizedBox(),
//           onPressed: (){
//             var val = int.parse(calories.text);
//             setState(() {
//               calories.text = (val - 10).toString();
//             });
//           },
//         ),
//         suffix: FlatButton.icon(
//           padding: EdgeInsets.all(0),
//           materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//           shape: CircleBorder(),
//           label: SizedBox(),
//           icon: Icon(Icons.add),
//           onPressed: (){
//             var val = int.parse(calories.text);
//             setState(() {
//               calories.text = (val + 10).toString();
//             });
//           },
//         )
//   );
// }