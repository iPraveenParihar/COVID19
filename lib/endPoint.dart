
class Post implements Comparable<Post> {

  final String location;
  final int confirmed;
  final int dead;
  final int recovered;
  final String updated;

  Post({this.location, this.confirmed, this.dead, this.recovered, this.updated});

  factory Post.fromJson(Map<String, dynamic> json)
  {
    return Post(
        location: json['location'].toString(),
        confirmed: json['confirmed'],
        dead: json['dead'] != null ? json['dead'] : 0,
        recovered: json['recovered'] != null ? json['recovered'] : 0,
        updated: json['updated'].toString()
    );
  }

  @override
  int compareTo(Post item) {
    return location.toLowerCase().compareTo(item.location.toLowerCase());
  }
}
