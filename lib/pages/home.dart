import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map data = {};

  @override
  Widget build(BuildContext context) {

    data = data.isNotEmpty ? data : ModalRoute.of(context)!.settings.arguments as Map;
    print(data);
    // print(data.runtimeType);
    String bgimg = data['isDayTime'] ? 'day.jpg' : 'night.jpg';
    Color bgcolor = data['isDayTime'] ? Colors.blue.shade200 : Colors.black12;
    return Scaffold(
      backgroundColor: bgcolor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/$bgimg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(0.0, 200.0, 0.0, 0.0),
            child: Column(
              children: [
                TextButton.icon(
                  onPressed: () async {
                    dynamic result = await Navigator.pushNamed(context, '/location');
                    setState(() {
                      data = {
                        'location': result['location'],
                        'time': result['time'],
                        'flag': result['flag'],
                        'isDayTime': result['isDayTime'],
                      };
                    });
                  }, 
                  icon: Icon(
                    Icons.edit_location,
                    color: Colors.grey.shade200,
                  ), 
                  label: Text(
                    'Edit Location',
                    style: TextStyle(color: Colors.grey.shade100),
                  ),
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      // data['location'],
                      data['location'],
                      style: TextStyle(
                        fontSize: 28.0,
                        letterSpacing: 2.0,
                        color: Colors.grey.shade100,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                Text(
                  //data!['time'],
                  data['time'],
                  style: TextStyle(
                    fontSize: 60.0,
                    color: Colors.grey.shade100,
                  ),
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}