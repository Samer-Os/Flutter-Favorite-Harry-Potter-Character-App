import 'dart:convert';
import 'package:get/get.dart';
import '../Models/character.dart';
import 'package:http/http.dart' as http;

class CharacterController extends GetxController {
  String actorName = 'Hermione Granger';
  Character myInfo = Character(
    name: 'Oussama Samer',
    species: 'human',
    gender: 'male',
    yearOfBirth: '2000',
    actor: 'Developper',
    imageUrl: 'https://i.ibb.co/sgPSWfG/oussama.png',
  );
  Character actor = Character(
    name: '',
    species: '',
    gender: '',
    yearOfBirth: '',
    actor: '',
    imageUrl: '',
  );

  Future<void> fetchActorInfo() async {
    try {
      var url = Uri.parse('https://hp-api.onrender.com/api/characters');
      var response = await http.get(url);

      if (json.decode(response.body) == null) {
        return;
      }

      final extractedData = json.decode(response.body) as List<dynamic>;

      //print(extractedData[0]['name']);
      final actorInfo =
          extractedData.firstWhere((data) => data['name'] == actorName);
      actor.name = actorInfo['name'].toString();
      actor.species = actorInfo['species'].toString();
      actor.gender = actorInfo['gender'].toString();
      actor.yearOfBirth = actorInfo['yearOfBirth'].toString();
      actor.imageUrl = actorInfo['image'].toString();
      actor.actor = actorInfo['actor'].toString();
      update();
    } catch (error) {
      rethrow;
    }
  }
}
