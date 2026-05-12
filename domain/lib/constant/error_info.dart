class ErrorInfo {
  final String message;
  final String? content;
  final int? code;
  final String description;
  final ErrorColor? color;

  ErrorInfo({required this.message,this.content='', this.code, this.description= '',this.color});

}
enum ErrorColor{
  red,orange;
}