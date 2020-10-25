class User{
  final int id;
  final String name;
  final String imageUrl;
  final bool isOnline;

  User({
    this.id,
    this.name,
    this.imageUrl,
    this.isOnline,
  });
}
  final User currentUser = User(
    id: 0,
    name: 'Diego',
    imageUrl: 'imagens/diego.jpg',
    isOnline: true,
  );
  final User lorenzo = User(
    id: 1,
    name: 'lorenzo',
    imageUrl: 'imagens/lorenzo.jpg',
    isOnline: false,
  );
  final User joao = User(
    id: 2,
    name: 'joao',
    imageUrl: 'imagens/joao.jpg',
    isOnline: true,
  );
