import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:magic/src/repository/shared_preference.dart';

part 'newuser_state.dart';

class NewuserCubit extends Cubit<NewuserState> {
  final SharedPreferenceRepo sharedPreferenceRepo;
  NewuserCubit({required this.sharedPreferenceRepo}) : super(NewuserInitial());

  Future<void> decideNewOrOldUser() async {
    try {
      bool value = await sharedPreferenceRepo.getNewUserValue();
      emit(NewuserLoaded(isNewUser: value));
    } catch (e) {
      emit(NewuserError(message: e.toString()));
    }
  }
}
