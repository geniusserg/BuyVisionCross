// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.menu, color: Colors.black,), onPressed: () {}),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          const Icon(Icons.location_on, color: Colors.black,),
          const SizedBox(width: 3.0),
          Text("N. Novgorod, 1 May, 70", 
          style: Theme.of(context).textTheme.subtitle1!.copyWith(color: Colors.black)),
        ]),
        actions: [
          IconButton( icon: const Icon(Icons.notifications), onPressed: (){}),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Text("Масло Сады Придонья", style: Theme.of(context).textTheme.headline4!
                              .copyWith(fontWeight: FontWeight.w500, 
                              color: Colors.black)),
        const Text("199 \$", style: TextStyle(fontSize: 18),),
        Form(child: TextFormField(
          decoration: InputDecoration(
            hintText: "Search here...",
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
            prefixIcon: Padding(padding: EdgeInsets.all(12), child: Icon(Icons.search)),
            suffixIcon: Padding(padding: EdgeInsets.symmetric(horizontal: 7),
              child: SizedBox( 
                width: 48,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {}, 
                  child: Icon(Icons.filter_1_outlined),
                  style: ElevatedButton.styleFrom(
                    alignment: Alignment.center,
                    primary: Theme.of(context).primaryColor,
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))))
                    ))
            )
          ),
        ),)
      ],)
    );
  }
}
