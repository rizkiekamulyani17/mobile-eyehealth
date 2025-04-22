import 'package:flutter/material.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  const Header({
    super.key,
  });

  final bool login = true;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                "Eye",
                style: TextStyle(
                    color: Color.fromRGBO(54, 91, 109, 1),
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "Health",
                style: TextStyle(
                  color: Color.fromRGBO(65, 193, 186, 1),
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
