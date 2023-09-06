

import 'dart:ffi';

import 'package:flutter/materiaL.dart';

import '../movies/formovies.dart';


//import '../model/questions.dart';

class movielistview extends StatelessWidget {
  //const movielistview({super.key});
  final List<MyMovies>movielist=MyMovies.getMovies();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:AppBar(title:Text("WATCH MOVIES"),backgroundColor:Colors.blueGrey.shade900,centerTitle: true,),

        backgroundColor:Colors.blueGrey.shade900,
        body:ListView.builder(
            itemCount:movielist.length,//total number of movies shown on screen seperately
            itemBuilder: (BuildContext context,int index)
            {
              return Stack(
                  children:<Widget>[
                    moviecard(movielist[index],context),//to seperate card from image so that image doesnot occupy card shade

                    Positioned(
                      top:10.0,
                      left:5.0,
                      child: movieimage(movielist[index].images[0]),)

                  ]
              );
              // return Card(//instead of card it is also possible to do things like in old method by container but if u want to create a multiple containers quickly then we use card
              //   color:Colors.blue,
              //    elevation: 100.0,//Card provide a shoadow gap beween each card in different rows OR The elevation property is used to give the Card a three-dimensional appearance, making it look like it's slightly floating above the surface it's placed on.
              //    child:ListTile(
              //      leading:CircleAvatar(//to give icon to with each movie name
              //        child:Container(
              //          width:200,
              //          height:200,
              //          decoration:BoxDecoration(
              //            image:DecorationImage(image:NetworkImage(movielist[index].images[0]),fit:BoxFit.cover,),//give image to each circle avatar of each movie
              //            color:Colors.blue,//to give background color to that icon
              //            borderRadius:BorderRadius.circular(13.9),
              //          ),
              //          //child:Text("M"),
              //        )
              //      ),
              //     trailing:Text("......."),//to right anything in end of any row in light shade
              //     title:Text("${movielist[index].title}"),//name of ech movie
              //      subtitle: Text("${movielist[index].writer}"),
              //      //onTap:()=>debugPrint("MOVIE NAME:${movies[index]}"),//this happen when click on any movie on screen
              //      onTap:()
              //        {
              //          Navigator.push(context,MaterialPageRoute(builder: (context)=>moviedetails(movieName:"${movielist[index].title}")));
              //        },
              //   )
              // );
            }
        )
    );
    return const Placeholder();
  }
  Widget moviecard(MyMovies movie,BuildContext context)
  {
    return InkWell(
        onTap:()
        {
          //Navigator.push(context,MaterialPageRoute(builder: (context)=>moviedetails(movieName:"${movie.title}")));
          Navigator.push(context,MaterialPageRoute(builder: (context)=>moviedetails(movieName: '', movie: movie,)));

        },
        child:Container(
            width:MediaQuery.of(context).size.width,//to give flexible width
            height:120,
            child:Card(
                color:Colors.black,
                child:Padding(
                    padding:const EdgeInsets.only(top:8.0,
                      bottom:8.0,
                      left:54.0,),

                    child:Column(
                        crossAxisAlignment:CrossAxisAlignment.start,//By setting crossAxisAlignment to CrossAxisAlignment.start, you're aligning the children at the start (left) of the cross axis. This means that the contents of the Column will be aligned to the left edge of the Card.
                        mainAxisAlignment: MainAxisAlignment.spaceAround, //to add space vertically(columnwise)
                        children:<Widget>[
                          Row(
                              mainAxisAlignment:MainAxisAlignment.spaceBetween,
                              children:<Widget>[
                                Flexible(child: Text(movie.title,style:TextStyle(color:Colors.white,fontWeight:FontWeight.bold,fontSize:15.0)),),//to avoid overflow error on screen if movie title name is too long

                                Row(
                                    children:<Widget>[
                                      Text("Rating:${movie.imdbrating}/10",style:TextStyle(color:Colors.grey,fontWeight:FontWeight.bold,fontSize:15.0)),
                                    ]
                                )

                              ]
                          ),
                          Row(
                              mainAxisAlignment:MainAxisAlignment.spaceAround,//to add decent space between things present in one row
                              children:<Widget>[
                                Text("Released:${movie.released}",style:TextStyle(color:Colors.grey,fontWeight:FontWeight.bold,fontSize:15.0)),
                                Text("Time:${movie.runtime}",style:TextStyle(color:Colors.grey,fontWeight:FontWeight.bold,fontSize:15.0)),
                                Text("Rating:${movie.rated}",style:TextStyle(color:Colors.grey,fontWeight:FontWeight.bold,fontSize:15.0)),
                              ]
                          )


                        ]
                    )
                )
            )
        )

    );
  }
  Widget movieimage(String imageurl)
  {
    return Container(
        width:50,
        height:50,

        decoration:BoxDecoration(
          borderRadius:BorderRadius.circular(25.0),
          image:DecorationImage(image:NetworkImage(imageurl??'https://images-na.ssl-images-amazon.com/images/M/MV5BNDI3ODYyODY4OV5BMl5BanBnXkFtZTgwNjE5NDMwMDI@._V1_SY1000_SX1500_AL_.jpg'),fit:BoxFit.cover),//this link will work if the is image is not found that we pass in function parameter(String image url)

        )
    );
  }


}
//our new screen
class moviedetails extends StatelessWidget {
  //const moviedetails({super.key});
  final String movieName;//to apear a movie name dynamically on new screen on which movie user tapped beacuse this variable will took all information of movie which is tapped on previous screen in it
  final MyMovies movie;
  const moviedetails({super.key, required this.movieName,required this.movie});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:AppBar(title:Text("${movie.title}"),

          backgroundColor:Colors.blueGrey.shade900,centerTitle: true,),
        //backgroundColor:Colors.blueGrey.shade900,


