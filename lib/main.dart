import 'package:flutter/material.dart'
    show
        Align,
        AnimatedOpacity,
        BorderRadius,
        BouncingScrollPhysics,
        BoxConstraints,
        BuildContext,
        ButtonBar,
        Card,
        Center,
        CircleBorder,
        Colors,
        Column,
        ConstrainedBox,
        Curves,
        EdgeInsets,
        FloatingActionButton,
        Form,
        FormState,
        GlobalKey,
        Icon,
        IconButton,
        IconTheme,
        Icons,
        Image,
        InputDecoration,
        Key,
        ListTile,
        ListView,
        MaterialApp,
        MaterialStateMouseCursor,
        NeverScrollableScrollPhysics,
        OutlineInputBorder,
        Padding,
        Radius,
        RaisedButton,
        RoundedRectangleBorder,
        Scaffold,
        Scrollbar,
        SelectableText,
        SizedBox,
        SnackBar,
        StadiumBorder,
        State,
        StatefulWidget,
        StatelessWidget,
        Text,
        TextFormField,
        TextInputType,
        Theme,
        ThemeData,
        ThemeMode,
        ToolbarOptions,
        Tooltip,
        ValueListenableBuilder,
        VisualDensity,
        Widget,
        WidgetsFlutterBinding,
        Wrap,
        WrapAlignment,
        WrapCrossAlignment,
        Material,
        Flex,
        Axis,
        Expanded,
        TextStyle,
        BoxDecoration,
        BoxShape,
        DecorationImage,
        BoxFit,
        AssetImage,
        runApp;
import 'package:flutter/services.dart' show Brightness, TextInputType;
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter_icons/flutter_icons.dart'
    show FontAwesome, FontAwesome5Brands;
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart' show Hive;
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:percent_indicator/linear_percent_indicator.dart'
    show LinearPercentIndicator, LinearStrokeCap;
import 'package:string_validator/string_validator.dart'
    show isEmail, isLength, isNumeric, normalizeEmail, stripLow, toString;
import 'package:url_launcher/url_launcher.dart' show canLaunch, launch;
import 'package:dio/dio.dart' show Dio;
import 'package:velocity_x/velocity_x.dart';
import 'package:meta/meta.dart';


Future<void> main() async => Hive.initFlutter()
    .whenComplete(
      () async => Hive.openBox(
        'darkMode',
      ),
    )
    .whenComplete(WidgetsFlutterBinding.ensureInitialized)
    .whenComplete(
      () => runApp(
        const Home(),
      ),
    );

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: Hive.box('darkMode').listenable(),
        builder: (_, box, __) {
          final _isDarkMode = box.get('darkMode', defaultValue: false);
          return MaterialApp(
            themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
            darkTheme: ThemeData.dark().copyWith(
              textTheme: GoogleFonts.comfortaaTextTheme(
                ThemeData(
                  primarySwatch: Colors.teal,
                  brightness: Brightness.dark,
                ).textTheme,
              ),
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            theme: ThemeData.light().copyWith(
              textTheme: GoogleFonts.comfortaaTextTheme(),
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: Scaffold(
              body: const Center(
                child: HomePage(),
              ),
              floatingActionButton: FloatingActionButton(
                mouseCursor: MaterialStateMouseCursor.clickable,
                onPressed: () => box.put('darkMode', !_isDarkMode),
                child:
                    Icon(_isDarkMode ? FontAwesome.sun_o : FontAwesome.moon_o),
              ),
            ),
          );
        },
      );
}

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scrollbar(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          physics: const BouncingScrollPhysics(),
          primary: true,
          children: <Widget>[
            const SizedBox(
              height: 64,
            ),
            Wrap(
              alignment: WrapAlignment.center,
              runSpacing: 64,
              spacing: 64,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Container(
                  width: 400,
                  height: 400,
                  decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    image: new DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage("assets/images/Profiles.png"),
                    )
                )),
                const SizedBox(
                  width: 500,
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(24)),
                    ),
                    child: Info(),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 64,
            ),
            MiddleScreen(),
            const SizedBox(
              height: 64,
            ),
            Wrap(
              runAlignment: WrapAlignment.center,
              runSpacing: 32,
              spacing: 64,
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Image.asset(
                  'assets/images/svg.png',
                  width: 436,
                  isAntiAlias: true,
                  frameBuilder: (_, Widget child, int frame,
                      bool wasSynchronouslyLoaded) {
                    return wasSynchronouslyLoaded
                        ? child
                        : AnimatedOpacity(
                            opacity: frame == null ? 0 : 1,
                            duration: const Duration(seconds: 1),
                            curve: Curves.easeOut,
                            child: child,
                          );
                  },
                ),
                const SizedBox(
                  width: 500,
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(24)),
                    ),
                    child: AboutMe(),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 64,
            ),
            const ProjectShowCase(),
            const SizedBox(
              height: 64,
            ),
            Wrap(
              runAlignment: WrapAlignment.center,
              alignment: WrapAlignment.center,
              runSpacing: 32,
              spacing: 64,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: const [
                TechnicalSkills(),
                ContactMe(),
              ]
                  .map(
                    (e) => SizedBox(
                      width: 500,
                      child: Card(
                        elevation: 2,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(24)),
                        ),
                        child: e,
                      ),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(
              height: 64,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 32),
                child: Text(
                    '© ${DateTime.now().year} Chiranjeevi Saride. All rights reserved.'),
              ),
            )
          ],
        ),
      );
}



class MiddleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).accentColor,
      child: Flex(
          direction: context.isMobile ? Axis.vertical : Axis.horizontal,
          children: [
            "Work Experience,\n"
                .richText
                .withTextSpanChildren(
                    ["5+ years".textSpan.yellow400.make()])
                .xl4
                .white
                .make(),
            20.widthBox,
            Expanded(
                child: VxSwiper(
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
              items: [
                ProjectWidget(title: "Sr. Full Stack Engineer at Cox Automotive (July, 2018 - current)"),
                ProjectWidget(title: "Senior Full Stack Developer at Barclays (Mar, 2017 - Jun, 2018) "),
                ProjectWidget(title: "Senior Engineer at American Express, May (2016 - Mar, 2017)"),
                ProjectWidget(title: "Software Developer Inter at NYSED (Jan, 2016 - May, 2016)"),
              ],
              height: 370,
              viewportFraction: context.isMobile ? 0.75 : 0.3,
              autoPlay: true,
              autoPlayAnimationDuration: 1.seconds,
            ))
          ]).p64().h(context.isMobile ? 400 : 300),
    );
  }
}


class ProjectWidget extends StatelessWidget {
  final String title;

  const ProjectWidget({Key key, @required this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return title.text.bold.white.xl.wide.center
        .make()
        .box
        .p8
        .roundedLg
        .neumorphic(color: Theme.of(context).accentColor)
        .alignCenter
        .square(310)
        .make()
        .p16();
  }
}

class Info extends StatelessWidget {
  const Info({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ListView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: const EdgeInsets.all(24),
        children: [
          Align(
            child: FloatingActionButton.extended(
              shape: const StadiumBorder(),
              highlightElevation: 2,
              elevation: 0,
              onPressed: null,
              label: const Text(
                "Hello I'm",
                textScaleFactor: 1.5,
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          const ListTile(
            leading: Icon(Icons.account_circle),
            title: SelectableText(
              'Chiranjeevi Saride',
              textScaleFactor: 2,
              toolbarOptions: ToolbarOptions(
                copy: true,
                selectAll: true,
              ),
            ),
            subtitle: Text(
              'Full Stack Engineer',
            ),
          ),
          ...const [
            [
              Icon(Icons.location_on),
              'Atlanta, GA, United States',
            ],
            [
              Icon(Icons.email),
              'chiranjeevisaride1@gmail.com',
            ],
            [
              Icon(Icons.phone),
              '+1 201 234 1289',
            ]
          ]
              .map(
                (e) => ListTile(
                  leading: e.first,
                  title: SelectableText(
                    e.last,
                    toolbarOptions: const ToolbarOptions(
                      copy: true,
                      selectAll: true,
                      cut: true,
                    ),
                  ),
                ),
              )
              .toList(),
          ButtonBar(
            children: [
              [FontAwesome5Brands.github, 'https://github.com/chiranjeevisaride'],
              [
                FontAwesome5Brands.linkedin,
                'https://linkedin.com/in/chiranjeevisaride'
              ]
            ]
                .map(
                  (e) => Tooltip(
                    message: 'Visit ${e.last}',
                    child: RaisedButton(
                      mouseCursor: MaterialStateMouseCursor.clickable,
                      color: Theme.of(context).accentColor,
                      shape: const CircleBorder(),
                      onPressed: () async {
                        if (await canLaunch(e.last)) {
                          await launch(e.last);
                        }
                      },
                      child: Icon(
                        e.first,
                        size: IconTheme.of(context).size - 4,
                      ),
                    ),
                  ),
                )
                .toList(),
          )
        ],
      );
}

class AboutMe extends StatelessWidget {
  const AboutMe({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ListView(
        padding: const EdgeInsets.all(
          24,
        ),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          const ListTile(
            title: SelectableText(
              'About Me',
              textScaleFactor: 2,
              toolbarOptions: ToolbarOptions(
                copy: true,
                selectAll: true,
              ),
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          const ListTile(
            title: Text(
              'I enjoy working on Web, Mobile & Cloud technologies. My Areas of interest include AR/VR, Algorithms System Design',
               style: TextStyle(
                  fontSize: 15.0,
                  letterSpacing: 1.2,
                  wordSpacing: 1.2,
               ),
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          Wrap(
            runAlignment: WrapAlignment.spaceAround,
            alignment: WrapAlignment.spaceAround,
            crossAxisAlignment: WrapCrossAlignment.center,
            runSpacing: 15,
            children: [
              ['Engineer', ''],
              ['Entrepreneur', ''],
              ['Day Trader', ''],
            ]
                .map(
                  (e) => FloatingActionButton.extended(
                    mouseCursor: MaterialStateMouseCursor.clickable,
                    highlightElevation: 2,
                    elevation: 2,
                    tooltip: 'Visit ${e.first} homepage',
                    shape: const StadiumBorder(),
                    onPressed: () async {
                      if (await canLaunch(e.last)) {
                        await launch(e.last);
                      }
                    },
                    label: Text(e.first),
                  ),
                )
                .toList(),
          ),
        ],
      );
}

class ProjectShowCase extends StatelessWidget {
  const ProjectShowCase({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        children: [
          const Align(
            child: Text(
              'Project Showcase',
              textScaleFactor: 2,
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          Wrap(
            runAlignment: WrapAlignment.center,
            alignment: WrapAlignment.center,
            runSpacing: 32,
            spacing: 64,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              [
                'BookWithMe',
                'Search & book for rooms & hotels around the world',
                'http://bookwithme-react.herokuapp.com/rentals',
              ], 
              [
                'FlyX',
                'Flight booking website',
                'https://flyx.io/',
              ],
              [
                'VR Planetarium',
                'Modernized the planetarium experience using virtual reality',
                'https://store.steampowered.com/app/1313970/PlanetariumVR/'
              ],
            ]
                .map(
                  (e) => ConstrainedBox(
                    constraints: const BoxConstraints(
                      minHeight: 125,
                      maxWidth: 500,
                    ),
                    child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      child: Center(
                        child: ListTile(
                          title: Text(
                            e.first,
                            textScaleFactor: 2,
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              e.elementAt(1),
                            ),
                          ),
                          trailing: IconButton(
                            mouseCursor: MaterialStateMouseCursor.clickable,
                            tooltip: 'Vist ${e.first}',
                            icon: Icon(
                              Icons.open_in_new,
                              color: Theme.of(context).accentColor,
                            ),
                            onPressed: () async {
                              if (await canLaunch(e.last)) {
                                await launch(e.last);
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      );
}

class TechnicalSkills extends StatelessWidget {
  const TechnicalSkills({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ListView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: const EdgeInsets.all(
          24,
        ),
        children: [
          const Align(
            child: Text(
              'Technical Skills',
              textScaleFactor: 2,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          ...[
            ['Java Spring', .95],
            ['Javascript', .90],
            ['React.js', .90],
            ['Angular', .55],
            ['AWS', .85],
            ['Docker', .80],
            ['Mongo DB', .65],
            ['Flutter (Dart)', .55],
            ['Python', .50],
            ['Jenkins CI/CD', .80],
            ['Elastic Search / Solr', .60],
          ]
              .map(
                (e) => ListTile(
                  title: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      e.first,
                    ),
                  ),
                  subtitle: LinearPercentIndicator(
                    percent: e.last,
                    lineHeight: 15,
                    animationDuration: 2500,
                    animation: true,
                    progressColor: Theme.of(context).accentColor,
                    linearStrokeCap: LinearStrokeCap.roundAll,
                  ),
                ),
              )
              .toList(),
        ],
      );
}

class ContactMe extends StatefulWidget {
  const ContactMe({Key key}) : super(key: key);

  @override
  _ContactMeState createState() => _ContactMeState();
}

class _ContactMeState extends State<ContactMe> {
  final _formKey = GlobalKey<FormState>();
  String name, phone, email, details;

  @override
  Widget build(BuildContext context) => ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(
          24,
        ),
        physics: const NeverScrollableScrollPhysics(),
        children: [
          const Align(
            child: Text(
              'Contact Me',
              textScaleFactor: 2,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Form(
            key: _formKey,
            child: ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(18),
                      ),
                    ),
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (value) =>
                      value.isEmpty ? 'Name cannot be empty' : null,
                  onChanged: (value) => setState(() {
                    name = value.trim();
                  }),
                  keyboardType: TextInputType.text,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(18),
                      ),
                    ),
                    prefixIcon: Icon(Icons.phone),
                  ),
                  keyboardType: TextInputType.phone,
                  onChanged: (value) => setState(
                    () {
                      if (isNumeric(value)) {
                        phone = value;
                      }
                    },
                  ),
                  validator: (value) => !isNumeric(value)
                      ? 'Invalid PhoneNumber'
                      : !isLength(value, 4, 22) ? 'Invalid PhoneNumber' : null,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(18),
                      ),
                    ),
                    prefixIcon: Icon(Icons.email),
                  ),
                  validator: (value) => value.isEmpty
                      ? 'Email cannot be empty'
                      : !isEmail(value) ? 'Invalid Email' : null,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) => setState(
                    () {
                      if (isEmail(value)) {
                        email = toString(normalizeEmail(value)).trim();
                      }
                    },
                  ),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(18),
                      ),
                    ),
                    labelText: 'Message',
                    helperMaxLines: 7,
                    hintMaxLines: 7,
                    prefixIcon: Icon(Icons.speaker_notes),
                  ),
                  validator: (value) =>
                      value.isEmpty ? 'Description cannot be empty' : null,
                  onChanged: (value) => setState(
                      () => details = stripLow(toString(value)).trim()),
                  keyboardType: TextInputType.multiline,
                  maxLines: 7,
                ),
                Center(
                  child: FloatingActionButton.extended(
                    mouseCursor: MaterialStateMouseCursor.clickable,
                    elevation: 2,
                    highlightElevation: 4,
                    tooltip: 'Submit Details',
                    hoverElevation: 4,
                    icon: const Icon(Icons.send),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        final _timestamp = DateFormat('yMMMd')
                            .add_jms()
                            .format(
                              DateTime.now(),
                            )
                            .trim();
                        final _ipData = '?name='
                            '$name'
                            '&phone=$phone'
                            '&email=$email'
                            '&details=$details'
                            '&timestamp=$_timestamp';
                        const url =
                            'https://script.google.com/macros/s/AKfycbyQNVoxSjwWskTGpjO5ad11syVkcC3y-WLmalFsBn_8ujeFV3-B/exec';

                        try {
                          await Dio()
                              .get(
                                url + _ipData,
                              )
                              .then(
                                (value) => value.statusCode == 200
                                    ? Scaffold.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'Submission Recevied',
                                          ),
                                        ),
                                      )
                                    : Scaffold.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'Insufficient information provided',
                                          ),
                                        ),
                                      ),
                              );
                        } on Exception catch (e) {
                          Exception(e);
                        }
                      }
                    },
                    label: const Text('Send'),
                  ),
                ),
              ]
                  .map(
                    (e) => Padding(padding: const EdgeInsets.all(8), child: e),
                  )
                  .toList(),
            ),
          )
        ],
      );
}
