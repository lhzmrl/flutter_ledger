import 'package:flutter/material.dart';
import 'package:ledger/ui/transaction/view/transaction_list_header.dart';

class TransactionsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    ScrollBehavior _configuration = ScrollConfiguration.of(context);
    ScrollPhysics physics = _configuration.getScrollPhysics(context);

    return SafeArea(
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 64,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  right: 16,
                  child: Text("日期"),
                ),
                Container(
                  child: Text("账本名称"),
                ),
              ],
            ),
          ),
          TransListHeader(),
          Expanded(
            child: ListView.builder(
                physics: _AnimScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(title: Text("$index"));
                }
            )
          )
        ],
      ),
    );
  }

}

class _AnimScrollPhysics extends ScrollPhysics {

  @override
  double applyPhysicsToUserOffset(ScrollMetrics position, double offset) {
    print("applyPhysicsToUserOffset: offset=$offset");
    return super.applyPhysicsToUserOffset(position, offset);
  }

  @override
  double applyBoundaryConditions(ScrollMetrics position, double value) {
    print("applyBoundaryConditions: value=$value");
    return super.applyBoundaryConditions(position, value);
  }

  @override
  Simulation createBallisticSimulation(ScrollMetrics position, double velocity) {
    print("createBallisticSimulation: velocity=$velocity");
    return super.createBallisticSimulation(position, velocity);
  }

  @override
  double carriedMomentum(double existingVelocity) {
    print("carriedMomentum: existingVelocity=$existingVelocity");
    return super.carriedMomentum(existingVelocity);
  }

}