
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe_game/core/provider/room_provider.dart';
import 'package:tictactoe_game/core/routes/routes.dart';
import 'package:tictactoe_game/core/utils/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RoomDataProvider(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Tic Tac Toe Game',
        theme: ThemeData.dark(
          useMaterial3: true,
        ).copyWith(
          scaffoldBackgroundColor: bgColor,
          colorScheme: const ColorScheme.dark().copyWith(
            primary: Colors.white,
            secondary: secondaryColor,
          ),
          textTheme:
              GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme.apply(
                    bodyColor: Colors.white,
                    displayColor: Colors.white,
                  )),
        ),
        routerConfig: router,
      ),
    );
  }
}
