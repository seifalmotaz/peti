import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petiapp/models/pet.dart';
import 'package:petiapp/pages/post/create/controller/post.dart';

class PetsList extends StatelessWidget {
  final List<Pet> pets;
  const PetsList(this.pets, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PostCreateController controller = Get.find<PostCreateController>();
    return RefreshIndicator(
      onRefresh: () async => await controller.getPets(),
      child: ListView.builder(
        padding: const EdgeInsets.all(13),
        itemCount: pets.length,
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        itemBuilder: (context, index) {
          Pet pet = pets[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 13),
            child: InkWell(
              onTap: () {
                controller.pet.value = pet;
                controller.chooseType();
              },
              child: Row(
                children: [
                  CachedNetworkImage(
                    imageUrl: pet.avatar!,
                    imageBuilder: (context, imageProvider) {
                      return CircleAvatar(
                        radius: 30,
                        backgroundImage: imageProvider,
                      );
                    },
                  ),
                  const SizedBox(width: 5),
                  Text(
                    '@' + pet.name!,
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
    );
  }
}
