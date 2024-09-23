import 'package:go_router/go_router.dart';
import 'package:tictactoe_game/core/routes/route_names.dart';
import 'package:tictactoe_game/core/screen/create_game_room.dart';
import 'package:tictactoe_game/core/screen/main_menu.dart';

GoRouter router = GoRouter(
  routes: [
    GoRoute(
      name: RouteName.mainMenu,
      path: '/',
      builder: (context, state) => const MainMenuScreen(),
    ),
    GoRoute(
      name: RouteName.createRoom,
      path: '/create-room',
      builder: (context, state) => const CreateGameRoom(),
    ),
    GoRoute(
      name: RouteName.joinRoom,
      path: '/join-room',
      builder: (context, state) => const CreateGameRoom(),
    )
  ],
);
