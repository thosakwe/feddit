// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite.dart';

// **************************************************************************
// MigrationGenerator
// **************************************************************************

class FavoriteMigration extends Migration {
  @override
  up(Schema schema) {
    schema.create('favorites', (table) {
      table.serial('id')..primaryKey();
      table.integer('user_id');
      table.timeStamp('created_at');
      table.timeStamp('updated_at');
    });
  }

  @override
  down(Schema schema) {
    schema.drop('favorites');
  }
}

// **************************************************************************
// OrmGenerator
// **************************************************************************

class FavoriteQuery extends Query<Favorite, FavoriteQueryWhere> {
  FavoriteQuery({Set<String> trampoline}) {
    trampoline ??= Set();
    trampoline.add(tableName);
    _where = FavoriteQueryWhere(this);
  }

  @override
  final FavoriteQueryValues values = FavoriteQueryValues();

  FavoriteQueryWhere _where;

  @override
  get casts {
    return {};
  }

  @override
  get tableName {
    return 'favorites';
  }

  @override
  get fields {
    return const ['id', 'user_id', 'created_at', 'updated_at'];
  }

  @override
  FavoriteQueryWhere get where {
    return _where;
  }

  @override
  FavoriteQueryWhere newWhereClause() {
    return FavoriteQueryWhere(this);
  }

  static Favorite parseRow(List row) {
    if (row.every((x) => x == null)) return null;
    var model = Favorite(
        id: row[0].toString(),
        userId: (row[1] as int),
        createdAt: (row[2] as DateTime),
        updatedAt: (row[3] as DateTime));
    return model;
  }

  @override
  deserialize(List row) {
    return parseRow(row);
  }
}

class FavoriteQueryWhere extends QueryWhere {
  FavoriteQueryWhere(FavoriteQuery query)
      : id = NumericSqlExpressionBuilder<int>(query, 'id'),
        userId = NumericSqlExpressionBuilder<int>(query, 'user_id'),
        createdAt = DateTimeSqlExpressionBuilder(query, 'created_at'),
        updatedAt = DateTimeSqlExpressionBuilder(query, 'updated_at');

  final NumericSqlExpressionBuilder<int> id;

  final NumericSqlExpressionBuilder<int> userId;

  final DateTimeSqlExpressionBuilder createdAt;

  final DateTimeSqlExpressionBuilder updatedAt;

  @override
  get expressionBuilders {
    return [id, userId, createdAt, updatedAt];
  }
}

class FavoriteQueryValues extends MapQueryValues {
  @override
  get casts {
    return {};
  }

  int get id {
    return (values['id'] as int);
  }

  set id(int value) => values['id'] = value;
  int get userId {
    return (values['user_id'] as int);
  }

  set userId(int value) => values['user_id'] = value;
  DateTime get createdAt {
    return (values['created_at'] as DateTime);
  }

  set createdAt(DateTime value) => values['created_at'] = value;
  DateTime get updatedAt {
    return (values['updated_at'] as DateTime);
  }

  set updatedAt(DateTime value) => values['updated_at'] = value;
  void copyFrom(Favorite model) {
    userId = model.userId;
    createdAt = model.createdAt;
    updatedAt = model.updatedAt;
  }
}

// **************************************************************************
// JsonModelGenerator
// **************************************************************************

@generatedSerializable
class Favorite extends _Favorite {
  Favorite({this.id, this.userId, this.createdAt, this.updatedAt});

  @override
  final String id;

  @override
  final int userId;

  @override
  final DateTime createdAt;

  @override
  final DateTime updatedAt;

  Favorite copyWith(
      {String id, int userId, DateTime createdAt, DateTime updatedAt}) {
    return new Favorite(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt);
  }

  bool operator ==(other) {
    return other is _Favorite &&
        other.id == id &&
        other.userId == userId &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return hashObjects([id, userId, createdAt, updatedAt]);
  }

  Map<String, dynamic> toJson() {
    return FavoriteSerializer.toMap(this);
  }
}

// **************************************************************************
// SerializerGenerator
// **************************************************************************

abstract class FavoriteSerializer {
  static Favorite fromMap(Map map) {
    return new Favorite(
        id: map['id'] as String,
        userId: map['user_id'] as int,
        createdAt: map['created_at'] != null
            ? (map['created_at'] is DateTime
                ? (map['created_at'] as DateTime)
                : DateTime.parse(map['created_at'].toString()))
            : null,
        updatedAt: map['updated_at'] != null
            ? (map['updated_at'] is DateTime
                ? (map['updated_at'] as DateTime)
                : DateTime.parse(map['updated_at'].toString()))
            : null);
  }

  static Map<String, dynamic> toMap(_Favorite model) {
    if (model == null) {
      return null;
    }
    return {
      'id': model.id,
      'user_id': model.userId,
      'created_at': model.createdAt?.toIso8601String(),
      'updated_at': model.updatedAt?.toIso8601String()
    };
  }
}

abstract class FavoriteFields {
  static const List<String> allFields = <String>[
    id,
    userId,
    createdAt,
    updatedAt
  ];

  static const String id = 'id';

  static const String userId = 'user_id';

  static const String createdAt = 'created_at';

  static const String updatedAt = 'updated_at';
}
