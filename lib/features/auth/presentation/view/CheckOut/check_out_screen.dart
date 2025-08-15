// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class CheckoutScreen extends StatefulWidget {
//   const CheckoutScreen({super.key});

//   @override
//   State<CheckoutScreen> createState() => _CheckoutScreenState();
// }

// class _CheckoutScreenState extends State<CheckoutScreen> {
//   bool _twoDaysDelivery = true;
//   bool _cashOnDelivery = true;
//   late GoogleMapController mapController;
//   final LatLng _center = const LatLng(30.0444, 31.2357); // Cairo coordinates

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Checkout'),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Address Section with Map
//             const Text(
//               'Address',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
//             Card(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(
//                     height: 200,
//                     child: GoogleMap(
//                       onMapCreated: (controller) {
//                         setState(() {
//                           mapController = controller;
//                         });
//                       },
//                       initialCameraPosition: CameraPosition(
//                         target: _center,
//                         zoom: 11.0,
//                       ),
//                       markers: {
//                         Marker(
//                           markerId: const MarkerId('deliveryLocation'),
//                           position: _center,
//                           infoWindow: const InfoWindow(
//                             title: 'Delivery Location',
//                             snippet: 'Anshas, AI-sharaja, Egypt',
//                           ),
//                         ),
//                       },
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(16),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Text(
//                           'Home',
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16,
//                           ),
//                         ),
//                         const SizedBox(height: 4),
//                         const Text(
//                           'Anshas, AI-sharaja, Egypt.',
//                           style: TextStyle(fontSize: 14),
//                         ),
//                         const SizedBox(height: 4),
//                         const Text(
//                           'Mobile: +20 101 840 3043',
//                           style: TextStyle(fontSize: 14),
//                         ),
//                         const SizedBox(height: 8),
//                         Align(
//                           alignment: Alignment.centerRight,
//                           child: TextButton(
//                             onPressed: () {
//                               // Handle change address
//                             },
//                             child: const Text('Change'),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const Divider(height: 32),

//             // Delivery Time Section
//             const Text(
//               'Delivery time',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
//             CheckboxListTile(
//               title: const Text('Within 2 days'),
//               value: _twoDaysDelivery,
//               onChanged: (value) {
//                 setState(() {
//                   _twoDaysDelivery = value ?? false;
//                 });
//               },
//               controlAffinity: ListTileControlAffinity.leading,
//             ),
//             const Divider(height: 32),

//             // Payment Method Section
//             const Text(
//               'Payment',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
//             CheckboxListTile(
//               title: const Text('Cash on delivery'),
//               value: _cashOnDelivery,
//               onChanged: (value) {
//                 setState(() {
//                   _cashOnDelivery = value ?? false;
//                 });
//               },
//               controlAffinity: ListTileControlAffinity.leading,
//             ),
//             Align(
//               alignment: Alignment.centerRight,
//               child: TextButton(
//                 onPressed: () {
//                   // Handle change payment method
//                 },
//                 child: const Text('Change'),
//               ),
//             ),
//             const Divider(height: 32),

//             // Voucher Code Section
//             Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     decoration: InputDecoration(
//                       hintText: 'Voucher code',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 8),
//                 ElevatedButton(
//                   onPressed: () {
//                     // Handle apply voucher
//                   },
//                   child: const Text('Apply'),
//                 ),
//               ],
//             ),
//             const Divider(height: 32),

//             // Payment Summary Section
//             const Text(
//               'Payment',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
//             const Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text('Subtotal (3 items)'),
//                 Text('EGP 1,120.00'),
//               ],
//             ),
//             const SizedBox(height: 8),
//             const Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text('Delivery Fees'),
//                 Text('EGP 10.00'),
//               ],
//             ),
//             const Divider(height: 16),
//             const Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Total',
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                 ),
//                 Text(
//                   'EGP 1,130.00',
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                 ),
//               ],
//             ),
//             const Divider(height: 32),

//             // Place Order Button
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: () {
//                   // Handle place order
//                 },
//                 style: ElevatedButton.styleFrom(
//                   padding: const EdgeInsets.symmetric(vertical: 16),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//                 child: const Text(
//                   'Place Order',
//                   style: TextStyle(fontSize: 16),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }