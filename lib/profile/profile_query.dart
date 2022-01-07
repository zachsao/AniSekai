String profileQuery = '''
query {
  Viewer {
    id
    name
    bannerImage
    about
    avatar {
      large
    }
  }
}
''';