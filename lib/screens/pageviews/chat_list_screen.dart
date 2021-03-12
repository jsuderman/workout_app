import 'package:flutter/material.dart';
import 'package:workout_app/net/firebase_repo.dart';
import 'package:workout_app/utils/utils.dart';
import 'package:workout_app/widgets/appbar.dart';
import 'package:workout_app/widgets/custom_tile.dart';

class ChatListScreen extends StatefulWidget {
  ChatListScreen({Key key}) : super(key: key);

  @override
  _ChatListScreenState createState() => _ChatListScreenState();
}

//global var
final FirebaseRepo _repository = FirebaseRepo();

class _ChatListScreenState extends State<ChatListScreen> {
  String currentUserId;
  String initials;

  @override
  void initState() {
    super.initState();
    _repository.getCurrentAppUser().then((appUser) {
      setState(() {
        currentUserId = appUser.uid;
        initials = Utils.getInitials(appUser.displayName);
      });
    });
  }

  CustomAppBar customAppBar(BuildContext context) {
    return CustomAppBar(
      leading: IconButton(
        icon: Icon(
          Icons.notifications,
          color: Colors.white,
        ),
        onPressed: () {},
      ),
      title: UserCircle(initials),
      centerTitle: true,
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.search,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(
            Icons.more_vert,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: customAppBar(context),
      floatingActionButton: NewChatButton(),
      body: ChatListContainer(currentUserId),
    );
  }
}

class ChatListContainer extends StatefulWidget {
  final String currentUserId;

  ChatListContainer(this.currentUserId);

  @override
  _ChatListContainerState createState() => _ChatListContainerState();
}

class _ChatListContainerState extends State<ChatListContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(itemBuilder: (context, index) {
        return CustomTile(
          mini: false,
          onTap: () {},
          title: Text(
            "Justin Suderman",
            style: TextStyle(
              color: Colors.white,
              fontFamily: "Arial",
              fontSize: 19,
            ),
          ),
          subtitle: Text(
            "Last message in chat",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
          leading: Container(
            constraints: BoxConstraints(
              maxHeight: 60,
              maxWidth: 60,
            ),
            child: Stack(
              children: <Widget>[
                CircleAvatar(
                  maxRadius: 30,
                  backgroundColor: Colors.grey,
                  backgroundImage: NetworkImage(
                      "https://yt3.ggpht.com/a/AGF-17_zT8BuWwHTymaQaBptCy7WrsOD72gYGp-puw=s900-c-k-c0xffffffff-no-rj-mo"),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue,
                        border: Border.all(
                          color: Colors.black,
                          width: 2,
                        )),
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}

class UserCircle extends StatelessWidget {
  final String text;

  UserCircle(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.blueGrey,
      ),
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.amber,
                fontSize: 13,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              height: 12,
              width: 12,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.grey,
                  width: 2,
                ),
                color: Colors.green,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class NewChatButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [
            const Color(0xFF5032b6),
            const Color(0xFFb765d3),
          ],
        ),
      ),
      child: Icon(
        Icons.edit,
        color: Colors.white,
        size: 25,
      ),
      padding: EdgeInsets.all(15),
    );
  }
}
