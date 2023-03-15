import 'package:final_year_project/utils/media_query.dart';
import 'package:flutter/material.dart';

class IndividualPostSection extends StatefulWidget {
  const IndividualPostSection({
    Key? key,
  }) : super(key: key);

  @override
  State<IndividualPostSection> createState() => _IndividualPostSectionState();
}

class _IndividualPostSectionState extends State<IndividualPostSection> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("2 hours ago"),
                Icon(Icons.share),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 250,
            width: screenWidth(context) < 500 ? screenWidth(context) : 450,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.green,
              image: const DecorationImage(
                image: NetworkImage(
                    "https://static.vecteezy.com/packs/media/vectors/term-bg-1-3d6355ab.jpg"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: screenWidth(context) < 500 ? 250 : screenWidth(context),
            child: const Text(
              "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before final copy is available.",
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    Icon(
                      Icons.thumb_up,
                      size: 35,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Like",
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: const [
                    Icon(
                      Icons.archive,
                      size: 35,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.comment_bank_outlined,
                      size: 35,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(
            thickness: 5,
          )
        ],
      ),
    );
  }
}
