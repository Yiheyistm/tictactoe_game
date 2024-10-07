import 'package:go_router/go_router.dart';
import 'package:tictactoe_game/core/routes/route_names.dart';
import 'package:tictactoe_game/core/screen/create_game_room.dart';
import 'package:tictactoe_game/core/screen/game_room.dart';
import 'package:tictactoe_game/core/screen/join_game_room.dart';
import 'package:tictactoe_game/core/screen/main_menu.dart';
import 'package:tictactoe_game/core/widgets/waiting_lobby.dart';

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
      builder: (context, state) => const JoinGameRoom(),
    ),
    GoRoute(
      name: RouteName.gameRoom,
      path: '/game-room',
      builder: (context, state) => const GameRoom(),
    ),
    GoRoute(
      name: RouteName.waitingLobby,
      path: '/waiting-lobby',
      builder: (context, state) => const WaitingLobby(),
    ),
  ],
);
