// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Task extends Equatable {
  final String title;
  final String id;
  final DateTime? dateTime;

  bool? isDone;
  bool? isDelete;

  Task({
    required this.title,
    required this.id,
    this.isDone,
    this.isDelete,
    this.dateTime,
  }) {
    isDone = isDone ?? false;
    isDelete = isDelete ?? false;
  }

  Task copyWith({
    String? title,
    String? id,
    bool? isDone,
    bool? isDelete,
    DateTime? dateTime,
  }) {
    return Task(
      title: title ?? this.title,
      id: id ?? this.id,
      isDone: isDone ?? this.isDone,
      isDelete: isDelete ?? this.isDelete,
      dateTime: dateTime ?? this.dateTime,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'id': id,
      'isDone': isDone,
      'isDelete': isDelete,
      'dateTime': dateTime?.toIso8601String(),
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      title: map['title'] as String,
      id: map['id'] as String,
      isDone: map['isDone'] != null ? map['isDone'] as bool : null,
      isDelete: map['isDelete'] != null ? map['isDelete'] as bool : null,
      dateTime: map['dateTime'] != null
          ? DateTime.parse(map['dateTime'] as String)
          : null,
    );
  }

  @override
  List<Object?> get props => [
        title,
        id,
        isDone,
        isDelete,
      ];
}
