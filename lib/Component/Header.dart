import 'package:flutter/material.dart';

class KamcaHeader extends StatelessWidget {
  const KamcaHeader({
    super.key,
    required this.userName,
    this.backgroundColor = const Color.fromARGB(255, 35, 53, 49),
    this.textColor = const Color.fromARGB(255, 220, 186, 162),
    this.widthFactor = 1,
    this.height = kToolbarHeight + 50,
    this.profileImage,
    this.subtitle = 'Welcome to Kamca',
    this.avatarRadius = 17,
  });

  final String userName;
  final Color backgroundColor;
  final Color textColor;
  final double widthFactor;
  final double height;
  final Widget? profileImage;
  final String subtitle;
  final double avatarRadius;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * widthFactor;

    return Center(
      child: Container(
        width: width,
        height: height,
        margin: EdgeInsets.zero,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
          border: Border.all(
            color: const Color.fromARGB(255, 29, 38, 34).withOpacity(0.22),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.35),
              blurRadius: 21,
              spreadRadius: 1,
              offset: const Offset(3, 6),
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 35,
              offset: const Offset(6, 12),
            ),
          ],
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 25, right: 1, left: 15, bottom: 6),
              child: CircleAvatar(
                radius: avatarRadius,
                backgroundColor: Colors.white,
                child: profileImage ?? Icon(Icons.person, color: textColor, size: avatarRadius + 4),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 25),
                    child: Text(
                      subtitle,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 41, right: 10, bottom: 20),
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.35),
                    width: 1,
                  ),
                ),
                child: Icon(
                  Icons.keyboard_arrow_left_rounded,
                  color: textColor,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