        body:ListView(
            children:<Widget>[
              SizedBox(height:20),
              moviethumbnail(thumbnail:movie.images[0]),
              moviedetailsother(movie2:movie),
              horizontalline(),
              moviedetailscast(movie4:movie),
              horizontalline(),
              movieextraposters(posters:movie.images)

            ]
        )

      // body:Container(
      //
      //   child:ElevatedButton(//Elevated button is used to form a button quickly
      //     child:Text("GO BACK $movieName"),
      //     onPressed:()
      //       {
      //         Navigator.push(context,MaterialPageRoute(builder: (context)=>movielistview()));
      //
      //       }
      //   )
      //   ),

    );
    return const Placeholder();
  }

}

class moviethumbnail extends StatelessWidget {

  final String thumbnail; //to apear a movie thumbnail dynamically on new screen on which movie user tapped beacuse this variable will took all information of movie which is tapped on previous screen in it
  const moviethumbnail({super.key, required this.thumbnail});
  //const moviethumbnail({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 190,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(thumbnail), fit: BoxFit.cover),),

                ),
                Icon(Icons.play_circle_outline, size: 100, color: Colors.white)

              ]
          ),
          //ADDING A GRADIENT TO FORM A SHADOW
          Container(
            decoration:BoxDecoration(
                gradient:LinearGradient(colors:[Color(0x00f5f5f5),Color(0xfff5f5f5)],
                    begin:Alignment.topCenter,
                    end:Alignment.bottomCenter)
            ),
            height:80,
          )
        ]
    );
    return const Placeholder();
  }

}
class moviedetailsother extends StatelessWidget {
  //const moviedetailsother({super.key});
  final MyMovies movie2;

  const moviedetailsother({super.key, required this.movie2});
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:const EdgeInsets.symmetric(horizontal:16),
        child:Row(
            children:<Widget>[
              movieposter(poster:movie2.images[0].toString()),
              SizedBox(width:16),//to make a gap in a row between two items
              Expanded(
                child:moviedetailsheader(movie3:movie2),
              ),



            ]
        )
    );
    return const Placeholder();
  }
}

class movieposter extends StatelessWidget {
  final String poster;

  const movieposter({super.key, required this.poster});


  //const movieposter({super.key});
  @override
  Widget build(BuildContext context) {
    var borderRadius=BorderRadius.all(Radius.circular(10));
    return Card(
      child:ClipRRect(//More flexibel tool to form a circular or rectangular or square widgets
          borderRadius:borderRadius,
          child:Container(
              width:MediaQuery.of(context).size.width/4,// /4 beacuse we need width narrow
              height:160,
              decoration:BoxDecoration(

                image:DecorationImage(image:NetworkImage(poster),
                    fit:BoxFit.cover),
              )
          )
      ),
    );


    return const Placeholder();
  }
}
class moviedetailsheader extends StatelessWidget {
  //const moviedetailsheader({super.key});
  final MyMovies movie3;

