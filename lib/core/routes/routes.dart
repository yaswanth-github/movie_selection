import 'package:flutter/cupertino.dart';
import 'package:movie_selection/core/models/project_model.dart';
import 'package:movie_selection/core/ui/screens/broco_projects_screen.dart';
import 'package:movie_selection/movie_selection/movie_selection_app.dart';

class ProjectRoutes {
  static Map<String, WidgetBuilder> routes = {
    '/': (context) => const BrocoProjectsScreen(),
    ProjectModel.movieSelection.route: (_) => const MovieSelectionApp(),

  };
}
