// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'season_works.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SeasonWorks {

 String get season; String get seasonText; List<Work> get works;
/// Create a copy of SeasonWorks
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SeasonWorksCopyWith<SeasonWorks> get copyWith => _$SeasonWorksCopyWithImpl<SeasonWorks>(this as SeasonWorks, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SeasonWorks&&(identical(other.season, season) || other.season == season)&&(identical(other.seasonText, seasonText) || other.seasonText == seasonText)&&const DeepCollectionEquality().equals(other.works, works));
}


@override
int get hashCode => Object.hash(runtimeType,season,seasonText,const DeepCollectionEquality().hash(works));

@override
String toString() {
  return 'SeasonWorks(season: $season, seasonText: $seasonText, works: $works)';
}


}

/// @nodoc
abstract mixin class $SeasonWorksCopyWith<$Res>  {
  factory $SeasonWorksCopyWith(SeasonWorks value, $Res Function(SeasonWorks) _then) = _$SeasonWorksCopyWithImpl;
@useResult
$Res call({
 String season, String seasonText, List<Work> works
});




}
/// @nodoc
class _$SeasonWorksCopyWithImpl<$Res>
    implements $SeasonWorksCopyWith<$Res> {
  _$SeasonWorksCopyWithImpl(this._self, this._then);

  final SeasonWorks _self;
  final $Res Function(SeasonWorks) _then;

/// Create a copy of SeasonWorks
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? season = null,Object? seasonText = null,Object? works = null,}) {
  return _then(_self.copyWith(
season: null == season ? _self.season : season // ignore: cast_nullable_to_non_nullable
as String,seasonText: null == seasonText ? _self.seasonText : seasonText // ignore: cast_nullable_to_non_nullable
as String,works: null == works ? _self.works : works // ignore: cast_nullable_to_non_nullable
as List<Work>,
  ));
}

}


/// Adds pattern-matching-related methods to [SeasonWorks].
extension SeasonWorksPatterns on SeasonWorks {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SeasonWorks value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SeasonWorks() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SeasonWorks value)  $default,){
final _that = this;
switch (_that) {
case _SeasonWorks():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SeasonWorks value)?  $default,){
final _that = this;
switch (_that) {
case _SeasonWorks() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String season,  String seasonText,  List<Work> works)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SeasonWorks() when $default != null:
return $default(_that.season,_that.seasonText,_that.works);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String season,  String seasonText,  List<Work> works)  $default,) {final _that = this;
switch (_that) {
case _SeasonWorks():
return $default(_that.season,_that.seasonText,_that.works);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String season,  String seasonText,  List<Work> works)?  $default,) {final _that = this;
switch (_that) {
case _SeasonWorks() when $default != null:
return $default(_that.season,_that.seasonText,_that.works);case _:
  return null;

}
}

}

/// @nodoc


class _SeasonWorks extends SeasonWorks {
  const _SeasonWorks({required this.season, required this.seasonText, required final  List<Work> works}): _works = works,super._();
  

@override final  String season;
@override final  String seasonText;
 final  List<Work> _works;
@override List<Work> get works {
  if (_works is EqualUnmodifiableListView) return _works;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_works);
}


/// Create a copy of SeasonWorks
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SeasonWorksCopyWith<_SeasonWorks> get copyWith => __$SeasonWorksCopyWithImpl<_SeasonWorks>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SeasonWorks&&(identical(other.season, season) || other.season == season)&&(identical(other.seasonText, seasonText) || other.seasonText == seasonText)&&const DeepCollectionEquality().equals(other._works, _works));
}


@override
int get hashCode => Object.hash(runtimeType,season,seasonText,const DeepCollectionEquality().hash(_works));

@override
String toString() {
  return 'SeasonWorks(season: $season, seasonText: $seasonText, works: $works)';
}


}

/// @nodoc
abstract mixin class _$SeasonWorksCopyWith<$Res> implements $SeasonWorksCopyWith<$Res> {
  factory _$SeasonWorksCopyWith(_SeasonWorks value, $Res Function(_SeasonWorks) _then) = __$SeasonWorksCopyWithImpl;
@override @useResult
$Res call({
 String season, String seasonText, List<Work> works
});




}
/// @nodoc
class __$SeasonWorksCopyWithImpl<$Res>
    implements _$SeasonWorksCopyWith<$Res> {
  __$SeasonWorksCopyWithImpl(this._self, this._then);

  final _SeasonWorks _self;
  final $Res Function(_SeasonWorks) _then;

/// Create a copy of SeasonWorks
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? season = null,Object? seasonText = null,Object? works = null,}) {
  return _then(_SeasonWorks(
season: null == season ? _self.season : season // ignore: cast_nullable_to_non_nullable
as String,seasonText: null == seasonText ? _self.seasonText : seasonText // ignore: cast_nullable_to_non_nullable
as String,works: null == works ? _self._works : works // ignore: cast_nullable_to_non_nullable
as List<Work>,
  ));
}


}

// dart format on
