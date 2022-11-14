part of 'newuser_cubit.dart';

abstract class NewuserState extends Equatable {
  const NewuserState();

  @override
  List<Object> get props => [];
}

class NewuserInitial extends NewuserState {}

class NewuserLoaded extends NewuserState {
  final bool isNewUser;

  const NewuserLoaded({required this.isNewUser});

  @override
  List<Object> get props => [isNewUser];

  @override
  String toString() => 'NewuserLoaded(isNewUser: $isNewUser)';
}

class NewuserError extends NewuserState {
  final String message;

  const NewuserError({required this.message});

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'NewuserError(message: $message)';
}
