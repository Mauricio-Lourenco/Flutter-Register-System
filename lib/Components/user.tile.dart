import 'package:flutter/material.dart';
import 'package:flutter_crud/models/user.dart';
import 'package:flutter_crud/provider/users.dart';
import 'package:flutter_crud/routes/app_routes.dart';
import 'package:provider/provider.dart';

class UserTile extends StatelessWidget {
  final User user;

  const UserTile(this.user);

  @override
  Widget build(BuildContext context) {
    final avatar = user.avatarUrl == ''
        ? CircleAvatar(child: Icon(Icons.person))
        : CircleAvatar(backgroundImage: NetworkImage(user.avatarUrl!));
    return ListTile(
      leading: avatar,
      title: Text(user.name),
      subtitle: Text(user.email),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              color: const Color.fromARGB(255, 38, 152, 209),
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.USER_FORM,
                  arguments: user,
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              color: Colors.red,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Excluir Usuário'),
                    content: Text('Tem Certeza?'),
                    actions: <Widget>[
                      FloatingActionButton(
                        child: Text('Não'),
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                      ),
                      FloatingActionButton(
                        child: Text('Sim'),
                        onPressed: () {
                          Provider.of<Users>(context, listen: false)
                              .delete(user);
                          Navigator.of(context).pop(true);
                        },
                      ),
                    ],
                  ),
                ).then((confimed) {
                  if (confimed) {
                    Provider.of<Users>(
                      context,
                    ).delete(user);
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
