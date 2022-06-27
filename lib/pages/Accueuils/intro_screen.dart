import 'package:fashiontailor/pages/widgets/walkthrough.dart';
import 'package:fashiontailor/utils/storage_util.dart';
import 'package:flutter/material.dart';

import 'package:fashiontailor/utils/flutkart.dart';
import 'package:fashiontailor/utils/my_navigator.dart';

class IntroScreen extends StatefulWidget {
  static String tagIntroScreen = 'tagIntroScreen';

  @override
  IntroScreenState createState() {
    return IntroScreenState();
  }
}

class IntroScreenState extends State<IntroScreen> {
  final PageController controller = new PageController();
  int currentPage = 0;
  bool lastPage = false;
  var token = '';

 Future<void> _refreshData(String val) async {
   await StorageUtil.getInstance();
   token = StorageUtil.getString("token");
   print("Voici le token  :"+token);


   print("On enregistre EstInformer $val");
   StorageUtil.putString("estImformer", val.toString());

   var informe=StorageUtil.getString("estImformer");
   print("Voici EstInformer :"+informe);

  }

  void _onPageChanged(int page) {
    setState(() {


      currentPage = page;
      if (currentPage == 7) {
        lastPage = true;
        _refreshData(currentPage.toString());

      } else {
        lastPage = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFEEEEEE),
      padding: EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(),
          ),
          Expanded(
            flex: 3,
            child: PageView(
              children: <Widget>[
                Walkthrough(
                  title: Flutkart.wt1,
                  content: Flutkart.wc1,
                  imageIcon: Icons.mobile_screen_share,
                ),
                Walkthrough(
                  title: Flutkart.wt2,
                  content: Flutkart.wc2,
                  imageIcon: Icons.search,
                ),
                Walkthrough(
                  title: Flutkart.wt3,
                  content: Flutkart.wc3,
                  imageIcon: Icons.shopping_cart,
                ),
                Walkthrough(
                  title: Flutkart.wt4,
                  content: Flutkart.wc4,
                  imageIcon: Icons.verified_user,
                ),
                Walkthrough(
                  title: Flutkart.wt5,
                  content: Flutkart.wc5,
                  imageIcon: Icons.accessible_outlined,
                ),
                Walkthrough(
                  title: Flutkart.wt6,
                  content: Flutkart.wc6,
                  imageIcon: Icons.local_shipping_outlined,
                ),
                Walkthrough(
                  title: Flutkart.wt7,
                  content: Flutkart.wc7,
                  imageIcon: Icons.shopping_cart_outlined
                ),
                Walkthrough(
                  title: Flutkart.wt8,
                  content: Flutkart.wc8,
                  imageIcon: Icons.phone_in_talk_outlined,
                ),
              ],
              controller: controller,
              onPageChanged: _onPageChanged,
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                FlatButton(
                  child: Text(lastPage ? "" : Flutkart.skip,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0)),
                  onPressed: () =>
                  ((token==null)||(token==''))
                      ? MyNavigator.goToConnexion(context)
                      : MyNavigator.goToAcceuil(context)
                ),
                FlatButton(
                  child: Text(lastPage ? Flutkart.gotIt : Flutkart.next,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0)),
                  onPressed: () => lastPage
                      ? ((token==null)||(token==''))
                         ? MyNavigator.goToConnexion(context)
                         : MyNavigator.goToAcceuil(context)
                      : controller.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeIn),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
