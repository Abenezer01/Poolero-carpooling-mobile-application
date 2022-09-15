import 'package:carpooling_beta/app/Home/presentation/components/input_icon.dart';
import 'package:carpooling_beta/app/Home/presentation/components/switcher.dart';
import 'package:carpooling_beta/app/Home/presentation/controllers/map_controller.dart';
import 'package:carpooling_beta/app/core/components/my_button.dart';
import 'package:carpooling_beta/app/core/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RideForm extends GetWidget<MapController> {
  const RideForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20,
      right: 0,
      left: 0,
      child: Obx(
        () => Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          height: (controller.focusOnMap.value)
              ? 0
              : !controller.switchForm.value
                  ? 520
                  : 410,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(24)),
            boxShadow: [AppTheme.roundItemShadowColor],
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
            child: Obx(
              () => Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => controller.switchForm.value =
                              !controller.switchForm.value,
                          child: Switcher(
                            icon: 'assets/Search.png',
                            text: 'Find Offer',
                            active: controller.switchForm.value,
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => controller.switchForm.value =
                              !controller.switchForm.value,
                          child: Switcher(
                            icon: 'assets/Car.png',
                            text: 'Offer Ride',
                            active: !controller.switchForm.value,
                          ),
                        ),
                      ),
                    ],
                  ),
                  InputIcon(
                    textController: controller.originTextController.value,
                    icon: 'assets/Dot.png',
                    inputText: 'Choose your starting point',
                    readOnly: true,
                    onTap: () => controller.showSearchBar(context, 'origin'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 20,
                        child: Image.asset('assets/3 dots.png',
                            height: 20, fit: BoxFit.contain),
                      ),
                    ],
                  ),
                  InputIcon(
                      textController:
                          controller.destinationTextController.value,
                      icon: 'assets/pin-3.png',
                      inputText: 'Choose destination',
                      readOnly: true,
                      onTap: () {
                        controller.originTextController.value.text != ''
                            ? controller.showSearchBar(context, 'destination')
                            : Get.snackbar('Info',
                                'Please select the origin position first !',
                                colorText: Colors.white,
                                backgroundColor: AppTheme.accentColor);
                      }),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Expanded(
                        child: InputIcon(
                          textController:
                              controller.timePicker1Controller.value,
                          icon: 'assets/Clock2.png',
                          inputText: 'Pick a time from',
                          inputType: TextInputType.datetime,
                          readOnly: true,
                          onTap: () => controller.pickDatTime(context, 1),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: InputIcon(
                            textController:
                                controller.timePicker2Controller.value,
                            icon: 'assets/Clock2.png',
                            inputText: 'Pick a time to',
                            inputType: TextInputType.datetime,
                            readOnly: true,
                            onTap: () => controller.pickDatTime(context, 2),
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (!controller.switchForm.value)
                    Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: InputIcon(
                                textController:
                                    controller.choosedCarController.value,
                                icon: 'assets/Car 2.png',
                                inputText: 'Select your vehicule',
                                readOnly: true,
                                onTap: () {
                                  GlobalKey<NavigatorState>? carsDialog =
                                      GlobalKey<NavigatorState>();
                                  Get.defaultDialog(
                                    navigatorKey: carsDialog,
                                    title: 'Select your vehicule',
                                    titlePadding:
                                        EdgeInsets.symmetric(vertical: 10),
                                    // contentPadding:
                                    //     EdgeInsets.all(15),
                                    content: Container(
                                      width:
                                          context.mediaQuery.size.width * .99,
                                      child: Obx(
                                        () => (controller.carsList.isNotEmpty)
                                            ? Container(
                                                width: double.infinity,
                                                height: 300,
                                                child: GridView.builder(
                                                  itemCount: controller
                                                      .carsList.length,
                                                  gridDelegate:
                                                      SliverGridDelegateWithFixedCrossAxisCount(
                                                          crossAxisCount: 2),
                                                  shrinkWrap: true,
                                                  physics:
                                                      BouncingScrollPhysics(),
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    return Container(
                                                      width: 20,
                                                      margin: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 15,
                                                          horizontal: 10),
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(20.0),
                                                        ),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    .09),
                                                            offset:
                                                                Offset(0, 4),
                                                            blurRadius: 14,
                                                          ),
                                                        ],
                                                      ),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {
                                                              controller
                                                                      .choosedCarController
                                                                      .value
                                                                      .text =
                                                                  '${controller.carsList[index].model.name} - ${controller.carsList[index].mark.name}';
                                                              controller
                                                                      .choosedCar
                                                                      .value =
                                                                  controller
                                                                      .carsList[
                                                                          index]
                                                                      .id;
                                                              print(controller
                                                                  .carsList[
                                                                      index]
                                                                  .id);
                                                              Get.close(1);
                                                            },
                                                            child: Container(
                                                              height: 56,
                                                              child: Image.asset(
                                                                  'assets/Body Type.png'),
                                                            ),
                                                          ),
                                                          Text(
                                                            controller
                                                                .carsList[index]
                                                                .mark
                                                                .name,
                                                            style: TextStyle(
                                                              color: AppTheme
                                                                  .naturalColor2,
                                                              fontFamily:
                                                                  'Nunito',
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                          SizedBox(height: 5),
                                                          Text(
                                                            controller
                                                                .carsList[index]
                                                                .model
                                                                .name,
                                                            style: TextStyle(
                                                              color: AppTheme
                                                                  .naturalColor4,
                                                              fontFamily: AppTheme
                                                                  .primaryFont,
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                ),
                                              )
                                            : Center(
                                                child:
                                                    Text('No cars to select'),
                                              ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: InputIcon(
                                textController:
                                    controller.totalCostController.value,
                                icon: 'assets/Clock2.png',
                                inputText: 'Total Cost',
                                inputType: TextInputType.number,
                              ),
                            ),
                            Expanded(
                              child: Container(
                                child: InputIcon(
                                  icon: 'assets/Car 2.png',
                                  inputText: 'Numbre of Free Spots',
                                  inputType: TextInputType.number,
                                  textController:
                                      controller.numFreeSpotsController.value,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  Row(
                    children: (!controller.switchForm.value)
                        ? [
                            //AllowPauses
                            Expanded(
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 20,
                                    child: Checkbox(
                                      value: controller.allowPauses.value,
                                      onChanged: (value) {
                                        controller.allowPauses.value = value!;
                                      },
                                      activeColor: AppTheme.primaryColor,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Text('Pauses'),
                                ],
                              ),
                            ),
                            //AllowBigBags
                            Expanded(
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 20,
                                    child: Checkbox(
                                      value: controller.allowBigBags.value,
                                      onChanged: (value) {
                                        controller.allowBigBags.value = value!;
                                      },
                                      activeColor: AppTheme.primaryColor,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Text('Big Bags'),
                                ],
                              ),
                            ), //AllowBigBags
                            Expanded(
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 20,
                                    child: Checkbox(
                                      value: controller.allowSmocking.value,
                                      onChanged: (value) {
                                        controller.allowSmocking.value = value!;
                                      },
                                      activeColor: AppTheme.primaryColor,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Text('Smocking'),
                                ],
                              ),
                            )
                          ]
                        : [
                            Expanded(
                              child: Container(
                                child: InputIcon(
                                  icon: 'assets/Car 2.png',
                                  inputText: 'Numbre of requested seats',
                                  inputType: TextInputType.number,
                                  textController:
                                      controller.requestedSeatsController.value,
                                ),
                              ),
                            ),
                          ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: MyButton(
                          isPrimary: true,
                          isDisabled: false,
                          textTitle:
                              controller.switchForm.value ? 'Find' : 'Offre',
                          onPresse: () {
                            (!controller.switchForm.value)
                                ? controller.addRide()
                                : controller.findRide();
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