  const moviedetailsheader({super.key, required this.movie3});
  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment:CrossAxisAlignment.start,//every thing start from movie information container
        children:<Widget>[
          Text("${movie3.year}  ${movie3.genre}".toUpperCase(),style:TextStyle(
              fontWeight:FontWeight.bold,fontSize:25,
              color:Colors.indigo
          ),),
          Text(movie3.title,style:TextStyle(fontWeight:FontWeight.bold,fontSize:32,color:Colors.black)),
          Text("${movie3.plot} More........",style:TextStyle(color:Colors.black,fontSize:12,fontWeight:FontWeight.bold))
        ]
    );
    return const Placeholder();
  }
}

class moviedetailscast extends StatelessWidget {
  //const moviedetailscast({super.key});
  final MyMovies movie4;

  const moviedetailscast({super.key, required this.movie4});
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:const EdgeInsets.symmetric(horizontal:16.0),
        child:Column(
            children:<Widget>[
              movieField(field:"Cast",value:movie4.actors),
              movieField(field:"DIRECTORS",value:movie4.director),
              movieField(field:"AWARDS",value:movie4.awards),

            ]
        )
    );
    return const Placeholder();
  }
}
class movieField extends StatelessWidget {
  //const movieField({super.key});
  final String field;
  final String value;

  const movieField({super.key, required this.field, required this.value});
  @override
  Widget build(BuildContext context) {
    return Row(
        crossAxisAlignment:CrossAxisAlignment.start,
        children:<Widget>[
          Text("$field: ",style:TextStyle(
            color:Colors.black,
            fontWeight:FontWeight.bold,
            fontSize:12,)
          ),
          Expanded(

              child: Text(value,style:TextStyle(
                color:Colors.black,
                fontSize:12,
                fontWeight:FontWeight.bold,
              ))
          ),
        ]
    );
    return const Placeholder();
  }
}
class horizontalline extends StatelessWidget {//this class act to create  divider on screen
  const horizontalline({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:const EdgeInsets.symmetric(horizontal: 8.0,vertical: 12.0),
      height:0.5,
      color:Colors.grey,

    );

    return const Placeholder();
  }
}
class movieextraposters extends StatelessWidget {
  final List<String>posters;

  const movieextraposters({super.key, required this.posters});
  //const movieextraposters({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:CrossAxisAlignment.start,//we use cross axis alignment when we want to align any specific widget not all widgets(like in past examples where we use main axis alignment to aplly alignment on all children widgets that are present inside parent widget
      children:<Widget>[
        Text("MORE MOVIE POSTERS".toUpperCase(),style:TextStyle(
          fontSize:14,
          fontWeight:FontWeight.bold,
          color:Colors.black
        )),
        Container(
          height:200,
          child:ListView.separated(
    scrollDirection: Axis.horizontal,

              separatorBuilder: (context,index)=>SizedBox(width:8,),//it is a seperator between items that are present in this widget
              itemCount: posters.length,
              itemBuilder: (context,index)=>ClipRect(
              //borderRadius:BorderRadius.circular(10.0),
    child:Container(
    width:MediaQuery.of(context).size.width/4,
    height:160,
    decoration:BoxDecoration(
    image:DecorationImage(image:NetworkImage(posters[index]),fit:BoxFit.cover)
    )
    )


    ),
              ),

        )
        
      ]

    );

    return const Placeholder();
  }
}









