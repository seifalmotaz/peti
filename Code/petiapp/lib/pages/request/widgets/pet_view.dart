import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petiapp/models/pet.dart';

class PetViewWidget extends StatelessWidget {
  final Pet pet;
  const PetViewWidget(this.pet, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * .4,
      height: Get.height * .3,
      decoration: BoxDecoration(
        color: pet.gender! == 'Female'
            ? const Color(0xFFFF80A6)
            : const Color(0xFF6BC1C1),
        borderRadius: BorderRadius.circular(11),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.23),
            spreadRadius: 3,
            blurRadius: 7,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 61,
            height: 61,
            child: CachedNetworkImage(
              imageUrl: pet.avatar!,
              errorWidget: (context, url, error) => const Icon(Icons.error),
              imageBuilder: (c, i) => CircleAvatar(
                backgroundColor: pet.gender == 'Female'
                    ? const Color(0xFFFF80A6)
                    : const Color(0xFF6BC1C1),
                backgroundImage: i,
              ),
            ),
          ),
          const SizedBox(height: 3),
          Text(
            '@' + pet.name!,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'CourgetteFont',
              fontSize: 21,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            pet.birthText,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
            ),
          ),
          Text(
            'gender: ' + pet.gender!,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
            ),
          ),
          Text(
            'breed: ' + (pet.breed ?? 'unknown'),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
