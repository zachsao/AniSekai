
import 'package:json_annotation/json_annotation.dart';
part 'save_medialist_entry_model.g.dart';

@JsonSerializable()
class SaveMediaListEntryModel {
  @JsonKey(name: "SaveMediaListEntry")
  final SaveMediaListEntry entry;

  SaveMediaListEntryModel(this.entry);

  factory SaveMediaListEntryModel.fromJson(Map<String, dynamic> json) => _$SaveMediaListEntryModelFromJson(json);
}

@JsonSerializable()
class SaveMediaListEntry {
  final String status;

  SaveMediaListEntry(this.status);

  factory SaveMediaListEntry.fromJson(Map<String, dynamic> json) => _$SaveMediaListEntryFromJson(json);

  String? viewingStatus() {
    switch (status) {
      case "CURRENT":
        return "Watching";
      case "PLANNING":
        return "Planning";
      case "COMPLETED":
        return "Completed";
    }
  }
}