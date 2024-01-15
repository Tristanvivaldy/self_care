abstract interface class Usecase<T, P> {
  Future<T> call(P params);
}
