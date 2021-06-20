import 'package:flutter/material.dart';
import 'package:linkapp/bottomnav.dart';
import 'package:linkapp/presentation/widgets/custom_tab_bar.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkapp/data/model/user_model.dart';
import 'package:linkapp/presentation/bloc/auth/auth_cubit.dart';
import 'package:linkapp/presentation/bloc/communication/communication_cubit.dart';
import 'package:linkapp/presentation/bloc/get_device_number/get_device_numbers_cubit.dart';
import 'package:linkapp/presentation/bloc/my_chat/my_chat_cubit.dart';
import 'package:linkapp/presentation/bloc/phone_auth/phone_auth_cubit.dart';
import 'package:linkapp/presentation/bloc/user/user_cubit.dart';
import 'package:linkapp/presentation/screens/home_screen.dart';
import 'package:linkapp/presentation/screens/welcome_screen.dart';
import 'package:linkapp/presentation/widgets/theme/style.dart';
import 'injection_container.dart' as di;



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.sl<AuthCubit>()..appStarted(),
        ),
        BlocProvider(
          create: (_) => di.sl<PhoneAuthCubit>(),
        ),
        BlocProvider<UserCubit>(
          create: (_) => di.sl<UserCubit>()..getAllUsers(),
        ),
        BlocProvider<GetDeviceNumbersCubit>(
          create: (_) => di.sl<GetDeviceNumbersCubit>(),
        ),
        BlocProvider<CommunicationCubit>(
          create: (_) => di.sl<CommunicationCubit>(),
        ),
        BlocProvider<MyChatCubit>(
          create: (_) => di.sl<MyChatCubit>(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'LinkApp Chat',
        theme: ThemeData(primaryColor: primaryColor),
        routes: {
          "/": (context) {
            return BlocBuilder<AuthCubit, AuthState>(
              builder: (context, authState) {
                if (authState is Authenticated) {
                  return BlocBuilder<UserCubit, UserState>(
                    builder: (context, userState) {
                      if (userState is UserLoaded) {
                        final currentUserInfo = userState.users.firstWhere(
                                (user) => user.uid == authState.uid,
                            orElse: () => UserModel());
                        return Chat(
                          userInfo: currentUserInfo,
                        );
                      }
                      return Container();
                    },
                  );
                }
                if (authState is UnAuthenticated) {
                  return WelcomeScreen();
                }
                return Container();
              },
            );
          }
        },
      ),
    );
  }
}