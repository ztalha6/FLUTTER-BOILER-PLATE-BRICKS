import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class SelectableDropdown<T> extends StatefulWidget {
  final List<T> items;
  final String title;
  dynamic selectedValue;
  final void Function(dynamic) onChanged;
  bool isRequired;
  Color color;

  SelectableDropdown({
    Key? key,
    required this.items,
    required this.title,
    required this.onChanged,
    this.selectedValue,
    this.isRequired = false,
    this.color = Colors.white,
  }) : super(key: key);

  @override
  State<SelectableDropdown> createState() => _SelectableDropdownState();
}

class _SelectableDropdownState extends State<SelectableDropdown> {
  String? selectedValue;
  List<dynamic> selectedItemss = [];

  @override
  Widget build(BuildContext context) {
    //selectedValue = widget.selectedValue;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text(
                    widget.title,
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          color: const Color(0xFF707581),
                          fontSize: 16,
                        ),
                  ),
                  if (widget.isRequired)
                    Text(
                      '*',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 1.5.h),
        FormField<dynamic>(
          builder: (FormFieldState<dynamic> state) {
            return InputDecorator(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(
                  top: 18,
                  bottom: 18,
                  left: 5,
                  right: 20,
                ),
                filled: true,
                fillColor: Colors.grey.shade200,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                labelStyle: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(color: Colors.grey),
                floatingLabelStyle: Theme.of(context).textTheme.headlineMedium,
                // label: widget.label == null ? null : Text(widget.label!),
                // hintText: "widget.hintText",
                hintStyle: Theme.of(context).textTheme.headlineMedium,
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Color(0xFFF6F7F9),
                  ),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                // errorText: widget.errorText,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: const BorderSide(
                    color: Color(0xFFF6F7F9),
                  ),
                ),
              ),
              isEmpty: selectedValue == '',
              child: DropdownButtonHideUnderline(
                child: DropdownButton2(
                  dropdownElevation: 2,
                  isExpanded: true,
                  hint: Text(
                    selectedItemss.isEmpty
                        ? widget.title
                        : selectedItemss.join(', '),
                    style: Theme.of(context).textTheme.titleMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  items: widget.items.map((item) {
                    return DropdownMenuItem<dynamic>(
                      value: item,
                      //disable default onTap to avoid closing menu when selecting an item
                      enabled: false,
                      child: StatefulBuilder(
                        builder: (context, menuSetState) {
                          return InkWell(
                            onTap: () {
                              item.isSelected = !item.isSelected;
                              item.isSelected
                                  ? selectedItemss.add(item.name)
                                  : selectedItemss.remove(item.name);
                              //This rebuilds the StatefulWidget to update the button's text
                              setState(() {});
                              //This rebuilds the dropdownMenu Widget to update the check mark
                              menuSetState(() {});
                              widget.onChanged(
                                widget.items
                                    .where(
                                      (element) => element.isSelected,
                                    )
                                    .toList(),
                              );
                            },
                            child: Container(
                              height: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      item.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                  ),
                                  if (item.isSelected)
                                    Icon(Icons.check)
                                  else
                                    SizedBox.shrink()
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }).toList(),
                  //Use last selected item as the current value so if we've limited menu height, it scroll to last item.
                  value: /*widget.isMultiSelect ? (selectedItems.isEmpty ? null : selectedItems.last) : */
                      selectedValue,
                  onChanged: (value) {},

                  icon: const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: Colors.grey,
                    size: 30,
                  ),
                  buttonHeight: 25,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
