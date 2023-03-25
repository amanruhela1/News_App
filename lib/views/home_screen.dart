import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/news_bloc.dart';
import '../blocs/news_states.dart';
import '../models/article_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
          body: Stack(
        children: [
          Container(
            color: Color.fromARGB(255, 15, 23, 42),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: width * 0.03),
                      child: Text(
                        "Top News",
                        style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: width * 0.03),
                      child: Icon(Icons.search, size: 26, color: Colors.white,)
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            color: Color.fromARGB(255, 15, 23, 42),
            margin: EdgeInsets.only(top: height * 0.08),
            child: BlocBuilder<NewsBloc, NewsStates>(
              builder: (BuildContext context, NewsStates state) {
                if (state is NewsLoadingState) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is NewsLoadedState) {
                  List<ArticleModel> _articleList = [];
                  _articleList = state.articleList;
                  return ListView.builder(
                      itemCount: _articleList.length,
                      itemBuilder: (context, index) {
                        return Container(
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 38, 40, 56),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 1,
                                      color: Color.fromARGB(255, 38, 40, 56),
                                      offset: Offset(0, 2),
                                      spreadRadius: 1)
                                ]),
                            height: height * 0.18,
                            margin: EdgeInsets.only(
                                bottom: height * 0.01,
                                top: height * 0.01,
                                left: width * 0.02,
                                right: width * 0.02),
                            child: Row(
                              children: [
                                Container(
                                  width: width * 0.40,
                                  height: height * 0.18,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                      ),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                            _articleList[index].urlToImage.toString()!=
                                                    null
                                                ? _articleList[index].urlToImage.toString()
                                                : "https://www.shutterstock.com/image-photo/visual-contents-concept-social-networking-service-1896527446",
                                          ),
                                          fit: BoxFit.cover)),
                                ),
                                SizedBox(
                                  width: width * 0.03,
                                ),
                                Container(
                                  height: height * 0.18,
                                  width: width * 0.50,
                                  padding: EdgeInsets.symmetric(
                                      vertical: height * 0.01),
                                  child: Text(
                                    _articleList[index].title.toString(),
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                )
                              ],
                            ),
                        );
                      });
                } else if (state is NewsErrorState) {

                  String error = state.errorMessage;
                  return Center(child: Text(error));

                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      )),
    );
  }
}