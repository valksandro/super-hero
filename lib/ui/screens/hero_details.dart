import 'package:flutter/material.dart';
import 'package:flutter_rounded_progress_bar/flutter_rounded_progress_bar.dart';
import 'package:flutter_rounded_progress_bar/rounded_progress_bar_style.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_hero/core/models/hero.dart';

class HeroDetails extends StatefulWidget {
  final HeroModel hero;
  HeroDetails(this.hero);

  @override
  _HeroDetailsState createState() => _HeroDetailsState();
}

class _HeroDetailsState extends State<HeroDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sami Heroes', style: GoogleFonts.carterOne()),
      ),
      body: Stack(children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Hero(
              tag: widget.hero.id, child: Image.network(widget.hero.image)),
        ),
        Positioned(
            left: 15,
            bottom: 10,
            child: Container(
                padding: EdgeInsets.all(10),
                child: ListView(
                  children: <Widget>[
                    progressBar(
                        'Inteligence', widget.hero.powerStats.intelligence),
                    progressBar('strength', widget.hero.powerStats.strength),
                    progressBar('speed', widget.hero.powerStats.speed),
                    progressBar(
                        'durability', widget.hero.powerStats.durability),
                    progressBar('power', widget.hero.powerStats.power),
                    progressBar('combat', widget.hero.powerStats.combat),
                  ],
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.black.withOpacity(.2),
                ),
                width: MediaQuery.of(context).size.width / 1.5,
                height: MediaQuery.of(context).size.height / 2.7)),
        Positioned(
            top: 25,
            right: 20,
            child: Container(
                padding: EdgeInsets.all(10),
                child: Text(
                widget.hero.name,
                style: GoogleFonts.luckiestGuy(fontSize: 40),

                )))
      ]),
    );
  }

  Widget progressBar(String title, String percentage) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              title,
              style: GoogleFonts.ptSans(),
            )),
        RoundedProgressBar(
            height: 10,
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            milliseconds: 1000,
            percent: double.tryParse(percentage) ?? 1,
            theme: RoundedProgressBarTheme.red,
            borderRadius: BorderRadius.circular(24))
      ]);
}
