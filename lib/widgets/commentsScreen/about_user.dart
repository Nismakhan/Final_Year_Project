import 'package:final_year_project/widgets/common/my_circle_avatars.dart';
import 'package:flutter/material.dart';

class AboutUser extends StatelessWidget {
  const AboutUser({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        children: [
          SizedBox(
            width: 60,
            height: 60,
            child: Stack(
              clipBehavior: Clip.none,
              children: const [
                Positioned(
                  top: -35,
                  left: 10,
                  child: MyCircleAvatars(
                    borderColor: Colors.black,
                    img:
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSFRmWtO1zrO6tt35ewAJOE9NpAb8yiwhbrBWyxjVQCZw&s",
                    raduis: 40,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 45,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "City University",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text("11001"),
            ],
          ),
        ],
      ),
    );
  }
}
