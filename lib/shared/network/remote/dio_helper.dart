// import 'package:dio/dio.dart';
//
// class DioHelper {
//
//   static Dio? dio;
//
//   static init() {
//     dio = Dio(
//         BaseOptions(
//             baseUrl: 'https://student.valuxapps.com/api/',
//             receiveDataWhenStatusError: true,
//         )
//     );
//   }
//
//
//
//   static Future<Response?> getData({
//     required String url,
//     dynamic query,
//     String lang = 'en',
//     String? token
//   }) async {
//     init(); // Initialize the Dio instance
//     dio?.options.headers = {
//       'Content-Type': 'application/json',
//       'lang': lang,
//       'Authorization': token
//     };
//     return await dio?.get(
//         url,
//         queryParameters: query
//     );
//   }
//
//
//
//   static Future<Response?> postData({
//     required String url,
//     dynamic query,
//     required dynamic data,
//     String lang = 'en',
//     String? token
//   }) async {
//     init(); // Initialize the Dio instance
//     dio?.options.headers = {
//       'Content-Type': 'application/json',
//       'lang': lang,
//       'Authorization': token
//     };
//     return await dio?.post(
//         url,
//         data: data
//     );
//   }
//
//
//   static Future<Response?> putData({
//     required String url,
//     dynamic query,
//     required dynamic data,
//     String lang = 'en',
//     String? token
//   }) async {
//     init(); // Initialize the Dio instance
//     dio?.options.headers = {
//       'Content-Type': 'application/json',
//       'lang': lang,
//       'Authorization': token
//     };
//     return await dio?.put(
//         url,
//         data: data
//     );
//   }
//
// }
