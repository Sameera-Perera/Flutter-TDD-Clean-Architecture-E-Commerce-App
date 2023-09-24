import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'order_fetch_state.dart';

class OrderFetchCubit extends Cubit<OrderFetchState> {
  OrderFetchCubit() : super(OrderFetchInitial());
}
