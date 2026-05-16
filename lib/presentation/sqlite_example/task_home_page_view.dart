import 'package:domain/entities/task_entity.dart';
import 'package:flutter/material.dart';
import 'package:kick_stack/base/base_page.dart';
import 'package:kick_stack/core/theme/app_colors.dart';
import 'package:kick_stack/generated/l10n.dart';
import 'package:kick_stack/presentation/sqlite_example/task_home_page_view_model.dart';
import 'package:kick_stack/ui/app_ui.dart';
import 'package:kick_stack/utils/enums.dart';
import 'package:kick_stack/utils/resource.dart';

class TaskHomePageView extends BasePageViewWidget<TaskHomePageViewModel> {
  const TaskHomePageView(super.providerBase, {super.key});

  @override
  Widget build(BuildContext context, TaskHomePageViewModel model) {
    final strings = S.of(context);

    return ColoredBox(
      color: AppColors.background,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                strings.sqliteExampleTitle,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                strings.sqliteExampleDescription,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 24),
              AppStreamBuilder<bool>(
                stream: model.loadingStream,
                initialData: false,
                dataBuilder: (context, isLoading) {
                  final loading = isLoading ?? false;
                  return Row(
                    children: [
                      Expanded(
                        child: AppPrimaryButton(
                          title: strings.createLocalTask,
                          loading: loading,
                          onTap: () => model.createSampleTask(
                            title: strings.sampleTaskTitle,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: AppSecondaryButton(
                          title: strings.refreshLocalTasks,
                          onTap: loading ? null : model.getLocalTasks,
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 16),
              AppStreamBuilder<Resource<TaskEntity>>(
                stream: model.createTaskResponseStream,
                initialData: Resource.none(),
                dataBuilder: (context, response) {
                  return _ResourceStatusText(
                    resource: response,
                    successText: strings.localTaskCreated,
                  );
                },
              ),
              const SizedBox(height: 8),
              Expanded(
                child: AppStreamBuilder<Resource<List<TaskEntity>>>(
                  stream: model.localTasksResponseStream,
                  initialData: Resource.none(),
                  dataBuilder: (context, response) {
                    final tasks = response?.data ?? [];

                    if (response?.status == Status.LOADING) {
                      return Center(child: Text(strings.loading));
                    }

                    if (response?.status == Status.ERROR) {
                      return Center(
                        child: Text(
                          response?.appError?.error.message ??
                              strings.emptyTaskMessage,
                          style: const TextStyle(color: AppColors.error),
                        ),
                      );
                    }

                    if (tasks.isEmpty) {
                      return Center(
                        child: Text(
                          strings.emptyTaskMessage,
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      );
                    }

                    return ListView.separated(
                      itemCount: tasks.length,
                      separatorBuilder: (_, __) => const Divider(
                        color: AppColors.divider,
                      ),
                      itemBuilder: (context, index) {
                        final task = tasks[index];
                        return _TaskTile(
                          task: task,
                          onChanged: () => model.toggleTask(task),
                          onDelete: () => model.deleteTask(task.id),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ResourceStatusText<T> extends StatelessWidget {
  final Resource<T>? resource;
  final String successText;

  const _ResourceStatusText({
    required this.resource,
    required this.successText,
  });

  @override
  Widget build(BuildContext context) {
    if (resource == null || resource?.status == Status.NONE) {
      return const SizedBox.shrink();
    }

    final message = switch (resource!.status) {
      Status.LOADING => S.of(context).loading,
      Status.SUCCESS => successText,
      Status.ERROR => resource?.appError?.error.message ?? '',
      Status.NONE => '',
    };

    if (message.isEmpty) return const SizedBox.shrink();

    return AppInfoBanner(
      message: message,
      type: resource?.status == Status.ERROR
          ? AppInfoBannerType.error
          : AppInfoBannerType.success,
    );
  }
}

class _TaskTile extends StatelessWidget {
  final TaskEntity task;
  final VoidCallback onChanged;
  final VoidCallback onDelete;

  const _TaskTile({
    required this.task,
    required this.onChanged,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Checkbox(
        value: task.isCompleted,
        onChanged: (_) => onChanged(),
      ),
      title: Text(
        task.title,
        style: const TextStyle(color: AppColors.textPrimary),
      ),
      trailing: IconButton(
        tooltip: S.of(context).deleteTask,
        onPressed: onDelete,
        icon: const Icon(Icons.delete_outline),
      ),
    );
  }
}
