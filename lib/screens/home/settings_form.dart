import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/services/database.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:provider/provider.dart';
class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {


  final _formKey= GlobalKey<FormState>();
  final List<String> sugars=['0','1','2','3','4'];
  
  String _currentName;
  String _currentSugars;
  int _currentStrength;
  
  
  
  
  
  @override
  Widget build(BuildContext context) {
    final user= Provider.of<User>(context);
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      // ignore: missing_return
      builder: (context, snapshot) {
          if(snapshot.hasData){


            UserData userData= snapshot.data;
             return Form(
       
          key: _formKey,
          child: Column(
            children:<Widget>[
            Text(
              'Update Your Brew Settings',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height:20 ,),
            TextFormField(
              initialValue: userData.name,
              autocorrect: true,
            decoration: textInputDecoration,
          validator: (val)=>val.isEmpty?'Please enter a name':null,
          onChanged: (val)=>setState(()=>_currentName=val),
            ),
            SizedBox(height: 20,),
            //dropdown
DropdownButtonFormField(
  decoration: textInputDecoration,
  value: _currentSugars??userData.sugars,
  items: sugars.map((sugar){
        return DropdownMenuItem(value: sugar,
        child:Text('$sugar sugars'),
        );
  }).toList(),      onChanged: (val)=>setState(()=>_currentSugars=val),
),
Slider(
  value: (_currentStrength??userData.strength).toDouble(),
  activeColor: Colors.brown[_currentStrength??userData.strength],
  inactiveColor: Colors.brown[_currentStrength??userData.strength],
  min:100.0,
  max:900.0,
  divisions: 8,
  onChanged:(val)=>setState(()=> _currentStrength= val.round()), 

),

            //slider
            RaisedButton(
               shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(15)),
              color: Colors.pink[400],
              child: Text(
                'Update',
                style:TextStyle(color: Colors.white),

              ),
              
              
              onPressed: ()async{
if(_formKey.currentState.validate()){
  await DatabaseService(uid:user.uid).updateUserData(
    
    
    
    _currentSugars??userData.sugars,
    _currentName??userData.name,
    _currentStrength??userData.strength);
    Navigator.pop(context);
}

              },
            )
          ],
        ),
        );



          }else{
return Loading();



          }
       
      }
    ) ;
  }
}