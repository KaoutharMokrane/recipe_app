import 'package:flutter/material.dart';
import '../widgets/google_sign_in_button.dart';


class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BoxDecoration _buildBackground() {
      return BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/brooke-lark-wMzx2nBdeng-unsplash.jpg'),
          fit: BoxFit.cover,
        ),
      );
    }

    Text _buildText() {
      return Text(
        'Recipes',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headline,

      );
    }

    return Scaffold(
        backgroundColor: Colors.lightBlue,
        body: Container(
          decoration: _buildBackground(),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildText(),
                SizedBox(
                  height: 50.0,
                ),
                // Passing function callback as constructor argument:
                GoogleSignInButton((){Navigator.of(context).pushReplacementNamed('/');})
              ],
            ),
          ),
        ));
  }
}
