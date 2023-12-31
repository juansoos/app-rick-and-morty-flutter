// Mocks generated by Mockito 5.4.2 from annotations
// in app_rick_and_morty_flutter/test/utils/mocks/mocks.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:app_rick_and_morty_flutter/src/api/http_client.dart' as _i3;
import 'package:app_rick_and_morty_flutter/src/api/model/character_response.dart'
    as _i6;
import 'package:app_rick_and_morty_flutter/src/api/repository/character_repository.dart'
    as _i5;
import 'package:http/http.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeResponse_0 extends _i1.SmartFake implements _i2.Response {
  _FakeResponse_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [HttpClient].
///
/// See the documentation for Mockito's code generation for more information.
class MockHttpClient extends _i1.Mock implements _i3.HttpClient {
  MockHttpClient() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Response> get(String? path) => (super.noSuchMethod(
        Invocation.method(
          #get,
          [path],
        ),
        returnValue: _i4.Future<_i2.Response>.value(_FakeResponse_0(
          this,
          Invocation.method(
            #get,
            [path],
          ),
        )),
      ) as _i4.Future<_i2.Response>);
  @override
  _i4.Future<_i2.Response> post(
    String? path, {
    Object? body,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #post,
          [path],
          {#body: body},
        ),
        returnValue: _i4.Future<_i2.Response>.value(_FakeResponse_0(
          this,
          Invocation.method(
            #post,
            [path],
            {#body: body},
          ),
        )),
      ) as _i4.Future<_i2.Response>);
}

/// A class which mocks [CharacterRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockCharacterRepository extends _i1.Mock
    implements _i5.CharacterRepository {
  MockCharacterRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i6.CharacterResponse?> getCharacters({int? page = 1}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getCharacters,
          [],
          {#page: page},
        ),
        returnValue: _i4.Future<_i6.CharacterResponse?>.value(),
      ) as _i4.Future<_i6.CharacterResponse?>);
}
