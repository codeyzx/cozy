import 'package:chyess/src/features/order/domain/order/order.dart' as domain;
import 'package:chyess/src/services/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'order_repository.g.dart';

class OrderRepository {
  final orderDb = FirebaseFirestore.instance.collection('orders').withConverter(
        fromFirestore: (snapshot, _) => domain.Order.fromJson(snapshot.data()!),
        toFirestore: (domain.Order order, _) => order.toJson(),
      );

  Future<Result<List<domain.Order>>> getOrders(
      {String? uid, String? designerId}) async {
    try {
      final resultOrders = uid != null
          ? await orderDb
              .where(
                'customer.id',
                isEqualTo: uid,
              )
              .get()
          : designerId != null
              ? await orderDb
                  .where(
                    'designer.id',
                    isEqualTo: designerId,
                  )
                  .get()
              : await orderDb.get();
      final orders = resultOrders.docs.map((e) => e.data()).toList();
      return Result.success(orders);
    } catch (e) {
      Logger().e(e);
      return Result.failure(
          NetworkExceptions.getFirebaseException(e), StackTrace.current);
    }
  }

  Future<Result<domain.Order>> getOrder(String id) async {
    try {
      final resultOrder = await orderDb.doc(id).get();
      final order = resultOrder.data();
      return Result.success(order!);
    } catch (e) {
      Logger().e(e);
      return Result.failure(
          NetworkExceptions.getFirebaseException(e), StackTrace.current);
    }
  }

  Future<Result<String>> addOrder(domain.Order order) async {
    try {
      final ref = orderDb.doc();
      order = order.copyWith(id: ref.id);
      await ref.set(order);
      return const Result.success('Success');
    } catch (e) {
      Logger().e(e);
      return Result.failure(
          NetworkExceptions.getFirebaseException(e), StackTrace.current);
    }
  }

  Future<Result<String>> addTransaction(domain.Order order) async {
    try {
      final ref = orderDb.doc(order.id);
      await ref.update({
        'transaction': order.transaction?.toJson(),
      });
      return const Result.success('Success');
    } catch (e) {
      Logger().e(e);
      return Result.failure(
          NetworkExceptions.getFirebaseException(e), StackTrace.current);
    }
  }

  Future<Result<String>> cancelOrder(String orderId) async {
    try {
      await orderDb.doc(orderId).update({
        'statusCustom': 'Dibatalkan',
      });
      return const Result.success('Success');
    } catch (e) {
      Logger().e(e);
      return Result.failure(
          NetworkExceptions.getFirebaseException(e), StackTrace.current);
    }
  }

  Future<Result<String>> confirmDeliveryOrder(String orderId) async {
    try {
      await orderDb.doc(orderId).update({
        'statusCustom': 'Selesai',
      });
      return const Result.success('Success');
    } catch (e) {
      Logger().e(e);
      return Result.failure(
          NetworkExceptions.getFirebaseException(e), StackTrace.current);
    }
  }

  // confirmSendOrder
  Future<Result<String>> confirmSendOrder(String orderId) async {
    try {
      await orderDb.doc(orderId).update({
        'statusCustom': 'Dikirim',
      });
      return const Result.success('Success');
    } catch (e) {
      Logger().e(e);
      return Result.failure(
          NetworkExceptions.getFirebaseException(e), StackTrace.current);
    }
  }

  Future<Result<String>> confirmOrder(int price, String orderId) async {
    try {
      await orderDb.doc(orderId).update({
        'items.price': price,
        'statusCustom': 'Diterima',
      });
      return const Result.success('Success');
    } catch (e) {
      Logger().e(e);
      return Result.failure(
          NetworkExceptions.getFirebaseException(e), StackTrace.current);
    }
  }

