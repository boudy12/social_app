import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_app/styles/icon_broken.dart';


Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 0.0,
  required String text,
  required Function function,
}) => Container(
  width: width,
  height: 40,
  child: MaterialButton(
    onPressed: () => function(),
    child: Text(
      isUpperCase ? text.toUpperCase() : text,
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),
    ),
  ),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(radius),
    color: background,
  ),
);

PreferredSizeWidget defaultAppBar({
  required BuildContext context,
  String? title,
  List<Widget>? actions,
}) => AppBar(
  titleSpacing: 5.0,
  leading: IconButton(
    onPressed: (){
      Navigator.pop(context);
    },
    icon: const Icon(
      IconBroken.Arrow___Left_2,
    ),
  ),
  actions: actions,
  title: Text(
    title!,

  ),
);

Widget defaultFormField({

  required TextEditingController controller,
  required TextInputType type,
  Function(String s)? onChanged,
  Function(String s)? onSubmit,
  bool isPasswordIcons = false,
  required String? Function(String? value) validate,
  required String text,
  Function()? onTap,
  required IconData prefixIcon,
  IconData? suffix,
  Function? prefixpress,
  bool isClickable = true,
}) => TextFormField(

  controller: controller,
  keyboardType: type,
  onFieldSubmitted: onSubmit,
  onChanged: onChanged,
  validator: validate,
  onTap: onTap,
  enabled: isClickable,
  obscureText: isPasswordIcons,
  decoration: InputDecoration(
    labelText: text,
    border: OutlineInputBorder(),
    prefixIcon: Icon(
        prefixIcon,
    ),
    suffixIcon: suffix != null ?   IconButton(
      onPressed: () => prefixpress!(),
      icon: Icon(
        suffix,
      ),
    ) : null,
  ),

);




Widget buildSpacerLine()=> Padding(

  padding: EdgeInsets.symmetric(horizontal: 16),

  child: Container(

    height: 1,

    width: double.infinity,

    color: Colors.grey,



  ),

);


void navigateTo(context,widget) => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget
    )
);

void navigateAndFinishSS(context,widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
        builder: (context) => widget
    ),
    (route) => false,
);

void showToast({
  required String msg,
  required ToastStates state,

})=>  Fluttertoast.showToast(
    msg: msg,
    backgroundColor: chooseToastColor(state),
    toastLength: Toast.LENGTH_LONG,
    timeInSecForIosWeb: 5,
    textColor: Colors.white,
    fontSize: 16,
    gravity: ToastGravity.BOTTOM
);
enum ToastStates {SUCCESS, ERROR, WARNING}

Color chooseToastColor(ToastStates state){
  Color color;
  switch(state)
  {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;

    case ToastStates.ERROR:
      color = Colors.redAccent;
      break;

    case ToastStates.WARNING:
      color = Colors.amberAccent;
      break;
  }
  return color;
}

