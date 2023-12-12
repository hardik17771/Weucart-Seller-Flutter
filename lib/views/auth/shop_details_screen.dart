import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ShopDetailsScreen extends StatefulWidget {
  final User user;
  const ShopDetailsScreen({
    required this.user,
    super.key,
  });

  @override
  State<ShopDetailsScreen> createState() => _ShopDetailsScreenState();
}

class _ShopDetailsScreenState extends State<ShopDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
