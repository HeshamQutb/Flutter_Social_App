

abstract class FeedsStates {}


class FeedsInitialStateState extends FeedsStates{}

class FeedsLoadingState extends FeedsStates{}

class FeedsSuccessState extends FeedsStates{

}

class FeedsErrorState extends FeedsStates{
  final String error;

  FeedsErrorState(this.error);
}

