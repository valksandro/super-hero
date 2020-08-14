import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:super_hero/core/models/hero.dart';
import 'package:super_hero/core/models/interface_screen.dart';
import 'package:super_hero/core/providers/hero_provider.dart';
import 'package:super_hero/core/repositories/remote/hero_repository.dart';
import 'package:super_hero/ui/screens/hero_details.dart';
import 'package:super_hero/ui/widgets/loader_body.dart';
import 'package:super_hero/core/providers/base_provider.dart';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: BaseProvider(),
          ),
          ChangeNotifierProvider.value(
            value: HeroProvider(),
          )
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Sami Heroes',
          theme: ThemeData.dark(),
          home: MyHomePage(title: 'Sami Heroes'),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> implements InterfaceScreen {
  bool _enableSearch = false;
  String _searchOption = 'Name';
  List<HeroModel> _allHeroes = <HeroModel>[];
  List<HeroModel> _listHeroes = <HeroModel>[];
  HeroProvider _heroProvider;
  TextEditingController _searchController = TextEditingController();
  FocusNode _searchFocusNode = new FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _heroProvider = Provider.of<HeroProvider>(context)
        ..init(this, HeroRepository());
      _heroProvider.listAllHeroes().then((value) {
        _allHeroes = value;
        _listHeroes = _allHeroes;
        _heroProvider.refresh();
      });
      _searchName();
    });

  }

  @override
  void onError(error) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(error.message),
      duration: Duration(milliseconds: 700),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HeroProvider>(
        builder: (cx, value, child) => LoaderBody(
            child: Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  title: _enableSearch
                      ? _searchField()
                      : Text(widget.title, style: GoogleFonts.carterOne()),
                  actions: <Widget>[
                    Row(children: <Widget>[
                      _enableSearch ? _popup() : SizedBox(),
                      IconButton(
                        icon: _enableSearch
                            ? Icon(Icons.close)
                            : Icon(Icons.search),
                        onPressed: () {
                          _enableSearch = !_enableSearch;
                          _searchController.text = '';
                          _heroProvider.refresh();
                        },
                      ),
                    ])
                  ],
                ),
                body: _listHeroes.isNotEmpty
                    ? ListView(
                    physics: BouncingScrollPhysics(),
                    children: <Widget>[
                        ..._listHeroes
                            .map((el) => Card(
                                  child: ListTile(
                                    title: Text(el.name,
                                        style: GoogleFonts.carterOne(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white)),
                                    leading: Hero(
                                        tag: el.id,
                                        child: CircleAvatar(
                                          backgroundImage:
                                              NetworkImage(el.image),
                                          radius: 30,
                                        )),
                                    subtitle: Text(el.biography.fullName,
                                        style: GoogleFonts.roboto(
                                            fontWeight: FontWeight.w600)),
                                    trailing: Icon(Icons.arrow_forward_ios),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HeroDetails(el)));
                                    },
                                  ),
                                ))
                            .toList()
                      ])
                    : SizedBox())));
  }

  void _searchName() {
    _searchController.addListener(() {
      if (_searchController.text.isEmpty) {
        _listHeroes = _allHeroes;
      } else {
        _listHeroes = _allHeroes.where((hero) => hero.name.toLowerCase().contains(_searchController.text.toLowerCase())).toList();
      }
      _heroProvider.refresh();
    });
  }

  Widget _searchField() => TextField(
        autofocus: true,
        controller: _searchController,
        focusNode: _searchFocusNode,
        style: TextStyle(color: Colors.white),
        textInputAction: TextInputAction.done,
        onSubmitted: (_) {
          SystemChannels.textInput.invokeMethod('TextInput.hide');
        },
        decoration: InputDecoration(
            hintText: _searchOption, hintStyle: TextStyle(color: Colors.white)),
      );

  Widget _popup() => PopupMenuButton(
      child: Icon(Icons.more_vert),
      itemBuilder: (_) => <PopupMenuEntry>[
            new PopupMenuItem(
              value: 1,
              child: Text('Name'),
            ),
            new PopupMenuItem(value: 2, child: Text('Power')),
          ],
      onSelected: (options) async {
        switch (options) {
          case 1:
            _searchOption = 'Name';
            break;
          case 2:
            _searchOption = 'Power';
            break;
        }
        _heroProvider.refresh();
      });
}
