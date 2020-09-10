import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gregdoucette/model/intake-history_model.dart';
import 'package:hive/hive.dart';
import 'model/intake_model.dart';
import 'widgets/add-intake-bottom_sheet.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{

  TabController controller;

  int index;
  int consumed;
  List<IntakeHistoryModel> lastDays;


  @override
  void initState() {
    super.initState();

    final box = Hive.box<IntakeHistoryModel>('records');

    if (box.length > 5) {
      lastDays = box.values.skip(box.length - 5).toList();
    } else {
      lastDays = box.values.toList();
    }
    index = lastDays.length - 1;
    consumed = _totalConsumed(index);
    controller = TabController(vsync: this,initialIndex: index,length: lastDays.length);
    controller.addListener(() {
      setState(() {
        consumed = _totalConsumed(index);
      });
    });
  }

  _dayOfWeekday(int i) {
    return ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][i-1];
  }

  _buildTabs() {
    final list = <Widget>[];

    for (var i = 0; i < lastDays.length - 2; ++i) {
      list.add(Tab(child: Text('${_dayOfWeekday(lastDays[i].createdAt.weekday)}, ${lastDays[i].createdAt.day}')));
    }

    if (lastDays.length >= 2) {
      list.add(Tab(child: Text('Yesterday')));
    }

    list.add(Tab(child: Text('Today')));
    return list;
  }
  _buildViews() {
    return lastDays.map((days) {
      return CustomScrollView(
          slivers: [
        SliverPadding(
          padding: EdgeInsets.only(left: 8,right: 8,top: 10,bottom: 20),
            sliver: SliverToBoxAdapter(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: (){
                    showDialog(
                        barrierDismissible: true,
                        context: context,
                        child: CupertinoAlertDialog(
                          title: Text("Change Daily Caloric Intake"),
                          content: Container(
                            height: 200,
                            child: CupertinoPicker.builder(
                                itemExtent: 20,
                                childCount: 5200,
                                scrollController: FixedExtentScrollController(initialItem:
                                lastDays[index].dailyGoal - 800),
                                onSelectedItemChanged: (val) async {

                                  var box = await Hive.openBox('dailyCalorieIntake');
                                  print(box.values);

                                  await box.put('dailyCalorieIntake', val+800);
                                  print(box.values);
                                  lastDays[index].dailyGoal = val+800;
                                  lastDays[index].save();

                                  setState(() {

                                  });

                                },
                                itemBuilder: (context,index){
                                  return Text((index+800).toString(),style: TextStyle(
                                      color: Colors.black
                                  ),);
                                }),
                          ),
                        )
                    );
                  },
                    child: dailyGoalWidget('Total calories for today:  ', lastDays[index].dailyGoal.toString())),
              consumedWidget('Total calories consumed:  ', consumed.toString()) ,
                consumed <= lastDays[index].dailyGoal ?     remaining((lastDays[index].dailyGoal - consumed).toString()) :
                overtook((consumed - lastDays[index].dailyGoal ).toString())
              ],
            ))),

        SliverList(delegate: SliverChildBuilderDelegate(
          (context, i) {
            return Dismissible(
              key: ValueKey(DateTime.now()),
              background: Container(
                color: Colors.green,
               child: Align(
                    alignment: Alignment.centerLeft,
                    child: Icon(CupertinoIcons.pencil,color: Colors.white,)),
              ),

              secondaryBackground: Container(
                color: Colors.red,
                child: Align(
                  alignment: Alignment.centerRight,
                    child: Icon(CupertinoIcons.delete,color: Colors.white,)),
              ),
              onDismissed: (DismissDirection direction) async {
                if(direction == DismissDirection.endToStart){
                  lastDays[index].intakes.removeAt(i);
                  lastDays[index].save();
                  setState(() {
                    consumed = _totalConsumed(index);
                  });
                }
              },
              dismissThresholds: {
                // DismissDirection.endToStart: 100
              },
              confirmDismiss: (direction) async {
                if (direction == DismissDirection.endToStart) {
                  return Future.value(true);
                } else {
                  var res = await showModalBottomSheet(
                      isScrollControlled: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                            top: Radius.circular(15.0)),
                      ),
                      context: context,
                      builder: (context) => AddIntakeSheet(
                        intake: lastDays[index].intakes[i],
                      ));

                  if (res != null) {
                    lastDays[index].intakes[i] = res;
                    await lastDays[index].save();
                    setState(() {
                      consumed = _totalConsumed(index);
                    });
                  }
                  return Future.value(false);
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey,width: 0.5),
                ),
                child: ListTile(
                  dense: true,
                  title: Text("Consumed " + days.intakes[i].calories.toString() + " calories"),
                  subtitle: days.intakes[i].description !=null ? Text(days.intakes[i].description) : null,
                  trailing: Text(TimeOfDay.fromDateTime(days.intakes[i].time).format(context)),
                ),
              ),
            );
          },
          childCount: days.intakes.length
        ))
      ]);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFD40504),
        child: Icon(CupertinoIcons.add,size: 30,semanticLabel: 'Add calorie intake',),
        onPressed: () async {
          var res = await  showModalBottomSheet(
           isScrollControlled: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                    top: Radius.circular(15.0)),
              ),
              context: context,
              builder: (context) => AddIntakeSheet(

              ));

          if (res != null) {
            lastDays[index].intakes.add(res);
            await lastDays[index].save();
            setState(() {
              consumed = _totalConsumed(index);
            });
          }
        },
      ),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFFEAEAEA),
        title: Image.asset("assets/images/logo.jpeg",scale: 10),
        bottom: TabBar(
          isScrollable: true,
          controller: controller,
          labelColor: Colors.black,
          indicatorColor: Colors.red,
          onTap: (i) {
            index = i;
            consumed = _totalConsumed(index);
            setState(() {
            });
          },

          tabs: _buildTabs(),
        ),
      ),


      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
          controller: controller,
          children: _buildViews()
      )
    );
  }

  _totalConsumed(int index) {
    var sum = 0;
    lastDays[index].intakes.forEach((element) {
      sum += element.calories;
    });

    return sum;
  }

  Widget consumedWidget(String label, String value){
    return  RichText(
      text: TextSpan(
        text: label,
        style: TextStyle(
            color: Colors.black,
            fontSize: 17
        ),
        children: <TextSpan>[
          TextSpan(text: value, style: TextStyle(fontWeight: FontWeight.bold,
              color: Color(0xFFD40504),
          )),
        ],
      ),
    );
  }

  Widget dailyGoalWidget(String label, String value){
    return  Row(
      children: [
        RichText(
          text: TextSpan(
            text: label,
            style: TextStyle(
                color: Colors.black,
                fontSize: 17
            ),
            children: <TextSpan>[
              TextSpan(text: value, style: TextStyle(fontWeight: FontWeight.bold,
                color: Color(0xFFD40504),
              )),
            ],
          ),
        ),
        SizedBox(width: 5),
        Icon(CupertinoIcons.pencil,size: 15,color: Colors.red,),
      ],
    );
  }

  Widget remaining(String value){
    return RichText(
      text: TextSpan(
        text: 'You have ',
        style: TextStyle(
            color: Colors.black,
            fontSize: 17
        ),
        children: <TextSpan>[
          TextSpan(text: value, style: TextStyle(fontWeight: FontWeight.bold,
              color: Color(0xFFD40504),
          )),
          TextSpan(text: ' calories left for today', style: TextStyle(
              color: Colors.black,
              fontSize: 17
          )),
        ],
      ),
    );
  }

  Widget overtook(String value){
    return RichText(
      text: TextSpan(
        text: 'You overtook ',
        style: TextStyle(
            color: Colors.black,
            fontSize: 17
        ),
        children: <TextSpan>[
          TextSpan(text: value, style: TextStyle(fontWeight: FontWeight.bold,
            color: Color(0xFFD40504),
          )),
          TextSpan(text: ' calories', style: TextStyle(
              color: Colors.black,
              fontSize: 17
          )),
        ],
      ),
    );
  }
}
