import 'dart:io';

import 'package:binaural/tone.dart';

void main() {
  final tones = Tone(
    sampleRate: 44100,
    durationInSeconds: 5,
    baseFrequency: 200,
    diffFrequency: 215,
  ).generateTones();

  stdout.writeln(tones);
}
