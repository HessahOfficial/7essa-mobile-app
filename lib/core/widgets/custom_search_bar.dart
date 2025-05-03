import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hessa/core/themes/colors/app_colors.dart';

class CustomSearchBar extends StatefulWidget {
  final double width;
  const CustomSearchBar({super.key, required this.width});

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 58,
      // width: widget.width,
      decoration: BoxDecoration(
        // color: AppColors.white2,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        spacing: 10,
        children: [
          Expanded(
            flex: 10,
            child: SizedBox(
              height: 58,
              child: TextField(
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: SizedBox(
                    width: 30,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SvgPicture.asset("assets/images/Search.svg"),
                        SizedBox(width: 8),
                        Container(
                          width: 2,
                          height: 25,
                          decoration: BoxDecoration(
                            color: AppColors.primaryLight,
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      ],
                    ),
                  ),
                  fillColor: AppColors.backgtoundLight,
                  filled: true,
                  hintText: "Search...",
                  hintStyle: TextStyle(fontSize: 18, color: AppColors.gray),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: GestureDetector(
              onTap: () {},
              child: Container(
                height: 60,

                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  spacing: 5,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: AppColors.lightAccent,
                      radius: 15,
                      child: Icon(
                        IconData(0xf755, fontFamily: 'MaterialIcons'),
                        color: AppColors.primaryLight,
                        size: 20,
                      ),
                    ),
                    Text(
                      "Filters",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
