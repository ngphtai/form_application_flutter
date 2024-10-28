
/// {@template mapper_domain}
/// [MapperDomain] is base for all DTOs model and entities model
/// This class have function convert from DTOs model and entities
/// to domain model
/// {@endtemplate}
abstract class MapperDomain<DomainModel> {
  /// {@macro mapper_domain}
  MapperDomain();

  /// Convert from DTOs model and entities model to domain model
  DomainModel toDomain();
}