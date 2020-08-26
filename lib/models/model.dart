abstract class Model {}

abstract class JsonModel extends Model {
  Map<String, dynamic> toJson();
}
