import 'package:ecomarce/Widgets/CatAppBar.dart';
import 'package:ecomarce/helpers/apihelper.dart';
import 'package:ecomarce/provider/storage/init.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  bool loading = false;
  var data;

  getProfileInfo() async {
    setState(() {
      loading = true;
    });
    var info = await ApiHelper.callapi(path: "/profile");
    setState(() {
      data = info;
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getProfileInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: cartAppBar(context, title: "Profile"),
      body: Center(
        child: Builder(builder: (context) {
          if (loading) {
            return CircularProgressIndicator(
              color: Colors.black,
            );
          } else if (data == null) {
            return Text('Data Not Found');
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(data['dpic'].toString()),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  data['name'].toString(),
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: TextButton(
                      onPressed: () async {
                        await LocalDB.instense
                            .setStorege(key: 'auth', data: {});
                        GoRouter.of(context)
                            .pushReplacement(Uri(path: '/').toString());
                      },
                      child: Text("Logout")),
                )
              ],
            );
          }
        }),
      ),
    );
  }
}