//..............................
// class quizapp extends StatefulWidget {
//   const quizapp({super.key});
//
//   @override
//   State<quizapp> createState() => _quizappState();
// }
// // class _quizappState extends State<quizapp> {
// //   var questions=[
// //     Question("The sun rises in the west?", true),
// //     Question("Water boils at 100 degrees Celsius?",true),
// //     Question("Abraham Lincoln was the first President of the United States?",false),
// //     Question("The Great Wall of China is visible from space?",true),
// //     Question("Penguins can fly?",true),
// //     Question("The Eiffel Tower is located in London?",false),
// //     Question("Diamonds are made from compressed coal?",true),
// //     Question("The capital of Japan is Tokyo?",false),
// //     Question("The primary colors in art are red, blue, and green?",true),
// //     Question("The human body has 206 bones?",false),
// //     Question("The Nile is the longest river in the world?",true),
// //     Question("Honey never spoils?",true),
// //     Question("Mount Everest is the highest peak on Earth?",false),
// //     Question("Mars is the hottest planet in our solar system?",true)];
//   int _index=0;
//   int _myscore=0;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar:AppBar(title:Text("True Citizen",style:TextStyle(color:Colors.white,fontWeight:FontWeight.bold,
//         )
//         ),
//           centerTitle: true,backgroundColor: Colors.blueGrey,),
//         backgroundColor: Colors.blueGrey,
//         body:Container(
//
//           //margin:EdgeInsets.only(top:MediaQuery.of(context).size.height*0.1),
//             alignment:Alignment.center,
//             child:Column(
//               //mainAxisAlignment:MainAxisAlignment.center,
//               children:<Widget>[
//                 SizedBox(height:30),
//                 Container_getimage(),
//                 SizedBox(height:30),
//                 Container_showquestions(),
//                 SizedBox(height:30),
//                 Container_mybutton(),
//
//
//
//               ],
//
//             )
//         )
//     );
//
//     return const Placeholder();
//   }
//   Container_getimage()
//   {
//     return Container(
//
//       child:Image.asset("Images/flag.png",
//         width:300,
//         height:250,
//
//       ),
//
//     );
//   }
//   Container_showquestions()
//   {
//     return Container(
//         width:400,
//         height:120,
//         decoration:BoxDecoration(
//           color:Colors.transparent,
//           border:Border.all(color:Colors.grey,width:0.5),
//           borderRadius:BorderRadius.circular(12.0),
//         ),
//         child:Column(
//             children:<Widget>[
//               Padding(
//                   padding:EdgeInsets.all(10.0),
//                   child:Center(
//
//                     child:Text("${questions[_index].questiontext}",style:TextStyle(color:Colors.white,fontSize:20)),
//                   )
//               ),
//               SizedBox(height:10),
//
//             ]
//
//         )
//     );
//
//
//
//   }
//   Container_mybutton()
//   {
//     return Container(
//       child:Column(
//
//         children:<Widget>[
//           Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children:<Widget>[
//                 InkWell(
//                     onTap:()
//                     {
//
//                       myquestionsprevious();
//                     },
//                     child:Container(
//                         width:70,
//                         height:50,
//                         decoration:BoxDecoration(
//                           color:Colors.blueGrey.shade900,
//                         ),
//                         child:Center(child:Text("PREVIOUS",style:TextStyle(color:Colors.white,fontSize:14)))
//                     )
//                 ),
//
//
//                 Row(
//
//                   children:<Widget>[
//                     InkWell(
//                         onTap:()
//                         {
//                           checkanswer(true);
//                           myquestions();
//
//                         },
//                         child:Container(
//                           width:70,
//                           height:50,
//                           decoration:BoxDecoration(
//                             color:Colors.blueGrey.shade900,
//                           ),
//                           child:Center(child:Text("True",style:TextStyle(color:Colors.white,fontSize:14))),
//
//
//                         )
//                     ),
//
//                   ],
//                 ),
//                 Row(
//                     children:<Widget>[
//                       InkWell(
//                           onTap:()
//                           {
//                             checkanswer(false);
//                             myquestions();
//                           },
//                           child:Container(
//                               width:70,
//                               height:50,
//                               decoration:BoxDecoration(
//                                 color:Colors.blueGrey.shade900,
//                               ),
//                               child:Center(child:Text("FALSE",style:TextStyle(color:Colors.white,fontSize:14)))
//                           )
//                       )
//                     ]
//                 ),
//                 Row(
//                     children:<Widget>[
//                       InkWell(
//                           onTap:()
//                           {
//                             myquestions();
//                           },
//                           child:Container(
//                               width:80,
//                               height:50,
//                               decoration:BoxDecoration(
//                                 color:Colors.blueGrey.shade900,
//                               ),
//                               child:Center(child:Text("NEXT",style:TextStyle(color:Colors.white,fontSize:14)))
//                           )
//                       )
//                     ]
//                 )
//               ]
//           ),
//           SizedBox(height:30),
//           Row(
//
//               mainAxisAlignment:MainAxisAlignment.spaceBetween,
//               children:<Widget>[
//                 Text("YOUR SCORE",style:TextStyle(color:Colors.white,fontSize: 15,fontWeight:FontWeight.bold,)),
//                 Row(
//                     children:<Widget>[
//                       Container(
//                           width:100,
//                           height:50,
//                           decoration:BoxDecoration(
//                             color:Colors.blueGrey.shade900,
//                             borderRadius:BorderRadius.circular(15.0),
//                           ),
//                           child:Center(child:Text("$_myscore",style:TextStyle(color:Colors.white,fontSize:15,fontWeight:FontWeight.bold)))
//                       )
//                     ]
//                 )
//               ]
//
//           )
//         ],
//       ),
//     );
//   }
//
//
//   myquestions()//to move to next question
//   {
//     setState(() {
//       _index=(_index+1)%questions.length;//to avoid error that will apear when all questions are finished in array and length is finished
//     });
//   }
//   myquestionsprevious()
//   {
//     setState(() {
//       if(_index>=1)
//       {
//         _index--;
//       }
//     });
//   }
//
//   calculatemyscore()
//   {
//     setState(() {
//       _myscore++;
//     });
//   }
//
//   calculatemyscorenegative()
//   {
//     setState(() {
//       if(_myscore>=1) {
//         _myscore--;
//       }
//     });
//   }
//
//
//   checkanswer(bool userchoice)
//   {
//     if(userchoice==questions[_index].iscorrect)
//     {
//       final snackbar=SnackBar(content:Text("CORRECT ANSWER!!"),backgroundColor:Colors.blue,duration:Duration(milliseconds:1000,)
//       );
//       ScaffoldMessenger.of(context).showSnackBar(snackbar);
//       calculatemyscore();
//     }
//     else
//     {
//       final snackbar=SnackBar(content:Text("INCORRECT ANSWER!!"),backgroundColor:Colors.red,
//         duration:Duration(milliseconds:1000),
//       );
//       ScaffoldMessenger.of(context).showSnackBar(snackbar);
//       calculatemyscorenegative();
//     }
//   }
//
//
//
// }

