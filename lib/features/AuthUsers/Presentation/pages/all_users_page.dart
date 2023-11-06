import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto_c2/features/AuthUsers/Presentation/cubit/user/user_cubit.dart';
import 'package:proyecto_c2/features/AuthUsers/Presentation/widgets/single_item_user_widget.dart';

class AllUsersPage extends StatefulWidget {
  final String uid;
  final String? query;

  const AllUsersPage({Key? key, required this.uid, this.query})
      : super(key: key);

  @override
  _AllUsersPageState createState() => _AllUsersPageState();
}

class _AllUsersPageState extends State<AllUsersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, userState) {
          if (userState is UserLoaded) {
            final users = userState.users
                .where((element) => element.uid != widget.uid)
                .toList();

            final filteredUsers = users
                .where((user) =>
                    user.name.startsWith(widget.query!) ||
                    user.name.startsWith(widget.query!.toLowerCase()))
                .toList();
            return Column(
              children: [
                Expanded(
                    child: filteredUsers.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.group,
                                  size: 40,
                                  color: Color.fromARGB(255, 0, 0, 0)
                                      .withOpacity(.4),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Aún no hay usuarios",
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(.2)),
                                )
                              ],
                            ),
                          )
                        : ListView.builder(
                            itemCount: filteredUsers.length,
                            itemBuilder: (_, index) {
                              return SingleItemStoriesStatusWidget(
                                user: filteredUsers[index],
                              );
                            },
                          ))
              ],
            );
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}