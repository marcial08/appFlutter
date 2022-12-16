import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:idepronet/src/models/category.dart';
import 'package:idepronet/src/models/product.dart';
import 'package:idepronet/src/pages/home/Inicio/menu_principal_controller.dart';
import 'package:idepronet/src/utils/my_colors.dart';
import 'package:idepronet/src/widgets/no_data_widget.dart';

import 'RoomDetails.dart';

class MenuPrincipalPage extends StatefulWidget {
  const MenuPrincipalPage({Key key}) : super(key: key);

  @override
  _MenuPrincipalPageState createState() => _MenuPrincipalPageState();
}

class _MenuPrincipalPageState extends State<MenuPrincipalPage> {

  MenuPrincipalPageController _con = new MenuPrincipalPageController();
  bool isSwitched = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
  }

  final List roomData = [
    {
      "roomName": "Living Room",
      "members": "3 family members have access",
      "devices": "4 Devices",
      "isActive": true
    }
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _con.categories?.length,
      child: Scaffold(
        key: _con.key,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(170),
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            actions: [
              _shoppingBag()
            ],
            flexibleSpace: Column(
              children: [
                SizedBox(height: 40),
                _menuDrawer(),
               SizedBox(height: 20),
              //  _textFieldSearch()
              ],
            ),
            bottom: TabBar(
              indicatorColor: MyColors.primaryColor,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey[400],
              isScrollable: true,
              tabs: List<Widget>.generate(_con.categories.length, (index) {
                return Tab(
                  child: Text(_con.categories[index].name ?? ''),
                );
              }),
            ),
          ),
        ),
        drawer: _drawer(),
        body: TabBarView(
          children: _con.categories.map((Category category) {
            return FutureBuilder(
                future:_con.getProducts(category.id, _con.productName),
                builder: (context, AsyncSnapshot<List<Product>> snapshot) {

                  if (snapshot.hasData) {

                    if (snapshot.data.length > 0) {
                      return GridView.builder(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.7
                          ),
                          itemCount: snapshot.data?.length ?? 0,
                          itemBuilder: (_, index) {
                           // return _cardProduct(snapshot.data[index]);
                          }
                      );
                    }
                    else {
                      return NoDataWidget(text: 'No hay productos');
                    }
                  }
                  else {
                    return NoDataWidget(text: 'No hay productos');
                  }
                }
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _shoppingBag() {
    return GestureDetector(
      onTap: _con.logout,
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(right: 15, top: 22),
            child: Icon(
              Icons.logout_outlined,
              color: Colors.black,
            ),
          ),
          Positioned(
            right: 16,
            top: 15,
            child: Container(
              width: 9,
              height: 9,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.all(Radius.circular(30))
              ),
            )
          )
        ],
      ),
    );
  }

  // Widget _textFieldSearch() {
  //   return Container(
  //
  //                       margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
  //                       child: GridView.builder(
  //
  //                           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //                             crossAxisCount: 2,
  //                             crossAxisSpacing: 10,
  //                             mainAxisSpacing: 10,
  //                             childAspectRatio: 0.84,
  //                           ),
  //                           itemCount: roomData.length,
  //                           shrinkWrap: true,
  //                           primary: false,
  //                           itemBuilder: (_, index) {
  //                             return InkWell(
  //                               onTap: () {
  //                                 Navigator.push(
  //                                   context,
  //                                   MaterialPageRoute(
  //                                     builder: (_) => RoomDetails(
  //                                       roomName: roomData[index]['roomName'],
  //                                       members: roomData[index]['members'],
  //                                     ),
  //                                   ),
  //                                 );
  //                               },
  //                               child: Container(
  //                                 padding: EdgeInsets.symmetric(
  //                                     horizontal: 20, vertical: 10),
  //                                 decoration: BoxDecoration(
  //                                     color: Colors.white,
  //                                     borderRadius: BorderRadius.circular(12)),
  //                                 child: Column(
  //                                   crossAxisAlignment: CrossAxisAlignment.start,
  //
  //                                   children: [
  //
  //                                     Text(
  //                                       roomData[index]['roomName'],
  //                                       style: TextStyle(
  //                                         fontWeight: FontWeight.bold,
  //                                       ),
  //                                     ),
  //                                     SizedBox(
  //                                       height: 5,
  //                                     ),
  //                                     Text(
  //                                       roomData[index]['members'],
  //                                       style:
  //                                       TextStyle(fontSize: 12, color: Colors.grey),
  //                                     ),
  //                                     SizedBox(
  //                                       height: 20,
  //                                     ),
  //                                     Text(
  //                                       roomData[index]['devices'],
  //                                       style: TextStyle(
  //                                           fontSize: 12, color: Color(0xFFF8833F)),
  //
  //                                     ),
  //                                     SizedBox(
  //                                       height: 20,
  //                                     ),
  //                                     Switch(
  //                                       value: roomData[index]['isActive'],
  //                                       onChanged: (value) {
  //                                         setState(() {
  //                                           isSwitched = value;
  //                                           print(isSwitched);
  //                                         });
  //                                       },
  //                                       activeTrackColor: Colors.orangeAccent,
  //                                       activeColor: Color(0xFFF8833F),
  //                                     ),
  //                                   ],
  //                                 ),
  //                               ),
  //                             );
  //                           }),
  //   );
  // }

  Widget _menuDrawer() {
    return GestureDetector(
      onTap: _con.openDrawer,
      child: Container(
        margin: EdgeInsets.only(left:20,top: 20 ),
        alignment: Alignment.centerLeft,
        child: Image.asset('assets/img/menu.png', width: 20, height: 20),
      ),
    );
  }

  Widget _drawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
              decoration: BoxDecoration(
                color: MyColors.primaryColor
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${_con.user?.nombre ?? ''} ${_con.user?.nombre ?? ''}',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                    ),
                    maxLines: 1,
                  ),
                  Text(
                    _con.user?.email ?? '',
                    style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[200],
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic
                    ),
                    maxLines: 1,
                  ),
                  Text(
                    _con.user?.nombre ?? '',
                    style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[200],
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic
                    ),
                    maxLines: 1,
                  ),
                  Container(
                    height: 60,
                    margin: EdgeInsets.only(top: 10),
                    child: FadeInImage(
                      image: _con.user?.nombre != null
                         ? NetworkImage(_con.user?.nombre)
                          : AssetImage('assets/img/no-image.png'),
                      fit: BoxFit.contain,
                      fadeInDuration: Duration(milliseconds: 50),
                      placeholder: AssetImage('assets/img/no-image.png'),
                    ),
                  )

                ],
              )
          ),
          ListTile(
            onTap: _con.goToUpdatePage,
            title: Text('Ver mis datos'),
            trailing: Icon(Icons.visibility_outlined),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => RoomDetails(
                    roomName: 'FORMULARIOS',
                    members: ' Formularios Asignados ',
                  ),
                ),
              );
            },
            title: Text('Formularios'),
            trailing: Icon(Icons.note_add_outlined),
          ),
          _con.user != null ?
          _con.user.roles.length > 1 ?
          ListTile(
            onTap: _con.goToRoles,
            title: Text('Seleccionar rol'),
            trailing: Icon(Icons.person_outline),
          ) : Container() : Container(),
          ListTile(
            onTap: _con.logout,
            title: Text('Cerrar sesion'),
            trailing: Icon(Icons.power_settings_new),
          ),
        ],
      ),
    );
  }



  void refresh() {
    setState(() {}); // CTRL + S
  }

}