  // Future<Result<String>> addOrders() async {
  //   try {
  //     // List<Map<String, Object>> listOrder = [
  //     //   {
  //     //     "id": "1",
  //     //     "name": "Gaun Pesta Custom",
  //     //     "description":
  //     //         "Gaun pesta dengan desain elegan sesuai keinginan Anda.",
  //     //     "imageUrl": [],
  //     //     "category": "Dress",
  //     //     "material": ["Satin", "Lace"],
  //     //     "sizes": ["S", "M", "L", "XL"],
  //     //     "colors": ["Merah", "Hitam", "Emas"],
  //     //     "sellerId": "S001",
  //     //     "location": "Jl. Sudirman No.45",
  //     //     "city": "Jakarta",
  //     //     "price": 1500000,
  //     //     "qty": 20,
  //     //     "sold": 5,
  //     //     "isArAvailable": false,
  //     //   },
  //     //   {
  //     //     "id": "2",
  //     //     "name": "Hoodie Custom",
  //     //     "description": "Hoodie nyaman dengan desain sesuai keinginan Anda.",
  //     //     "imageUrl": [],
  //     //     "category": "Hoodie",
  //     //     "material": ["Katun", "Polyester"],
  //     //     "sizes": ["M", "L", "XL"],
  //     //     "colors": ["Hitam", "Abu-abu", "Putih"],
  //     //     "sellerId": "S002",
  //     //     "location": "Jl. Malioboro No.12",
  //     //     "city": "Yogyakarta",
  //     //     "price": 300000,
  //     //     "qty": 50,
  //     //     "sold": 25,
  //     //     "isArAvailable": true,
  //     //   },
  //     //   {
  //     //     "id": "3",
  //     //     "name": "T-shirt Custom",
  //     //     "description":
  //     //         "T-shirt berkualitas dengan desain sesuai keinginan Anda.",
  //     //     "imageUrl": [],
  //     //     "category": "T-shirt",
  //     //     "material": ["Katun"],
  //     //     "sizes": ["S", "M", "L", "XL", "XXL"],
  //     //     "colors": ["Putih", "Hitam", "Biru"],
  //     //     "sellerId": "S003",
  //     //     "location": "Jl. Diponegoro No.7",
  //     //     "city": "Bandung",
  //     //     "price": 100000,
  //     //     "qty": 100,
  //     //     "sold": 60,
  //     //     "isArAvailable": true,
  //     //   },
  //     //   {
  //     //     "id": "4",
  //     //     "name": "Kemeja Custom",
  //     //     "description": "Kemeja formal dengan desain sesuai kebutuhan Anda.",
  //     //     "imageUrl": [],
  //     //     "category": "Kemeja",
  //     //     "material": ["Katun", "Poliester"],
  //     //     "sizes": ["M", "L", "XL"],
  //     //     "colors": ["Putih", "Biru", "Hitam"],
  //     //     "sellerId": "S004",
  //     //     "location": "Jl. Asia Afrika No.24",
  //     //     "city": "Bandung",
  //     //     "price": 200000,
  //     //     "qty": 30,
  //     //     "sold": 10,
  //     //     "isArAvailable": false,
  //     //   },
  //     //   {
  //     //     "id": "5",
  //     //     "name": "Jaket Bomber Custom",
  //     //     "description":
  //     //         "Jaket bomber stylish dengan desain sesuai selera Anda.",
  //     //     "imageUrl": [],
  //     //     "category": "Jaket",
  //     //     "material": ["Nilon", "Poliester"],
  //     //     "sizes": ["L", "XL"],
  //     //     "colors": ["Hitam", "Hijau Tua"],
  //     //     "sellerId": "S005",
  //     //     "location": "Jl. Pahlawan No.89",
  //     //     "city": "Surabaya",
  //     //     "price": 350000,
  //     //     "qty": 40,
  //     //     "sold": 15,
  //     //     "isArAvailable": true,
  //     //   },
  //     //   {
  //     //     "id": "6",
  //     //     "name": "Dress Batik Custom",
  //     //     "description":
  //     //         "Dress batik modern dengan desain sesuai permintaan Anda.",
  //     //     "imageUrl": [],
  //     //     "category": "Dress",
  //     //     "material": ["Katun Batik"],
  //     //     "sizes": ["S", "M", "L"],
  //     //     "colors": ["Biru", "Merah", "Coklat"],
  //     //     "sellerId": "S006",
  //     //     "location": "Jl. Solo No.5",
  //     //     "city": "Solo",
  //     //     "price": 500000,
  //     //     "qty": 25,
  //     //     "sold": 8,
  //     //     "isArAvailable": false,
  //     //   },
  //     //   {
  //     //     "id": "7",
  //     //     "name": "Kaos Polo Custom",
  //     //     "description": "Kaos polo casual dengan desain sesuai selera Anda.",
  //     //     "imageUrl": [],
  //     //     "category": "Polo",
  //     //     "material": ["Katun"],
  //     //     "sizes": ["M", "L", "XL"],
  //     //     "colors": ["Putih", "Hitam", "Merah"],
  //     //     "sellerId": "S007",
  //     //     "location": "Jl. Dipati Ukur No.10",
  //     //     "city": "Bandung",
  //     //     "price": 120000,
  //     //     "qty": 60,
  //     //     "sold": 30,
  //     //     "isArAvailable": true,
  //     //   },
  //     //   {
  //     //     "id": "8",
  //     //     "name": "Jas Custom",
  //     //     "description": "Jas formal dengan desain sesuai kebutuhan Anda.",
  //     //     "imageUrl": [],
  //     //     "category": "Jas",
  //     //     "material": ["Wol", "Poliester"],
  //     //     "sizes": ["M", "L", "XL"],
  //     //     "colors": ["Hitam", "Abu-abu"],
  //     //     "sellerId": "S008",
  //     //     "location": "Jl. Rasuna Said No.15",
  //     //     "city": "Jakarta",
  //     //     "price": 800000,
  //     //     "qty": 15,
  //     //     "sold": 3,
  //     //     "isArAvailable": false,
  //     //   },
  //     //   {
  //     //     "id": "9",
  //     //     "name": "Rok Panjang Custom",
  //     //     "description":
  //     //         "Rok panjang elegan dengan desain sesuai keinginan Anda.",
  //     //     "imageUrl": [],
  //     //     "category": "Rok",
  //     //     "material": ["Sifon", "Katun"],
  //     //     "sizes": ["S", "M", "L"],
  //     //     "colors": ["Merah", "Hitam", "Putih"],
  //     //     "sellerId": "S009",
  //     //     "location": "Jl. Merdeka No.20",
  //     //     "city": "Medan",
  //     //     "price": 200000,
  //     //     "qty": 35,
  //     //     "sold": 10,
  //     //     "isArAvailable": true,
  //     //   },
  //     //   {
  //     //     "id": "10",
  //     //     "name": "Celana Jogger Custom",
  //     //     "description":
  //     //         "Celana jogger nyaman dengan desain sesuai keinginan Anda.",
  //     //     "imageUrl": [],
  //     //     "category": "Celana",
  //     //     "material": ["Katun", "Poliester"],
  //     //     "sizes": ["M", "L", "XL"],
  //     //     "colors": ["Hitam", "Abu-abu"],
  //     //     "sellerId": "S010",
  //     //     "location": "Jl. Gajah Mada No.50",
  //     //     "city": "Jakarta",
  //     //     "price": 250000,
  //     //     "qty": 40,
  //     //     "sold": 20,
  //     //     "isArAvailable": true,
  //     //   },
  //     //   {
  //     //     "id": "11",
  //     //     "name": "Baju Kurung Custom",
  //     //     "description":
  //     //         "Baju kurung modern dengan desain sesuai kebutuhan Anda.",
  //     //     "imageUrl": [],
  //     //     "category": "Baju Kurung",
  //     //     "material": ["Katun", "Satin"],
  //     //     "sizes": ["S", "M", "L", "XL"],
  //     //     "colors": ["Hijau", "Merah", "Putih"],
  //     //     "sellerId": "S011",
  //     //     "location": "Jl. Thamrin No.35",
  //     //     "city": "Jakarta",
  //     //     "price": 300000,
  //     //     "qty": 25,
  //     //     "sold": 12,
  //     //     "isArAvailable": false,
  //     //   },
  //     //   {
  //     //     "id": "12",
  //     //     "name": "Kaftan Custom",
  //     //     "description": "Kaftan elegan dengan desain sesuai permintaan Anda.",
  //     //     "imageUrl": [],
  //     //     "category": "Kaftan",
  //     //     "material": ["Satin", "Chiffon"],
  //     //     "sizes": ["M", "L"],
  //     //     "colors": ["Emas", "Perak", "Hitam"],
  //     //     "sellerId": "S012",
  //     //     "location": "Jl. Pemuda No.17",
  //     //     "city": "Semarang",
  //     //     "price": 450000,
  //     //     "qty": 20,
  //     //     "sold": 8,
  //     //     "isArAvailable": true,
  //     //   },
  //     //   {
  //     //     "id": "13",
  //     //     "name": "Sweater Rajut Custom",
  //     //     "description":
  //     //         "Sweater rajut hangat dengan desain sesuai keinginan Anda.",
  //     //     "imageUrl": [],
  //     //     "category": "Sweater",
  //     //     "material": ["Wol", "Akrilik"],
  //     //     "sizes": ["M", "L", "XL"],
  //     //     "colors": ["Merah", "Hitam", "Coklat"],
  //     //     "sellerId": "S013",
  //     //     "location": "Jl. Veteran No.29",
  //     //     "city": "Surabaya",
  //     //     "price": 300000,
  //     //     "qty": 30,
  //     //     "sold": 15,
  //     //     "isArAvailable": false,
  //     //   },
  //     //   {
  //     //     "id": "14",
  //     //     "name": "Blazer Custom",
  //     //     "description": "Blazer stylish dengan desain sesuai kebutuhan Anda.",
  //     //     "imageUrl": [],
  //     //     "category": "Blazer",
  //     //     "material": ["Wol", "Poliester"],
  //     //     "sizes": ["M", "L", "XL"],
  //     //     "colors": ["Hitam", "Abu-abu", "Biru"],
  //     //     "sellerId": "S014",
  //     //     "location": "Jl. Soekarno Hatta No.5",
  //     //     "city": "Malang",
  //     //     "price": 500000,
  //     //     "qty": 20,
  //     //     "sold": 7,
  //     //     "isArAvailable": true,
  //     //   },
  //     //   {
  //     //     "id": "15",
  //     //     "name": "Kemeja Batik Custom",
  //     //     "description":
  //     //         "Kemeja batik dengan desain unik sesuai permintaan Anda.",
  //     //     "imageUrl": [],
  //     //     "category": "Kemeja",
  //     //     "material": ["Katun Batik"],
  //     //     "sizes": ["S", "M", "L"],
  //     //     "colors": ["Coklat", "Biru", "Merah"],
  //     //     "sellerId": "S015",
  //     //     "location": "Jl. Pattimura No.23",
  //     //     "city": "Bali",
  //     //     "price": 250000,
  //     //     "qty": 40,
  //     //     "sold": 20,
  //     //     "isArAvailable": false,
  //     //   },
  //     //   {
  //     //     "id": "16",
  //     //     "name": "Celana Kulot Custom",
  //     //     "description":
  //     //         "Celana kulot dengan desain modern sesuai keinginan Anda.",
  //     //     "imageUrl": [],
  //     //     "category": "Celana",
  //     //     "material": ["Katun", "Linen"],
  //     //     "sizes": ["M", "L", "XL"],
  //     //     "colors": ["Putih", "Hitam", "Abu-abu"],
  //     //     "sellerId": "S016",
  //     //     "location": "Jl. Merapi No.7",
  //     //     "city": "Makassar",
  //     //     "price": 150000,
  //     //     "qty": 35,
  //     //     "sold": 12,
  //     //     "isArAvailable": true,
  //     //   },
  //     //   {
  //     //     "id": "17",
  //     //     "name": "Jaket Denim Custom",
  //     //     "description":
  //     //         "Jaket denim stylish dengan desain sesuai permintaan Anda.",
  //     //     "imageUrl": [],
  //     //     "category": "Jaket",
  //     //     "material": ["Denim"],
  //     //     "sizes": ["M", "L", "XL"],
  //     //     "colors": ["Biru", "Hitam"],
  //     //     "sellerId": "S017",
  //     //     "location": "Jl. Kawi No.18",
  //     //     "city": "Malang",
  //     //     "price": 400000,
  //     //     "qty": 25,
  //     //     "sold": 10,
  //     //     "isArAvailable": true,
  //     //   },
  //     //   {
  //     //     "id": "18",
  //     //     "name": "Kebaya Custom",
  //     //     "description": "Kebaya elegan dengan desain sesuai kebutuhan Anda.",
  //     //     "imageUrl": [],
  //     //     "category": "Kebaya",
  //     //     "material": ["Satin", "Lace"],
  //     //     "sizes": ["S", "M", "L"],
  //     //     "colors": ["Merah", "Putih", "Hijau"],
  //     //     "sellerId": "S018",
  //     //     "location": "Jl. Merdeka No.10",
  //     //     "city": "Surabaya",
  //     //     "price": 700000,
  //     //     "qty": 15,
  //     //     "sold": 5,
  //     //     "isArAvailable": false,
  //     //   },
  //     //   {
  //     //     "id": "19",
  //     //     "name": "Jaket Parka Custom",
  //     //     "description": "Jaket parka nyaman dengan desain sesuai selera Anda.",
  //     //     "imageUrl": [],
  //     //     "category": "Jaket",
  //     //     "material": ["Katun", "Poliester"],
  //     //     "sizes": ["M", "L", "XL"],
  //     //     "colors": ["Hitam", "Hijau", "Abu-abu"],
  //     //     "sellerId": "S019",
  //     //     "location": "Jl. Diponegoro No.15",
  //     //     "city": "Bali",
  //     //     "price": 350000,
  //     //     "qty": 30,
  //     //     "sold": 12,
  //     //     "isArAvailable": true,
  //     //   },
  //     //   {
  //     //     "id": "20",
  //     //     "name": "Kaos Oversize Custom",
  //     //     "description":
  //     //         "Kaos oversize nyaman dengan desain sesuai keinginan Anda.",
  //     //     "imageUrl": [],
  //     //     "category": "T-shirt",
  //     //     "material": ["Katun"],
  //     //     "sizes": ["M", "L", "XL", "XXL"],
  //     //     "colors": ["Hitam", "Putih", "Abu-abu"],
  //     //     "sellerId": "S020",
  //     //     "location": "Jl. Ahmad Yani No.25",
  //     //     "city": "Semarang",
  //     //     "price": 120000,
  //     //     "qty": 50,
  //     //     "sold": 20,
  //     //     "isArAvailable": true,
  //     //   }
  //     // ];

