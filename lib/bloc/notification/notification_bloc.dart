import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:diabuddy/bloc/notification/notification_event.dart';
import 'package:diabuddy/bloc/notification/notification_state.dart';
import 'package:diabuddy/model/enitity/enum/notification_type.dart';
import 'package:diabuddy/notification_service/notification_manager.dart';
import 'package:diabuddy/repository/notification_repository.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc({
    required this.notificationRepository,
  }) : super(InitialNotificationState()) {
    on<SaveNotification>(_onSaveNotification);
    on<DeleteNotification>(_onDeleteNotification);
    on<GetNotifications>(_onFetchNotifications);
    on<GetNotificationsForTherapy>(_onFetchNotificationsForTherapy);
  }

  final NotificationRepository notificationRepository;

  FutureOr<void> _onSaveNotification(
    SaveNotification event,
    Emitter<NotificationState> emit,
  ) async {
    try {
      NotificationManager().scheduleDailyNotification(
        id: event.notification.id.hashCode,
        scheduleNotificationDateTime: event.notification.triggerTime,
        body: getNotificationBody(event.notification.notificationType),
        title: getNotificationTitle(event.notification.notificationType),
        payload: event.notification.therapyId,
      );
      await notificationRepository.addNotification(
        notification: event.notification,
      );
      emit(SavedNotification());
    } catch (_) {
      emit(SavingNotificationFailed());
    }
  }

  FutureOr<void> _onDeleteNotification(
    DeleteNotification event,
    Emitter<NotificationState> emit,
  ) async {
    try {
      NotificationManager().deleteNotification(event.notificationId.hashCode);
      await notificationRepository.deleteNotification(
        notificationId: event.notificationId,
      );
      emit(DeletedNotification());
    } catch (_) {
      emit(DeletingNotificationFailed());
    }
  }

  FutureOr<void> _onFetchNotifications(
    GetNotifications event,
    Emitter<NotificationState> emit,
  ) async {
    try {
      var data = await notificationRepository.fetchNotification();
      emit(FetchedNotifications(data));
    } catch (_) {
      emit(FetchingNotificationsFailed());
    }
  }

  FutureOr<void> _onFetchNotificationsForTherapy(
    GetNotificationsForTherapy event,
    Emitter<NotificationState> emit,
  ) async {
    try {
      var data = await notificationRepository.fetchNotificationForTherapy(
          therapyId: event.therapyId);
      emit(FetchedNotificationsForTherapy(data));
    } catch (_) {
      emit(FetchingNotificationsFailedForTherapy());
    }
  }
}
