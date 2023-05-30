import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class CustomSocialLoginButton extends StatelessWidget {
  final String assetPath;
  final String title;
  final VoidCallback onTap;
  const CustomSocialLoginButton({
    Key? key,
    required this.assetPath,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 40),
        height: 60,
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: const BorderSide(
              width: 1,
              color: Colors.white,
            ),
          ),
          color: Colors.red[900],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                width: 15,
              ),
              SvgPicture.asset(
                assetPath,
                height: 25,
                width: 25,
              ),
              const SizedBox(
                width: 15,
              ),
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Colors.white, fontWeight: FontWeight.w500),
              )
            ],
          ),
        ),
      ),
    );
  }
}
