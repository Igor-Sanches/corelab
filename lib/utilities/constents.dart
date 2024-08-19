
String noNull(value){
  if(value == null){
    return '';
  }
  return value;
}

double toDouble(value, {double defaultValue = 0.0}) {
  if(value is double){
    return value;
  }else if(value is int){
    return value.toDouble();
  }else if(value is String){
    return double.parse(value);
  }else{
    return 0.0;
  }
}

int toInt(value, {int defaultValue = 0}) {
  if(value == null){
    return defaultValue;
  }
  if(value is int){
    return value;
  }else if(value is double){
    return value.toInt();
  }else if(value is String){
    return int.parse(value);
  }else if(value is bool){
    return value ? 1 : 0;
  }else{
    return defaultValue;
  }
}

bool toBool(value, {bool defaultValue = false}) {
  if(value == null) return defaultValue;

  if(value is int){
    return value == 1;
  }else if(value is String){
    return value == 'true';
  }else if(value is bool){
    return value;
  }else{
    return defaultValue;
  }
}

String? toString(data, {String? defaultValue}){
  if(data == null){
    return defaultValue;
  }

  return data.toString();
}