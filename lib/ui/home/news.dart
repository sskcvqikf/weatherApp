import 'package:flutter/material.dart';
import 'package:weatherApp/ui/common/common.dart';
import 'package:weatherApp/utils/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class NewNews extends StatelessWidget {
  Widget _buildImage() {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
      child: Image(
        image: NetworkImage(
            'https://www.tagesspiegel.de/images/us-praesident-trump-und-gouverneur-brian-kemp/26691476/1-format530.jpg'),
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _buildTitle() {
    return ThemedText(
        "Initial COVID vaccine supply 10% of original government promise",
        12,
        SolarizedColorScheme.mainBG);
  }

  Widget _buildAuthor() {
    return Container(
        child: Row(
      children: [
        ThemedText("Christopher Stolz", 10, SolarizedColorScheme.secondaryBG),
        ThemedText(" | ", 10, SolarizedColorScheme.secondaryBG),
        ThemedText("2020.12.06 18:29", 10, SolarizedColorScheme.secondaryBG),
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: Container(
          color: SolarizedColorScheme.accentFG,
          margin: EdgeInsets.all(3),
          padding: EdgeInsets.all(5),
          child: Row(
            children: [
              Expanded(flex: 2, child: _buildImage()),
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    Container(child: _buildTitle()),
                    SizedBox(
                      height: 10,
                    ),
                    _buildAuthor()
                  ],
                ),
              )
            ],
          ),
        ),
        onLongPress: () async {
          const url =
              'https://www.tagesspiegel.de/politik/verzweifelter-anruf-in-georgia-trump-fordert-gouverneur-auf-die-wahl-noch-zu-kippen-doch-der-lehnt-ab/26229376.html';
          if (await canLaunch(url)) {
            await launch(url);
          } else {
            throw 'Could not launch $url';
          }
        });
  }
}

class NewsFeed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [NewNews(), NewNews(), NewNews()],
    ));
  }
}
