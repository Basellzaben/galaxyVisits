import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:galaxyvisits/Ui/VisitDetailsAdmin/VisitDetailAdmin.dart';
import 'package:galaxyvisits/ViewModel/VisitDetailViewModel.dart';
import 'package:provider/provider.dart';

class CustomDropdownFormField extends StatefulWidget {
  final List<String> items;
  final String value;
  final String? hintText;
  final String? labelText;
  final void Function(String?) onChanged;
  final Future<void> Function(String?)? onSearch;

  final String? Function(String?)? validator;

  const CustomDropdownFormField({
    Key? key,
    required this.items,
    required this.value,
    required this.onChanged,
    this.onSearch,

    this.validator,
    this.hintText,
    this.labelText,
  }) : super(key: key);

  @override
  _CustomDropdownFormFieldState createState() => _CustomDropdownFormFieldState();
}

class _CustomDropdownFormFieldState extends State<CustomDropdownFormField> {
  late TextEditingController textEditingController;
  late String selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.value;
    textEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Consumer<VisitDetailViewModel>(
        builder: (context, value, child) => 
      Container(
          width: double.infinity,
          // color: Colors.red,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              
          
              barrierColor: Colors.grey.withOpacity(0.1),
              isExpanded: true,
              hint: Text(
                widget.hintText ?? 'اختر من القائمة',
                style: TextStyle(
                  fontSize: 24,
                  color: Theme.of(context).hintColor,
                ),
              ),
              items: widget.items
                  .map((item) => DropdownMenuItem(
                    alignment: Alignment.centerRight,
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ))
                  .toList(),
                
              value: selectedValue,
              
              onChanged: (value) {
                setState(() {
                  selectedValue = value ?? "";
                });
                widget.onChanged(value);
              },
              buttonStyleData:  ButtonStyleData(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                height: height * 0.08,
                width: width * 0.9,
              ),
              
              dropdownStyleData:  DropdownStyleData(
                maxHeight: height * 0.6,
                direction: DropdownDirection.left,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                  border: Border.all(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
              menuItemStyleData:  MenuItemStyleData(
                height: height * 0.07,
                
              ),
              dropdownSearchData: DropdownSearchData(
                
                searchController: textEditingController,
                searchInnerWidgetHeight: 50,
                searchInnerWidget: Container(
                  height: 50,
                  padding: const EdgeInsets.only(
                    top: 8,
                    bottom: 4,
                    right: 8,
                    left: 8,
                  ),
                  child: TextFormField(
                    textAlign: TextAlign.right,
                    textDirection: TextDirection.rtl,
                   
                
                    expands: true,
                    maxLines: null,
                    controller: textEditingController,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 6,
                      ),
                      hintText: '... بحث ',
                      hintStyle: const TextStyle(fontSize: 18),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                searchMatchFn: (item, searchValue) {
                 // widget.onSearch!(searchValue);
                  return item.value.toString().contains(searchValue);
                },
              ),
              //This to clear the search value when you close the menu
              onMenuStateChange: (isOpen) {
                if (!isOpen) {
                  textEditingController.clear();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
