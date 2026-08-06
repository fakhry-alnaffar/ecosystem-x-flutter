/// Common HTTP status code constants used throughout the library.
class HttpStatus {
  /// 200 OK — request succeeded.
  static const int kCodeSuccess200 = 200;

  /// 201 Created — resource created successfully.
  static const int kCodeSuccess201 = 201;

  /// 400 Bad Request — the server could not understand the request.
  static const int badRequest = 400;

  /// 401 Unauthorized — authentication is required or has failed.
  static const int unauthorized = 401;

  /// 403 Forbidden — the server refuses to authorise the request.
  static const int forbidden = 403;

  /// 404 Not Found — the requested resource does not exist.
  static const int notFound = 404;

  /// 415 Unsupported Media Type — the request content type is not supported.
  static const int unsupportedMediaType = 415;

  /// 422 Unprocessable Entity — validation failed on the request body.
  static const int unprocessedEntity = 422;

  /// 429 Too Many Requests — rate limit exceeded.
  static const int tooManyRequests = 429;

  /// 500 Internal Server Error — unexpected server-side failure.
  static const int internalServerError = 500;

  /// 501 Not Implemented — the server does not support this functionality.
  static const int notImplemented = 501;

  /// 502 Bad Gateway — upstream server returned an invalid response.
  static const int badGateway = 502;

  /// 503 Service Unavailable — the server is temporarily unable to handle requests.
  static const int serviceUnavailable = 503;

  /// 599 Network Connect Timeout — connection timed out at the network level.
  static const int networkConnectTimeoutError = 599;
}
