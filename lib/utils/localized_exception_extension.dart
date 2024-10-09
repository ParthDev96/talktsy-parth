import 'dart:io';
import 'package:flutter/material.dart';
import 'package:matrix/encryption.dart';
import 'package:matrix/matrix.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'uia_request_manager.dart';
import 'package:get/get.dart';

extension LocalizedExceptionExtension on Object {
  String toLocalizedString(
    BuildContext context, [
    ExceptionContext? exceptionContext,
  ]) {
    if (this is MatrixException) {
      switch ((this as MatrixException).error) {
        case MatrixError.M_FORBIDDEN:
          if (exceptionContext == ExceptionContext.changePassword) {
            return L10n.of(Get.context!)?.passwordIsWrong ?? "";
          }
          return L10n.of(Get.context!)?.noPermission ?? "";
        case MatrixError.M_LIMIT_EXCEEDED:
          return L10n.of(Get.context!)?.tooManyRequestsWarning ?? "";
        default:
          return (this as MatrixException).errorMessage;
      }
    }
    if (this is InvalidPassphraseException) {
      return L10n.of(Get.context!)?.wrongRecoveryKey ?? "";
    }
    if (this is FileTooBigMatrixException) {
      return L10n.of(Get.context!)?.fileIsTooBigForServer ?? "";
    }
    if (this is BadServerVersionsException) {
      final serverVersions = (this as BadServerVersionsException)
          .serverVersions
          .toString()
          .replaceAll('{', '"')
          .replaceAll('}', '"');
      final supportedVersions = (this as BadServerVersionsException)
          .supportedVersions
          .toString()
          .replaceAll('{', '"')
          .replaceAll('}', '"');
      return 'badServerVersionsException'.trParams({
        'serverVersions': serverVersions,
        'supportedVersions': supportedVersions,
      });
    }
    if (this is BadServerLoginTypesException) {
      final serverVersions = (this as BadServerLoginTypesException)
          .serverLoginTypes
          .toString()
          .replaceAll('{', '"')
          .replaceAll('}', '"');
      final supportedVersions = (this as BadServerLoginTypesException)
          .supportedLoginTypes
          .toString()
          .replaceAll('{', '"')
          .replaceAll('}', '"');
      return 'badServerLoginTypesException'.trParams({
        'serverVersions': serverVersions,
        'supportedVersions': supportedVersions,
      });
    }
    if (this is MatrixException ||
        this is SocketException ||
        this is SyncConnectionException) {
      return L10n.of(Get.context!)?.noConnectionToTheServer ?? "";
    }
    if (this is String) return toString();
    if (this is UiaException) return toString();
    Logs().w('Something went wrong: ', this);
    return L10n.of(Get.context!)?.oopsSomethingWentWrong ?? "";
  }
}

enum ExceptionContext {
  changePassword,
}
