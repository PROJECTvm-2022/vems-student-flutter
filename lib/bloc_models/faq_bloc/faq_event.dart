import 'package:flutter/material.dart';
import 'package:vems/api_services/static_services.dart';
import 'package:vems/bloc_models/base_state.dart';
import 'package:vems/bloc_models/faq_bloc/index.dart';

///
/// Created by Auro (aurosmruti@smarttersstudio.com) on 22/4/21 at 9:03 PM
///

@immutable
abstract class FAQEvent {
  Stream<BaseState> applyAsync({BaseState currentState, FAQBloc bloc});
}

class LoadFAQs extends FAQEvent {
  @override
  String toString() => 'LoadFAQs';

  @override
  Stream<BaseState> applyAsync({BaseState currentState, FAQBloc bloc}) async* {
    try {
      bloc.faqSkip = 0;
      bloc.shouldLoadMore = true;
      bloc.faqs.clear();
      yield LoadingBaseState();
      final result = await getFAQs(skip: bloc.faqSkip, limit: bloc.faqLimit);

      if (result.isEmpty) {
        bloc.faqSkip = 0;
        bloc.shouldLoadMore = false;
        yield EmptyBaseState();
      } else {
        if (result.isEmpty || result.length < bloc.faqLimit) {
          bloc.shouldLoadMore = false;
        }
        bloc.faqs = result;
        yield FAQLoadedState();
      }
    } catch (_, st) {
      print(st);
      yield ErrorBaseState(_?.toString());
    }
  }
}

class LoadMoreFAQs extends FAQEvent {
  @override
  String toString() => 'LoadMoreFAQs';

  @override
  Stream<BaseState> applyAsync({BaseState currentState, FAQBloc bloc}) async* {
    try {
      if (bloc.shouldLoadMore) {
        bloc.faqSkip = bloc.faqs.length;

        final result = await getFAQs(skip: bloc.faqSkip, limit: bloc.faqLimit);

        if (result.isEmpty || result.length < bloc.faqLimit) {
          bloc.shouldLoadMore = false;
        }
        bloc.faqs += result;
        yield FAQLoadedState();
      } else {
        yield currentState;
      }
    } catch (_) {
      yield currentState;
    }
  }
}
