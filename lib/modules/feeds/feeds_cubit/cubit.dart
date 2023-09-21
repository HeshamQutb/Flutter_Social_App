// ignore_for_file: avoid_print

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/feeds/feeds_cubit/states.dart';



class FeedsCubit extends Cubit<FeedsStates>{
  FeedsCubit() : super(FeedsInitialStateState());

  static FeedsCubit get(context) => BlocProvider.of(context);





}