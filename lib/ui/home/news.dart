import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:weatherApp/utils/colors.dart';

import 'package:weatherApp/requests/newsLogic.dart';

import 'package:weatherApp/bloc/newsBloc.dart';

import 'package:weatherApp/ui/common/common.dart';

class NewNews extends StatelessWidget {
  final String title;
  final String img_url;
  final String url;
  final String author;
  String date;

  NewNews(this.title, this.url, this.img_url, this.author, String date_) {
    date_ = date_.replaceAll('T', ' ');
    DateTime _dateTime = DateTime.parse(date_);
    String minute = DateFormat('m').format(_dateTime);
    minute = minute.length == 1 ? '0$minute' : minute;
    String hour = DateFormat('H').format(_dateTime);
    hour = hour.length == 1 ? '0$hour' : hour;
    this.date = '${DateFormat('yMd').format(_dateTime)} $hour:$minute';
  }
  Widget _buildImage() {
    ImageProvider<Object> image;
    if (img_url == null || img_url == 'local') {
      image = AssetImage('assets/asukaMock.jpg');
    } else {
      image = NetworkImage(img_url);
    }
    return Container(
      padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
      child: Image(
        image: image,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _buildTitle() {
    return ThemedText(
        title == null ? 'Loading...' : title, 12, SolarizedColorScheme.mainBG);
  }

  Widget _buildAuthor() {
    return Container(
        child: Row(
      children: [
        ThemedText(author == null ? 'Loading...' : author, 10,
            SolarizedColorScheme.secondaryBG),
        ThemedText(" | ", 10, SolarizedColorScheme.secondaryBG),
        ThemedText(date == null ? 'Loading...' : date, 10,
            SolarizedColorScheme.secondaryBG),
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
                    Container(
                        alignment: Alignment.topLeft, child: _buildTitle()),
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
          if (await canLaunch(url)) {
            await launch(url);
          } else {
            throw 'Could not launch $url';
          }
        });
  }
}

class NewsFeed extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NewsFeedState();
  }
}

class _NewsFeedState extends State<NewsFeed> {
  final _newsBloc = BlocProvider.getBloc<NewsBloc>();
  List<Map<String, String>> _news = List<Map<String, String>>();
  List<NewNews> _toDraw = List<NewNews>();

  @override
  void dispose() {
    _newsBloc.dispose();
    super.dispose();
  }

  @override
  initState() {
    super.initState();
    sendCurrentNewsStateBloc();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _newsBloc.newsStream,
      builder: (_, AsyncSnapshot<List<Map<String, String>>> snaphot) {
        if (snaphot.hasData) {
          _news = snaphot.data;

          for (var i in _news) {
            _toDraw.add(NewNews(
                i['title'], i['url'], i['img_url'], i['author'], i['date']));
          }
        }
        return Container(child: Column(children: _toDraw));
      },
    );
  }
}
