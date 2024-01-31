import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:runwey_trend/helper/date_formate_helper.dart';
import 'package:runwey_trend/model/chat_model.dart';
import 'package:runwey_trend/utils/app_colors.dart';
import 'package:runwey_trend/utils/app_constent.dart';
import 'package:runwey_trend/utils/app_icons.dart';
import 'package:runwey_trend/utils/app_strings.dart';
import 'package:runwey_trend/utils/device_utils.dart';
import 'package:runwey_trend/view/screens/message/Controller/chat_controller.dart';
import 'package:runwey_trend/view/widgets/app_bar/custom_app_bar.dart';
import 'package:runwey_trend/view/widgets/cache_nerwork_image.dart';
import 'package:runwey_trend/view/widgets/custom_back_button.dart';
import 'package:runwey_trend/view/widgets/custom_loader.dart';
import 'package:runwey_trend/view/widgets/empty_screen.dart';
import 'package:runwey_trend/view/widgets/general_error_screen.dart';
import 'package:runwey_trend/view/widgets/image/custom_image.dart';
import 'package:runwey_trend/view/widgets/no_internet_screen.dart';
import 'package:runwey_trend/view/widgets/text_field/custom_text_field.dart';

import 'inner_widgets/custom_chat_bubble.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _chatController = Get.put(ChatController());
  var chatId;

  @override
  void initState() {
    chatId = Get.arguments;
    DeviceUtils.authUtils();
    _chatController.getUserId();
    _chatController.listenMessage(Get.arguments);
    _chatController.scrollController =
        ScrollController(initialScrollOffset: 0.0);

    _chatController.scrollController =
        ScrollController(initialScrollOffset: 0.0);
    _chatController.fastLoad(Get.arguments);
    _chatController.scrollController.addListener(() {
      if (_chatController.scrollController.position.pixels <=
          _chatController.scrollController.position.minScrollExtent) {
        print("====> scroll Top");
        // _chatController.loadMore(Get.arguments);
        // _controller.loadMore(userData.id);
      } else if (_chatController.scrollController.position.pixels ==
          _chatController.scrollController.position.maxScrollExtent) {
        print("====> scroll bottom");
        _chatController.loadMore(Get.arguments);
      }

      ///  Change Fab button

      // if (_chatController.scrollController.position.pixels == 0) {
      //   // At the top
      //   if (!_chatController.isFabButton.value) {
      //     setState(() {
      //       _chatController.isFabButton.value = true;
      //     });
      //   }
      // } else if (_chatController.scrollController.position.pixels ==
      //     _chatController.scrollController.position.maxScrollExtent) {
      //   // At the bottom
      //   if (_chatController.isFabButton.value) {
      //     setState(() {
      //       _chatController.isFabButton.value = false;
      //     });
      //   }
      //   }
    });

    //  _chatController.receivedListen(userData.id!);

    super.initState();
  }

  @override
  void dispose() {
    _chatController.offSocket(chatId);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColors.whiteBg,
        appBar: AppBar(
          title: const Text(
            AppStrings.message,
          ),
          leading: CustomBackButton(
            color: Colors.black,
          ),
          backgroundColor: AppColors.whiteBg,
        ),
        body: Obx(() {
          switch (_chatController.rxRequestStatus.value) {
            case Status.loading:
              return CustomLoader();
            case Status.internetError:
              return NoInternetScreen(onTap: () {
                _chatController.fastLoad(Get.arguments);
              });
            case Status.error:
              return GeneralErrorScreen(onTap: () {
                _chatController.fastLoad(Get.arguments);
              });
            case Status.completed:
              return Obx(
                () => Column(
                  children: [
                    Expanded(
                      child:_chatController.chatList.value.isEmpty?const EmptyScreen():Stack(
                        alignment: Alignment.center,
                        children: [
                          GroupedListView<ChatModel, DateTime>(
                            elements: _chatController.chatList.value,
                            controller: _chatController.scrollController,
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            order: GroupedListOrder.DESC,
                            itemComparator: (item1, item2) =>
                                item1.createdAt!.compareTo(item2.createdAt!),
                            groupBy: (ChatModel message) => DateTime(
                                message.createdAt!.year,
                                message.createdAt!.month,
                                message.createdAt!.day),
                            reverse: true,
                            shrinkWrap: true,
                            physics: const AlwaysScrollableScrollPhysics(),
                            groupSeparatorBuilder: (DateTime date) {
                              return const SizedBox();
                            },
                            itemBuilder: (context, ChatModel message) {
                              return message.sender!.id ==
                                      _chatController.userId
                                  ? senderBubble(context, message)
                                  : receiverBubble(context, message);
                            },
                          ),
                          Positioned(
                              top: 20,
                              child: Obx(
                                  () => _chatController.isLoadMoreRunning.value
                                      ? const CircularProgressIndicator(
                                          color: Colors.grey,
                                        )
                                      : const SizedBox()))
                        ],
                      ),
                    ),
                    Obx(() => _chatController.rxRequestStatus.value ==
                            Status.loading
                        ? const SizedBox()
                        : Container(
                            padding: EdgeInsets.only(
                                left: 20.w, right: 20.w, bottom: 20.h, top: 10),
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                    child: TextField(
                                  controller: _chatController.messageCtrl,
                                  onSubmitted: (value) {
                                    if (value.isNotEmpty) {
                                      _chatController.sendMessage(value,
                                          chatId: Get.arguments);
                                    }
                                  },
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 20.w),
                                      enabledBorder: buildOutlineInputBorder(),
                                      focusedBorder: buildOutlineInputBorder(),
                                      errorBorder: buildOutlineInputBorder()),
                                )),
                                SizedBox(width: 16.w),
                                GestureDetector(
                                  onTap: () {
                                    if (_chatController
                                        .messageCtrl.text.isNotEmpty) {
                                      _chatController.sendMessage(
                                          _chatController.messageCtrl.text,
                                          chatId: Get.arguments);
                                    }
                                  },
                                  child: const CustomImage(
                                      imageColor: AppColors.purple,
                                      imageType: ImageType.svg,
                                      imageSrc: AppIcons.send,
                                      size: 24),
                                ),
                              ],
                            ),
                          ))
                  ],
                ),
              );
          }
        }),
        // bottomNavigationBar: Obx(()=>_chatController.rxRequestStatus.value==Status.loading?const SizedBox():
        //    Container(
        //     padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.h,top: 10),
        //     width: MediaQuery.of(context).size.width,
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         Expanded(
        //             child: TextField(
        //           controller: _chatController.messageCtrl,
        //           onSubmitted: (value){
        //             if(value.isNotEmpty){
        //               _chatController.sendMessage(value, chatId:Get.arguments);
        //             }
        //           },
        //           decoration: InputDecoration(
        //               contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
        //               enabledBorder: buildOutlineInputBorder(),
        //               focusedBorder: buildOutlineInputBorder(),
        //               errorBorder: buildOutlineInputBorder()),
        //         )),
        //         SizedBox(width: 16.w),
        //         GestureDetector(
        //           onTap: () {
        //             if (_chatController.messageCtrl.text.isNotEmpty) {
        //               _chatController.sendMessage(_chatController.messageCtrl.text,
        //                   chatId: Get.arguments);
        //             }
        //           },
        //           child: const CustomImage(
        //               imageColor: AppColors.purple,
        //               imageType: ImageType.svg,
        //               imageSrc: AppIcons.send,
        //               size: 24),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
      ),
    );
  }

  receiverBubble(BuildContext context, ChatModel chatModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CustomNetworkImage(
          imageUrl: chatModel.sender!.image!.publicFileUrl ?? "",
          height: 35,
          width: 35,
          boxShape: BoxShape.circle,
          border: Border.all(color: AppColors.purple_20, width: 1),
        ),
        SizedBox(
          width: 5.w,
        ),
        Expanded(
          child: ChatBubble(
            clipper: ChatBubbleClipper3(type: BubbleType.receiverBubble),
            backGroundColor: const Color(0xffE7E7ED),
            margin: const EdgeInsets.only(top: 20, bottom: 20),
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.57,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    chatModel.message ?? "",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.start,
                    // textAlign: TextAlign.start,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                          DateFormatHelper.formatTimeHHMM(chatModel.createdAt!),
                          style: TextStyle(
                            color: AppColors.black_60,
                            fontSize: 12.sp,
                          ),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  senderBubble(BuildContext context, ChatModel chatModel) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: ChatBubble(
            clipper: ChatBubbleClipper3(
              type: BubbleType.sendBubble,
            ),
            alignment: Alignment.topRight,
            margin: const EdgeInsets.only(top: 20, bottom: 20),
            backGroundColor: AppColors.purple,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.57,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    chatModel.message ?? "",
                    style: const TextStyle(color: Colors.white),
                    textAlign: TextAlign.start,
                  ),
                  Text(
                    DateFormatHelper.formatTimeHHMM(chatModel.createdAt!),
                    style:
                        TextStyle(color: AppColors.purple_20, fontSize: 12.sp),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          width: 4.w,
        ),
        CustomNetworkImage(
          imageUrl: chatModel.sender!.image!.publicFileUrl ?? "",
          height: 35,
          width: 35,
          boxShape: BoxShape.circle,
          border: Border.all(color: AppColors.purple_20, width: 1),
        ),
      ],
    );
  }

  OutlineInputBorder buildOutlineInputBorder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(24.r),
        ),
        borderSide: const BorderSide(color: AppColors.black_40));
  }
}
