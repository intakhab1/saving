part of 'screens.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          Container(
            width: deviceWidth(context),
            height: 140 - statusBarHeight(context),
            decoration: BoxDecoration(
              color: baseColor,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(24),
                bottomLeft: Radius.circular(24),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: defaultMargin,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40,
                ),
                Text(
                  "Savings - Mobile Savings App",
                  style: semiBoldBaseFont.copyWith(
                    fontSize: 16,
                    color: lightColor,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  width: defaultWidth(context),
                  height: 100,
                  padding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: lightColor,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF888888).withOpacity(0.25),
                        blurRadius: 24,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ValueListenableBuilder(
                        valueListenable:
                            Hive.box<History>('histories').listenable(),
                        builder: (context, Box<History> box, _) {
                          int currentMoney = box.values.fold(
                              0, (sum, historyBox) => sum + historyBox.nominal);
                          int todayMoney = box.values.where((targetBox) {
                            int historyDate =
                                DateTime.fromMillisecondsSinceEpoch(
                                        targetBox.createdAt)
                                    .day;
                            int currentDate = DateTime.now().day;
                            return historyDate == currentDate;
                          }).fold(
                              0, (sum, histories) => sum + histories.nominal);

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "My Total Money",
                                style: semiBoldBaseFont.copyWith(
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                NumberFormat.currency(
                                  locale: 'id_ID',
                                  decimalDigits: 0,
                                  symbol: "INR ",
                                ).format(currentMoney),
                                style: extraBoldBaseFont.copyWith(
                                  fontSize: 24,
                                ),
                              ),
                              Text(
                                NumberFormat.currency(
                                      locale: 'id_ID',
                                      decimalDigits: 0,
                                      symbol: "+INR ",
                                    ).format(todayMoney) +
                                    " Today",
                                style: semiBoldBaseFont.copyWith(
                                  fontSize: 12,
                                  color: greenColor,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      SizedBox(
                        width: 60,
                        height: 60,
                        child: FloatingActionButton(
                          elevation: 0,
                          heroTag: "btn_summary",
                          backgroundColor: greyColor,
                          child: SvgPicture.asset(
                            "assets/svg/ic_chart.svg",
                            width: 24,
                            height: 24,
                          ),
                          onPressed: null,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Saving Target",
                      style: semiBoldBaseFont.copyWith(
                        fontSize: 14,
                      ),
                    ),
                    FlatButton(
                      padding: EdgeInsets.symmetric(
                        horizontal: 0,
                      ),
                      child: Text(
                        "View All",
                        style: semiBoldBaseFont.copyWith(
                          fontSize: 14,
                        ),
                      ),
                      onPressed: () {
                        Provider.of<NavigationProvider>(context, listen: false)
                            .changeIndex(1);
                      },
                    ),
                  ],
                ),
                Container(
                  height: ((Hive.box<Target>('targets').values.isEmpty)
                          ? 220
                          : Hive.box<Target>('targets').values.length * 86 - 16)
                      .toDouble(),
                  child: ValueListenableBuilder(
                      valueListenable: Hive.box<Target>('targets').listenable(),
                      builder: (context, Box<Target> box, _) {
                        if (box.values.isEmpty) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  "assets/svg/no_data_illustration.svg",
                                  width: 180,
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                                Text(
                                  "You Don't Have A\nSavings Target",
                                  textAlign: TextAlign.center,
                                  style: semiBoldBaseFont.copyWith(
                                    color: greyColor,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }

                        return ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: box.values.take(3).length,
                          itemBuilder: (_, index) {
                            Target targets = box.getAt(index);

                            return Padding(
                              padding: EdgeInsets.only(
                                top: (index == 0) ? 0 : 16,
                              ),
                              child: SavingTargetCard(
                                targetName: targets.targetName,
                                nominal: targets.nominal,
                                period: targets.period,
                                durationType: targets.durationType,
                                currentMoney: targets.currentMoney,
                                category: targets.category,
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    DetailTargetScreen.routeName,
                                    arguments: Target(
                                      id: index,
                                      targetName: targets.targetName,
                                      nominal: targets.nominal,
                                      period: targets.period,
                                      durationType: targets.durationType,
                                      currentMoney: targets.currentMoney,
                                      category: targets.category,
                                      priorityLevel: targets.priorityLevel,
                                      description: targets.description,
                                      createdAt: targets.createdAt,
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        );
                      }),
                ),
                SizedBox(
                  height: 9,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Savings History",
                      style: semiBoldBaseFont.copyWith(
                        fontSize: 14,
                      ),
                    ),
                    FlatButton(
                      padding: EdgeInsets.symmetric(
                        horizontal: 0,
                      ),
                      child: Text(
                        "View All",
                        style: semiBoldBaseFont.copyWith(
                          fontSize: 14,
                        ),
                      ),
                      onPressed: () {
                        Provider.of<NavigationProvider>(context, listen: false)
                            .changeIndex(1, isTargetTab: false);
                      },
                    ),
                  ],
                ),
                Container(
                  height: ((Hive.box<History>('histories').values.isEmpty)
                          ? 220
                          : Hive.box<History>('histories').values.length * 86 -
                              16)
                      .toDouble(),
                  child: ValueListenableBuilder(
                    valueListenable:
                        Hive.box<History>('histories').listenable(),
                    builder: (context, Box<History> box, _) {
                      if (box.values.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                "assets/svg/no_data_illustration.svg",
                                width: 180,
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Text(
                                "You Don't Have A\nSavings History",
                                textAlign: TextAlign.center,
                                style: semiBoldBaseFont.copyWith(
                                  color: greyColor,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        );
                      }

                      return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: box.values.take(3).length,
                        itemBuilder: (_, index) {
                          History histories = box.getAt(index);

                          return Padding(
                            padding: EdgeInsets.only(
                              top: (index == 0) ? 0 : 16,
                            ),
                            child: SavingHistoryCard(
                              targetName: histories.targetName,
                              nominal: histories.nominal,
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 104,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
