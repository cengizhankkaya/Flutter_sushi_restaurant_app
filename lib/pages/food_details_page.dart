import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:susi/components/button.dart';
import 'package:susi/models/shop.dart';
import 'package:susi/theme/colors.dart';

import '../models/food.dart';

class FoodDeatailsPage extends StatefulWidget {
  const FoodDeatailsPage({super.key, required this.food});
  final Food food;

  @override
  State<FoodDeatailsPage> createState() => _FoodDeatailsPageState();
}

class _FoodDeatailsPageState extends State<FoodDeatailsPage> {
  //quantity
  int quantitCount = 0;

  // decrement quantity
  void decrementQuantity() {
    setState(() {
      if (quantitCount > 0) {
        quantitCount--;
      }
    });
  }
  // increment quantity

  void incrementQuantity() {
    setState(() {
      quantitCount++;
    });
  }

  // add to cart
  void addToCart() {
    // only add to cart if there is something in the cart
    if (quantitCount > 0) {
      //get access to shop
      final shop = context.read<Shop>();

      // add toı cart

      shop.addToCart(widget.food, quantitCount);

      //let the user know it was successful

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          backgroundColor: primaryColor,
          content: const Text(
            "Successfully added to cart",
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          actions: [
            // okay button
            IconButton(
                onPressed: () {
                  // pop once to remove dialog box
                  Navigator.pop(context);

                  //pop again to go previus screen
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.done,
                  color: Colors.white,
                ))
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.grey[900],
      ),
      body: Column(
        children: [
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: ListView(
              children: [
                // image
                Image.asset(
                  widget.food.imagePath,
                  height: 200,
                ),
                // rating
                Row(
                  // star icon
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.yellow[800],
                    ),
                    const SizedBox(width: 5),
                    // rating number
                    Text(
                      widget.food.rating,
                      style: TextStyle(
                          color: Colors.grey[600], fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                const SizedBox(height: 10),

                // food name
                Text(
                  widget.food.name,
                  style: GoogleFonts.dmSerifDisplay(fontSize: 28),
                ),
                // description
                Text(
                  "Description",
                  style: TextStyle(
                    color: Colors.grey[900],
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),

                Text(
                  "Salmon Sushi is a traditional Japanese dish prepared using fresh and flavorful salmon. This delicious meal is crafted by skillfully combining slices of salmon with sushi rice and is typically served with special sauces and garnishes.The main ingredients of Salmon Sushi include fresh salmon, sushi rice, and seaweed sheets (nori). Sushi rice is seasoned with a special vinegar mixture and presented in perfect harmony with the salmon slices.",
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                    height: 2,
                  ),
                ),
              ],
            ),
          )),
          // price + quantity + add to cart button
          Container(
            color: primaryColor,
            padding: const EdgeInsets.all(25),
            child: Column(children: [
              // price
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "\$${widget.food.price}",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  // quantity
                  Row(
                    children: [
                      //mınus button
                      Container(
                        decoration: BoxDecoration(
                            color: secondaryColor, shape: BoxShape.circle),
                        child: IconButton(
                          icon: const Icon(
                            Icons.remove,
                            color: Colors.white,
                          ),
                          onPressed: decrementQuantity,
                        ),
                      ),
                      // quantity count
                      SizedBox(
                        width: 40,
                        child: Center(
                          child: Text(
                            quantitCount.toString(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ),
                      ),

                      // plus button

                      Container(
                        decoration: BoxDecoration(
                            color: secondaryColor, shape: BoxShape.circle),
                        child: IconButton(
                          icon: const Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                          onPressed: incrementQuantity,
                        ),
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(height: 25),

              // add to cart button
              MyButton(text: "Add To Cart", onTap: addToCart),
            ]),
          )
        ],
      ),
    );
  }
}
