import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {

  
  final Function toggleView;
  SignIn({this.toggleView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
 final _formKey= GlobalKey<FormState>();
 bool loading=false;
  //text 
  String email="";
  String password="";
  String error="";
  @override
  Widget build(BuildContext context) {
    return loading?
    Loading()
     :
      Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
         shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(15)),
        backgroundColor: Colors.brown[200],
        elevation:10.0,
        title: Text('Sign in To brew Crew',
          style:TextStyle(color:Colors.black)),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Register'),
            onPressed: (){
      widget.toggleView();
            },
            ),
        ],
      ),
      body:Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal:50),
        child:  Form(
            key:_formKey,
          child: Column(children: <Widget>[
            SizedBox(height: 20,),
            TextFormField(
              decoration: textInputDecoration.copyWith(labelText:'Email'),
               validator: (val)=>val.isEmpty?'Enter Email':null,
              onChanged: (val){
setState(()=>email=val);
              },
            ),
             SizedBox(height: 20,),
             TextFormField(
               decoration: textInputDecoration.copyWith(labelText:'Password'),

                  validator: (val)=>val.length<6?'Enter Pass 6+ Chars long':null,
               obscureText: true,
              onChanged: (val){
setState(()=>password=val);
              },
            ),
            SizedBox(height: 20,),
            RaisedButton(
               shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(15)),
              color: Colors.pink[400],
              child:Text(
                'Sign In',
                style: TextStyle(color: Colors.white),

              ),
              onPressed: () async{
if(_formKey.currentState.validate()){

setState(() {
  loading=true;
});
 dynamic result = await _auth.signInWithEmailAndPassword(email,password);
if(result==null){
setState(() {
  error="Couldn't Sign In";
  loading=false;
});
}

}
              },
            ),
             SizedBox(height: 12,),
            Text(
              error,
              style: TextStyle(color:Colors.red,fontSize: 14),
            )
          ],
          ),
        )
      ),
    );
  }
}