import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive/rive.dart';

import 'cubit/main_cubit.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainCubit(),
      child: Scaffold(
        body: Center(
          child: BlocBuilder<MainCubit, MainState>(
            builder: (context, state) {
              return Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          context.read<MainCubit>().getSuccess();
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(6.0),
                          child: Text(
                            'Success',
                            style: TextStyle(
                              fontSize: 32,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 50),
                      ElevatedButton(
                        onPressed: () {
                          context.read<MainCubit>().getError();
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(6.0),
                          child: Text(
                            'Fail',
                            style: TextStyle(
                              fontSize: 32,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (state is MainLoading) ...{
                    BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 5.0,
                        sigmaY: 5.0,
                      ),
                      child: Container(
                        color: Colors.transparent,
                      ),
                    ),
                    Transform.scale(
                      scale: 0.5,
                      child: RiveAnimation.asset(
                        'assets/animation.riv',
                        onInit: context.read<MainCubit>().onInitAnimation,
                      ),
                    ),
                  },
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
