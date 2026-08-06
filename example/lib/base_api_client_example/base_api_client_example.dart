import 'package:example/base_api_client_example/domain/entity/user_entity.dart';
import 'package:example/base_api_client_example/presentation/cubit/user_cubit.dart';
import 'package:example/base_api_client_example/util/screen_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class BaseApiClientExample extends StatelessWidget {
  final String title;

  const BaseApiClientExample({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.I.get<UserCubit>()..loadUsers(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(
            title,
            style: TextStyle(fontSize: 18.asp),
          ),
        ),
        body: BlocBuilder<UserCubit, UserState>(
          // Only rebuild when state type or content changes.
          buildWhen: (prev, curr) => prev != curr,
          builder: (context, state) => switch (state) {
            UserInitial() || UserLoading() => const Center(
                child: CircularProgressIndicator(),
              ),
            UserLoaded(:final users) => _UserList(users: users),
            UserError(:final failure) => _ErrorView(message: failure.toString()),
          },
        ),
      ),
    );
  }
}

// ── Private sub-widgets ────────────────────────────────────────────────────

class _UserList extends StatelessWidget {
  final List<UserEntity> users;

  const _UserList({required this.users});

  @override
  Widget build(BuildContext context) {
    if (users.isEmpty) {
      return Center(
        child: Text(
          'No users found.',
          style: TextStyle(fontSize: 14.asp),
        ),
      );
    }

    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 16.aw, vertical: 12.ah),
      itemCount: users.length,
      separatorBuilder: (_, _) => SizedBox(height: 8.ah),
      itemBuilder: (context, index) => _UserTile(user: users[index]),
    );
  }
}

class _UserTile extends StatelessWidget {
  final UserEntity user;

  const _UserTile({required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.ar),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.aw, vertical: 12.ah),
        child: Row(
          children: [
            CircleAvatar(
              radius: 22.ar,
              backgroundColor:
                  Theme.of(context).colorScheme.primaryContainer,
              child: Text(
                user.name.isNotEmpty ? user.name[0].toUpperCase() : '?',
                style: TextStyle(
                  fontSize: 16.asp,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
            ),
            SizedBox(width: 12.aw),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name,
                    style: TextStyle(
                      fontSize: 15.asp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 2.ah),
                  Text(
                    user.email,
                    style: TextStyle(
                      fontSize: 13.asp,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;

  const _ErrorView({required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.aw),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14.asp,
            color: Theme.of(context).colorScheme.error,
          ),
        ),
      ),
    );
  }
}
