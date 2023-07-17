import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/providers/providers.dart';
import 'package:qr_scanner/utils/utils.dart';

class ScanList extends StatelessWidget {
  final String type;

  const ScanList({required this.type});

  @override
  Widget build(BuildContext context) {
    final results = Provider.of<ScanProvider>(context);
    final listOfResults = results.scans;

    return Container(
      color: Colors.grey.shade100,
      child: ListView.separated(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: listOfResults.length,
        separatorBuilder: (_, i) => Divider(color: Colors.grey.shade200),
        itemBuilder: (_, i) => Slidable(
          direction: Axis.horizontal,
          startActionPane: ActionPane(
            extentRatio: 0.15,
            motion: const StretchMotion(),
            children: [
              SlidableAction(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                backgroundColor: Colors.red.shade600,
                icon: Icons.delete,
                onPressed: (_) {
                  results.deleteScansByID(listOfResults[i].id!);
                },
              ),
            ],
          ),
          child: ListTile(
            leading: Icon(
              type == 'https' ? Icons.http : Icons.map_outlined,
              color: Colors.grey.shade700,
              size: 25,
            ),
            title: Text(
              listOfResults[i].value.toString(),
              style: TextStyle(color: Colors.grey.shade700),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.keyboard_arrow_right_outlined),
              color: Colors.grey.shade700,
              onPressed: () => launchURL(context, listOfResults[i]),
            ),
            onTap: () {},
          ),
        ),
      ),
    );
  }
}
