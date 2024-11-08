import 'package:org_connect_pt/utils/basic_colors.dart';
import 'package:org_connect_pt/utils/constants.dart';

class StatusHandleHelper {
  static int getStatusColor(int statusCode) {
    switch (statusCode) {
      case Constants.statusPending:
        return BasicColors.statusPendingColor;
      case Constants.statusApproved:
        return BasicColors.statusApprovedColor;
      case Constants.statusRejected:
        return BasicColors.statusRejectedColor;
      case Constants.statusReviewed:
        return BasicColors.statusReviewedColor;

      case Constants.statusRequestToCancel:
        return BasicColors.statusRequestToCancelColor;

      case Constants.statusCanceled:
        return BasicColors.statusCanceledColor;

      case Constants.statusReported:
        return BasicColors.statusReportedColor;

      case Constants.statusUnderInvestigation:
        return BasicColors.statusUnderInvestigationColor;
      case Constants.statusResolved:
        return BasicColors.statusUnderResolvedColor;
      case Constants.statusPendingAcknowledgement:
        return BasicColors.statusUnderPendingAcknowledgmentColor;
    }

    return BasicColors.primary;
  }
}
