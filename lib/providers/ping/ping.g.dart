// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ping.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$pingHash() => r'8c958e10743d2d99b139b3c71c396b2bc260241b';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$Ping extends BuildlessAutoDisposeAsyncNotifier<String> {
  late final String url;

  FutureOr<String> build({
    required String url,
  });
}

/// See also [Ping].
@ProviderFor(Ping)
const pingProvider = PingFamily();

/// See also [Ping].
class PingFamily extends Family<AsyncValue<String>> {
  /// See also [Ping].
  const PingFamily();

  /// See also [Ping].
  PingProvider call({
    required String url,
  }) {
    return PingProvider(
      url: url,
    );
  }

  @override
  PingProvider getProviderOverride(
    covariant PingProvider provider,
  ) {
    return call(
      url: provider.url,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'pingProvider';
}

/// See also [Ping].
class PingProvider extends AutoDisposeAsyncNotifierProviderImpl<Ping, String> {
  /// See also [Ping].
  PingProvider({
    required String url,
  }) : this._internal(
          () => Ping()..url = url,
          from: pingProvider,
          name: r'pingProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product') ? null : _$pingHash,
          dependencies: PingFamily._dependencies,
          allTransitiveDependencies: PingFamily._allTransitiveDependencies,
          url: url,
        );

  PingProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.url,
  }) : super.internal();

  final String url;

  @override
  FutureOr<String> runNotifierBuild(
    covariant Ping notifier,
  ) {
    return notifier.build(
      url: url,
    );
  }

  @override
  Override overrideWith(Ping Function() create) {
    return ProviderOverride(
      origin: this,
      override: PingProvider._internal(
        () => create()..url = url,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        url: url,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<Ping, String> createElement() {
    return _PingProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PingProvider && other.url == url;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, url.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin PingRef on AutoDisposeAsyncNotifierProviderRef<String> {
  /// The parameter `url` of this provider.
  String get url;
}

class _PingProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<Ping, String> with PingRef {
  _PingProviderElement(super.provider);

  @override
  String get url => (origin as PingProvider).url;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
