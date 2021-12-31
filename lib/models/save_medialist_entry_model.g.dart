// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_medialist_entry_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaveMediaListEntryModel _$SaveMediaListEntryModelFromJson(
        Map<String, dynamic> json) =>
    SaveMediaListEntryModel(
      SaveMediaListEntry.fromJson(
          json['SaveMediaListEntry'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SaveMediaListEntryModelToJson(
        SaveMediaListEntryModel instance) =>
    <String, dynamic>{
      'SaveMediaListEntry': instance.entry,
    };

SaveMediaListEntry _$SaveMediaListEntryFromJson(Map<String, dynamic> json) =>
    SaveMediaListEntry(
      json['status'] as String,
    );

Map<String, dynamic> _$SaveMediaListEntryToJson(SaveMediaListEntry instance) =>
    <String, dynamic>{
      'status': instance.status,
    };
