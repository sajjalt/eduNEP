import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/subject_provider.dart';

import '../widgets/subject_tile.dart';

class DashboardScreen extends StatefulWidget {
  static const routeName = '/dashboard-Screen';
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    final subjectListProvider = Provider.of<Subjects>(context);
    final subjectList = subjectListProvider.subList;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo[50],
        elevation: 0,
        leading: InkWell(
          onTap: () {},
          child: Icon(
            Icons.menu,
            color: Colors.indigo[700],
          ),
        ),
      ),
      backgroundColor: Colors.indigo[50],
      body: Container(
        padding: EdgeInsets.only(top: 0, left: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Hello Student",
                  style: TextStyle(fontSize: 20, color: Colors.indigo[700]),
                ),
                Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage('assets/images/profilePic.png'))),
                )
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'What do you\nwant to \nlearn Today?',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900),
            ),
            // SizedBox(
            //   height: 5,
            // ),
            Divider(
              thickness: 3,
              color: Colors.indigo[700],

            ),
            Expanded(
              child: ListView.builder(
                itemCount: subjectList.length,
                itemBuilder: (ctx, i) {
                  return ChangeNotifierProvider.value(
                    value:subjectList[i],
                    child: SubjectTile(),
                  );
                } ,
                // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //   crossAxisCount: 1,
                //   childAspectRatio: 3 / 1.75,
                //   mainAxisSpacing: 15,
                //   crossAxisSpacing: 10,
                // ),
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    onPressed: (){},
                    icon: Icon(Icons.subscriptions,
                    color: Colors.indigo[700],
                    size: 30,
                    ),
                  ),
                  IconButton(
                    onPressed: (){},
                    icon: Icon(Icons.play_circle_filled,
                    color: Colors.indigo[700].withOpacity(0.5),
                    size: 30,
                    ),
                  ),
                  IconButton(
                    onPressed: (){},
                    icon: Icon(Icons.account_circle,
                    color: Colors.indigo[700],
                    size: 30,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
