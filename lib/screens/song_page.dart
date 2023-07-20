import 'dart:async';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../radioState.dart';
import 'neu_page.dart';

class SongPage extends StatefulWidget {
   const SongPage({Key? key}) : super(key: key);

 @override
State<SongPage> createState() => _SongPageState();
}

class _SongPageState extends State<SongPage> with TickerProviderStateMixin {
   int currentIndex = 0;

  final List<String> urls = [
    'wa.me/917096374611', // Link for WhatsApp
    'https://rzp.io/l/wjBsTJwFZ', // Link for Support
    'https://www.youtube.com/@morfunradio', // Link for Youtube
    'https://www.facebook.com/morfunradio', // Link for Facebook
    'https://www.instagram.com/morfunradio/', // Link for Instagram
  ];



  bool isPlaying = false;
  late AudioPlayer audioPlayer;
  late AnimationController animationController;
  bool expanded = true;
  final number = '+917990178097';
  final number1 = '+917096374611';

  int currentCoverIndex = 0;
  late Timer coverTimer;

  List<String> coverImages = [
    'assets/images/cover4.png',
    'assets/images/3.png',
    'assets/images/covernew.png',
    'assets/images/covernew3.png',
  ];

  @override
  void initState() {
    super.initState();
    
    audioPlayer = AudioPlayer();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
      reverseDuration: const Duration(milliseconds: 400),
    );

    currentCoverIndex = Random().nextInt(coverImages.length);

    // Start the timer to change the cover image every 10 minutes
    coverTimer = Timer.periodic(const Duration(minutes: 10), (Timer timer) {
      setState(() {
        // Generate a random index different from the current one
        int newIndex;
        do {
          newIndex = Random().nextInt(coverImages.length);
        } while (newIndex == currentCoverIndex);

        currentCoverIndex = newIndex;
      });
    });
    
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    coverTimer.cancel(); // Cancel the timer when disposing of the widget
    super.dispose();
  }

void setupRadio(RadioState radioState) async {
  if (radioState.isPlaying) {
    await audioPlayer.stop();
  } else {
    await audioPlayer.play(UrlSource("https://cast5.asurahosting.com/proxy/viplove/stream"));
  }
  
  setState(() {
    radioState.setPlaying(!radioState.isPlaying);
  });
}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xffE1AEFF),
          elevation: 0,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                iconSize: 35,
                icon: const Icon(
                  Icons.menu,
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
        ),
        backgroundColor: const Color(0xffE1AEFF),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 5.0, 15.0, 10.0),
            child: Column(
              children: [
                const SizedBox(height: 25),
                // cover art, artist name, song name
                NeuBox(
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(coverImages[currentCoverIndex]),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        
                      )
                    ],
                  ),
                ),
                
                SizedBox(height: 60,),
                        
                SizedBox(
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: CircleAvatar(
                          radius: 40,
                          backgroundColor: const Color(0xffFFE4A7),
                          child: IconButton(
  color: Colors.white,
  iconSize: 50,
  icon: AnimatedIcon(
    icon: AnimatedIcons.play_pause,
    progress: animationController,
  ),
  onPressed: () {
    final radioState = Provider.of<RadioState>(context, listen: false);
    setupRadio(radioState);

 setState(() {
    if (!expanded) {
      animationController.reverse();
    } else {
      animationController.forward();
    }
    
    expanded = !expanded;
  });
},

                          ),

                        ),
                      ),
                       
                    ],
                  ),
                ),
                Expanded(
                  
                         child: ListView(
                                       padding: EdgeInsets.only(top: 30.0),
                                 children: [
                                   
                                   _buildComplexMarquee(),
                                 ].map(_wrapWithStuff).toList(),
                               ),
                       ),
              ],
            ),
          ),
        ),

        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                child: Text(' '),
                decoration: BoxDecoration(
                    color: Color(0xffFFE4A7),
                    image: DecorationImage(
                        image: AssetImage("assets/images/logo.png"),
                        fit: BoxFit.fitWidth)),
              ),
              ListTile(
                title: const Text(
                  'Home',
                  style: TextStyle(fontSize: 20, color: Color(0xffFFE4A7)),
                ),
                onTap: () {},
              ),
              ListTile(
                title: const Text(
                  'Support us',
                  style: TextStyle(fontSize: 20, color: Color(0xffFFE4A7)),
                ),
                onTap: () async {
                  launch('https://rzp.io/l/wjBsTJwFZ');
                },
              ),
              ListTile(
                title: const Text(
                  'Share',
                  style: TextStyle(fontSize: 20, color: Color(0xffFFE4A7)),
                ),
                onTap: () async {
                  launch('tel://$number1');
                },
              ),
              ListTile(
                title: const Text(
                  'Contact Morfun',
                  style: TextStyle(fontSize: 20, color: Color(0xffFFE4A7)),
                ),
                onTap: () async {
                  launch('tel://$number1');
                },
              ),
              ListTile(
                title: const Text(
                  'Contact Developer',
                  style: TextStyle(fontSize: 20, color: Color(0xffFFE4A7)),
                ),
                onTap: () async {
                  launch('tel://$number');
                },
              )
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.black54,
          unselectedItemColor: Colors.black54,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
        onTap: (index) {
          setState(() {  
            launch(urls[index]);
          });
        },
        items: const [
          BottomNavigationBarItem(
           
            icon: Icon(FeatherIcons.messageCircle,size: 35),
            label: 'WhatsApp'
        
          ),
          BottomNavigationBarItem(
            
            icon: Icon(Icons.handshake,size: 35),
              label: 'Support Us'
          
          ),
          BottomNavigationBarItem(
          
            icon: Icon(FeatherIcons.youtube,size: 35),
           label: 'Youtube'
          ),
          BottomNavigationBarItem(
             backgroundColor: Colors.black,
            icon: Icon(FeatherIcons.facebook,size: 35),
           label: 'Facebook'
          ),
          BottomNavigationBarItem(
           
            icon: Icon(FeatherIcons.instagram,size: 35),
            label: 'Instagram'
          ),]
        ),
        ),      
    );
  }
   Widget _buildComplexMarquee() {
    return Marquee(
      text: 'Kindly DM for Credit or Removal....Connect with us to share inspiring stories',
      textScaleFactor: 1.5,
      style: TextStyle(fontWeight: FontWeight.bold),
      scrollAxis: Axis.horizontal,
  crossAxisAlignment: CrossAxisAlignment.start,
  blankSpace: 20.0,
  velocity: 100.0,
  pauseAfterRound: Duration(seconds: 1),
  startPadding: 10.0,
  accelerationDuration: Duration(seconds: 1),
  accelerationCurve: Curves.linear,
  decelerationDuration: Duration(milliseconds: 500),
  decelerationCurve: Curves.easeOut,
    );
  }
   
  // Styling the Marquee
  Widget _wrapWithStuff(Widget child) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Container(height: 50.0, color:const Color(0xffE1AEFF) , child: child),
    );
  }

}