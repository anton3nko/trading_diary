import 'package:bloc/bloc.dart';

class NavBarCubit extends Cubit<int> {
  NavBarCubit() : super(0);

  void setPageIndex(int index) {
    emit(index);
  }

  int get pageIndex => state;
}
