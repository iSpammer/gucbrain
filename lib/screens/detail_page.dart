import 'package:flutter/material.dart';


class DetailsPage extends StatelessWidget {
  final String mac;
  String temp;
  String flame;
  String smoke;
  DetailsPage({@required this.mac, this.temp, this.flame, this.smoke});



  @override
  Widget build(BuildContext context) {
    if(temp == null)
      temp = "NAN";
    if(flame == null)
      flame = "NAN";
    if(smoke == null)
      smoke = "NAN";

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            DetailHeader(mac: mac,),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Description("Temp: $temp\nFlame: $flame\nSmoke: $smoke"),
            ),
            SizedBox(height: 50.0),
          ],
        ),
      ),
    );
  }
}


class Description extends StatelessWidget {
  Description(this.description);
  final String description;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description',
          style: textTheme.subhead.copyWith(fontSize: 18.0),
        ),
        SizedBox(height: 8.0),
        Text(
          description,
          style: textTheme.body1.copyWith(
            color: Colors.grey,
            fontSize: 16.0,
          ),
        ),
        // No expand-collapse in this tutorial, we just slap the "more"
        // button below the text like in the mockup.
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'more',
              style: textTheme.body1
                  .copyWith(fontSize: 16.0, color: theme.accentColor),
            ),
            Icon(
              Icons.keyboard_arrow_down,
              size: 18.0,
              color: theme.accentColor,
            ),
          ],
        ),
      ],
    );
  }
}


class Actor {
  Actor({
    this.name,
    this.avatarUrl,
  });

  final String name;
  final String avatarUrl;
}


class DetailHeader extends StatelessWidget {
  final String mac;
  DetailHeader({@required this.mac});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    var espInfo = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "ESP ",
          style: textTheme.title,
        ),
        SizedBox(height: 8.0),
        Text("MAC: $mac"),
        SizedBox(height: 12.0),
      ],
    );

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 140.0),
          child: ArcBannerImage("assets/banner.png",),
        ),
        Positioned(
          bottom: 0.0,
          left: 16.0,
          right: 16.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Poster(
                "assets/esp.png",
                height: 180.0,
              ),
              SizedBox(width: 16.0),
              Expanded(child: espInfo),
            ],
          ),
        ),
      ],
    );
  }
}





class ArcBannerImage extends StatelessWidget {
  ArcBannerImage(this.imageUrl);
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return ClipPath(
      clipper: ArcClipper(),
      child: Image.asset(
        imageUrl,
        width: screenWidth,
        height: 230.0,
        fit: BoxFit.cover,
      ),
    );
  }
}

class ArcClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - 30);

    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstPoint = Offset(size.width / 2, size.height);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstPoint.dx, firstPoint.dy);

    var secondControlPoint = Offset(size.width - (size.width / 4), size.height);
    var secondPoint = Offset(size.width, size.height - 30);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondPoint.dx, secondPoint.dy);

    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class Poster extends StatelessWidget {
  static const POSTER_RATIO = 0.7;

  Poster(
      this.posterUrl, {
        this.height = 100.0,
      });

  final String posterUrl;
  final double height;

  @override
  Widget build(BuildContext context) {
    var width = this.height;

    return Material(
      borderRadius: BorderRadius.circular(4.0),
      elevation: 2.0,
      child: Image.asset(
        posterUrl,
        fit: BoxFit.cover,
        width: width,
        height: height,
      ),
    );
  }
}