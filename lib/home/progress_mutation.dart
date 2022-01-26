String entryUpdateMutation = '''
  mutation saveProgress(\$entryId: Int, \$progress: Int){
    SaveMediaListEntry(id: \$entryId, progress: \$progress) {
      id
    }
  }
''';
