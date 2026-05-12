import 'package:domain/constant/error_info.dart';
import 'package:domain/constant/error_type.dart';
import 'package:domain/errors/app_error.dart';
import 'package:domain/errors/base_error.dart';


class NetworkError extends BaseError {
  NetworkError(
      {required int httpError,
        String errorCode= "",
        String message= "",
        String content= "",
        required super.cause,
        String description= "",
        ErrorColor? color,
      }) : super(error: ErrorInfo(
              code: httpError,
              message: message,
              content: content,
              description: description,
              color:color));

  @override
  String getFriendlyMessage() {
    return error.message;
  }

  @override
  AppError transform() {
    switch (error.code) {
      case 503:
        return AppError(error: error, cause: cause, type: ErrorType.NET_NO_INTERNET_CONNECTION);

      case 504:
        return AppError(cause: cause, error: error, type: ErrorType.NET_SERVER_MESSAGE);

      case 502:
        return AppError(cause: cause, error: error, type: ErrorType.NET_SERVER_MESSAGE);

      case 404:
        return AppError(cause: cause, error: error, type: ErrorType.NET_SERVER_MESSAGE);

      case 403:
        return AppError(cause: cause, error: error, type: ErrorType.FORBIDDEN_403);

      case 401:
        return AppError(cause: cause, error: error, type: ErrorType.UNAUTHORIZED_USER);

      default:
        switch (error.message) {
          case 'err-limitexcced':
            return AppError(cause: cause, error: error, type: ErrorType.OTP_LIMIT_EXCEEDED);

          case 'err-onlyexisting':
            return AppError(cause: cause, error: error, type: ErrorType.ONLY_EXISTING);

          case 'err-invalididnumber':
            return AppError(cause: cause, error: error, type: ErrorType.INVALID_ID_NUMBER);

          case 'err-cifinquiry':
            return AppError(cause: cause, error: error, type: ErrorType.ERROR_CIF_ENQUIRY);

          case 'err-existingnotallowed':
            return AppError(cause: cause, error: error, type: ErrorType.EXISTING_CUSTOMER_NOT_ALLOWED);

          case 'InvalidOtp':
            return AppError(cause: cause, error: error, type: ErrorType.INVALID_OTP);

          case 'ExpireOtp':
            return AppError(cause: cause, error: error, type: ErrorType.EXPIRED_OTP);

          case 'err-invalidpinnotmatch':
            return AppError(cause: cause, error: error, type: ErrorType.PIN_NOT_MATCH_API);

          case 'err-invalidpin':
            return AppError(cause: cause, error: error, type: ErrorType.PIN_NOT_MATCH_API);

          case 'ex-pinsave':
            return AppError(cause: cause, error: error, type: ErrorType.PIN_SAVE_ERROR);

          case 'ex-verifypin':
            return AppError(cause: cause, error: error, type: ErrorType.PIN_VERIFY_ERROR);

          case 'dto-pinnotmatch':
            return AppError(cause: cause, error: error, type: ErrorType.PIN_NOT_MATCH_DTO);

          case 'err-previosupin':
            return AppError(cause: cause, error: error, type: ErrorType.ERROR_PREVIOUS_PIN);

          case 'err-pinotsetup':
            return AppError(cause: cause, error: error, type: ErrorType.PIN_NOT_SETUP);

          case 'ex-pinlogin':
            return AppError(cause: cause, error: error, type: ErrorType.ERROR_PIN_LOGIN);

          case 'ex-firstbio':
            return AppError(cause: cause, error: error, type: ErrorType.ERROR_FIRST_BIO);

          case 'ex-generatekey':
            return AppError(cause: cause, error: error, type: ErrorType.ERROR_GENERATE_KEY_PAIR);

          case 'err-invalddetials':
            return AppError(cause: cause, error: error, type: ErrorType.INVALID_ID_DETAILS);

          case 'err-invalidcardid':
            return AppError(cause: cause, error: error, type: ErrorType.INVALID_INTERNAL_ID);

          case 'InvalidResentType':
            return AppError(cause: cause, error: error, type: ErrorType.INVALID_RESEND_TYPE);

          case 'err-0005':
            return AppError(cause: cause, error: error, type: ErrorType.DEVICE_ID_IS_REQUIRED_ERROR);

          case 'err-164':
            return AppError(cause: cause, error: error, type: ErrorType.VERSION_NOT_FOUND_ERROR);

          case 'ex-121':
            return AppError(cause: cause, error: error, type: ErrorType.EX_121_ERROR);

          case 'dto-0000':
            return AppError(cause: cause, error: error, type: ErrorType.BASE_CLASS_IS_REQUIRED_ERROR);

          case 'dto-0147':
            return AppError(cause: cause, error: error, type: ErrorType.UNIQUE_ID_IS_REQUIRED_ERROR);

          case 'dto-0016':
            return AppError(cause: cause, error: error, type: ErrorType.ID_NUMBER_IS_REQUIRED_ERROR);

          case 'err-otpnotconfigured':
            return AppError(cause: cause, error: error, type: ErrorType.OTP_TYPE_NOT_CONFIGURE_ERROR);

          case 'ex-0002':
            return AppError(cause: cause, error: error, type: ErrorType.EX_0002_ERROR);

          case 'dto-isbus':
            return AppError(cause: cause, error: error, type: ErrorType.IS_BUSINESS_USER_FLAG_REQUIRED_ERROR);

          case 'err-0006':
            return AppError(cause: cause, error: error, type: ErrorType.OTP_CODE_IS_REQUIRED_ERROR);

          case 'ex-0022':
            return AppError(cause: cause, error: error, type: ErrorType.EX_0022);

          case 'err-existingcustomermnadatory':
            return AppError(cause: cause, error: error, type: ErrorType.EXISTING_CUSTOMER_MANDATORY_ERROR);

          case 'CoolOff':
            return AppError(cause: cause, error: error, type: ErrorType.COOLOFF_TIME_ERROR);

          case 'AlreadyVerified':
            return AppError(cause: cause, error: error, type: ErrorType.OTP_ALREADY_VERIFY_ERROR);

          case 'dto-pinrequired':
            return AppError(cause: cause, error: error, type: ErrorType.PIN_REQUIRED_ERROR);

          case 'dto-invalidpin':
            return AppError(cause: cause, error: error, type: ErrorType.INVALID_PIN_MEMBER_ARE_ALLOWED_ERROR);

          case 'ex-164':
            return AppError(cause: cause, error: error, type: ErrorType.EX_164);

          case 'ex-verifyToken':
            return AppError(cause: cause, error: error, type: ErrorType.VERIFY_TOKEN_ERROR);

          case 'err-pinexpire':
            return AppError(cause: cause, error: error, type: ErrorType.PIN_EXPIRED_ERROR);

          case 'dto-confirmpinrequired':
            return AppError(cause: cause, error: error, type: ErrorType.CONFIRM_PIN_REQUIRED_ERROR);

          case 'err-pinlenghtinvalid':
            return AppError(cause: cause, error: error, type: ErrorType.INVALID_PIN_LENGTH_ERROR);

          case 'ex-loandashboard':
            return AppError(cause: cause, error: error, type: ErrorType.LOAN_DASHBOARD_ERROR);

          case 'dto-internalIdRequried':
            return AppError(cause: cause, error: error, type: ErrorType.INTERNAL_ID_REQUIRED_ERROR);

          case 'dto-TransactionTypeRequired':
            return AppError(cause: cause, error: error, type: ErrorType.TRANSACTION_TYPE_REQUIRED_ERROR);

          case 'ex-cardtransactionungroup':
            return AppError(cause: cause, error: error, type: ErrorType.CARD_TRANSACTION_UNGROUP_ERROR);

          case 'err-errorcardstatement':
            return AppError(cause: cause, error: error, type: ErrorType.ERROR_CARD_STATEMENT_ERROR);

          case 'ex-loanTransaction':
            return AppError(cause: cause, error: error, type: ErrorType.LOAN_TRANSACTION_ERROR);

          case 'err-invalidloanid':
            return AppError(cause: cause, error: error, type: ErrorType.INVALID_INTERNAL_LOAN_ID_ERROR);

          case 'err-errorloanstatement':
            return AppError(cause: cause, error: error, type: ErrorType.LOAN_STATEMENT_ERROR);

          case 'ex-loantransactionG':
            return AppError(cause: cause, error: error, type: ErrorType.LOAN_TRANSACTION_G_ERROR);

          case 'ex-cardtransactiogroup':
            return AppError(cause: cause, error: error, type: ErrorType.CARD_TRANSACTION_GROUP_ERROR);

          case 'ex-statementDates':
            return AppError(cause: cause, error: error, type: ErrorType.STATEMENT_DATES_ERROR);

          case 'ex-cardstatement':
            return AppError(cause: cause, error: error, type: ErrorType.CARD_STATEMENT_ERROR);

          case 'dto-status':
            return AppError(cause: cause, error: error, type: ErrorType.CARD_STATUS_IS_REQUIRED_ERROR);

          case 'ex-cardstatuschange':
            return AppError(cause: cause, error: error, type: ErrorType.CARD_STATUS_CHANGE_ERROR);

          case 'err-invalidstatus':
            return AppError(cause: cause, error: error, type: ErrorType.INVALID_CARD_STATUS_ERROR);

          case 'ex-updatednicknamecard':
            return AppError(cause: cause, error: error, type: ErrorType.UPDATED_NICKNAME_CARD_ERROR);

          case 'ex-nicknameloan':
            return AppError(cause: cause, error: error, type: ErrorType.NICKNAME_LOAN_ERROR);

          case 'dto-09901':
            return AppError(cause: cause, error: error, type: ErrorType.CIPHER_IS_REQUIRED_ERROR);

          case 'dto-09902':
            return AppError(cause: cause, error: error, type: ErrorType.PUBLIC_KEY_IS_REQUIRED_ERROR);

          case 'ex-enablebio':
            return AppError(cause: cause, error: error, type: ErrorType.ENABLE_BIO_ERROR);

          case 'dto-0147s':
            return AppError(cause: cause, error: error, type: ErrorType.DTO0147SERROR);

          case 'val-fingernotexist':
            return AppError(cause: cause, error: error, type: ErrorType.BIOMETRIC_NOT_SETUP_ERROR);

          case 'ex-biologin':
            return AppError(cause: cause, error: error, type: ErrorType.BIO_LOGIN_ERROR);

          case 'ex-144a':
            return AppError(cause: cause, error: error, type: ErrorType.EX_144A_ERROR);

          case 'dto-newpinrequired':
            return AppError(cause: cause, error: error, type: ErrorType.NEW_PIN_REQUIRED_ERROR);

          case 'ex-changepin':
            return AppError(cause: cause, error: error, type: ErrorType.CHANGE_PIN_ERROR);

          case 'ex-branchlist':
            return AppError(cause: cause, error: error, type: ErrorType.BRANCH_LIST_ERROR);

          case 'dto-0052':
            return AppError(cause: cause, error: error, type: ErrorType.ID_NUMBER_REQUIRED_ERROR);

          case 'ex-forgotpinsendotp':
            return AppError(cause: cause, error: error, type: ErrorType.FORGOT_PIN_SEND_OTP_ERROR);

          case 'ex-forgotpinResendotp':
            return AppError(cause: cause, error: error, type: ErrorType.FORGOT_PIN_RESEND_OTP_ERROR);

          case 'ex-verifyforgotpin':
            return AppError(cause: cause, error: error, type: ErrorType.VERIFY_FORGOT_PIN_ERROR);

          case 'dto-coderequired':
            return AppError(cause: cause, error: error, type: ErrorType.CODE_REQUIRED_ERROR);

          case 'ex-chagneforgotpin':
            return AppError(cause: cause, error: error, type: ErrorType.CHANGE_FORGOT_PIN_ERROR);

          case 'err-invalidCode':
            return AppError(cause: cause, error: error, type: ErrorType.INVALID_CODE_ERROR);

          case 'dto-vendorid':
            return AppError(cause: cause, error: error, type: ErrorType.VENDOR_ID);

          case 'dto-accountType':
            return AppError(cause: cause, error: error, type: ErrorType.ACCOUNT_TYPE);

          case 'dto-amount':
            return AppError(cause: cause, error: error, type: ErrorType.AMOUNT_REQUIRED);

          case 'err-amountgreater':
            return AppError(cause: cause, error: error, type: ErrorType.AMOUNT_GREATER);

          case 'err-amountless':
            return AppError(cause: cause, error: error, type: ErrorType.AMOUNT_LESS);

          case 'err-vendorid':
            return AppError(cause: cause, error: error, type: ErrorType.INVALID_VENDOR_ID);

          case 'err-invalidType':
            return AppError(cause: cause, error: error, type: ErrorType.INVALID_ACCOUNT_ID);

          case 'err-invalidpaymentid':
            return AppError(cause: cause, error: error, type: ErrorType.INVALID_PAYMENT_ID);

          case 'err-invalidvendorid':
            return AppError(cause: cause, error: error, type: ErrorType.ERROR_INVALID_VENDOR_ID);

          case 'err-paymentIdempty':
            return AppError(cause: cause, error: error, type: ErrorType.PAYMENT_ID_EMPTY);

          case 'ex-initiatepayment':
            return AppError(cause: cause, error: error, type: ErrorType.INITIATE_PAYMENT);

          case 'err-vendornotallowedforloan':
            return AppError(
                cause: cause, error: error, type: ErrorType.VENDOR_NOT_ALLOWED_FOR_THIS_TYPE_LOAN);

          case 'err-vendornotallowedforcard':
            return AppError(
                cause: cause, error: error, type: ErrorType.VENDOR_NOT_ALLOWED_FOR_THIS_TYPE_CARD);

          case 'ex-validatecustomer':
            return AppError(cause: cause, error: error, type: ErrorType.VALIDATE_CUSTOMER);

          case 'err-infonotvaliadted':
            return AppError(cause: cause, error: error, type: ErrorType.INFORMATION_NOT_VALIDATED);

          case 'ex-inquiry':
            return AppError(cause: cause, error: error, type: ErrorType.INQUIRY);

          case 'err-8977':
            return AppError(cause: cause, error: error, type: ErrorType.SOMETHING_WENT_WRONG);

          case 'dto-id':
            return AppError(cause: cause, error: error, type: ErrorType.ID_REQUIRED);

          case 'err-keyexpire':
            return AppError(cause: cause, error: error, type: ErrorType.KEY_EXPIRE);

          case 'err-mwerror':
            return AppError(cause: cause, error: error, type: ErrorType.ERROR_FROM_MIDDLEWARE);

          case 'ex-carddata':
            return AppError(cause: cause, error: error, type: ErrorType.SOMETHING_WENT_WRONG_CARD_DATA);

          case 'val-fingernotverified':
            return AppError(cause: cause, error: error, type: ErrorType.FINGER_PRINT_NOT_VERIFIED);

          case 'ex-logout':
            return AppError(cause: cause, error: error, type: ErrorType.LOGOUT);

          case 'err-accountlock':
            return AppError(cause: cause, error: error, type: ErrorType.ACCOUNT_LOCK);

          case 'err-alreadySigned':
            return AppError(cause: cause, error: error, type: ErrorType.ALREADY_SIGNED_DOCUMENT);

          default:
            return AppError(cause: cause, error: error, type: ErrorType.NETWORK);
        }
    }
  }
}