//...............................................
//child:column is used when u want to provide a new container inside another container or any other task that does not occupy that parent container properties
//list view allow us to scroll up and down
//to move any container up and down left and right on screen=>margin:EdgeInsets.only(top/bottom/left*right:MediaQuery.of(context.size.height*0.5))
//mainAxisAlignment:MainAxisAlignment.center is used to specify positionof children:<widget> inside child:column OR child:Row
//there is no need to right child with any container inside children:<Widget>[]
// class mybillsplit extends StatefulWidget {
//   const mybillsplit({super.key});
//
//   @override
//   State<mybillsplit> createState() => _mybillsplitState();
// }
// class _mybillsplitState extends State<mybillsplit> {
//   int _tippercentage=0;
//   int _personcounter=0;
//   int _percentagecounter=0;
//   double _billamount=0.0;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar:AppBar(title:Text("WELCOME TO BILL DIVIDER",style:TextStyle(color:Colors.purple,),),centerTitle: true,backgroundColor: Colors.blueGrey),
//       body:Container(
//         alignment:Alignment.center,
//         margin:EdgeInsets.only(top:MediaQuery.of(context).size.height*0.1),
//         color:Colors.white,
//         child:ListView(
//             scrollDirection:Axis.vertical,
//             children:<Widget>[
//               Container_myfunctionfirst(),
//               SizedBox(height:20),
//               Container_myfunctionsecond(),
//             ]
//
//         ),
//       ),
//     );
//     return const Placeholder();
//   }
//
//   Container_myfunctionfirst()
//   {
//     return Container(
//         width:100,
//         height:100,
//         decoration:BoxDecoration(
//           color:Colors.purple.shade50,
//           borderRadius:BorderRadius.circular((2.2),),
//         ),
//         child:Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children:<Widget>[
//               Text("TOTAL PER PERSON",style:TextStyle(color:Colors.purple,fontSize:15,fontWeight:FontWeight.bold)),
//               Text("\$ ${calculateperperson(_billamount, _personcounter, _tippercentage)}",style:TextStyle(color:Colors.purple,fontSize:34.9,fontWeight:FontWeight.bold)),
//
//             ]
//         )
//     );
//   }
//   Container_myfunctionsecond()
//   {
//     return Container(
//         margin:EdgeInsets.only(top:20),
//         decoration:BoxDecoration(
//           color:Colors.white,
//           borderRadius:BorderRadius.circular(12.0),
//         ),
//         child:Column(
//             children:<Widget>[
//               TextField(
//                   keyboardType: TextInputType.numberWithOptions(decimal:true),
//                   style:TextStyle(color:Colors.grey),
//                   decoration:InputDecoration(
//                     prefix:Text("BILL AMOUNT"),
//                     prefixIcon:Icon(Icons.attach_money),
//
//                   ),
//                   onChanged: (String value)
//                   {
//                     try
//                     {
//                       _billamount=double.parse(value);
//                     }
//                     catch(exception)
//                     {
//                       _billamount=0.0;
//                     }
//                   }
//               ),
//               Row(
//                   mainAxisAlignment:MainAxisAlignment.spaceBetween,
//                   children:<Widget>[
//                     Text("SPLIT",style:TextStyle(color:Colors.grey.shade700),),
//                     Row(
//                         children:<Widget>[
//                           InkWell(
//                               onTap:()
//                               {
//                                 setState(() {
//                                   if(_personcounter>=1)
//                                   {
//                                     _personcounter--;
//                                   }
//                                   else
//                                   {
//                                     //do nothing
//                                   }
//                                 });
//                               },
//                               child:Container(
//                                 width:40,
//                                 height:40,
//                                 margin:EdgeInsets.all(10.0),
//                                 decoration:BoxDecoration(
//                                   color:Colors.purple.withOpacity(0.1),
//                                   borderRadius:BorderRadius.circular(7.0),
//                                 ),
//                                 child:Center(child:Text("-",style:TextStyle(color:Colors.purple,fontWeight:FontWeight.bold,fontSize:17.0))),
//
//                               )
//                           ),
//                           Text("${_personcounter}",style:TextStyle(color:Colors.purple,fontWeight:FontWeight.bold,fontSize:17.0)),
//
//                           InkWell(
//                               onTap:()
//                               {
//                                 setState(() {
//                                   _personcounter++;
//                                 });
//                               },
//                               child:Container(
//                                 width:40,
//                                 height:40,
//                                 margin:EdgeInsets.all(10.0),
//                                 decoration:BoxDecoration(
//                                   color:Colors.purple.withOpacity(0.1),
//                                   borderRadius:BorderRadius.circular(7.0),
//                                 ),
//                                 child:Center(child:Text("+",style:TextStyle(color:Colors.purple,fontWeight:FontWeight.bold,fontSize:17.0))),
//
//                               )
//                           ),
//
//                         ]
//                     )
//                   ]
//               ),
//               Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children:<Widget>[
//                     Text("TIP",style:TextStyle(color:Colors.grey.shade700,)),
//                     Row(
//                         children:<Widget>[
//                           Text("\$ ${calculatetotaltip(_billamount, _personcounter, _tippercentage)}",style:TextStyle(color:Colors.purple,fontWeight:FontWeight.bold,fontSize:17.0)
//                           ),
//
//                         ]
//                     )
//                   ]
//               ),
//               Column(
//                   children:<Widget>[
//                     Text("${_tippercentage}%",style:TextStyle(color:Colors.purple,fontSize:17.0,
//                         fontWeight:FontWeight.bold),),
//                     Slider(
//                         min:0,
//                         max:100,
//                         activeColor:Colors.purple,
//                         divisions:10,
//                         value:_tippercentage.toDouble(),
//                         onChanged:(double newValue)
//                         {
//                           setState(() {
//                             _tippercentage=newValue.round();
//                           });
//                         }
//                     )
//                   ]
//               )
//
//
//
//             ]
//         )
//     );
//   }
//
//
//   calculatetotaltip(double billamount,int splitby,int tippercentage)
//   {
//     double totaltip=0.0;
//     if(billamount<0||billamount.toString().isEmpty||billamount==null)
//     {
//       print('ERROR!!');
//     }
//     else
//     {
//       totaltip=(billamount*tippercentage)/100;
//     }
//     return totaltip;
//   }
//   calculateperperson(double billamount2,int splitby2,int tippercentage2)
//   {
//     var perperson=(billamount2+calculatetotaltip(billamount2, splitby2, tippercentage2))/splitby2;
//     return perperson;
//   }
//
//
//
//
// }
// class billsplit extends StatefulWidget {
//   const billsplit({super.key});
//
//   @override
//   State<billsplit> createState() => _billsplitState();
// }
// class _billsplitState extends State<billsplit> {
//   int _tippercentage=0;
//   int _personcounter=0;
//   int _percentagecounter=1;
//   double _billamount=0.0;
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body:Container(
//             margin:EdgeInsets.only(top:MediaQuery.of(context).size.height*0.1),
//             alignment:Alignment.center,
//             color:Colors.white,
//             child:ListView(
//                 scrollDirection:Axis.vertical,
//                 children:<Widget>[
//                   Container_myfunctionfirst(),
//                   SizedBox(height: 20),
//                   Container_myfunctionsecond(),
//
//                 ]
//             )
//         )
//     );
//     // );return const Placeholder();
//   }
//
//   Container_myfunctionfirst()
//   {
//     return Container(
//         width:100,
//         height:200,
//         decoration:BoxDecoration(
//           //border:Border.all(color:Colors.blue.shade500,),
//           color:Colors.purple.shade50,
//           borderRadius:BorderRadius.circular(2.2),
//         ),
//         child:Column(
//             mainAxisAlignment:MainAxisAlignment.center,
//             children:<Widget>[
//               Text(" Total per person",style:TextStyle(color:Colors.purple,fontWeight:FontWeight.bold,
//                 fontSize:15.0,),
//               ),
//               Text("\$ ${calculatetotalperperson(_billamount,_personcounter,_tippercentage)}",style:TextStyle(color:Colors.purple,fontSize:34.9,
//                 fontWeight:FontWeight.bold,),
//               )
//             ]
//
//         )
//     );
//   }
//
//   Container_myfunctionsecond()
//   {
//     return Container(
//
//         margin:EdgeInsets.only(top:20.0),
//         //padding:EdgeInsets.all(12.0),
//         decoration:BoxDecoration(
//           color:Colors.transparent,
//
//           borderRadius:BorderRadius.circular(12.0),
//         ),
//         child:Column(
//             children:<Widget>[
//               TextField(
//                   keyboardType: TextInputType.numberWithOptions(decimal:true),
//                   style:TextStyle(
//                       color:Colors.grey),
//                   decoration:InputDecoration(
//                     prefixText: "BILL AMOUNT",
//                     prefixIcon: Icon(Icons.attach_money),
//                   ),
//                   onChanged:(String value )//the value will is the amount that we give input to our app
//                   {
//                     try{
//                       _billamount=double.parse(value);//if user enter a string value as input then this try block will change and praise that string value into double value
//                     }catch(exception) {//this catch blockwill executed when try block throw exception due to any reason
//                       _billamount=0.0;
//                     }
//                   }
//
//
//
//               ),
//               Row(
//                   mainAxisAlignment:MainAxisAlignment.spaceBetween,
//
//                   children:<Widget>[
//                     Text("Split",style:TextStyle(color:Colors.grey.shade700),),
//                     Row(
//                         children:<Widget>[
//                           InkWell(
//                             onTap:(){
//                               setState(() {
//                                 if(_personcounter>=1)
//                                 {
//                                   _personcounter--;
//
//                                 }
//                                 else{
//                                   //do nothing
//                                 }
//                               });
//                             },
//                             child:Container(
//                               width:40,
//                               height:40,
//                               margin:EdgeInsets.all(10.0),
//                               decoration:BoxDecoration(
//                                 border:Border.all(color:Colors.blue.shade500,),
//                                 borderRadius:BorderRadius.circular(7.0),
//                                 color:Colors.purple.withOpacity(0.1),//with opacity is ued to give color shade to anything that is not present in colors.shade property
//                               ),
//                               child:Center(
//                                 child:Text("-",style:TextStyle(color:Colors.purple,fontWeight:FontWeight.bold,fontSize:17.0),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Text("$_personcounter",style:TextStyle(
//                             color:Colors.purple,fontSize:17.0,fontWeight:FontWeight.bold,
//                           ),
//                           ),
//                           InkWell(
//                             onTap:()
//                             {
//                               setState(() {
//                                 _personcounter++;
//                               });
//
//                             },
//                             child:Container(
//                               width:40,
//                               height:40,
//                               margin:EdgeInsets.all(10.0),
//                               decoration:BoxDecoration(
//                                 border:Border.all(color:Colors.blue.shade500,),
//                                 color:Colors.purple.withOpacity(0.1),
//                                 borderRadius:BorderRadius.circular(7.0),
//                               ),
//                               child:Center(child:Text("+",style:TextStyle(
//                                 color:Colors.purple,fontWeight:FontWeight.bold,
//                                 fontSize:17.0,
//                               ),
//                               ),
//                               ),
//                             ),
//
//                           )
//                         ]
//                     )
//                   ]
//               ),
//               SizedBox(height: 20),
//               Row(
//
//                   mainAxisAlignment:MainAxisAlignment.spaceBetween,
//                   children:<Widget>[
//                     Text("TIP",style:TextStyle(color:Colors.grey.shade700),
//                     ),
//
//
//
//                     Row(
//                       children:<Widget>[
//
//                         Text("\$ ${(calculatetotaltip(_billamount,_personcounter,_tippercentage)).toStringAsFixed(3)}",style:TextStyle(color:Colors.purple,fontWeight:FontWeight.bold,
//                           fontSize:17.0,),
//                         ),
//
//                       ],
//
//
//                     ),
//                   ]
//               ),
//
//               //slider starting
//               Column(
//                   children:<Widget>[
//                     Text("$_tippercentage%",style:TextStyle(color:Colors.purple,fontSize:17.0,
//                       fontWeight:FontWeight.bold,),
//                     ),
//                     Slider(
//                         min:0,//minimum value that slider will show
//                         max:100, //maximum value that slider will show
//                         activeColor:Colors.purple,//to specify color of slider
//                         divisions:10,//to mark divisions on slide bar
//                         value:_tippercentage.toDouble(),
//                         onChanged:(double newValue){
//                           setState(() {//to change value on slider with moving
//                             _tippercentage=newValue.round();
//                           });
//                         })
//                   ]
//               )
//
//
//             ]
//         )
//     );
//
//   }
//
//
//
//
//
//
//
//
//   calculatetotalperperson(double billamount, int splitby,int tippercentage)
//   {
//     var totalperperson=(calculatetotaltip(billamount,splitby,tippercentage)+billamount)/splitby;
//     return totalperperson.toStringAsFixed(3);//to remove overflow or under flow error. this instruction mean that it will control over flow or underflow till 3 digits
//   }
//   calculatetotaltip(double billamount,int splitby,int tippercentage)
//   {
//     double totaltip=0.0;
//     if(billamount<0||billamount.toString().isEmpty||billamount==null)
//     {
//       print("ERROR!! NO BILL");
//     }
//     else
//     {
//       totaltip=(billamount*tippercentage)/100;
//     }
//     return totaltip;
//   }
// }
// class calculatorapp extends StatefulWidget {
//   const calculatorapp({super.key});
//
//   @override
//   State<calculatorapp> createState() => _calculatorappState();
// }
// class _calculatorappState extends State<calculatorapp> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body:Container(
//
//             alignment:Alignment.topCenter,
//             child:Column(
//                 mainAxisAlignment:MainAxisAlignment.center,
//                 children:<Widget>[
//                   Container_getcard(),
//                 ]
//             )
//         )
//     );
//     return const Placeholder();
//   }
//   Container_getcard()
//   {
//     return Container(
//       //alignment:Alignment.center,
//       width:350,
//       height:200,
//       decoration:BoxDecoration(
//         color:Colors.purple.shade50,
//         borderRadius:BorderRadius.circular(1.5),
//       ),
//       child:Column(
//           mainAxisAlignment:MainAxisAlignment.center,
//           children:<Widget>[
//             Text("Total Per Person",style:TextStyle(color:Colors.purple),),
//             Text("#137.5",style:TextStyle(color:Colors.purple,fontWeight:FontWeight.w900,fontSize:30),),
//
//           ]
//       ),
//
//
//     );
//
//
//
//   }
//
// }
// class scaffoldexample extends StatelessWidget {
//   _tappbutton() {
//     debugPrint("BUTTON TAPPED!!");
//   }
//
//   //const scafold({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("WELCOME TO MY APP"),
//         centerTitle: true,
//         backgroundColor: Colors.amberAccent,
//         actions: <Widget>[
//           IconButton(icon: Icon(Icons.email),
//               onPressed: () => debugPrint("EMAIL TAPPED")),
//           IconButton(
//               icon: Icon(Icons.access_alarm), onPressed: _tappbutton()),
//           IconButton(icon: Icon(Icons.abc_outlined), onPressed: _tappbutton())
//         ],
//       ),
// //body of app
//       backgroundColor: Colors.deepOrange,
//       body: Container(
//         alignment: Alignment.center,
//         color: Colors.blue,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: <Widget>[
//             InkWell(
//               //in line 31 child:Center(child: Text("TAP ME")is used if alignment:Alignment.center is not used in line 25
//               child: Text("TAP ME", style: TextStyle(
//                   fontSize: 30, backgroundColor: Colors.deepPurple)
//
//
//               ),
//               onTap: () => debugPrint("TAPPED!!"),
//
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// class homeexample extends StatelessWidget {
// //  const home({super.key});
//
//
//   @override
//   //correctopen
//   // Widget build(BuildContext context) {
//   // return Center(
//   // child: Text("HELLO FLUTTER",textDirection: TextDirection.ltr)
//   //
//   // );//const Placeholder();//K
//   //
//   //  }//correct close
//   Widget build(BuildContext context) {
//     return Material(
//         color: Colors.deepOrange,
//         child:Center(child: Text("HELLO FLUTTER1",textDirection:TextDirection.ltr,
//             style:TextStyle(fontWeight:FontWeight.w100,
//                 fontSize:25.5,
//                 fontStyle:FontStyle.italic,color:Colors.blue,
//                 backgroundColor:Colors.deepPurple)))
//
//     );
//   }//const Placeholder();
// }



