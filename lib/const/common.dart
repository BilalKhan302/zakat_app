import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
final Color primary=Colors.red.shade400;
Widget commonTextFormField({
  String ?hint,
  TextInputType ?type,
  TextEditingController ?controller
}){
  return TextFormField(
    controller: controller,
    keyboardType: type,
    decoration: InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        color: Colors.black54,
      ),
      filled: true,
      fillColor: Colors.grey[200],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
    ),
  );
}
//date-picker
class CommonDateContainer extends StatefulWidget {
  final String title;
   const CommonDateContainer({Key? key,required this.title}) : super(key: key);

  @override
  State<CommonDateContainer> createState() => _CommonDateContainerState();
}

class _CommonDateContainerState extends State<CommonDateContainer> {
  DateTime? startDate;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        startDate = (await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        ))!;
        setState(() {});
      },
      child: Container(
          height: MediaQuery.of(context).size.height * 0.08,
          width: MediaQuery.of(context).size.width * 0.85,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
          ),
          child:  Center(
              child: Text(widget.title,
                textAlign: TextAlign.center,
                style: TextStyle(

                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Colors.black54),
              ))),
    );

  }
}