import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vems/bloc_models/base_state.dart';
import 'package:vems/bloc_models/faq_bloc/index.dart';
import 'package:vems/data_models/faq_datum.dart';
import 'dart:async';
import 'dart:developer' as developer;

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 22/4/21 at 9:03 PM
///

class FAQBloc extends Bloc<FAQEvent, BaseState> {
  static final FAQBloc _faqBlocSingleton = FAQBloc._internal();

  factory FAQBloc() {
    return _faqBlocSingleton;
  }

  FAQBloc._internal() : super(LoadingBaseState());

  List<FaqDatum> faqs = [];
  int faqSkip = 0;
  int faqLimit = 20;
  bool shouldLoadMore = true;

  @override
  Future<void> close() async {
    _faqBlocSingleton.close();
    await super.close();
  }

  @override
  Stream<BaseState> mapEventToState(
    FAQEvent event,
  ) async* {
    try {
      yield* event.applyAsync(currentState: state, bloc: this);
    } catch (_, stackTrace) {
      developer.log('$_', name: 'FAQBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}
