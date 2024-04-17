part of 'phone_auth_cubit.dart';

@immutable
sealed class PhoneAuthState {}

final class PhoneAuthInitial extends PhoneAuthState {}
final class PhoneAuthLoading extends PhoneAuthState {}
final class PhoneAuthError extends PhoneAuthState {
  final String errorMessage;
  PhoneAuthError({required this.errorMessage});
}
final class PhoneAuthSubmited extends PhoneAuthState {}
final class PhoneOtpVerified extends PhoneAuthState {}

