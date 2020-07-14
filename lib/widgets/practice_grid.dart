// import 'package:flutter/material.dart';
// import '../Providers/dummy_data.dart';
// import 'package:provider/provider.dart';
// import '../widgets/practice_item.dart';
// import '../Providers/practice_model.dart';

// class PracticeGrid extends StatelessWidget {
//   final Practices trainings;

//   PracticeGrid(this.trainings);

//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//       padding: const EdgeInsets.all(10.0),
//       itemCount: trainings.length,
//       itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
//         value: trainings[i],
//         child: PracticeItem(trainings[i].name),
//       ),
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           childAspectRatio: 3 / 2,
//           crossAxisSpacing: 10,
//           mainAxisSpacing: 10),
//     );
//   }
// }
