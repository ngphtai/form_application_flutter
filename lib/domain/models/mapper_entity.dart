
/// {@template mapper_entity}
/// [MapperEntity] is base for a number of other Domain model intended to
/// be converted into an Entity model.
/// This class have function convert from Domain model to Entity model
/// {@endtemplate}
abstract class MapperEntity<EntityModel> {
  /// {@macro mapper_entity}
  MapperEntity();

  /// Convert from Domain model to entity model.
  EntityModel toEntity();
}