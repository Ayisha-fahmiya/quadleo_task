import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:quadleo_machine_test/api%20services/api_services.dart';
import 'package:quadleo_machine_test/constants/colour_constants.dart';
import 'package:quadleo_machine_test/responsive/responsive.dart';

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key});

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // final pageNoProvider = StateProvider((ref) => 4);
    int page = 4;
    final userDataApi = ref.watch(getAllUserDataProvider(page));
    final scrollController = ScrollController();

    scrollController.addListener(() {
      if (scrollController.position.physics ==
          scrollController.position.maxScrollExtent) {
        page++;
        ref.watch(getAllUserDataProvider(page));
      }
    });
    // bool isLoading = false;
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        backgroundColor: bgColor,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        title: const Text(
          "Customers",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: primariColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(54),
            topRight: Radius.circular(54),
          ),
        ),
        padding: EdgeInsets.only(
          top: R.sw(26, context),
          left: R.sw(28, context),
          right: R.sw(28, context),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: R.sh(46, context),
                  width: R.sw(282, context),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: R.sw(4, context),
                    // vertical: R.sw(24, context),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search",
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.search,
                        size: R.sh(20, context),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Image.asset("assets/adjustments.png"),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: R.sh(24, context)),
              child: userDataApi.when(
                data: (value) {
                  if (value != null) {
                    final userData = value.data.data;
                    final links = value.data.links;
                    return userData.isEmpty
                        ? const SizedBox(
                            height: 700,
                            child: Center(
                              child: Text("No customer data"),
                            ),
                          )
                        : SizedBox(
                            height: R.sh(userData.length * 58, context),
                            child: ListView.separated(
                              controller: scrollController,
                              itemCount: value.data.perPage,
                              separatorBuilder: (context, index) => Gap(
                                R.sh(14, context),
                              ),
                              itemBuilder: (context, index) {
                                return Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: R.sw(18, context),
                                    vertical: R.sw(14, context),
                                  ),
                                  height: R.sh(120, context),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: index % 2 == 0
                                            ? colours[1]
                                            : index % 3 == 0
                                                ? colours[2]
                                                : colours[0],
                                        radius: R.sw(28, context),
                                        child: Center(
                                          child: Text(
                                            userData[index]
                                                .name[0]
                                                .toUpperCase(),
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: R.sw(22, context),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(
                                            left: R.sw(10, context)),
                                        width: R.sw(140, context),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              userData[index].name,
                                              style: TextStyle(
                                                fontSize: R.sw(16, context),
                                                fontWeight: FontWeight.bold,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Text(
                                              userData[index].address,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Text(
                                              userData[index].areaName,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Text("ID : ${userData[index].id}"),
                                          ],
                                        ),
                                      ),
                                      const Spacer(),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color: index % 2 == 0
                                                  ? colours[1]
                                                  : index % 3 == 0
                                                      ? colours[2]
                                                      : colours[0],
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            padding: EdgeInsets.symmetric(
                                              horizontal: R.sw(10, context),
                                              vertical: R.sw(2, context),
                                            ),
                                            child: Text(
                                              links[index + 1].active
                                                  ? "active"
                                                  : "Inactive",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: R.sw(12, context),
                                                fontWeight: FontWeight.w300,
                                              ),
                                            ),
                                          ),
                                          Text("LCO# ${userData[index].lcoNo}"),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          );
                  } else {
                    return const Center(
                      child: Text("No data"),
                    );
                  }
                },
                error: (error, stackTrace) => SizedBox(
                  height: R.sh(500, context),
                  child: const Center(
                    child: Text("Failed to fetch customer data"),
                  ),
                ),
                loading: () => SizedBox(
                  height: R.sh(500, context),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