  //     List<Map<String, Object>> users = [
  //       {
  //         "id": "U001",
  //         "email": "user001@example.com",
  //         "name": "Budi Santoso",
  //         "photoUrl": "https://picsum.photos/id/237/200/200"
  //       },
  //       {
  //         "id": "U002",
  //         "email": "user002@example.com",
  //         "name": "Dewi Sari",
  //         "photoUrl": "https://picsum.photos/id/238/200/200"
  //       },
  //       {
  //         "id": "U003",
  //         "email": "user003@example.com",
  //         "name": "Ahmad Hadi",
  //         "photoUrl": "https://picsum.photos/id/239/200/200"
  //       },
  //       {
  //         "id": "U004",
  //         "email": "user004@example.com",
  //         "name": "Siti Rahayu",
  //         "photoUrl": "https://picsum.photos/id/240/200/200"
  //       },
  //       {
  //         "id": "U005",
  //         "email": "user005@example.com",
  //         "name": "Joko Susilo",
  //         "photoUrl": "https://picsum.photos/id/241/200/200"
  //       },
  //       {
  //         "id": "U006",
  //         "email": "user006@example.com",
  //         "name": "Rini Wijaya",
  //         "photoUrl": "https://picsum.photos/id/242/200/200"
  //       },
  //       {
  //         "id": "U007",
  //         "email": "user007@example.com",
  //         "name": "Eko Prasetyo",
  //         "photoUrl": "https://picsum.photos/id/243/200/200"
  //       },
  //       {
  //         "id": "U008",
  //         "email": "user008@example.com",
  //         "name": "Anita Fitriani",
  //         "photoUrl": "https://picsum.photos/id/244/200/200"
  //       },
  //       {
  //         "id": "U009",
  //         "email": "user009@example.com",
  //         "name": "Rudi Hermawan",
  //         "photoUrl": "https://picsum.photos/id/245/200/200"
  //       },
  //       {
  //         "id": "U010",
  //         "email": "user010@example.com",
  //         "name": "Sinta Dewi",
  //         "photoUrl": "https://picsum.photos/id/246/200/200"
  //       },
  //       {
  //         "id": "U011",
  //         "email": "user011@example.com",
  //         "name": "Hadi Susanto",
  //         "photoUrl": "https://picsum.photos/id/247/200/200"
  //       },
  //       {
  //         "id": "U012",
  //         "email": "user012@example.com",
  //         "name": "Diana Putri",
  //         "photoUrl": "https://picsum.photos/id/248/200/200"
  //       },
  //       {
  //         "id": "U013",
  //         "email": "user013@example.com",
  //         "name": "Firman Setiawan",
  //         "photoUrl": "https://picsum.photos/id/249/200/200"
  //       },
  //       {
  //         "id": "U014",
  //         "email": "user014@example.com",
  //         "name": "Rina Amelia",
  //         "photoUrl": "https://picsum.photos/id/250/200/200"
  //       },
  //       {
  //         "id": "U015",
  //         "email": "user015@example.com",
  //         "name": "Hendra Wijaya",
  //         "photoUrl": "https://picsum.photos/id/251/200/200"
  //       },
  //       {
  //         "id": "U016",
  //         "email": "user016@example.com",
  //         "name": "Lia Nurul",
  //         "photoUrl": "https://picsum.photos/id/252/200/200"
  //       },
  //       {
  //         "id": "U017",
  //         "email": "user017@example.com",
  //         "name": "Agus Rahman",
  //         "photoUrl": "https://picsum.photos/id/253/200/200"
  //       },
  //       {
  //         "id": "U018",
  //         "email": "user018@example.com",
  //         "name": "Dewi Kartini",
  //         "photoUrl": "https://picsum.photos/id/254/200/200"
  //       },
  //       {
  //         "id": "U019",
  //         "email": "user019@example.com",
  //         "name": "Bambang Sutrisno",
  //         "photoUrl": "https://picsum.photos/id/255/200/200"
  //       },
  //       {
  //         "id": "U020",
  //         "email": "user020@example.com",
  //         "name": "Siska Putri",
  //         "photoUrl": "https://picsum.photos/id/256/200/200"
  //       }
  //     ];

