import 'package:flutter/material.dart';

class User {
  final int? id;
  final String? name;
  final String? image;
  final String? location;
  final int? photos;
  final bool gender;
  final int? distance;
  final int? age;

  User({
    this.id,
    this.name,
    this.image,
    this.location,
    this.photos,
    this.distance,
    required this.gender,
    this.age,
  });
}

List<User> userdata = [
  User(
    id: 0,
    name: "Peter Mwangi",
    image: "assets/images/peter.png",
    location: "Nakuru Kenya",
    photos: 23,
    distance: 4,
    age: 19,
    gender: true,
  ),
  User(
    id: 1,
    name: "Shiko Mourine",
    image: "assets/images/ali.png",
    location: "Garrisa Kenya",
    photos: 2,
    distance: 40,
    age: 20,
    gender: false,
  ),
  User(
    id: 2,
    name: "Trevor",
    image: "assets/images/sandra.png",
    location: "Nairobi Kenya",
    photos: 1,
    distance: 20,
    age: 30,
    gender: true,
  ),
  User(
    id: 3,
    name: "Stella Gilu",
    image: "assets/images/stella.png",
    location: "Machakos Kenya",
    photos: 3,
    distance: 50,
    age: 24,
    gender: false,
  ),
  User(
    id: 4,
    name: "Eunice Wambo",
    image: "assets/images/trevor.png",
    location: "Nakuru Kenya",
    photos: 2,
    distance: 2,
    age: 18,
    gender: false,
  ),
];
