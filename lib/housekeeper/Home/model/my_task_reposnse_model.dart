
class MyTask {
    TaskSummary? taskSummary;
    List<TaskDatum>? taskData;

    MyTask({
        this.taskSummary,
        this.taskData,
    });

    factory MyTask.fromJson(Map<String, dynamic> json) => MyTask(
        taskSummary: json["task_summary"] == null ? null : TaskSummary.fromJson(json["task_summary"]),
        taskData: json["task_data"] == null ? [] : List<TaskDatum>.from(json["task_data"]!.map((x) => TaskDatum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "task_summary": taskSummary?.toJson(),
        "task_data": taskData == null ? [] : List<dynamic>.from(taskData!.map((x) => x.toJson())),
    };
}

class TaskDatum {
    int? id;
    String? name;
    String? description;
    DateTime? dueDate;
    String? type;
    List<String>? assignees;
    double? timeAllocated;
    List<Checklist> checklist=[];

    TaskDatum({
        this.id,
        this.name,
        this.description,
        this.dueDate,
        this.type,
        this.assignees,
        this.timeAllocated,
      required this.checklist,
    });

    factory TaskDatum.fromJson(Map<String, dynamic> json) => TaskDatum(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        dueDate: json["due_date"] == null ? null : DateTime.parse(json["due_date"]),
        type: json["type"],
        assignees: json["assignees"] == null ? [] : List<String>.from(json["assignees"]!.map((x) => x)),
        timeAllocated: json["time_allocated"],
        checklist: json["checklist"] == null ? [] : List<Checklist>.from(json["checklist"]!.map((x) => Checklist.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "due_date": dueDate,
        "type": type,
        "assignees": assignees == null ? [] : List<dynamic>.from(assignees!.map((x) => x)),
        "time_allocated": timeAllocated,
        "checklist":  List<dynamic>.from(checklist.map((x) => x.toJson())),
    };
}

class Checklist {
    String? type;
    List<Item>items=[];

    Checklist({
        this.type,
       required this.items,
    });

    factory Checklist.fromJson(Map<String, dynamic> json) => Checklist(
        type: json["type"],
        items: json["items"] == null ? [] : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
    };
}

class Item {
    String? name;
    bool? selected;

    Item({
        this.name,
        this.selected,
    });

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        name: json["name"],
        selected: json["selected"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "selected": selected,
    };
}

class TaskSummary {
    int? todoTasks;
    int? scheduledTasks;
    int? doneTasks;

    TaskSummary({
        this.todoTasks,
        this.scheduledTasks,
        this.doneTasks,
    });

    factory TaskSummary.fromJson(Map<String, dynamic> json) => TaskSummary(
        todoTasks: json["todo_tasks"],
        scheduledTasks: json["scheduled_tasks"],
        doneTasks: json["done_tasks"],
    );

    Map<String, dynamic> toJson() => {
        "todo_tasks": todoTasks,
        "scheduled_tasks": scheduledTasks,
        "done_tasks": doneTasks,
    };
}
