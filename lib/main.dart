import 'package:english_words/english_words.dart' as prefix0;
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
        return new MaterialApp(
        title: 'Startup Name Generator',

        theme: new ThemeData(primaryColor: Colors.green),
//      home: new RandomWords(),//listView
        home: new TutorialsPage(),


    );
//    Widget buttonSection = Container(
//      child: Row(
//        // 沿水平方向平均放置
//        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//        children: <Widget>[
//          _buildButtonColumn(context,Icons.call,'CALL'),
//          _buildButtonColumn(context,Icons.near_me,'ROUTE'),
//          _buildButtonColumn(context,Icons.share,'SHARE'),
//        ],
//      ),
//    );
//    return buttonSection;
  }

}

class RandomWords extends StatefulWidget {
  @override
  createState() => new RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);

  final _saved = new Set<WordPair>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Startup Name Generator'),
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.list), onPressed: _pushSaved)
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions() {
    return new ListView.builder(
      padding: const EdgeInsets.all(16.0),
      //itemBuilder 在每次生成一个单词对时 被回调
      //每一行都是用ListTIle代表
      //对于偶数行，这个回调函数都添加一个ListTile组件保存单词对
      //对于奇数行，这个回调函数都会添加一个Dicider来再视觉上分割单词对
      //注意，在小设备上看到分隔物可能会非常困难
      itemBuilder: (context, i) {
        //在ListView组件的每行之前，先添加一个像素高度的分割
        if (i.isOdd) return new Divider();
        final index = i ~/ 2;
        if (index >= _suggestions.length) {
          //生成10个单词对到建议的名称列表中
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[index]);
      },
    );
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);
    return new ListTile(
      title: new Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: new Icon(alreadySaved ? Icons.favorite : Icons.favorite_border,
          color: alreadySaved ? Colors.red : null),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) {
          final tiles = _saved.map(
            (pair) {
              return new ListTile(
                title: new Text(pair.asPascalCase, style: _biggerFont),
              );
            },
          );
          final divided = ListTile.divideTiles(context: context, tiles: tiles
                  // ignore: missing_return
                  )
              .toList();
          return new Scaffold(
            appBar: new AppBar(title: new Text('Saved Suggestions')),
            body: new ListView(children: divided),
          );
        },
      ),
    );
  }
}

class TutorialsPage extends StatefulWidget {
  @override
  _TutorialsPageState createState() => _TutorialsPageState();
}

class _TutorialsPageState extends State<TutorialsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          _buildHeader(), //第一部分头部图片
          Padding(
            child: Column(
              children: <Widget>[
                _buildSecond() //第二部分
              ],
            ),
            padding: const EdgeInsets.only(left: 30.0, right: 30.0),
          ),

        ],
      ),
    );
  }

  Widget _buildHeader() {
    // 这里对应的是图片
    return Image.asset("assets/lakes_header.jpg");
//    return Image.network("https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1571826111239&di=64310b0d13d58c4df3d15016affcaff4&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201807%2F09%2F20180709235634_HEh8H.thumb.700_0.jpeg"
//    ,width: 800.0,
//    height: 600.0,);
  }

  Widget _buildSecond() {
    Widget row = Row(children: <Widget>[
      Expanded(
        child: Column(
          children: <Widget>[
            Text('旅游圣地'),
            Text(
              '不要钱',
              style: TextStyle(color: Colors.green, fontSize: 12.0),
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
      ),
      Row(
        children: <Widget>[
          Icon(
            Icons.star,
            color: Colors.yellow,
          ),
          Text('99')
        ],
      )
    ]);
    row = SizedBox(
      height: 60.0,
      child: row,
    );
    return row;
  }

}
class TestWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var floatButton=FlatButton(
      onPressed: ()=>print("this is FlatButton"),
    );
    return null;
  }

}
Widget _buildButtonColumn(BuildContext  context,IconData icon,String label){
  final color=Theme.of(context).primaryColor;
  return  Column(
    mainAxisSize:MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Icon(icon,color: color),
      Container(
        margin: const EdgeInsets.only(top:8.0),
        child: (Text(
          label,
          style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w600,
              color: color
          ),
        )),
      )
    ],
  );
}
class _TitleSection extends StatelessWidget {
  final String title;
  final String subtitle;
  final int starCount;
  _TitleSection(this.title, this.subtitle, this.starCount);

  @override
  Widget build(BuildContext context) {
    // 为了给 title section 加上 padding，这里我们给内容套一个 Container
    return Container(
      // 设置上下左右的 padding 都是 32。类似的还有 EdgeInsets.only/symmetric 等
padding: EdgeInsets.all(32.0),
      child: Row(
        children: <Widget>[
          //这里为了让标题占满屏幕宽度的剩余空间，用 Expanded 把标题包了起来
          Expanded(
            //Expanded 只能包含一个子元素，使用的参数名是 child。接下来，
            //为了在竖直方向放2个标题，加入一个Column
          )
        ],
      ),
    );
  }

}