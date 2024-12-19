import 'package:chyess/gen/assets.gen.dart';
import 'package:chyess/src/constants/constants.dart';
import 'package:chyess/src/features/product/presentation/search/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChipBarWidget extends StatelessWidget {
  final String selectedChipIndex;
  final Function(String) onChipSelected;
  final List<Widget> chips;
  final List<String> enumValues;

  const ChipBarWidget({
    super.key,
    required this.selectedChipIndex,
    required this.onChipSelected,
    required this.chips,
    required this.enumValues,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70.h,
      child: Stack(
        children: [
          Positioned(
              left: 0,
              child: Container(
                margin: EdgeInsets.only(top: 10.h),
                child: FilterChip(
                  color: WidgetStateProperty.all(Colors.grey[200]),
                  showCheckmark: false,
                  label: Assets.icons.icFilterSearch.svg(width: 20.w),
                  selected: false,
                  onSelected: (_) {
                    showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      context: context,
                      isScrollControlled: true,
                      builder: (BuildContext context) {
                        return DraggableScrollableSheet(
                          initialChildSize: 0.73,
                          maxChildSize: 0.73,
                          minChildSize: 0.73,
                          builder: (context, scrollController) {
                            return FilterWidget(
                                scrollController: scrollController);
                          },
                        );
                      },
                    );
                  },
                  side: BorderSide.none,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                ),
              )),
          Padding(
            padding: EdgeInsets.only(left: 65.w),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: chips.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final chip = chips[index];
                return Container(
                  margin: EdgeInsets.only(right: 8.w),
                  child: FilterChip(
                    color: selectedChipIndex == enumValues[index]
                        ? WidgetStateProperty.all(ColorApp.primary)
                        : WidgetStateProperty.all(Colors.grey[200]),
                    showCheckmark: false,
                    label: chip,
                    labelStyle: TextStyle(
                      color: selectedChipIndex == enumValues[index]
                          ? Colors.white
                          : Colors.black,
                    ),
                    selected: selectedChipIndex == enumValues[index],
                    onSelected: (_) {
                      onChipSelected(enumValues[index]);
                    },
                    side: BorderSide.none,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
