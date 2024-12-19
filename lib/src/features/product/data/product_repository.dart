import 'package:chyess/src/features/auth/domain/user.dart';
import 'package:chyess/src/features/product/domain/product.dart';
import 'package:chyess/src/services/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_repository.g.dart';

class ProductRepository {
  final productDb =
      FirebaseFirestore.instance.collection('products').withConverter(
            fromFirestore: (snapshot, _) => Product.fromJson(snapshot.data()!),
            toFirestore: (Product product, _) => product.toJson(),
          );

  Future<Result<List<Product>>> getProducts() async {
    try {
      final resultProducts = await productDb.get();
      final products = resultProducts.docs.map((e) => e.data()).toList();
      // Logger().e(products.map((e) => e.id).toList());
      return Result.success(products);
    } catch (e) {
      Logger().e(e);
      return Result.failure(
          NetworkExceptions.getFirebaseException(e), StackTrace.current);
    }
  }

  Future<Result<Product>> getProduct(String id) async {
    try {
      final resultProduct = await productDb.doc(id).get();
      final product = resultProduct.data();
      return Result.success(product!);
    } catch (e) {
      Logger().e(e);
      return Result.failure(
          NetworkExceptions.getFirebaseException(e), StackTrace.current);
    }
  }

  Future<Result<String>> addProduct(Product product) async {
    try {
      final ref = productDb.doc();
      product = product.copyWith(id: ref.id);
      await ref.set(product);
      return const Result.success('Success');
    } catch (e) {
      Logger().e(e);
      return Result.failure(
          NetworkExceptions.getFirebaseException(e), StackTrace.current);
    }
  }

  Future<Result<String>> updateProduct(Map<String, String> product) async {
    try {
      await productDb.doc(product['id']).update(product);
      return const Result.success('Success');
    } catch (e) {
      Logger().e(e);
      return Result.failure(
          NetworkExceptions.getFirebaseException(e), StackTrace.current);
    }
  }

  Future<Result<String>> updateAllProductsByDesignerId(
      String designerId, Product data) async {
    try {
      final resultProducts = await productDb.get();
      final products = resultProducts.docs.map((e) => e.data()).toList();
      final productsByDesignerId =
          products.where((e) => e.designer?.id == designerId).toList();
      for (var product in productsByDesignerId) {
        Map<String, dynamic> datas = {
          'location': data.designer?.address,
          'city': data.designer?.city,
        };
        datas.addAll(data.toJson());
        await productDb.doc(product.id).update(datas);
      }
      return const Result.success('Success');
    } catch (e) {
      Logger().e(e);
      return Result.failure(
          NetworkExceptions.getFirebaseException(e), StackTrace.current);
    }
  }

