import 'package:bmi_project/providers/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
class DefaultTextField extends StatelessWidget {
  String hint;
  Function onSave;
  Function validate;
  bool isPass;
  DefaultTextField({
    @required this.hint,
    @required this.onSave,
    @required this.validate,
    this.isPass = false,
  });
  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context,provider,x)=>TextFormField(
        keyboardType: TextInputType.text,
        obscureText: isPass&&!provider.isVisible,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          isDense: true,
          hintText: hint.tr(),
          hintStyle: Theme.of(context).textTheme.headline4,
          suffixIconConstraints: BoxConstraints(maxHeight: 35),
          /// ///
          suffixIcon: isPass?GestureDetector(
            onTap: (){
              provider.changeIsisVisibleVar();
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 5.0),
              child: provider.isVisible?Icon(Icons.remove_red_eye_outlined,size:20)
                  :Icon(Icons.visibility_off_outlined,size:20),
            ),
          ):null
        ),
        onSaved: onSave,
        validator: validate,
      ),
    );
  }
}
