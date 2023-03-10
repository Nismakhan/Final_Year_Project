import 'package:final_year_project/widgets/common/my_circle_avatars.dart';
import 'package:flutter/material.dart';

class UserProfileSection extends StatelessWidget {
  const UserProfileSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          const ListTile(
            leading: SizedBox(
              child: MyCircleAvatars(
                borderColor: Colors.black,
                img:
                    "https://static.vecteezy.com/packs/media/vectors/term-bg-1-3d6355ab.jpg",
                raduis: 30,
              ),
            ),
            title: Text("City University"),
            subtitle: Text("1.3M followers"),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: Row(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    elevation: 10,
                  ),
                  onPressed: () {},
                  child: const Text("Message"),
                ),
                const SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    elevation: 10,
                  ),
                  onPressed: () {},
                  child: const Text("Follow"),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
