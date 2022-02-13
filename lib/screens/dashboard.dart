import 'package:flutter/material.dart';


class Dashboard extends StatefulWidget {
  const Dashboard({ Key key }) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          backgroundColor: Color(0xfffdfdfdf),
          body: SingleChildScrollView(
            child: Column(
              children: 
                [
                  Container(
                  margin: EdgeInsets.all(25),
                  child: Column(
                     crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                            "Dashboard",
                            style: TextStyle(
                              color: Color.fromRGBO(143, 148, 251, 6),
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                      SizedBox(height: 30,),
                      Container(
                         
                        //color: Color.fromRGBO(143, 148, 251, 5),
                        decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10.0),
                                        bottomRight: Radius.circular(10.0),
                                        topLeft: Radius.circular(10.0),
                                        bottomLeft: Radius.circular(10.0), 
                              ),
                        color: Color.fromRGBO(143, 148, 251, 5)
                        
                        ),
                        child: Card(

          child:Container(
            height: 100,
            color: Colors.white,
            child: Row(
              children: [
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(1),
                    child: Expanded(
                        child:Image.asset("assets/images/meeting.png"),
                        flex:2,
                    ),
                  ),
                ),
                Expanded(
                  child:Container(
                    alignment: Alignment.topLeft,
                    child: Column(
                        children: [
                          Expanded(
                            flex: 5,
                            child: ListTile(
                              title: Text("Meeting 1"),
                              subtitle: Text("01-02-2021"),
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(

                                  child:Text("View",
                                  style: TextStyle(
                                    color: Colors.purple[700],
                                    fontSize: 16
                                  ),
                                  ),
                                  onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => const Dashboard()),
                                      );
                                    },
                                ),
                                SizedBox(width: 8,),
                                TextButton(
                                  child: Text("ayo",
                                  style: TextStyle(
                                    color: Colors.purple[700],
                                    fontSize: 16
                                  ),
                                  ),
                                  onPressed: (){},
                                ),
                                SizedBox(width: 8,)
                              ],
                            ),
                          )
                        ],
                    ),
                  ),
                  flex:8 ,
                ),
              ],
            ),
          ),
          elevation: 8,
          margin: EdgeInsets.all(10),
        ),
                      ),    
                                            
                       
                                                  
                    ],
                    
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}