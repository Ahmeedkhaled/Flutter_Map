import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_profile/buseniess_logic/cubit/phone_auth/phone_auth_cubit.dart';
import 'package:my_profile/core/routes.dart';

class HomePage extends StatelessWidget {
  PhoneAuthCubit phoneAuthCubit=PhoneAuthCubit();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocProvider<PhoneAuthCubit>(
        create: (context) => phoneAuthCubit,
        child: ElevatedButton(
              onPressed: () async{
            await phoneAuthCubit.logOut();
      Navigator.of(context).pushReplacementNamed(MyRoutes.loginScreen);
      
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(110, 50),
                backgroundColor: Colors.black,
                shape:
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
              ),
              child: const Text(
                "Next",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
      ),
    );
  }
}
