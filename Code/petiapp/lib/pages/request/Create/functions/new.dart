import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:petiapp/models/pet.dart';
import 'package:petiapp/pages/pet/create/create.dart';
import 'package:petiapp/pages/request/Create/widgets/confirm.dart';
import 'package:petiapp/providers/pet.dart';

newRequestDialog(Pet pet) async {
  Response res = await PetProvider().owned();
  if (res.statusCode == 200) {
    List<Pet> pets = [for (var item in res.data) Pet.fromMap(item)];
    if (pets.length == 1) {
      return await Get.bottomSheet(ConfirmWidget(pet, pets.first));
    }
    if (pets.isEmpty) {
      return await Get.showSnackbar(GetBar(
        message: 'You have no pets',
        duration: const Duration(seconds: 3),
        mainButton: TextButton(
          onPressed: () async => await Get.to(const PetCreatePage()),
          child: const Text('Add one'),
        ),
      ));
    }
    return await Get.bottomSheet(Container(
      padding: const EdgeInsets.all(13),
      margin: const EdgeInsets.all(13),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(23)),
      ),
      child: ListView(
        shrinkWrap: true,
        children: [
          ListTile(
            title: const Text('Choose a pet'),
            subtitle: Text('pet ${pet.name} will marraige one of your pets'),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: pets.length,
            itemBuilder: (context, index) {
              Pet thePet = pets[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 13),
                child: InkWell(
                  onTap: () {
                    Get.back();
                    Get.bottomSheet(ConfirmWidget(pet, thePet));
                  },
                  child: Row(
                    children: [
                      CachedNetworkImage(
                        imageUrl: thePet.avatar!,
                        imageBuilder: (context, imageProvider) {
                          return CircleAvatar(
                            radius: 30,
                            backgroundImage: imageProvider,
                          );
                        },
                      ),
                      const SizedBox(width: 5),
                      Text(
                        '@' + thePet.name!,
                        style: const TextStyle(
                          fontFamily: 'CRFont',
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    ));
  }
}
