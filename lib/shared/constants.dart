import 'package:flutter/material.dart';


dynamic textInputDecoration=InputDecoration(
                              labelStyle: TextStyle(
                                color: Colors.brown[900],
                              ),
                           
                              fillColor: Colors.white,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    width: 1, color: Colors.blueGrey[800]),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    width: 1, color: Colors.pink[900]),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(),
                              ),
                            );