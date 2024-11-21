import 'package:flutter/material.dart';
import 'package:h_honey/pages/menu_page.dart';
//import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              Color(0xffFFFFFF),
              Color(0xffFFF8E1),
              Color(0xffFFECB3),
              Color(0xffD7CCC8),
              Color(0xff424242),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  //icon
                  Image.asset(
                    'assets/images/logo.png', // Ruta de la imagen
                    height: 200, // Ajusta el tamaño si es necesario
                    width: 200, // Ajusta el tamaño si es necesario
                  ),
                  const SizedBox(height: 20),

                  //hello
                  // Text(
                  //   '¡Hola de nuevo!', //style:  TextStyle(fontFamily:'Arial')
                  //   style: GoogleFonts.bebasNeue(
                  //     fontSize: 48,
                  //     color: const Color.fromARGB(255, 0, 0, 0),
                  //   ),
                  // ),
                  const SizedBox(height: 10),
                  const Text(
                    'Bienvenido a H-Honey',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff000000),
                      //fontWeight: FontWeight.bold
                    ),
                  ),

                  const SizedBox(height: 30),

                  //email textfield
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xffFAF3E0), // Fondo del campo
                        border: Border.all(
                          color:
                              const Color(0xffFFC107), // Borde amarillo dorado
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Email',
                          ),
                          style: TextStyle(
                            color: Color(
                                0xff3E2723), // Color del texto ingresado (marrón oscuro)
                            fontSize: 16, // Tamaño del texto ingresado
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  //password textfield
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xffFAF3E0), // Fondo del campo
                        border: Border.all(
                          color:
                              const Color(0xffFFC107), // Borde amarillo dorado
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child: TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Password',
                          ),
                          style: TextStyle(
                            color: Color(
                                0xff3E2723), // Color del texto ingresado (marrón oscuro)
                            fontSize: 16, // Tamaño del texto ingresado
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  //sign in button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: GestureDetector(
                      onTap: () {
                        // Navega a la página de menú
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MenuPage(),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: const Color(0xff532B20),
                          border: Border.all(color: const Color(0xffFFB74D)),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Center(
                          child: Text(
                            'Sign In',
                            style: TextStyle(
                              color: Color(0xffFDFDFD),
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),

                  //not member
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Text(
                      //   '¿Aún no tiene una cuenta?',
                      //   style: TextStyle(
                      //       fontWeight: FontWeight.bold,
                      //       color: Color(0xff89375F)),
                      // ),
                      Text(
                        'Olvide mi contraseña',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xff1565C0),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
