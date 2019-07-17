import 'package:dart_otp/src/util.dart';
import 'package:test/test.dart';

void main() {
  test('[Util] Should time format with 30 second interval', () {
    var time = DateTime.parse('2019-01-01 00:00:00.000');
    var formatTime = Util.timeFormat(time: time, interval: 30);

    expect(formatTime, 51543360);
  });

  test('[Util] Should time format with 60 second interval', () {
    var time = DateTime.parse('2019-01-01 00:00:00.000');
    var formatTime = Util.timeFormat(time: time, interval: 60);

    expect(formatTime, 25771680);
  });

  test('[Util] Should convert time format into byte list', () {
    var byteList = Util.intToBytelist(input: 25771680);

    expect(byteList.length, 8);

    byteList = Util.intToBytelist(input: 51543360, padding: 6);

    expect(byteList.length, 6);
  });
}
