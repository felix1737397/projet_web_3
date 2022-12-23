import '../entities/livre_entity.dart';
import '../services/livre.service.dart';
import '../services/auteur.service.dart';
import '../services/user.service.dart';

class UserController {
  static Future<String> getUserPermission(
      String identifiant, String motDePasse) async {
    return await Userservice.getUserPermission(identifiant, motDePasse);
  }
}
