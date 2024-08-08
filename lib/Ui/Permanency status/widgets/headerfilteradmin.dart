// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:galaxyvisits/GlobalVaribales.dart';
import 'package:galaxyvisits/ViewModel/SalesManViewModel.dart';
import 'package:galaxyvisits/color/HexColor.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../widget/custom_dropdown.dart';

class HeaderFilter extends StatefulWidget {
  const HeaderFilter({
    Key? key,
  }) : super(key: key);

  @override
  _HeaderFilter createState() => _HeaderFilter();
}

@override
class _HeaderFilter extends State<HeaderFilter> {
 

  @override
  Widget build(BuildContext context) {
    return Consumer<SalesManViewModel>(builder: (context, viewModel, child) {
      return Container(
        color: Colors.white,
        child: Column(
          children: [
            // create filter
            Container(
              padding: const EdgeInsets.all(10),
              child: CustomDropdownFormField(
                value: viewModel.manList.map((e) => e.arabicName ?? "اسم غير متوفر").first,
                items: viewModel.manList
                        .map((man) => man.arabicName ?? "اسم غير متوفر")
                        .toList(),
                onChanged: (value) {
                  viewModel.setemployeeNo(viewModel.manList
                      .firstWhere((man) => man.arabicName == value)
                      .id!);
                      
                },
              ),
            ),
           
            Row(
              children: [
                Container(
                    padding: const EdgeInsets.all(15),
                    height: MediaQuery.of(context).size.width / 3,
                    width: MediaQuery.of(context).size.width / 2,
                    child: Center(
                        child: TextField(
                      controller: viewModel.toDateController,
                      //editing controller of this TextField
                      decoration: const InputDecoration(
                          icon: Icon(Icons.calendar_today), //icon of text field
                          labelText: "الى تاريخ"),
                      readOnly: true,
                      //set it true, so that user will not able to edit text
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1950),
                            lastDate: DateTime(2100));

                        if (pickedDate != null) {
                          viewModel.settoDate(
                              DateFormat('dd-MM-yyyy').format(pickedDate));

                          viewModel.settoDateController(viewModel.toDate);
                        } else {}
                      },
                    ))),
                Container(
                    padding: const EdgeInsets.all(15),
                    height: MediaQuery.of(context).size.width / 3,
                    width: MediaQuery.of(context).size.width / 2,
                    child: Center(
                        child: TextField(
                      controller: viewModel.fromDateController,
                      //editing controller of this TextField
                      decoration: const InputDecoration(
                          icon: Icon(Icons.calendar_today), //icon of text field
                          labelText: "من تاريخ" //label text of field
                          ),
                      readOnly: true,
                      //set it true, so that user will not able to edit text
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1950),
                            //DateTime.now() - not to allow to choose before today.
                            lastDate: DateTime(2100));

                        if (pickedDate != null) {
                          viewModel.setfromDate(
                              DateFormat('dd-MM-yyyy').format(pickedDate));

                          viewModel.setfromDateController(viewModel.fromDate);
                        } else {}
                      },
                    ))),
              ],
            ),
            //ADD Button to get data
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: HexColor(Globalvireables.basecolor),
                ),
                onPressed: () {
                  viewModel.GetAllSalesmanAtt();
                },
                child: const Text('إحضار البيانات'),
              ),
            ),
            const Divider(),
            // Add Text and decoraion "قائمة الزيارات"
            Container(
              padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
              child: const Text(
                'قائمة الموظفين',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Divider(),
          ],
        ),
      );
    });
  }
}
