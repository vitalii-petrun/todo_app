import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/group_provider.dart';

///Menu to navigate between groups and creating new group.
class GroupsMenuWidget extends StatelessWidget {
  ///Receives groups list.
  const GroupsMenuWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, "/create_group_screen");
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.add),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    "Create new group",
                    style: TextStyle(
                      color: Theme.of(context).primaryColorDark,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Consumer<GroupProvider>(
            builder: (context, provider, child) {
              return provider.tabIndex == 0
                  ? const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Text(
                        "Default group cannot be deleted",
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  : TextButton(
                      onPressed: () {
                        provider.delete(provider.items[provider.tabIndex].id);

                        Navigator.pop(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Text(
                              "Delete this group",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    );
            },
          ),
        ],
      ),
    );
  }
}
