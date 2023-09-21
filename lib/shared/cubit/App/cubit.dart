import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/shared/cubit/App/states.dart';



class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitState());
  static AppCubit get(context) => BlocProvider.of(context);





}
