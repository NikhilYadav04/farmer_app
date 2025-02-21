import 'package:ai_plant_detecion/global/colors.dart';
import 'package:ai_plant_detecion/styling/sizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

Widget T1(String title, String image) {
  return Row(
    children: [
      Text(
        title,
        style: TextStyle(
            color: Colors.white,
            fontFamily: "CoreSansBold",
            fontSize: 3.37 * SizeConfig.heightMultiplier),
      ),
      SizedBox(
        width: 2.23 * SizeConfig.widthMultiplier,
      ),
     ( SizeConfig.heightMultiplier == 9.6 && SizeConfig.widthMultiplier == 4.11)
          ? Image.asset(
              image,
              height: 4.2 * SizeConfig.heightMultiplier,
              width: 9 * SizeConfig.widthMultiplier,
            )
          : Image.asset(
              image,
              height: 4.74 * SizeConfig.heightMultiplier,
              width: 10.04 * SizeConfig.widthMultiplier,
            )
    ],
  );
}

Widget T2(String title) {
  return Row(
    children: [
      Text(
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        title,
        style: TextStyle(
            color: Color.fromARGB(255, 230, 225, 225),
            fontFamily: "CoreSansLight",
            fontWeight: FontWeight.bold,
            fontSize: 2.31 * SizeConfig.heightMultiplier),
      ),
    ],
  );
}

Widget Authtext(String text) {
  return Row(
    children: [
      Text(
        text,
        style: TextStyle(
            color: Color.fromARGB(255, 249, 249, 249),
            fontFamily: "CoreSansLight",
            fontWeight: FontWeight.bold,
            fontSize: 2.63 * SizeConfig.heightMultiplier),
      ),
    ],
  );
}

Widget fieldText(String text, TextEditingController controller, IconData icon,
    TextInputType type) {
  return TextField(
    keyboardType: type,
    style: TextStyle(
        color: Colors.white,
        fontFamily: "CoreSansLight",
        fontSize: 2.31 * SizeConfig.heightMultiplier),
    controller: controller,
    decoration: InputDecoration(
        filled: true,
        fillColor: fieldColor,
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius:
                BorderRadius.circular(0.80 * SizeConfig.heightMultiplier)),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        contentPadding:
            EdgeInsets.symmetric(vertical: 2.10 * SizeConfig.heightMultiplier),
        label: Row(
          children: [
            Text(
              text,
              style: TextStyle(
                  color: Color.fromARGB(255, 157, 154, 154),
                  fontFamily: "CoreSansLight",
                  fontSize: 2.31 * SizeConfig.heightMultiplier),
            ),
          ],
        ),
        prefixIcon: Icon(
          icon,
          size: 2.52 * SizeConfig.heightMultiplier,
          color: const Color.fromARGB(255, 157, 154, 154),
        )),
  );
}

InputDecoration fieldPasswordDecoration(String text, IconData icon) {
  return InputDecoration(
      filled: true,
      fillColor: fieldColor,
      focusedBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
      border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius:
              BorderRadius.circular(0.84 * SizeConfig.heightMultiplier)),
      floatingLabelBehavior: FloatingLabelBehavior.never,
      contentPadding:
          EdgeInsets.symmetric(vertical: 2.10 * SizeConfig.heightMultiplier),
      label: Row(
        children: [
          Text(
            text,
            style: TextStyle(
                color: Color.fromARGB(255, 157, 154, 154),
                fontFamily: "CoreSansLight",
                fontSize: 2.31 * SizeConfig.heightMultiplier),
          ),
        ],
      ),
      prefixIcon: Icon(
        icon,
        size: 2.52 * SizeConfig.heightMultiplier,
        color: const Color.fromARGB(255, 157, 154, 154),
      ));
}

Widget authButton(String text, void Function() onTap) {
  return InkWell(
    onTap: onTap,
    child: Container(
      width: double.infinity,
      height: 6.32 * SizeConfig.heightMultiplier,
      decoration: BoxDecoration(
          color: screenBackgroundColorGreen,
          borderRadius:
              BorderRadius.circular(3.37 * SizeConfig.heightMultiplier)),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontFamily: "CoreSansMed",
              fontSize: 2.42 * SizeConfig.heightMultiplier),
        ),
      ),
    ),
  );
}

Widget T3(String text1, String text2, void Function() onTap) {
  return GestureDetector(
    onTap: onTap,
    child: RichText(
      text: TextSpan(
        text: text1,
        style: TextStyle(
                color: Colors.white,
                fontFamily: "CoreSansBold",
                fontSize: 2.40 * SizeConfig.heightMultiplier)
            .copyWith(color: Colors.white),
        children: <TextSpan>[
          TextSpan(
            text: text2,
            style: TextStyle(
                    color: Colors.white,
                    fontFamily: "CoreSansBold",
                    fontSize: 2.40 * SizeConfig.heightMultiplier)
                .copyWith(
                    color:
                        screenBackgroundColorGreen), // Different color for 'Login'
          ),
        ],
      ),
    ),
  );
}

Widget orDivider() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        child: Divider(
          color: Color.fromARGB(255, 185, 181, 181),
          thickness: 1,
          height: 10,
        ),
      ),
      Padding(
        padding:
            EdgeInsets.symmetric(horizontal: 2.23 * SizeConfig.widthMultiplier),
        child: Text(
          "OR",
          style: TextStyle(
            color: Color.fromARGB(255, 185, 181, 181),
            fontFamily: "CoreSansBold",
            fontSize: 2.00 * SizeConfig.heightMultiplier,
          ),
        ),
      ),
      Expanded(
        child: Divider(
          color: Color.fromARGB(255, 185, 181, 181),
          thickness: 1,
          height: 10,
        ),
      ),
    ],
  );
}

Widget OTPfield(TextEditingController controller) {
  return Pinput(
    controller: controller,
    length: 4,
    defaultPinTheme: pinTheme(),
    focusedPinTheme: pinTheme().copyWith(
      decoration: pinTheme().decoration!.copyWith(
            border: Border.all(color: Colors.white), // No border on focus
          ),
    ),
    submittedPinTheme: pinTheme(),
    showCursor: true,
    onTap: () {},
  );
}

PinTheme pinTheme() {
  return PinTheme(
    margin: EdgeInsets.symmetric(horizontal: 2.45 * SizeConfig.widthMultiplier),
    width: 17.85 * SizeConfig.widthMultiplier,
    height: 7.38 * SizeConfig.heightMultiplier,
    textStyle: TextStyle(
        color: Colors.white,
        fontFamily: "CoreSansLight",
        fontSize: 2.31 * SizeConfig.heightMultiplier),
    decoration: BoxDecoration(
      boxShadow: const [
        BoxShadow(color: fieldColor, blurRadius: 2, spreadRadius: 5)
      ],
      color: fieldColor,
      borderRadius: BorderRadius.circular(
          0.80 * SizeConfig.heightMultiplier), // Rounded corners
    ),
  );
}

Widget T4(String title) {
  return Center(
    child: Text(
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      title,
      style: TextStyle(
          color: screenBackgroundColorGreen,
          fontFamily: "CoreSansLight",
          fontWeight: FontWeight.bold,
          fontSize: 2.31 * SizeConfig.heightMultiplier),
    ),
  );
}
