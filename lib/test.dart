import 'package:hive/hive.dart';
part 'test.g.dart';

@HiveType(typeId: 0)
class itemlist extends HiveObject {
  @HiveField(0)
  List item_list;

  itemlist(
    this.item_list,
  );
}
