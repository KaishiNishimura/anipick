// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'work.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Work {

 int get id; String get title; String get seasonName; String get seasonNameText; int get watchersCount; Uri? get imageUrl; Uri? get facebookOgImageUrl; Uri? get twitterImageUrl;
/// Create a copy of Work
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WorkCopyWith<Work> get copyWith => _$WorkCopyWithImpl<Work>(this as Work, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Work&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.seasonName, seasonName) || other.seasonName == seasonName)&&(identical(other.seasonNameText, seasonNameText) || other.seasonNameText == seasonNameText)&&(identical(other.watchersCount, watchersCount) || other.watchersCount == watchersCount)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.facebookOgImageUrl, facebookOgImageUrl) || other.facebookOgImageUrl == facebookOgImageUrl)&&(identical(other.twitterImageUrl, twitterImageUrl) || other.twitterImageUrl == twitterImageUrl));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,seasonName,seasonNameText,watchersCount,imageUrl,facebookOgImageUrl,twitterImageUrl);

@override
String toString() {
  return 'Work(id: $id, title: $title, seasonName: $seasonName, seasonNameText: $seasonNameText, watchersCount: $watchersCount, imageUrl: $imageUrl, facebookOgImageUrl: $facebookOgImageUrl, twitterImageUrl: $twitterImageUrl)';
}


}

/// @nodoc
abstract mixin class $WorkCopyWith<$Res>  {
  factory $WorkCopyWith(Work value, $Res Function(Work) _then) = _$WorkCopyWithImpl;
@useResult
$Res call({
 int id, String title, String seasonName, String seasonNameText, int watchersCount, Uri? imageUrl, Uri? facebookOgImageUrl, Uri? twitterImageUrl
});




}
/// @nodoc
class _$WorkCopyWithImpl<$Res>
    implements $WorkCopyWith<$Res> {
  _$WorkCopyWithImpl(this._self, this._then);

  final Work _self;
  final $Res Function(Work) _then;

/// Create a copy of Work
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? seasonName = null,Object? seasonNameText = null,Object? watchersCount = null,Object? imageUrl = freezed,Object? facebookOgImageUrl = freezed,Object? twitterImageUrl = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,seasonName: null == seasonName ? _self.seasonName : seasonName // ignore: cast_nullable_to_non_nullable
as String,seasonNameText: null == seasonNameText ? _self.seasonNameText : seasonNameText // ignore: cast_nullable_to_non_nullable
as String,watchersCount: null == watchersCount ? _self.watchersCount : watchersCount // ignore: cast_nullable_to_non_nullable
as int,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as Uri?,facebookOgImageUrl: freezed == facebookOgImageUrl ? _self.facebookOgImageUrl : facebookOgImageUrl // ignore: cast_nullable_to_non_nullable
as Uri?,twitterImageUrl: freezed == twitterImageUrl ? _self.twitterImageUrl : twitterImageUrl // ignore: cast_nullable_to_non_nullable
as Uri?,
  ));
}

}


