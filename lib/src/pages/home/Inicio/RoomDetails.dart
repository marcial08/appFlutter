
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:idepronet/src/pages/home/Inicio/menu_principal_controller.dart';
import 'package:idepronet/src/utils/my_colors.dart';

class RoomDetails extends StatefulWidget {
  final String roomName;
  final String members;

  RoomDetails({this.roomName, this.members});

  @override
  _RoomDetailsState createState() => _RoomDetailsState();


}
@override

class _RoomDetailsState extends State<RoomDetails> {
  bool isSwitched = false;
  MenuPrincipalPageController _con = new MenuPrincipalPageController();
  void initState() {
    // TODO: implement initState
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
  }

  final List roomAssets = [
    {
      "icon": "assets/img/fridge.png",
      "title": "Formulario GNN",
      "subTitle": "Registro de Creditos Rechados",
      "isActive": true
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 250,
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              decoration: BoxDecoration(
                color: MyColors.primaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  // InkWell(
                  //     onTap: () {
                  //       Navigator.pop(context);
                  //     },
                  //     child: Icon(
                  //       Icons.arrow_back,
                  //       color: Colors.white,
                  //     )),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      Text(
                        widget.roomName,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                      InkWell(
                          onTap: () {
                            _con.logout();
                          },
                          child: Icon(
                            Icons.power_settings_new,
                            color: Colors.white,
                          )),


                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    _con.user.nombre,
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                  Text(
                    _con.user.cargo,
                    style: TextStyle(
                      color: Colors.white70,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                            iconSize: 50.0,
                            icon:  CircleAvatar(
                              backgroundColor: Colors.white70,
                              child: Image.asset('assets/img/user_idepro.png'),
                              radius: 30,

                            ),
                            onPressed: () {
                              _con.goToUpdatePage();
                            },
                          ),
                          // Text('Mis Perfil', style: TextStyle(
                          //   color: Colors.white,
                          //   fontSize: 15)
                          // ),
                          SizedBox(width: 10,),
                          Column(
                            children: [
                              Text('', style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold
                              ),),
                              // Text('TEMP', style: TextStyle(
                              //   color: Colors.white,
                              // ),),
                            ],
                          )
                        ],
                      ),

                      // Row(
                      //   crossAxisAlignment: CrossAxisAlignment.center,
                      //   children: [
                      //     CircleAvatar(
                      //       backgroundColor: Colors.white70,
                      //       child: Image.asset('assets/img/humidity.png'),
                      //       radius: 30,
                      //     ),
                      //     SizedBox(width: 10,),
                      //     Column(
                      //       children: [
                      //         // Text('50%', style: TextStyle(
                      //         //     color: Colors.white,
                      //         //     fontSize: 22,
                      //         //     fontWeight: FontWeight.bold
                      //         // ),),
                      //         // Text('Humidity', style: TextStyle(
                      //         //   color: Colors.white,
                      //         // ),),
                      //       ],
                      //     )
                      //   ],
                      // )
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: roomAssets.length,
                  itemBuilder: (_, index) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 20),
                      height: 70,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black54,
                                offset: Offset(3, 5),
                                blurRadius: 9,
                                spreadRadius: 1)
                          ]),
                      child: ListTile(
                        onTap: () {
                          _con.goToNegocioPage();
                        },
                        leading: Image.asset(roomAssets[index]['icon']),
                        title: Text(roomAssets[index]['title']),
                        subtitle: Text(roomAssets[index]['subTitle']),
                        trailing: Switch(
                          value: roomAssets[index]['isActive'],
                          onChanged: (value) {
                            setState(() {
                              isSwitched = value;
                              print(isSwitched);
                            });
                          },
                          activeTrackColor: Colors.orangeAccent,
                          activeColor: Color(0xFFF8833F),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  void refresh() {
    setState(() {}); // CTRL + S
  }
}