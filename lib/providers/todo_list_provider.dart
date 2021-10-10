import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase/supabase.dart';
import 'package:utility_manager_flutter/widgets/todo_list_service.dart';

final todoListProvider = FutureProvider.autoDispose<PostgrestResponse>(
  (_) => TodoListService().getUserTodos(),
);
