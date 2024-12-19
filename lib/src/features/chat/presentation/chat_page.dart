import 'package:cached_network_image/cached_network_image.dart';
import 'package:chyess/gen/assets.gen.dart';
import 'package:chyess/src/common_widgets/common_widgets.dart';
import 'package:chyess/src/constants/constants.dart';
import 'package:chyess/src/features/chat/presentation/chat_detail_page.dart';
import 'package:chyess/src/features/common/presentation/common_controller.dart';
import 'package:chyess/src/features/order/presentation/order_controller.dart';
import 'package:chyess/src/routes/app_routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class ChatPage extends ConsumerWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(orderControllerProvider);
    final user = ref.read(commonControllerProvider).userValue.asData?.value;

    return StatusBarWidget(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const CustomAppBar(),
        // TODO consultaion features
        body: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              TabBar(
                labelColor: ColorApp.primary,
                indicatorColor: ColorApp.primary,
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: Colors.transparent,
                labelStyle: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 55, 133, 236),
                ),
                tabs: const [
                  Tab(text: 'Pesanan'),
                  Tab(text: 'Konsultasi'),
                ],
              ),
              SizedBox(
                height: 1.sh - 205.h,
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: 18.w, right: 18.w, top: 20.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  height: 42.h,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10.r),
                                    // shadow all side
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.1),
                                        spreadRadius: 3,
                                        blurRadius: 6,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintStyle: TextStyle(
                                          fontSize: 14.sp, height: 4.h),
                                      prefixIcon: IconButton(
                                        icon: const Icon(Icons.search_rounded),
                                        onPressed: () {},
                                      ),
                                      iconColor: Colors.black,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.transparent,
                                            width: 0),
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.transparent,
                                            width: 0),
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                      ),
                                      hintText: "Search",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          SizedBox(
                            height: 1.sh - 205.h - 100.h,
                            width: 1.sw,
                            child: StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection("users")
                                  .doc(ref
                                      .read(commonControllerProvider.notifier)
                                      .getUid())
                                  .collection('chats')
                                  .where('lastMessage', isNotEqualTo: "")
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  return const Text("Error");
                                }
                                if (snapshot.data == null) return Container();
                                if (snapshot.data!.docs.isEmpty) {
                                  // Container with text
                                  return SizedBox(
                                    height: 1.sh - 205.h - 100.h,
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Belum ada pesan',
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                final data = snapshot.data!;
                                return ListView.builder(
                                  itemCount: data.docs.length,
                                  itemBuilder: (context, index) {
                                    Map<String, dynamic> item =
                                        (data.docs[index].data()
                                            as Map<String, dynamic>);
                                    item["id"] = data.docs[index].id;
                                    return Column(
                                      children: [
                                        FutureBuilder(
                                          future: FirebaseFirestore.instance
                                              .collection("users")
                                              .doc(item["contacts"])
                                              .get(),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasError) {
                                              return const Text("Error");
                                            }
                                            if (snapshot.data == null) {
                                              return Container();
                                            }
                                            if (snapshot.data!.data() == null) {
                                              return const Text("No Data 1");
                                            }
                                            final data = snapshot.data!;

                                            return StreamBuilder<QuerySnapshot>(
                                              stream: FirebaseFirestore.instance
                                                  .collection("messages")
                                                  .where('receiverId',
                                                      isEqualTo: ref
                                                          .read(
                                                              commonControllerProvider
                                                                  .notifier)
                                                          .getUid())
                                                  .snapshots(),
                                              builder: (context, snapshot2) {
                                                if (snapshot2.hasError) {
                                                  return const Text("Error");
                                                }
                                                if (snapshot2.data == null) {
                                                  return Container();
                                                }

                                                final readDocs = snapshot2
                                                    .data!.docs
                                                    .map((e) {
                                                  final temp = e.data()
                                                      as Map<String, dynamic>;
                                                  if (temp['isRead'] == false) {
                                                    return e.id;
                                                  } else {
                                                    return 0;
                                                  }
                                                }).toList();
                                                final reads = readDocs
                                                    .where((element) =>
                                                        element != 0)
                                                    .toList();
                                                final readLength = reads.length;

                                                return Column(
                                                  children: [
                                                    InkWell(
                                                      onTap: () async {
                                                        Future.wait((reads).map(
                                                          (e) {
                                                            return FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    "messages")
                                                                .doc(e
                                                                    .toString())
                                                                .update({
                                                              "isRead": true,
                                                            });
                                                          },
                                                        ));
                                                        // if (mounted) {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  ChatDetailPage(
                                                                usersId:
                                                                    data.id,
                                                                messagesId: item[
                                                                    'messagesId'],
                                                              ),
                                                            ));
                                                        // }
                                                      },
                                                      child: ListTile(
                                                        contentPadding:
                                                            EdgeInsets.only(
                                                                left: 18.w,
                                                                right: 18.w,
                                                                bottom: 5.h),
                                                        leading: CircleAvatar(
                                                          radius: 25.0,
                                                          backgroundImage: data
                                                                          .data()![
                                                                      'photoUrl'] !=
                                                                  null
                                                              ? CachedNetworkImageProvider(
                                                                  data.data()![
                                                                      'photoUrl'])
                                                              : Assets.images
                                                                  .profileDefaultImg
                                                                  .image(
                                                                    width: 60.w,
                                                                    height:
                                                                        60.h,
                                                                  )
                                                                  .image,
                                                        ),
                                                        title: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  bottom: 5.0),
                                                          child: Text(
                                                            data.data()![
                                                                'name'],
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                        subtitle: readLength !=
                                                                0
                                                            ? Text(
                                                                item[
                                                                    'lastMessage'],
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              )
                                                            : Text(
                                                                item[
                                                                    'lastMessage'],
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              ),
                                                        trailing: SizedBox(
                                                          height: 100,
                                                          width: 100,
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .end,
                                                            children: [
                                                              Text(
                                                                formatDate(item[
                                                                    'timeSent']),
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 12,
                                                                  color: readLength !=
                                                                          0
                                                                      ? Colors
                                                                          .black
                                                                      : Colors
                                                                          .grey,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 7.0,
                                                              ),
                                                              readLength != 0
                                                                  ? CircleAvatar(
                                                                      backgroundColor:
                                                                          Colors
                                                                              .red,
                                                                      radius:
                                                                          12.0,
                                                                      child:
                                                                          Text(
                                                                        readLength
                                                                            .toString(),
                                                                        style:
                                                                            const TextStyle(
                                                                          color:
                                                                              Colors.white,
                                                                          fontSize:
                                                                              14,
                                                                        ),
                                                                      ),
                                                                    )
                                                                  : const SizedBox(
                                                                      height:
                                                                          23,
                                                                    ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: 18.w, right: 18.w, top: 20.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                // Container with text and icon for saying "Konsultasi dengan Designer Sekarang" without text field
                                Container(
                                  height: 42.h,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10.r),
                                    border: Border.all(
                                      color: ColorApp.primary,
                                      width: 1.0,
                                    ),
                                  ),
                                  child: Card(
                                    color: Colors.white,
                                    elevation: 0,
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(10.r),
                                      onTap: () async {
                                        ref
                                            .read(commonControllerProvider
                                                .notifier)
                                            .fetchDesigners();
                                        ref
                                            .read(goRouterProvider)
                                            .pushNamed(Routes.consult.name);
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          // const Icon(Icons.chat_rounded,
                                          //     size: 20, color: ColorApp.primary),
                                          Assets.icons.icChat.svg(
                                            width: 20,
                                            height: 20,
                                            colorFilter: const ColorFilter.mode(
                                                ColorApp.primary,
                                                BlendMode.srcIn),
                                          ),
                                          const SizedBox(width: 10),
                                          Text(
                                            'Konsultasi dengan Designer Sekarang',
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 18.w,
                                    right: 18.w,
                                    top: 15.h,
                                    bottom: 13.h),
                                child: Text(
                                  'Sedang Berlangsung',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black.withOpacity(0.8),
                                  ),
                                ),
                              ),
                              const Spacer(),
                              InkWell(
                                onTap: () {},
                                splashColor: ColorApp.primary.withOpacity(0.5),
                                overlayColor: WidgetStateProperty.all(
                                    ColorApp.primary.withOpacity(0.1)),
                                borderRadius: BorderRadius.circular(20.r),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 18.w,
                                      right: 18.w,
                                      top: 15.h,
                                      bottom: 13.h),
                                  child: Text(
                                    'Riwayat',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                      color: ColorApp.primary,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          AsyncValueWidget(
                              value: state.orders,
                              data: (data) {
                                final orders = data
                                    ?.where(
                                      (order) => (order.type ==
                                              'consultation' &&
                                          order.statusCustom == 'Diproses' &&
                                          DateTime.now()
                                                  .difference(
                                                      order.items!.createdAt!)
                                                  .inMinutes <
                                              30),
                                    )
                                    .toList();
                                return orders?.isEmpty == true
                                    ? const SizedBox.shrink()
                                    : SizedBox(
                                        height: 1.sh - 205.h - 100.h,
                                        width: 1.sw,
                                        child: StreamBuilder<QuerySnapshot>(
                                          stream: FirebaseFirestore.instance
                                              .collection("users")
                                              .doc(ref
                                                  .read(commonControllerProvider
                                                      .notifier)
                                                  .getUid())
                                              .collection('chats')
                                              .where('lastMessage',
                                                  isNotEqualTo: "")
                                              .snapshots(),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasError) {
                                              return const Text("Error");
                                            }
                                            if (snapshot.data == null) {
                                              return Container();
                                            }
                                            if (snapshot.data!.docs.isEmpty) {
                                              // Container with text
                                              return SizedBox(
                                                height: 1.sh - 205.h - 100.h,
                                                child: Center(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        'Belum ada pesan',
                                                        style: TextStyle(
                                                          fontSize: 16.sp,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            }
                                            final data = snapshot.data!;
                                            return ListView.builder(
                                              itemCount: data.docs.length,
                                              itemBuilder: (context, index) {
                                                Map<String, dynamic> item =
                                                    (data.docs[index].data()
                                                        as Map<String,
                                                            dynamic>);
                                                item["id"] =
                                                    data.docs[index].id;
                                                return Column(
                                                  children: [
                                                    FutureBuilder(
                                                      future: FirebaseFirestore
                                                          .instance
                                                          .collection("users")
                                                          .doc(item["contacts"])
                                                          .get(),
                                                      builder:
                                                          (context, snapshot) {
                                                        if (snapshot.hasError) {
                                                          return const Text(
                                                              "Error");
                                                        }
                                                        if (snapshot.data ==
                                                            null) {
                                                          return Container();
                                                        }
                                                        if (snapshot.data!
                                                                .data() ==
                                                            null) {
                                                          return const Text(
                                                              "No Data 1");
                                                        }
                                                        final data =
                                                            snapshot.data!;

                                                        return StreamBuilder<
                                                            QuerySnapshot>(
                                                          stream: FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  "messages")
                                                              .where(
                                                                  'receiverId',
                                                                  isEqualTo: ref
                                                                      .read(commonControllerProvider
                                                                          .notifier)
                                                                      .getUid())
                                                              .snapshots(),
                                                          builder: (context,
                                                              snapshot2) {
                                                            if (snapshot2
                                                                .hasError) {
                                                              return const Text(
                                                                  "Error");
                                                            }
                                                            if (snapshot2
                                                                    .data ==
                                                                null) {
                                                              return Container();
                                                            }

                                                            final readDocs =
                                                                snapshot2
                                                                    .data!.docs
                                                                    .map((e) {
                                                              final temp = e
                                                                      .data()
                                                                  as Map<String,
                                                                      dynamic>;
                                                              if (temp[
                                                                      'isRead'] ==
                                                                  false) {
                                                                return e.id;
                                                              } else {
                                                                return 0;
                                                              }
                                                            }).toList();
                                                            final reads = readDocs
                                                                .where(
                                                                    (element) =>
                                                                        element !=
                                                                        0)
                                                                .toList();
                                                            final readLength =
                                                                reads.length;

                                                            return user?.role ==
                                                                    'designer'
                                                                ? orders!.any((order) =>
                                                                        order
                                                                            .customer
                                                                            ?.id ==
                                                                        data.data()![
                                                                            'id'])
                                                                    ? InkWell(
                                                                        onTap:
                                                                            () async {
                                                                          Future.wait(
                                                                              (reads).map(
                                                                            (e) {
                                                                              return FirebaseFirestore.instance.collection("messages").doc(e.toString()).update({
                                                                                "isRead": true,
                                                                              });
                                                                            },
                                                                          ));
                                                                          // if (mounted) {
                                                                          Navigator.push(
                                                                              context,
                                                                              MaterialPageRoute(
                                                                                builder: (context) => ChatDetailPage(
                                                                                  usersId: data.id,
                                                                                  messagesId: item['messagesId'],
                                                                                ),
                                                                              ));
                                                                          // }
                                                                        },
                                                                        child:
                                                                            ListTile(
                                                                          contentPadding: EdgeInsets.only(
                                                                              left: 18.w,
                                                                              right: 18.w,
                                                                              bottom: 5.h),
                                                                          leading:
                                                                              CircleAvatar(
                                                                            radius:
                                                                                25.0,
                                                                            backgroundImage: data.data()!['photoUrl'] != null
                                                                                ? CachedNetworkImageProvider(data.data()!['photoUrl'])
                                                                                : Assets.images.profileDefaultImg
                                                                                    .image(
                                                                                      width: 60.w,
                                                                                      height: 60.h,
                                                                                    )
                                                                                    .image,
                                                                          ),
                                                                          title:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(bottom: 5.0),
                                                                            child:
                                                                                Text(
                                                                              data.data()!['name'],
                                                                              style: const TextStyle(
                                                                                fontSize: 16,
                                                                                fontWeight: FontWeight.bold,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          subtitle: readLength != 0
                                                                              ? Text(
                                                                                  item['lastMessage'],
                                                                                  style: const TextStyle(
                                                                                    fontSize: 14,
                                                                                    color: Colors.black,
                                                                                    fontWeight: FontWeight.w500,
                                                                                  ),
                                                                                )
                                                                              : Text(
                                                                                  item['lastMessage'],
                                                                                  style: const TextStyle(
                                                                                    fontSize: 14,
                                                                                    fontWeight: FontWeight.w500,
                                                                                  ),
                                                                                ),
                                                                          trailing:
                                                                              SizedBox(
                                                                            height:
                                                                                100,
                                                                            width:
                                                                                100,
                                                                            child:
                                                                                Column(
                                                                              mainAxisSize: MainAxisSize.min,
                                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                                              crossAxisAlignment: CrossAxisAlignment.end,
                                                                              children: [
                                                                                Text(
                                                                                  formatDate(item['timeSent']),
                                                                                  style: TextStyle(
                                                                                    fontSize: 12,
                                                                                    color: readLength != 0 ? Colors.black : Colors.grey,
                                                                                    fontWeight: FontWeight.w600,
                                                                                  ),
                                                                                ),
                                                                                const SizedBox(
                                                                                  height: 7.0,
                                                                                ),
                                                                                readLength != 0
                                                                                    ? CircleAvatar(
                                                                                        backgroundColor: Colors.red,
                                                                                        radius: 12.0,
                                                                                        child: Text(
                                                                                          readLength.toString(),
                                                                                          style: const TextStyle(
                                                                                            color: Colors.white,
                                                                                            fontSize: 14,
                                                                                          ),
                                                                                        ),
                                                                                      )
                                                                                    : const SizedBox(
                                                                                        height: 23,
                                                                                      ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      )
                                                                    : const SizedBox
                                                                        .shrink()
                                                                : orders!.any((order) =>
                                                                        order
                                                                            .designer
                                                                            ?.id ==
                                                                        data.data()![
                                                                            'id'])
                                                                    ? InkWell(
                                                                        onTap:
                                                                            () async {
                                                                          Future.wait(
                                                                              (reads).map(
                                                                            (e) {
                                                                              return FirebaseFirestore.instance.collection("messages").doc(e.toString()).update({
                                                                                "isRead": true,
                                                                              });
                                                                            },
                                                                          ));
                                                                          // if (mounted) {
                                                                          Navigator.push(
                                                                              context,
                                                                              MaterialPageRoute(
                                                                                builder: (context) => ChatDetailPage(
                                                                                  usersId: data.id,
                                                                                  messagesId: item['messagesId'],
                                                                                ),
                                                                              ));
                                                                          // }
                                                                        },
                                                                        child:
                                                                            ListTile(
                                                                          contentPadding: EdgeInsets.only(
                                                                              left: 18.w,
                                                                              right: 18.w,
                                                                              bottom: 5.h),
                                                                          leading:
                                                                              CircleAvatar(
                                                                            radius:
                                                                                25.0,
                                                                            backgroundImage: data.data()!['photoUrl'] != null
                                                                                ? CachedNetworkImageProvider(data.data()!['photoUrl'])
                                                                                : Assets.images.profileDefaultImg
                                                                                    .image(
                                                                                      width: 60.w,
                                                                                      height: 60.h,
                                                                                    )
                                                                                    .image,
                                                                          ),
                                                                          title:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(bottom: 5.0),
                                                                            child:
                                                                                Text(
                                                                              data.data()!['name'],
                                                                              style: const TextStyle(
                                                                                fontSize: 16,
                                                                                fontWeight: FontWeight.bold,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          subtitle: readLength != 0
                                                                              ? Text(
                                                                                  item['lastMessage'],
                                                                                  style: const TextStyle(
                                                                                    fontSize: 14,
                                                                                    color: Colors.black,
                                                                                    fontWeight: FontWeight.w500,
                                                                                  ),
                                                                                )
                                                                              : Text(
                                                                                  item['lastMessage'],
                                                                                  style: const TextStyle(
                                                                                    fontSize: 14,
                                                                                    fontWeight: FontWeight.w500,
                                                                                  ),
                                                                                ),
                                                                          trailing:
                                                                              SizedBox(
                                                                            height:
                                                                                100,
                                                                            width:
                                                                                100,
                                                                            child:
                                                                                Column(
                                                                              mainAxisSize: MainAxisSize.min,
                                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                                              crossAxisAlignment: CrossAxisAlignment.end,
                                                                              children: [
                                                                                Text(
                                                                                  formatDate(item['timeSent']),
                                                                                  style: TextStyle(
                                                                                    fontSize: 12,
                                                                                    color: readLength != 0 ? Colors.black : Colors.grey,
                                                                                    fontWeight: FontWeight.w600,
                                                                                  ),
                                                                                ),
                                                                                const SizedBox(
                                                                                  height: 7.0,
                                                                                ),
                                                                                readLength != 0
                                                                                    ? CircleAvatar(
                                                                                        backgroundColor: Colors.red,
                                                                                        radius: 12.0,
                                                                                        child: Text(
                                                                                          readLength.toString(),
                                                                                          style: const TextStyle(
                                                                                            color: Colors.white,
                                                                                            fontSize: 14,
                                                                                          ),
                                                                                        ),
                                                                                      )
                                                                                    : const SizedBox(
                                                                                        height: 23,
                                                                                      ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      )
                                                                    : const SizedBox
                                                                        .shrink();
                                                          },
                                                        );
                                                      },
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      );
                              }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => Size.fromHeight(56.h + 1.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Text(
        'Chat',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: 20.sp,
        ),
      ),
      centerTitle: false,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(1.h),
        child: Container(
          height: 1.h,
          color: Colors.grey[300],
        ),
      ),
    );
  }
}

String formatDate(int epoch) {
  final date = DateTime.fromMillisecondsSinceEpoch(epoch);
  final now = DateTime.now();
  final difference = now.difference(date);
  if (difference.inDays > 7) {
    return DateFormat('dd MMM').format(date);
  } else if (difference.inDays > 1) {
    return DateFormat('EEEE').format(date);
  } else {
    return DateFormat('Hm').format(date);
  }
}
