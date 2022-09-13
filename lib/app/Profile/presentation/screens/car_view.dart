import 'package:carpooling_beta/app/Profile/presentation/controllers/car_controller.dart';
import 'package:carpooling_beta/app/core/components/my_button.dart';
import 'package:carpooling_beta/app/core/components/my_text_field.dart';
import 'package:carpooling_beta/app/core/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CarView extends GetWidget<CarController> {
  const CarView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          Get.arguments['addCar'] ? 'Add Car' : 'Edit Car',
          style: TextStyle(
            color: AppTheme.naturalColor1,
            fontFamily: AppTheme.primaryFont,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppTheme.naturalColor1,
          ),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
        elevation: 0,
        shadowColor: Colors.black.withOpacity(.08),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          padding: EdgeInsets.fromLTRB(30, 30, 30, 0),
          child: Column(
            children: [
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/Body Type.png',
                          fit: BoxFit.cover,
                          width: 80,
                        ),
                        SizedBox(height: 20),
                        // Text(
                        //   'Change Picture',
                        //   style: TextStyle(
                        //     color: AppTheme.primaryColor,
                        //     fontFamily: AppTheme.primaryFont,
                        //     fontSize: 14,
                        //     fontWeight: FontWeight.w600,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              // MyTextField(labelText: 'Make'),
              Obx(
                () => DropdownButton(
                  hint: Text(
                    'choose one mark',
                  ),
                  isExpanded: true,
                  value: controller.car.value.mark.id.isNotEmpty
                      ? controller.car.value.mark.id
                      : null,
                  onChanged: (value) {
                    controller.car.update((val) {
                      val!.mark.id = value.toString();
                      val.mark.name = controller.marks
                          .firstWhere((el) => el.id == value)
                          .name
                          .toString();
                    });
                  },
                  items: controller.marks
                      .map((vl) =>
                          DropdownMenuItem(value: vl.id, child: Text(vl.name)))
                      .toList(),
                ),
              ),
              SizedBox(height: 20),
              Obx(
                () => DropdownButton(
                  hint: Text(
                    'choose one color',
                  ),
                  isExpanded: true,
                  value: controller.car.value.color.id.isNotEmpty
                      ? controller.car.value.color.id
                      : null,
                  onChanged: (value) {
                    controller.car.update((val) {
                      val!.color.id = value.toString();
                      val.color.name = controller.colors
                          .firstWhere((el) => el.id == value)
                          .name
                          .toString();
                    });
                  },
                  items: controller.colors
                      .map((vl) =>
                          DropdownMenuItem(value: vl.id, child: Text(vl.name)))
                      .toList(),
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      child: Obx(
                        () => DropdownButton(
                          value: controller.car.value.model.id.isNotEmpty
                              ? controller.car.value.model.id
                              : null,
                          onChanged: (value) {
                            controller.car.update((val) {
                              val!.model.id = value.toString();
                              val.model.name = controller.models
                                  .firstWhere((el) => el.id == value)
                                  .name
                                  .toString();
                            });
                          },
                          hint: Text(
                            'choose one model',
                          ),
                          isExpanded: true,
                          items: controller.models
                              .map((vl) => DropdownMenuItem(
                                  value: vl.id, child: Text(vl.name)))
                              .toList(),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Container(
                      child: Obx(
                        () => DropdownButton(
                          hint: Text(
                            'choose one category',
                          ),
                          isExpanded: true,
                          value: controller.car.value.category.id.isNotEmpty
                              ? controller.car.value.category.id
                              : null,
                          onChanged: (value) {
                            controller.car.update((val) {
                              val!.category.id = value.toString();
                              val.category.name = controller.categories
                                  .firstWhere((el) => el.id == value)
                                  .name
                                  .toString();
                            });
                          },
                          items: controller.categories
                              .map((vl) => DropdownMenuItem(
                                  value: vl.id, child: Text(vl.name)))
                              .toList(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: MyTextField(
                      textController: controller.modelYearController,
                      labelText: 'Model Year',
                      inputType: TextInputType.datetime,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 60),
              Row(
                children: [
                  if (!Get.arguments['addCar'])
                    Expanded(
                      child: Container(
                        child: MyButton(
                          onPresse: () {
                            controller.questionDialog(controller.car.value.id);
                          },
                          isPrimary: false,
                          isDisabled: false,
                          isDecline: true,
                          textTitle: 'Delete Car',
                        ),
                      ),
                    ),
                  if (!Get.arguments['addCar']) SizedBox(width: 15),
                  Expanded(
                    child: Container(
                      child: MyButton(
                        onPresse: () {
                          !Get.arguments['addCar']
                              ? controller.updateCar(controller.car.value)
                              : controller.addCar(controller.car.value);
                        },
                        isPrimary: true,
                        isDisabled: false,
                        textTitle:
                            !Get.arguments['addCar'] ? 'Update Car' : 'Add Car',
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
