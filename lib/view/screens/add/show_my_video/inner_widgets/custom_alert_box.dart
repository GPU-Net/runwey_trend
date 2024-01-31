import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:runwey_trend/utils/app_colors.dart';
import 'package:runwey_trend/view/widgets/text/custom_text.dart';

import '../Controller/show_my_video_contorller.dart';

class CustomAlertBox extends StatefulWidget {
  const CustomAlertBox({super.key,required this.id});
 final String id;
  @override
  State<CustomAlertBox> createState() => _CustomAlertBoxState();
}

class _CustomAlertBoxState extends State<CustomAlertBox> {
  final _showMyVideoController = Get.put(ShowMyVideoController());
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        children: [
          const CustomText(
            text: 'Do you want to delete this Product?',
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: AppColors.black_100,
            bottom: 24,
          ),
          Row(
            children: [
              Expanded(
                  child:InkWell(
                    onTap: (){
                     _showMyVideoController.deleteContentVideo(widget.id);
                    },
                    child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(width: 1,color: AppColors.purple),
                            borderRadius: BorderRadius.circular(8)
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: CustomText(
                            text: 'Yes',
                            fontWeight: FontWeight.w600,
                            color: AppColors.purple,
                          ),
                        )
                    ),
                  )
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                  child: InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(

                        decoration: BoxDecoration(
                            color: AppColors.purple,
                            borderRadius:
                            BorderRadius.circular(8)),
                        child:   Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 12),
                          child:CustomText(
                            text: 'No',
                            fontWeight: FontWeight.w600,
                            color: AppColors.white,
                          ),
                        )),
                  )),
            ],
          )
        ],
      ),
    );
  }
}