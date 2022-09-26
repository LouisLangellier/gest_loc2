import 'package:flutter/material.dart';

class AuthController extends StatefulWidget {
  const AuthController({Key? key}) : super(key: key);

  @override
  State<AuthController> createState() => _AuthControllerState();
}

class _AuthControllerState extends State<AuthController>
    with TickerProviderStateMixin {
  final _formConnectionKey = GlobalKey<FormState>();
  final _formInscriptionKey = GlobalKey<FormState>();
  late PageController _pageController;
  late TabController _tabController;
  late TextEditingController _name;
  late TextEditingController _firstName;
  late TextEditingController _mail;
  late TextEditingController _password;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _tabController = TabController(length: 2, vsync: this);
    _name = TextEditingController();
    _firstName = TextEditingController();
    _mail = TextEditingController();
    _password = TextEditingController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _tabController.dispose();
    _name.dispose();
    _firstName.dispose();
    _mail.dispose();
    _password.dispose();
    super.dispose();
  }

  hideKeyboard() {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Text(
          "GestLoc",
          style: TextStyle(color: Colors.white),
        )),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          tabs: const [
            Tab(
              text: "Connexion",
            ),
            Tab(
              text: "Inscription",
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Form(
            key: _formConnectionKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 15, left: 15, right: 15, bottom: 7.5),
                  child: TextFormField(
                    controller: _mail,
                    validator: (String? value) =>
                        value!.isEmpty ? "Le champ nom doit être rempli" : null,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        hintText: "Email",
                        prefixIcon: const Icon(Icons.mail_outline)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 15, left: 15, right: 15, bottom: 7.5),
                  child: TextFormField(
                    controller: _password,
                    validator: (String? value) =>
                        value!.isEmpty ? "Le champ nom doit être rempli" : null,
                    textAlign: TextAlign.center,
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        hintText: "Mot de passe",
                        prefixIcon: const Icon(Icons.password)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 7.5, left: 15, right: 15, bottom: 15),
                  child: SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pink,
                          shape: const StadiumBorder()),
                      child: const Text(
                        "Connexion",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Form(
            key: _formInscriptionKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 15, left: 15, right: 15, bottom: 7.5),
                  child: TextFormField(
                    controller: _name,
                    validator: (String? value) =>
                        value!.isEmpty ? "Le champ nom doit être rempli" : null,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      hintText: "Nom",
                      prefixIcon: const Icon(Icons.person),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 7.5, left: 15, right: 15, bottom: 7.5),
                  child: TextFormField(
                    controller: _firstName,
                    validator: (String? value) =>
                        value!.isEmpty ? "Le champ nom doit être rempli" : null,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      hintText: "Prénom",
                      prefixIcon: const Icon(Icons.person),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 7.5, left: 15, right: 15, bottom: 7.5),
                  child: TextFormField(
                    controller: _mail,
                    validator: (String? value) =>
                        value!.isEmpty ? "Le champ nom doit être rempli" : null,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        hintText: "Email",
                        prefixIcon: const Icon(Icons.mail_outline)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 7.5, left: 15, right: 15, bottom: 7.5),
                  child: TextFormField(
                    controller: _password,
                    validator: (String? value) =>
                        value!.isEmpty ? "Le champ nom doit être rempli" : null,
                    textAlign: TextAlign.center,
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        hintText: "Mot de passe",
                        prefixIcon: const Icon(Icons.password)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 7.5, left: 15, right: 15, bottom: 15),
                  child: SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pink,
                          shape: const StadiumBorder()),
                      child: const Text(
                        "Inscription",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
