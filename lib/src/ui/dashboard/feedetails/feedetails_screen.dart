import 'package:flutter/material.dart';
import 'package:iroots/src/utility/app_colors.dart';

class FeeDetailsScreen extends StatefulWidget {
  const FeeDetailsScreen({super.key});

  @override
  State<FeeDetailsScreen> createState() => _FeeDetailsScreenState();
}

class _FeeDetailsScreenState extends State<FeeDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.contentColorBlue,
        actions: [],
        title: Text(
          "Fee Details",
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            spacing: 2,
            children: [_feedetails(), _feedetails(), _feedetails()],
          ),
        ),
      ),
    );
  }

  _feedetails() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: const Color.fromARGB(255, 165, 203, 233),
        width: MediaQuery.of(context).size.width / 1,
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.mail,
                    color: Colors.blue,
                  ),
                  Text("February"),
                  Icon(
                    Icons.arrow_downward,
                    color: Colors.blue,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width / 1,
                  child: Divider(
                    height: 2,
                    color: Colors.blue,
                  )),
              SizedBox(
                height: 10,
              ),
              Text("Total"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("₹ 16,600"),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Container(
                      color: const Color.fromARGB(255, 138, 223, 182),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Paid"),
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text("Activity Fee"), Text("₹ 2,600")],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text("Activity Fee"), Text("₹ 2,600")],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text("Activity Fee"), Text("₹ 2,600")],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text("Activity Fee"), Text("₹ 2,600")],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
