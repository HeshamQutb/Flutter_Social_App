// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shop_app/shared/components/constants.dart';
// import 'package:shop_app/shared/cubit/search/states.dart';
// import 'package:shop_app/shared/network/remote/dio_helper.dart';
//
// import '../../../models/search_model.dart';
// import '../../network/end_points.dart';
//
// class SearchCubit extends Cubit<SearchStates> {
//   SearchCubit() : super(SearchInitState());
//   static SearchCubit get(context) => BlocProvider.of(context);
//
//   SearchModel? model;
//   void search(String text) {
//     emit(SearchLoadingState());
//     DioHelper.postData(
//         url: SEARCH,
//         token: token,
//         data: {'text': text}
//     ).then((value)
//     {
//       model = SearchModel.fromJson(value?.data);
//       emit(SearchSuccessState());
//     }).catchError((error)
//     {
//       emit(SearchErrorState());
//     });
//   }
// }