  //     List<Map<String, Object>> listOrder = [
  //       {
  //         "id": "1",
  //         "name": "Gaun Pesta Custom Elegan",
  //         "description":
  //             "Gaun pesta yang dirancang khusus dengan sentuhan elegan untuk membuat Anda tampak memukau di setiap acara.",
  //         "imageUrl": [],
  //         "category": "Dress",
  //         "material": ["Satin", "Lace"],
  //         "sizes": ["S", "M", "L", "XL"],
  //         "colors": ["Merah", "Hitam", "Emas"],
  //         "sellerId": "S001",
  //         "location": "Jl. Sudirman No.45, Kav. 10, Kebayoran Baru",
  //         "city": "Jakarta",
  //         "price": 1500000,
  //         "qty": 20,
  //         "sold": 5,
  //         "isArAvailable": false,
  //       },
  //       {
  //         "id": "2",
  //         "name": "Hoodie Custom Keren",
  //         "description":
  //             "Hoodie nyaman dan stylish dengan desain sesuai keinginan Anda, cocok untuk aktivitas sehari-hari maupun olahraga.",
  //         "imageUrl": [],
  //         "category": "Hoodie",
  //         "material": ["Katun", "Polyester"],
  //         "sizes": ["M", "L", "XL"],
  //         "colors": ["Hitam", "Abu-abu", "Putih"],
  //         "sellerId": "S002",
  //         "location": "Jl. Malioboro No.12, Gedung B, Lantai 3",
  //         "city": "Yogyakarta",
  //         "price": 300000,
  //         "qty": 50,
  //         "sold": 25,
  //         "isArAvailable": true,
  //       },
  //       {
  //         "id": "3",
  //         "name": "T-shirt Custom Desain Unik",
  //         "description":
  //             "T-shirt berkualitas tinggi dengan desain yang dapat disesuaikan sesuai keinginan Anda, ideal untuk segala suasana.",
  //         "imageUrl": [],
  //         "category": "T-shirt",
  //         "material": ["Katun"],
  //         "sizes": ["S", "M", "L", "XL", "XXL"],
  //         "colors": ["Putih", "Hitam", "Biru"],
  //         "sellerId": "S003",
  //         "location": "Jl. Diponegoro No.7, Kompleks Ruko Diponegoro",
  //         "city": "Bandung",
  //         "price": 100000,
  //         "qty": 100,
  //         "sold": 60,
  //         "isArAvailable": true,
  //       },
  //       {
  //         "id": "4",
  //         "name": "Kemeja Formal Custom",
  //         "description":
  //             "Kemeja formal dengan desain yang dapat disesuaikan untuk menunjang penampilan profesional Anda di kantor.",
  //         "imageUrl": [],
  //         "category": "Kemeja",
  //         "material": ["Katun", "Poliester"],
  //         "sizes": ["M", "L", "XL"],
  //         "colors": ["Putih", "Biru", "Hitam"],
  //         "sellerId": "S004",
  //         "location": "Jl. Asia Afrika No.24, Gedung Asia Afrika Center",
  //         "city": "Bandung",
  //         "price": 200000,
  //         "qty": 30,
  //         "sold": 10,
  //         "isArAvailable": false,
  //       },
  //       {
  //         "id": "5",
  //         "name": "Jaket Bomber Custom Stylish",
  //         "description":
  //             "Jaket bomber dengan desain stylish dan bahan berkualitas, cocok untuk gaya kasual sehari-hari.",
  //         "imageUrl": [],
  //         "category": "Jaket",
  //         "material": ["Nilon", "Poliester"],
  //         "sizes": ["L", "XL"],
  //         "colors": ["Hitam", "Hijau Tua"],
  //         "sellerId": "S005",
  //         "location": "Jl. Pahlawan No.89, Blok B, Lantai 2",
  //         "city": "Surabaya",
  //         "price": 350000,
  //         "qty": 40,
  //         "sold": 15,
  //         "isArAvailable": true,
  //       },
  //       {
  //         "id": "6",
  //         "name": "Dress Batik Modern Custom",
  //         "description":
  //             "Dress batik modern dengan desain eksklusif sesuai permintaan Anda, sempurna untuk acara formal dan informal.",
  //         "imageUrl": [],
  //         "category": "Dress",
  //         "material": ["Katun Batik"],
  //         "sizes": ["S", "M", "L"],
  //         "colors": ["Biru", "Merah", "Coklat"],
  //         "sellerId": "S006",
  //         "location": "Jl. Solo No.5, Pasar Klewer, Lantai 1",
  //         "city": "Solo",
  //         "price": 500000,
  //         "qty": 25,
  //         "sold": 8,
  //         "isArAvailable": false,
  //       },
  //       {
  //         "id": "7",
  //         "name": "Kaos Polo Custom Casual",
  //         "description":
  //             "Kaos polo casual dengan desain yang dapat disesuaikan, terbuat dari bahan katun berkualitas tinggi untuk kenyamanan maksimal.",
  //         "imageUrl": [],
  //         "category": "Polo",
  //         "material": ["Katun"],
  //         "sizes": ["M", "L", "XL"],
  //         "colors": ["Putih", "Hitam", "Merah"],
  //         "sellerId": "S007",
  //         "location": "Jl. Dipati Ukur No.10, Kav. 3",
  //         "city": "Bandung",
  //         "price": 120000,
  //         "qty": 60,
  //         "sold": 30,
  //         "isArAvailable": true,
  //       },
  //       {
  //         "id": "8",
  //         "name": "Jas Formal Custom Eksklusif",
  //         "description":
  //             "Jas formal dengan desain eksklusif yang dapat disesuaikan untuk penampilan terbaik Anda di acara resmi.",
  //         "imageUrl": [],
  //         "category": "Jas",
  //         "material": ["Wol", "Poliester"],
  //         "sizes": ["M", "L", "XL"],
  //         "colors": ["Hitam", "Abu-abu"],
  //         "sellerId": "S008",
  //         "location": "Jl. Rasuna Said No.15, Menara Kuningan, Lantai 5",
  //         "city": "Jakarta",
  //         "price": 800000,
  //         "qty": 15,
  //         "sold": 3,
  //         "isArAvailable": false,
  //       },
  //       {
  //         "id": "9",
  //         "name": "Rok Panjang Custom Elegan",
  //         "description":
  //             "Rok panjang yang elegan dengan desain khusus untuk menambah pesona penampilan Anda di setiap kesempatan.",
  //         "imageUrl": [],
  //         "category": "Rok",
  //         "material": ["Sifon", "Katun"],
  //         "sizes": ["S", "M", "L"],
  //         "colors": ["Merah", "Hitam", "Putih"],
  //         "sellerId": "S009",
  //         "location": "Jl. Merdeka No.20, Gedung Plaza Merdeka",
  //         "city": "Medan",
  //         "price": 200000,
  //         "qty": 35,
  //         "sold": 10,
  //         "isArAvailable": true,
  //       },
  //       {
  //         "id": "10",
  //         "name": "Celana Jogger Custom Nyaman",
  //         "description":
  //             "Celana jogger dengan desain dan bahan yang nyaman, ideal untuk olahraga maupun kegiatan santai sehari-hari.",
  //         "imageUrl": [],
  //         "category": "Celana",
  //         "material": ["Katun", "Poliester"],
  //         "sizes": ["M", "L", "XL"],
  //         "colors": ["Hitam", "Abu-abu"],
  //         "sellerId": "S010",
  //         "location": "Jl. Gajah Mada No.50, Gedung Gajah Mada Plaza",
  //         "city": "Jakarta",
  //         "price": 250000,
  //         "qty": 40,
  //         "sold": 20,
  //         "isArAvailable": true,
  //       },
  //       {
  //         "id": "11",
  //         "name": "Baju Kurung Custom Modern",
  //         "description":
  //             "Baju kurung dengan desain modern dan bahan berkualitas tinggi, cocok untuk berbagai acara resmi.",
  //         "imageUrl": [],
  //         "category": "Baju Kurung",
  //         "material": ["Katun", "Satin"],
  //         "sizes": ["S", "M", "L", "XL"],
  //         "colors": ["Hijau", "Merah", "Putih"],
  //         "sellerId": "S011",
  //         "location": "Jl. Thamrin No.35, Plaza Indonesia, Lantai 3",
  //         "city": "Jakarta",
  //         "price": 300000,
  //         "qty": 25,
  //         "sold": 12,
  //         "isArAvailable": false,
  //       },
  //       {
  //         "id": "12",
  //         "name": "Kaftan Custom Elegan",
  //         "description":
  //             "Kaftan elegan dengan desain mewah yang dapat disesuaikan, sempurna untuk acara istimewa dan perayaan.",
  //         "imageUrl": [],
  //         "category": "Kaftan",
  //         "material": ["Satin", "Chiffon"],
  //         "sizes": ["M", "L"],
  //         "colors": ["Emas", "Perak", "Hitam"],
  //         "sellerId": "S012",
  //         "location": "Jl. Pemuda No.17, Mall Ciputra, Lantai 2",
  //         "city": "Semarang",
  //         "price": 450000,
  //         "qty": 20,
  //         "sold": 8,
  //         "isArAvailable": true,
  //       },
  //       {
  //         "id": "13",
  //         "name": "Sweater Rajut Custom Hangat",
  //         "description":
  //             "Sweater rajut yang hangat dan nyaman dengan desain yang dapat disesuaikan, cocok untuk cuaca dingin.",
  //         "imageUrl": [],
  //         "category": "Sweater",
  //         "material": ["Wol", "Akrilik"],
  //         "sizes": ["M", "L", "XL"],
  //         "colors": ["Merah", "Hitam", "Coklat"],
  //         "sellerId": "S013",
  //         "location": "Jl. Veteran No.29, Gedung Veteran Plaza",
  //         "city": "Surabaya",
  //         "price": 300000,
  //         "qty": 30,
  //         "sold": 15,
  //         "isArAvailable": false,
  //       },
  //       {
  //         "id": "14",
  //         "name": "Blazer Custom Stylish",
  //         "description":
  //             "Blazer stylish dengan desain eksklusif yang dapat disesuaikan untuk menunjang penampilan profesional dan elegan Anda.",
  //         "imageUrl": [],
  //         "category": "Blazer",
  //         "material": ["Wol", "Poliester"],
  //         "sizes": ["M", "L", "XL"],
  //         "colors": ["Hitam", "Abu-abu", "Biru"],
  //         "sellerId": "S014",
  //         "location": "Jl. Soekarno Hatta No.5, Gedung Hatta Plaza, Lantai 3",
  //         "city": "Malang",
  //         "price": 500000,
  //         "qty": 20,
  //         "sold": 7,
  //         "isArAvailable": true,
  //       },
  //       {
  //         "id": "15",
  //         "name": "Kemeja Batik Custom Unik",
  //         "description":
  //             "Kemeja batik dengan desain unik dan eksklusif yang dapat disesuaikan sesuai permintaan Anda, ideal untuk acara resmi maupun santai.",
  //         "imageUrl": [],
  //         "category": "Kemeja",
  //         "material": ["Katun Batik"],
  //         "sizes": ["S", "M", "L"],
  //         "colors": ["Coklat", "Biru", "Merah"],
  //         "sellerId": "S015",
  //         "location": "Jl. Pattimura No.23, Pasar Seni Ubud, Lantai 2",
  //         "city": "Bali",
  //         "price": 250000,
  //         "qty": 40,
  //         "sold": 20,
  //         "isArAvailable": false,
  //       },
  //       {
  //         "id": "16",
  //         "name": "Celana Kulot Custom Modern",
  //         "description":
  //             "Celana kulot dengan desain modern dan bahan berkualitas, ideal untuk penampilan kasual maupun formal.",
  //         "imageUrl": [],
  //         "category": "Celana",
  //         "material": ["Katun", "Linen"],
  //         "sizes": ["M", "L", "XL"],
  //         "colors": ["Putih", "Hitam", "Abu-abu"],
  //         "sellerId": "S016",
  //         "location": "Jl. Merapi No.7, Kompleks Perkantoran Merapi",
  //         "city": "Makassar",
  //         "price": 150000,
  //         "qty": 35,
  //         "sold": 12,
  //         "isArAvailable": true,
  //       },
  //       {
  //         "id": "17",
  //         "name": "Jaket Denim Custom Trendy",
  //         "description":
  //             "Jaket denim dengan desain trendy yang dapat disesuaikan sesuai keinginan Anda, cocok untuk gaya kasual sehari-hari.",
  //         "imageUrl": [],
  //         "category": "Jaket",
  //         "material": ["Denim"],
  //         "sizes": ["M", "L", "XL"],
  //         "colors": ["Biru", "Hitam"],
  //         "sellerId": "S017",
  //         "location": "Jl. Kawi No.18, Malang Town Square, Lantai 1",
  //         "city": "Malang",
  //         "price": 400000,
  //         "qty": 25,
  //         "sold": 10,
  //         "isArAvailable": true,
  //       },
  //       {
  //         "id": "18",
  //         "name": "Kebaya Custom Mewah",
  //         "description":
  //             "Kebaya elegan dan mewah dengan desain eksklusif yang dapat disesuaikan, cocok untuk acara pernikahan dan perayaan penting lainnya.",
  //         "imageUrl": [],
  //         "category": "Kebaya",
  //         "material": ["Satin", "Lace"],
  //         "sizes": ["S", "M", "L"],
  //         "colors": ["Merah", "Putih", "Hijau"],
  //         "sellerId": "S018",
  //         "location": "Jl. Merdeka No.10, Surabaya City Center, Lantai 2",
  //         "city": "Surabaya",
  //         "price": 700000,
  //         "qty": 15,
  //         "sold": 5,
  //         "isArAvailable": false,
  //       },
  //       {
  //         "id": "19",
  //         "name": "Jaket Parka Custom Nyaman",
  //         "description":
  //             "Jaket parka dengan desain yang dapat disesuaikan dan bahan berkualitas tinggi, ideal untuk menjaga kehangatan di musim hujan.",
  //         "imageUrl": [],
  //         "category": "Jaket",
  //         "material": ["Katun", "Poliester"],
  //         "sizes": ["M", "L", "XL"],
  //         "colors": ["Hitam", "Hijau", "Abu-abu"],
  //         "sellerId": "S019",
  //         "location": "Jl. Diponegoro No.15, Pasar Seni Sukawati, Lantai 3",
  //         "city": "Bali",
  //         "price": 350000,
  //         "qty": 30,
  //         "sold": 12,
  //         "isArAvailable": true,
  //       },
  //       {
  //         "id": "20",
  //         "name": "Kaos Oversize Custom Nyaman",
  //         "description":
  //             "Kaos oversize dengan desain yang dapat disesuaikan dan bahan katun berkualitas, cocok untuk gaya santai dan nyaman sehari-hari.",
  //         "imageUrl": [],
  //         "category": "T-shirt",
  //         "material": ["Katun"],
  //         "sizes": ["M", "L", "XL", "XXL"],
  //         "colors": ["Hitam", "Putih", "Abu-abu"],
  //         "sellerId": "S020",
  //         "location": "Jl. Ahmad Yani No.25, Simpang Lima Plaza, Lantai 2",
  //         "city": "Semarang",
  //         "price": 120000,
  //         "qty": 50,
  //         "sold": 20,
  //         "isArAvailable": true,
  //       }
  //     ];

  //     List<Order> orders = listOrder.map((e) => Order.fromJson(e)).toList();
  //     int idx = 0;
  //     for (var order in orders) {
  //       final ref = orderDb.doc();
  //       order = order.copyWith(
  //         id: ref.id,
  //         imageUrl: List.generate(
  //             idx++ % 6 + 1,
  //             (index) =>
  //                 'https://picsum.photos/id/${Random().nextInt(20)}/200/200'),
  //         rating:
  //             // random rating between 3.0 and 5.0
  //             (3.0 + (2.0 * idx / orders.length)).toDouble(),
  //         designer: User.fromJson(users[idx % users.length]),
  //       );
  //       await ref.set(order);
  //     }
  //     return const Result.success('Success');
  //   } catch (e) {
  //
  // Logger().e(e);
  // return Result.failure(
  //         NetworkExceptions.getFirebaseException(e), StackTrace.current);
  //   }
  // }
}

@Riverpod(keepAlive: true)
OrderRepository orderRepository(OrderRepositoryRef ref) {
  return OrderRepository();
}