/// Adds pattern-matching-related methods to [Work].
extension WorkPatterns on Work {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Work value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Work() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Work value)  $default,){
final _that = this;
switch (_that) {
case _Work():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Work value)?  $default,){
final _that = this;
switch (_that) {
case _Work() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String title,  String seasonName,  String seasonNameText,  int watchersCount,  Uri? imageUrl,  Uri? facebookOgImageUrl,  Uri? twitterImageUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Work() when $default != null:
return $default(_that.id,_that.title,_that.seasonName,_that.seasonNameText,_that.watchersCount,_that.imageUrl,_that.facebookOgImageUrl,_that.twitterImageUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String title,  String seasonName,  String seasonNameText,  int watchersCount,  Uri? imageUrl,  Uri? facebookOgImageUrl,  Uri? twitterImageUrl)  $default,) {final _that = this;
switch (_that) {
case _Work():
return $default(_that.id,_that.title,_that.seasonName,_that.seasonNameText,_that.watchersCount,_that.imageUrl,_that.facebookOgImageUrl,_that.twitterImageUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String title,  String seasonName,  String seasonNameText,  int watchersCount,  Uri? imageUrl,  Uri? facebookOgImageUrl,  Uri? twitterImageUrl)?  $default,) {final _that = this;
switch (_that) {
case _Work() when $default != null:
return $default(_that.id,_that.title,_that.seasonName,_that.seasonNameText,_that.watchersCount,_that.imageUrl,_that.facebookOgImageUrl,_that.twitterImageUrl);case _:
  return null;

}
}

}

/// @nodoc


class _Work extends Work {
  const _Work({required this.id, required this.title, required this.seasonName, required this.seasonNameText, required this.watchersCount, this.imageUrl, this.facebookOgImageUrl, this.twitterImageUrl}): super._();
  

@override final  int id;
@override final  String title;
@override final  String seasonName;
@override final  String seasonNameText;
@override final  int watchersCount;
@override final  Uri? imageUrl;
@override final  Uri? facebookOgImageUrl;
@override final  Uri? twitterImageUrl;

/// Create a copy of Work
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WorkCopyWith<_Work> get copyWith => __$WorkCopyWithImpl<_Work>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Work&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.seasonName, seasonName) || other.seasonName == seasonName)&&(identical(other.seasonNameText, seasonNameText) || other.seasonNameText == seasonNameText)&&(identical(other.watchersCount, watchersCount) || other.watchersCount == watchersCount)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.facebookOgImageUrl, facebookOgImageUrl) || other.facebookOgImageUrl == facebookOgImageUrl)&&(identical(other.twitterImageUrl, twitterImageUrl) || other.twitterImageUrl == twitterImageUrl));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,seasonName,seasonNameText,watchersCount,imageUrl,facebookOgImageUrl,twitterImageUrl);

@override
String toString() {
  return 'Work(id: $id, title: $title, seasonName: $seasonName, seasonNameText: $seasonNameText, watchersCount: $watchersCount, imageUrl: $imageUrl, facebookOgImageUrl: $facebookOgImageUrl, twitterImageUrl: $twitterImageUrl)';
}


}

/// @nodoc
abstract mixin class _$WorkCopyWith<$Res> implements $WorkCopyWith<$Res> {
  factory _$WorkCopyWith(_Work value, $Res Function(_Work) _then) = __$WorkCopyWithImpl;
@override @useResult
$Res call({
 int id, String title, String seasonName, String seasonNameText, int watchersCount, Uri? imageUrl, Uri? facebookOgImageUrl, Uri? twitterImageUrl
});




}
/// @nodoc
class __$WorkCopyWithImpl<$Res>
    implements _$WorkCopyWith<$Res> {
  __$WorkCopyWithImpl(this._self, this._then);

  final _Work _self;
  final $Res Function(_Work) _then;

/// Create a copy of Work
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? seasonName = null,Object? seasonNameText = null,Object? watchersCount = null,Object? imageUrl = freezed,Object? facebookOgImageUrl = freezed,Object? twitterImageUrl = freezed,}) {
  return _then(_Work(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,seasonName: null == seasonName ? _self.seasonName : seasonName // ignore: cast_nullable_to_non_nullable
as String,seasonNameText: null == seasonNameText ? _self.seasonNameText : seasonNameText // ignore: cast_nullable_to_non_nullable
as String,watchersCount: null == watchersCount ? _self.watchersCount : watchersCount // ignore: cast_nullable_to_non_nullable
as int,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as Uri?,facebookOgImageUrl: freezed == facebookOgImageUrl ? _self.facebookOgImageUrl : facebookOgImageUrl // ignore: cast_nullable_to_non_nullable
as Uri?,twitterImageUrl: freezed == twitterImageUrl ? _self.twitterImageUrl : twitterImageUrl // ignore: cast_nullable_to_non_nullable
as Uri?,
  ));
}


}

// dart format on