  Future<Result<String>> addProducts() async {
    try {
      // List<Map<String, Object>> listProduct = [
      //   {
      //     "id": "1",
      //     "name": "Gaun Pesta Custom",
      //     "description":
      //         "Gaun pesta dengan desain elegan sesuai keinginan Anda.",
      //     "imageUrl": [],
      //     "category": "Dress",
      //     "material": ["Satin", "Lace"],
      //     "sizes": ["S", "M", "L", "XL"],
      //     "colors": ["Merah", "Hitam", "Emas"],
      //     "sellerId": "S001",
      //     "location": "Jl. Sudirman No.45",
      //     "city": "Jakarta",
      //     "price": 1500000,
      //     "qty": 20,
      //     "sold": 5,
      //     "isArAvailable": false,
      //   },
      //   {
      //     "id": "2",
      //     "name": "Hoodie Custom",
      //     "description": "Hoodie nyaman dengan desain sesuai keinginan Anda.",
      //     "imageUrl": [],
      //     "category": "Hoodie",
      //     "material": ["Katun", "Polyester"],
      //     "sizes": ["M", "L", "XL"],
      //     "colors": ["Hitam", "Abu-abu", "Putih"],
      //     "sellerId": "S002",
      //     "location": "Jl. Malioboro No.12",
      //     "city": "Yogyakarta",
      //     "price": 300000,
      //     "qty": 50,
      //     "sold": 25,
      //     "isArAvailable": true,
      //   },
      //   {
      //     "id": "3",
      //     "name": "T-shirt Custom",
      //     "description":
      //         "T-shirt berkualitas dengan desain sesuai keinginan Anda.",
      //     "imageUrl": [],
      //     "category": "T-shirt",
      //     "material": ["Katun"],
      //     "sizes": ["S", "M", "L", "XL", "XXL"],
      //     "colors": ["Putih", "Hitam", "Biru"],
      //     "sellerId": "S003",
      //     "location": "Jl. Diponegoro No.7",
      //     "city": "Bandung",
      //     "price": 100000,
      //     "qty": 100,
      //     "sold": 60,
      //     "isArAvailable": true,
      //   },
      //   {
      //     "id": "4",
      //     "name": "Kemeja Custom",
      //     "description": "Kemeja formal dengan desain sesuai kebutuhan Anda.",
      //     "imageUrl": [],
      //     "category": "Kemeja",
      //     "material": ["Katun", "Poliester"],
      //     "sizes": ["M", "L", "XL"],
      //     "colors": ["Putih", "Biru", "Hitam"],
      //     "sellerId": "S004",
      //     "location": "Jl. Asia Afrika No.24",
      //     "city": "Bandung",
      //     "price": 200000,
      //     "qty": 30,
      //     "sold": 10,
      //     "isArAvailable": false,
      //   },
      //   {
      //     "id": "5",
      //     "name": "Jaket Bomber Custom",
      //     "description":
      //         "Jaket bomber stylish dengan desain sesuai selera Anda.",
      //     "imageUrl": [],
      //     "category": "Jaket",
      //     "material": ["Nilon", "Poliester"],
      //     "sizes": ["L", "XL"],
      //     "colors": ["Hitam", "Hijau Tua"],
      //     "sellerId": "S005",
      //     "location": "Jl. Pahlawan No.89",
      //     "city": "Surabaya",
      //     "price": 350000,
      //     "qty": 40,
      //     "sold": 15,
      //     "isArAvailable": true,
      //   },
      //   {
      //     "id": "6",
      //     "name": "Dress Batik Custom",
      //     "description":
      //         "Dress batik modern dengan desain sesuai permintaan Anda.",
      //     "imageUrl": [],
      //     "category": "Dress",
      //     "material": ["Katun Batik"],
      //     "sizes": ["S", "M", "L"],
      //     "colors": ["Biru", "Merah", "Coklat"],
      //     "sellerId": "S006",
      //     "location": "Jl. Solo No.5",
      //     "city": "Solo",
      //     "price": 500000,
      //     "qty": 25,
      //     "sold": 8,
      //     "isArAvailable": false,
      //   },
      //   {
      //     "id": "7",
      //     "name": "Kaos Polo Custom",
      //     "description": "Kaos polo casual dengan desain sesuai selera Anda.",
      //     "imageUrl": [],
      //     "category": "Polo",
      //     "material": ["Katun"],
      //     "sizes": ["M", "L", "XL"],
      //     "colors": ["Putih", "Hitam", "Merah"],
      //     "sellerId": "S007",
      //     "location": "Jl. Dipati Ukur No.10",
      //     "city": "Bandung",
      //     "price": 120000,
      //     "qty": 60,
      //     "sold": 30,
      //     "isArAvailable": true,
      //   },
      //   {
      //     "id": "8",
      //     "name": "Jas Custom",
      //     "description": "Jas formal dengan desain sesuai kebutuhan Anda.",
      //     "imageUrl": [],
      //     "category": "Jas",
      //     "material": ["Wol", "Poliester"],
      //     "sizes": ["M", "L", "XL"],
      //     "colors": ["Hitam", "Abu-abu"],
      //     "sellerId": "S008",
      //     "location": "Jl. Rasuna Said No.15",
      //     "city": "Jakarta",
      //     "price": 800000,
      //     "qty": 15,
      //     "sold": 3,
      //     "isArAvailable": false,
      //   },
      //   {
      //     "id": "9",
      //     "name": "Rok Panjang Custom",
      //     "description":
      //         "Rok panjang elegan dengan desain sesuai keinginan Anda.",
      //     "imageUrl": [],
      //     "category": "Rok",
      //     "material": ["Sifon", "Katun"],
      //     "sizes": ["S", "M", "L"],
      //     "colors": ["Merah", "Hitam", "Putih"],
      //     "sellerId": "S009",
      //     "location": "Jl. Merdeka No.20",
      //     "city": "Medan",
      //     "price": 200000,
      //     "qty": 35,
      //     "sold": 10,
      //     "isArAvailable": true,
      //   },
      //   {
      //     "id": "10",
      //     "name": "Celana Jogger Custom",
      //     "description":
      //         "Celana jogger nyaman dengan desain sesuai keinginan Anda.",
      //     "imageUrl": [],
      //     "category": "Celana",
      //     "material": ["Katun", "Poliester"],
      //     "sizes": ["M", "L", "XL"],
      //     "colors": ["Hitam", "Abu-abu"],
      //     "sellerId": "S010",
      //     "location": "Jl. Gajah Mada No.50",
      //     "city": "Jakarta",
      //     "price": 250000,
      //     "qty": 40,
      //     "sold": 20,
      //     "isArAvailable": true,
      //   },
      //   {
      //     "id": "11",
      //     "name": "Baju Kurung Custom",
      //     "description":
      //         "Baju kurung modern dengan desain sesuai kebutuhan Anda.",
      //     "imageUrl": [],
      //     "category": "Baju Kurung",
      //     "material": ["Katun", "Satin"],
      //     "sizes": ["S", "M", "L", "XL"],
      //     "colors": ["Hijau", "Merah", "Putih"],
      //     "sellerId": "S011",
      //     "location": "Jl. Thamrin No.35",
      //     "city": "Jakarta",
      //     "price": 300000,
      //     "qty": 25,
      //     "sold": 12,
      //     "isArAvailable": false,
      //   },
      //   {
      //     "id": "12",
      //     "name": "Kaftan Custom",
      //     "description": "Kaftan elegan dengan desain sesuai permintaan Anda.",
      //     "imageUrl": [],
      //     "category": "Kaftan",
      //     "material": ["Satin", "Chiffon"],
      //     "sizes": ["M", "L"],
      //     "colors": ["Emas", "Perak", "Hitam"],
      //     "sellerId": "S012",
      //     "location": "Jl. Pemuda No.17",
      //     "city": "Semarang",
      //     "price": 450000,
      //     "qty": 20,
      //     "sold": 8,
      //     "isArAvailable": true,
      //   },
      //   {
      //     "id": "13",
      //     "name": "Sweater Rajut Custom",
      //     "description":
      //         "Sweater rajut hangat dengan desain sesuai keinginan Anda.",
      //     "imageUrl": [],
      //     "category": "Sweater",
      //     "material": ["Wol", "Akrilik"],
      //     "sizes": ["M", "L", "XL"],
      //     "colors": ["Merah", "Hitam", "Coklat"],
      //     "sellerId": "S013",
      //     "location": "Jl. Veteran No.29",
      //     "city": "Surabaya",
      //     "price": 300000,
      //     "qty": 30,
      //     "sold": 15,
      //     "isArAvailable": false,
      //   },
      //   {
      //     "id": "14",
      //     "name": "Blazer Custom",
      //     "description": "Blazer stylish dengan desain sesuai kebutuhan Anda.",
      //     "imageUrl": [],
      //     "category": "Blazer",
      //     "material": ["Wol", "Poliester"],
      //     "sizes": ["M", "L", "XL"],
      //     "colors": ["Hitam", "Abu-abu", "Biru"],
      //     "sellerId": "S014",
      //     "location": "Jl. Soekarno Hatta No.5",
      //     "city": "Malang",
      //     "price": 500000,
      //     "qty": 20,
      //     "sold": 7,
      //     "isArAvailable": true,
      //   },
      //   {
      //     "id": "15",
      //     "name": "Kemeja Batik Custom",
      //     "description":
      //         "Kemeja batik dengan desain unik sesuai permintaan Anda.",
      //     "imageUrl": [],
      //     "category": "Kemeja",
      //     "material": ["Katun Batik"],
      //     "sizes": ["S", "M", "L"],
      //     "colors": ["Coklat", "Biru", "Merah"],
      //     "sellerId": "S015",
      //     "location": "Jl. Pattimura No.23",
      //     "city": "Bali",
      //     "price": 250000,
      //     "qty": 40,
      //     "sold": 20,
      //     "isArAvailable": false,
      //   },
      //   {
      //     "id": "16",
      //     "name": "Celana Kulot Custom",
      //     "description":
      //         "Celana kulot dengan desain modern sesuai keinginan Anda.",
      //     "imageUrl": [],
      //     "category": "Celana",
      //     "material": ["Katun", "Linen"],
      //     "sizes": ["M", "L", "XL"],
      //     "colors": ["Putih", "Hitam", "Abu-abu"],
      //     "sellerId": "S016",
      //     "location": "Jl. Merapi No.7",
      //     "city": "Makassar",
      //     "price": 150000,
      //     "qty": 35,
      //     "sold": 12,
      //     "isArAvailable": true,
      //   },
      //   {
      //     "id": "17",
      //     "name": "Jaket Denim Custom",
      //     "description":
      //         "Jaket denim stylish dengan desain sesuai permintaan Anda.",
      //     "imageUrl": [],
      //     "category": "Jaket",
      //     "material": ["Denim"],
      //     "sizes": ["M", "L", "XL"],
      //     "colors": ["Biru", "Hitam"],
      //     "sellerId": "S017",
      //     "location": "Jl. Kawi No.18",
      //     "city": "Malang",
      //     "price": 400000,
      //     "qty": 25,
      //     "sold": 10,
      //     "isArAvailable": true,
      //   },
      //   {
      //     "id": "18",
      //     "name": "Kebaya Custom",
      //     "description": "Kebaya elegan dengan desain sesuai kebutuhan Anda.",
      //     "imageUrl": [],
      //     "category": "Kebaya",
      //     "material": ["Satin", "Lace"],
      //     "sizes": ["S", "M", "L"],
      //     "colors": ["Merah", "Putih", "Hijau"],
      //     "sellerId": "S018",
      //     "location": "Jl. Merdeka No.10",
      //     "city": "Surabaya",
      //     "price": 700000,
      //     "qty": 15,
      //     "sold": 5,
      //     "isArAvailable": false,
      //   },
      //   {
      //     "id": "19",
      //     "name": "Jaket Parka Custom",
      //     "description": "Jaket parka nyaman dengan desain sesuai selera Anda.",
      //     "imageUrl": [],
      //     "category": "Jaket",
      //     "material": ["Katun", "Poliester"],
      //     "sizes": ["M", "L", "XL"],
      //     "colors": ["Hitam", "Hijau", "Abu-abu"],
      //     "sellerId": "S019",
      //     "location": "Jl. Diponegoro No.15",
      //     "city": "Bali",
      //     "price": 350000,
      //     "qty": 30,
      //     "sold": 12,
      //     "isArAvailable": true,
      //   },
      //   {
      //     "id": "20",
      //     "name": "Kaos Oversize Custom",
      //     "description":
      //         "Kaos oversize nyaman dengan desain sesuai keinginan Anda.",
      //     "imageUrl": [],
      //     "category": "T-shirt",
      //     "material": ["Katun"],
      //     "sizes": ["M", "L", "XL", "XXL"],
      //     "colors": ["Hitam", "Putih", "Abu-abu"],
      //     "sellerId": "S020",
      //     "location": "Jl. Ahmad Yani No.25",
      //     "city": "Semarang",
      //     "price": 120000,
      //     "qty": 50,
      //     "sold": 20,
      //     "isArAvailable": true,
      //   }
      // ];
      // List<Map<String, Object>> listProduct = [
      //   {
      //     "id": "1",
      //     "name": "Gaun Pesta Custom Elegan",
      //     "description":
      //         "Gaun pesta yang dirancang khusus dengan sentuhan elegan untuk membuat Anda tampak memukau di setiap acara.",
      //     "imageUrl": [],
      //     "category": "Dress",
      //     "material": ["Satin", "Lace"],
      //     "sizes": ["S", "M", "L", "XL"],
      //     "colors": ["Merah", "Hitam", "Emas"],
      //     "sellerId": "S001",
      //     "location": "Jl. Sudirman No.45, Kav. 10, Kebayoran Baru",
      //     "city": "Jakarta",
      //     "price": 1500000,
      //     "qty": 20,
      //     "sold": 5,
      //     "isArAvailable": false,
      //   },
      //   {
      //     "id": "2",
      //     "name": "Hoodie Custom Keren",
      //     "description":
      //         "Hoodie nyaman dan stylish dengan desain sesuai keinginan Anda, cocok untuk aktivitas sehari-hari maupun olahraga.",
      //     "imageUrl": [],
      //     "category": "Hoodie",
      //     "material": ["Katun", "Polyester"],
      //     "sizes": ["M", "L", "XL"],
      //     "colors": ["Hitam", "Abu-abu", "Putih"],
      //     "sellerId": "S002",
      //     "location": "Jl. Malioboro No.12, Gedung B, Lantai 3",
      //     "city": "Yogyakarta",
      //     "price": 300000,
      //     "qty": 50,
      //     "sold": 25,
      //     "isArAvailable": true,
      //   },
      //   {
      //     "id": "3",
      //     "name": "T-shirt Custom Desain Unik",
      //     "description":
      //         "T-shirt berkualitas tinggi dengan desain yang dapat disesuaikan sesuai keinginan Anda, ideal untuk segala suasana.",
      //     "imageUrl": [],
      //     "category": "T-shirt",
      //     "material": ["Katun"],
      //     "sizes": ["S", "M", "L", "XL", "XXL"],
      //     "colors": ["Putih", "Hitam", "Biru"],
      //     "sellerId": "S003",
      //     "location": "Jl. Diponegoro No.7, Kompleks Ruko Diponegoro",
      //     "city": "Bandung",
      //     "price": 100000,
      //     "qty": 100,
      //     "sold": 60,
      //     "isArAvailable": true,
      //   },
      //   {
      //     "id": "4",
      //     "name": "Kemeja Formal Custom",
      //     "description":
      //         "Kemeja formal dengan desain yang dapat disesuaikan untuk menunjang penampilan profesional Anda di kantor.",
      //     "imageUrl": [],
      //     "category": "Kemeja",
      //     "material": ["Katun", "Poliester"],
      //     "sizes": ["M", "L", "XL"],
      //     "colors": ["Putih", "Biru", "Hitam"],
      //     "sellerId": "S004",
      //     "location": "Jl. Asia Afrika No.24, Gedung Asia Afrika Center",
      //     "city": "Bandung",
      //     "price": 200000,
      //     "qty": 30,
      //     "sold": 10,
      //     "isArAvailable": false,
      //   },
      //   {
      //     "id": "5",
      //     "name": "Jaket Bomber Custom Stylish",
      //     "description":
      //         "Jaket bomber dengan desain stylish dan bahan berkualitas, cocok untuk gaya kasual sehari-hari.",
      //     "imageUrl": [],
      //     "category": "Jaket",
      //     "material": ["Nilon", "Poliester"],
      //     "sizes": ["L", "XL"],
      //     "colors": ["Hitam", "Hijau Tua"],
      //     "sellerId": "S005",
      //     "location": "Jl. Pahlawan No.89, Blok B, Lantai 2",
      //     "city": "Surabaya",
      //     "price": 350000,
      //     "qty": 40,
      //     "sold": 15,
      //     "isArAvailable": true,
      //   },
      //   {
      //     "id": "6",
      //     "name": "Dress Batik Modern Custom",
      //     "description":
      //         "Dress batik modern dengan desain eksklusif sesuai permintaan Anda, sempurna untuk acara formal dan informal.",
      //     "imageUrl": [],
      //     "category": "Dress",
      //     "material": ["Katun Batik"],
      //     "sizes": ["S", "M", "L"],
      //     "colors": ["Biru", "Merah", "Coklat"],
      //     "sellerId": "S006",
      //     "location": "Jl. Solo No.5, Pasar Klewer, Lantai 1",
      //     "city": "Solo",
      //     "price": 500000,
      //     "qty": 25,
      //     "sold": 8,
      //     "isArAvailable": false,
      //   },
      //   {
      //     "id": "7",
      //     "name": "Kaos Polo Custom Casual",
      //     "description":
      //         "Kaos polo casual dengan desain yang dapat disesuaikan, terbuat dari bahan katun berkualitas tinggi untuk kenyamanan maksimal.",
      //     "imageUrl": [],
      //     "category": "Polo",
      //     "material": ["Katun"],
      //     "sizes": ["M", "L", "XL"],
      //     "colors": ["Putih", "Hitam", "Merah"],
      //     "sellerId": "S007",
      //     "location": "Jl. Dipati Ukur No.10, Kav. 3",
      //     "city": "Bandung",
      //     "price": 120000,
      //     "qty": 60,
      //     "sold": 30,
      //     "isArAvailable": true,
      //   },
      //   {
      //     "id": "8",
      //     "name": "Jas Formal Custom Eksklusif",
      //     "description":
      //         "Jas formal dengan desain eksklusif yang dapat disesuaikan untuk penampilan terbaik Anda di acara resmi.",
      //     "imageUrl": [],
      //     "category": "Jas",
      //     "material": ["Wol", "Poliester"],
      //     "sizes": ["M", "L", "XL"],
      //     "colors": ["Hitam", "Abu-abu"],
      //     "sellerId": "S008",
      //     "location": "Jl. Rasuna Said No.15, Menara Kuningan, Lantai 5",
      //     "city": "Jakarta",
      //     "price": 800000,
      //     "qty": 15,
      //     "sold": 3,
      //     "isArAvailable": false,
      //   },
      //   {
      //     "id": "9",
      //     "name": "Rok Panjang Custom Elegan",
      //     "description":
      //         "Rok panjang yang elegan dengan desain khusus untuk menambah pesona penampilan Anda di setiap kesempatan.",
      //     "imageUrl": [],
      //     "category": "Rok",
      //     "material": ["Sifon", "Katun"],
      //     "sizes": ["S", "M", "L"],
      //     "colors": ["Merah", "Hitam", "Putih"],
      //     "sellerId": "S009",
      //     "location": "Jl. Merdeka No.20, Gedung Plaza Merdeka",
      //     "city": "Medan",
      //     "price": 200000,
      //     "qty": 35,
      //     "sold": 10,
      //     "isArAvailable": true,
      //   },
      //   {
      //     "id": "10",
      //     "name": "Celana Jogger Custom Nyaman",
      //     "description":
      //         "Celana jogger dengan desain dan bahan yang nyaman, ideal untuk olahraga maupun kegiatan santai sehari-hari.",
      //     "imageUrl": [],
      //     "category": "Celana",
      //     "material": ["Katun", "Poliester"],
      //     "sizes": ["M", "L", "XL"],
      //     "colors": ["Hitam", "Abu-abu"],
      //     "sellerId": "S010",
      //     "location": "Jl. Gajah Mada No.50, Gedung Gajah Mada Plaza",
      //     "city": "Jakarta",
      //     "price": 250000,
      //     "qty": 40,
      //     "sold": 20,
      //     "isArAvailable": true,
      //   },
      //   {
      //     "id": "11",
      //     "name": "Baju Kurung Custom Modern",
      //     "description":
      //         "Baju kurung dengan desain modern dan bahan berkualitas tinggi, cocok untuk berbagai acara resmi.",
      //     "imageUrl": [],
      //     "category": "Baju Kurung",
      //     "material": ["Katun", "Satin"],
      //     "sizes": ["S", "M", "L", "XL"],
      //     "colors": ["Hijau", "Merah", "Putih"],
      //     "sellerId": "S011",
      //     "location": "Jl. Thamrin No.35, Plaza Indonesia, Lantai 3",
      //     "city": "Jakarta",
      //     "price": 300000,
      //     "qty": 25,
      //     "sold": 12,
      //     "isArAvailable": false,
      //   },
      //   {
      //     "id": "12",
      //     "name": "Kaftan Custom Elegan",
      //     "description":
      //         "Kaftan elegan dengan desain mewah yang dapat disesuaikan, sempurna untuk acara istimewa dan perayaan.",
      //     "imageUrl": [],
      //     "category": "Kaftan",
      //     "material": ["Satin", "Chiffon"],
      //     "sizes": ["M", "L"],
      //     "colors": ["Emas", "Perak", "Hitam"],
      //     "sellerId": "S012",
      //     "location": "Jl. Pemuda No.17, Mall Ciputra, Lantai 2",
      //     "city": "Semarang",
      //     "price": 450000,
      //     "qty": 20,
      //     "sold": 8,
      //     "isArAvailable": true,
      //   },
      //   {
      //     "id": "13",
      //     "name": "Sweater Rajut Custom Hangat",
      //     "description":
      //         "Sweater rajut yang hangat dan nyaman dengan desain yang dapat disesuaikan, cocok untuk cuaca dingin.",
      //     "imageUrl": [],
      //     "category": "Sweater",
      //     "material": ["Wol", "Akrilik"],
      //     "sizes": ["M", "L", "XL"],
      //     "colors": ["Merah", "Hitam", "Coklat"],
      //     "sellerId": "S013",
      //     "location": "Jl. Veteran No.29, Gedung Veteran Plaza",
      //     "city": "Surabaya",
      //     "price": 300000,
      //     "qty": 30,
      //     "sold": 15,
      //     "isArAvailable": false,
      //   },
      //   {
      //     "id": "14",
      //     "name": "Blazer Custom Stylish",
      //     "description":
      //         "Blazer stylish dengan desain eksklusif yang dapat disesuaikan untuk menunjang penampilan profesional dan elegan Anda.",
      //     "imageUrl": [],
      //     "category": "Blazer",
      //     "material": ["Wol", "Poliester"],
      //     "sizes": ["M", "L", "XL"],
      //     "colors": ["Hitam", "Abu-abu", "Biru"],
      //     "sellerId": "S014",
      //     "location": "Jl. Soekarno Hatta No.5, Gedung Hatta Plaza, Lantai 3",
      //     "city": "Malang",
      //     "price": 500000,
      //     "qty": 20,
      //     "sold": 7,
      //     "isArAvailable": true,
      //   },
      //   {
      //     "id": "15",
      //     "name": "Kemeja Batik Custom Unik",
      //     "description":
      //         "Kemeja batik dengan desain unik dan eksklusif yang dapat disesuaikan sesuai permintaan Anda, ideal untuk acara resmi maupun santai.",
      //     "imageUrl": [],
      //     "category": "Kemeja",
      //     "material": ["Katun Batik"],
      //     "sizes": ["S", "M", "L"],
      //     "colors": ["Coklat", "Biru", "Merah"],
      //     "sellerId": "S015",
      //     "location": "Jl. Pattimura No.23, Pasar Seni Ubud, Lantai 2",
      //     "city": "Bali",
      //     "price": 250000,
      //     "qty": 40,
      //     "sold": 20,
      //     "isArAvailable": false,
      //   },
      //   {
      //     "id": "16",
      //     "name": "Celana Kulot Custom Modern",
      //     "description":
      //         "Celana kulot dengan desain modern dan bahan berkualitas, ideal untuk penampilan kasual maupun formal.",
      //     "imageUrl": [],
      //     "category": "Celana",
      //     "material": ["Katun", "Linen"],
      //     "sizes": ["M", "L", "XL"],
      //     "colors": ["Putih", "Hitam", "Abu-abu"],
      //     "sellerId": "S016",
      //     "location": "Jl. Merapi No.7, Kompleks Perkantoran Merapi",
      //     "city": "Makassar",
      //     "price": 150000,
      //     "qty": 35,
      //     "sold": 12,
      //     "isArAvailable": true,
      //   },
      //   {
      //     "id": "17",
      //     "name": "Jaket Denim Custom Trendy",
      //     "description":
      //         "Jaket denim dengan desain trendy yang dapat disesuaikan sesuai keinginan Anda, cocok untuk gaya kasual sehari-hari.",
      //     "imageUrl": [],
      //     "category": "Jaket",
      //     "material": ["Denim"],
      //     "sizes": ["M", "L", "XL"],
      //     "colors": ["Biru", "Hitam"],
      //     "sellerId": "S017",
      //     "location": "Jl. Kawi No.18, Malang Town Square, Lantai 1",
      //     "city": "Malang",
      //     "price": 400000,
      //     "qty": 25,
      //     "sold": 10,
      //     "isArAvailable": true,
      //   },
      //   {
      //     "id": "18",
      //     "name": "Kebaya Custom Mewah",
      //     "description":
      //         "Kebaya elegan dan mewah dengan desain eksklusif yang dapat disesuaikan, cocok untuk acara pernikahan dan perayaan penting lainnya.",
      //     "imageUrl": [],
      //     "category": "Kebaya",
      //     "material": ["Satin", "Lace"],
      //     "sizes": ["S", "M", "L"],
      //     "colors": ["Merah", "Putih", "Hijau"],
      //     "sellerId": "S018",
      //     "location": "Jl. Merdeka No.10, Surabaya City Center, Lantai 2",
      //     "city": "Surabaya",
      //     "price": 700000,
      //     "qty": 15,
      //     "sold": 5,
      //     "isArAvailable": false,
      //   },
      //   {
      //     "id": "19",
      //     "name": "Jaket Parka Custom Nyaman",
      //     "description":
      //         "Jaket parka dengan desain yang dapat disesuaikan dan bahan berkualitas tinggi, ideal untuk menjaga kehangatan di musim hujan.",
      //     "imageUrl": [],
      //     "category": "Jaket",
      //     "material": ["Katun", "Poliester"],
      //     "sizes": ["M", "L", "XL"],
      //     "colors": ["Hitam", "Hijau", "Abu-abu"],
      //     "sellerId": "S019",
      //     "location": "Jl. Diponegoro No.15, Pasar Seni Sukawati, Lantai 3",
      //     "city": "Bali",
      //     "price": 350000,
      //     "qty": 30,
      //     "sold": 12,
      //     "isArAvailable": true,
      //   },
      //   {
      //     "id": "20",
      //     "name": "Kaos Oversize Custom Nyaman",
      //     "description":
      //         "Kaos oversize dengan desain yang dapat disesuaikan dan bahan katun berkualitas, cocok untuk gaya santai dan nyaman sehari-hari.",
      //     "imageUrl": [],
      //     "category": "T-shirt",
      //     "material": ["Katun"],
      //     "sizes": ["M", "L", "XL", "XXL"],
      //     "colors": ["Hitam", "Putih", "Abu-abu"],
      //     "sellerId": "S020",
      //     "location": "Jl. Ahmad Yani No.25, Simpang Lima Plaza, Lantai 2",
      //     "city": "Semarang",
      //     "price": 120000,
      //     "qty": 50,
      //     "sold": 20,
      //     "isArAvailable": true,
      //   }
      // ];

      // List<Map<String, Object>> listProduct = [
      //   {
      //     "id": "1",
      //     "name": "Gaun Biru Elegan Custom",
      //     "description":
      //         "Gaun biru elegan yang dapat di-custom sesuai dengan keinginan Anda untuk tampil memukau di setiap acara.",
      //     "imageUrl": "",
      //     "category": "Dress",
      //     "material": "Satin,Lace",
      //     "sizes": "S,M,L,XL",
      //     "colors": "Biru",
      //     "sellerId": "C8tNzAhBtPbPtA9rexD28M22AFP2",
      //     "location": "Jl. Kemang Raya No.20",
      //     "city": "Bandung",
      //     "price": 2000000,
      //     "qty": 15,
      //     "sold": 3,
      //     "isArAvailable": false
      //   },
      //   {
      //     "id": "2",
      //     "name": "Jaket Kuning Hangat Custom",
      //     "description":
      //         "Jaket tebal kuning yang stylish dan nyaman, bisa di-custom sesuai dengan preferensi Anda untuk perlindungan maksimal di musim dingin.",
      //     "imageUrl": "",
      //     "category": "Jaket",
      //     "material": "Wool,Polyester",
      //     "sizes": "S,M,L,XL",
      //     "colors": "Kuning",
      //     "sellerId": "kqWR5quCoKOsRb1U80ft9EliKBw1",
      //     "location": "Jl. Braga No.15",
      //     "city": "Surabaya",
      //     "price": 3000000,
      //     "qty": 10,
      //     "sold": 4,
      //     "isArAvailable": false
      //   },
      //   {
      //     "id": "3",
      //     "name": "Kaos Putih Premium Custom",
      //     "description":
      //         "Kaos putih custom dengan bahan katun berkualitas tinggi, nyaman dipakai dan bisa didesain sesuai dengan keinginan Anda.",
      //     "imageUrl": "",
      //     "category": "Kaos",
      //     "material": "Katun",
      //     "sizes": "S,M,L,XL",
      //     "colors": "Putih",
      //     "sellerId": "C8tNzAhBtPbPtA9rexD28M22AFP2",
      //     "location": "Jl. Merdeka No.10",
      //     "city": "Medan",
      //     "price": 150000,
      //     "qty": 50,
      //     "sold": 20,
      //     "isArAvailable": false
      //   },
      //   {
      //     "id": "4",
      //     "name": "Jaket Kulit Premium Custom",
      //     "description":
      //         "Leather jacket custom yang trendy dan awet, sempurna untuk tampil gaya dengan sentuhan personal sesuai keinginan Anda.",
      //     "imageUrl": "",
      //     "category": "Jaket",
      //     "material": "Kulit",
      //     "sizes": "S,M,L,XL",
      //     "colors": "Hitam,Coklat",
      //     "sellerId": "kqWR5quCoKOsRb1U80ft9EliKBw1",
      //     "location": "Jl. Thamrin No.7",
      //     "city": "Yogyakarta",
      //     "price": 5000000,
      //     "qty": 5,
      //     "sold": 1,
      //     "isArAvailable": false
      //   },
      //   {
      //     "id": "5",
      //     "name": "Jersey Free Fire Ultimate Custom",
      //     "description":
      //         "Jersey Free Fire custom yang nyaman dan stylish, bisa di-custom sesuai dengan desain favorit Anda untuk tampil keren saat bermain game.",
      //     "imageUrl": "",
      //     "category": "Jersey",
      //     "material": "Polyester",
      //     "sizes": "S,M,L,XL",
      //     "colors": "Putih,Hitam",
      //     "sellerId": "C8tNzAhBtPbPtA9rexD28M22AFP2",
      //     "location": "Jl. Malioboro No.23",
      //     "city": "Bali",
      //     "price": 250000,
      //     "qty": 30,
      //     "sold": 10,
      //     "isArAvailable": false
      //   }
      // ];
      List<Map<String, Object>> listProduct = [];
      List<Map<String, Object>> designers = [
        {
          "id": "C8tNzAhBtPbPtA9rexD28M22AFP2",
          "name": "Emma August",
          "email": "emma@gmail.com",
          "phone": "8562444321",
          "description":
              "Saya berpengalamn dalam mendesain sebuah baju bertema kan korea dengan experience 3.5 tahun",
          "photoUrl":
              "https://firebasestorage.googleapis.com/v0/b/chyess-c7cad.appspot.com/o/users%2Fimages%2F1719461764447.jpg?alt=media&token=7923ac18-a097-45eb-a9e7-078d60e13a42",
          "address": "Jl. Kendaraan Dua Belas no 124A",
          "city": "Jakarta Utara",
          "role": "designer",
          "status": "",
          "isSuccessRegister": true,
        },
        {
          "id": "IQyN3tVEjrJmVDvntSDj",
          "name": "Ruth Viollet",
          "email": "ruth@gmail.com",
          "phone": "85621405448",
          "description":
              "Pengalaman desainer 5 tahun dan ahli dalam custom pakaian batik dan dress modern",
          "photoUrl":
              "https://firebasestorage.googleapis.com/v0/b/chyess-c7cad.appspot.com/o/custom%2Fimages%2F1719400126771.jpg?alt=media&token=68f17d68-2fc3-4621-90c3-c60f2dd3126c",
          "address": "Ciwastra Raya Regency 2 No 14",
          "city": "Jakarta Selatan",
          "role": "designer",
          "status": "",
          "isSuccessRegister": true,
        }
      ];
      List<Product> products =
          listProduct.map((e) => Product.fromJson(e)).toList();
      int idx = 0;
      for (var product in products) {
        final ref = productDb.doc();
        product = product.copyWith(
          id: ref.id,
          imageUrl: '',
          rating:
              // random rating between 3.0 and 5.0
              (3.0 + (2.0 * idx / products.length)).toDouble(),
          designer: User.fromJson(
            designers[idx % designers.length],
          ),
        );
        await ref.set(product);
      }
      return const Result.success('Success');
    } catch (e) {
      Logger().e(e);
      return Result.failure(
          NetworkExceptions.getFirebaseException(e), StackTrace.current);
    }
  }
}

@Riverpod(keepAlive: true)
ProductRepository productRepository(ProductRepositoryRef ref) {
  return ProductRepository();
}
