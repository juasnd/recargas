class Usuario {
  const Usuario({
    required this.name,
    required this.membership,
  });

  final String name;
  final String membership;

  static const demo = Usuario(
    name: 'Fabián',
    membership: 'Cliente preferencial',
  );
}
