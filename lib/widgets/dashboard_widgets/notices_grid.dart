import 'package:final_year_project/utils/media_query.dart';
import 'package:flutter/material.dart';

class NoticesGrid extends StatelessWidget {
  const NoticesGrid({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: const BorderSide(
          width: 1.0,
          color: Colors.black,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      shadowColor: Colors.black,
      elevation: 6,
      color: const Color.fromARGB(255, 169, 165, 241),
      child: SizedBox(
        width: screenWidth(context) * 0.88,
        height: screenHeight(context) * 0.44,
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: GridView.builder(
              itemCount: 4,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 6.6,
                  color: Colors.white,
                  child: const Center(
                    child: Text("data"),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
