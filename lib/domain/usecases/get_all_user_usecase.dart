

import 'package:linkapp/domain/entities/user_entity.dart';
import 'package:linkapp/domain/repositories/firebase_repository.dart';

class GetAllUserUseCase{
  final FirebaseRepository repository;

  GetAllUserUseCase({this.repository});

  Stream<List<UserEntity>> call(){
    return repository.getAllUsers();
  }

}