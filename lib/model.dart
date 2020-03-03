import 'dart:convert';

class LiveRoom {
  
  String roomId;

  String title;


  String liveUrl;

  String imageUrl;

  String label;

  String host;

  String viewCount;

  LiveRoom({
    this.roomId, 
    this.title, 
    this.liveUrl,
    this.imageUrl,
    this.label,
    this.host,
    this.viewCount, 
  });

  LiveRoom.fromJson(Map<String, dynamic> jsonData)
      : roomId = jsonData['roomId'],
        title = jsonData['title'],
        liveUrl = jsonData['liveUrl'],
        imageUrl = jsonData['imageUrl'],
        label = jsonData['label'],
        host = jsonData['host'],
        viewCount = jsonData['viewCount'];


  Map<String, dynamic> toJson() => {
        'roomId': roomId,
        'title': title,
        'liveUrl': liveUrl,
        'imageUrl' : imageUrl,
        'label' : label,
        'host': host,
        'viewCount': viewCount,
      };

  @override
  String toString() {
    return jsonEncode(this);
  }

}