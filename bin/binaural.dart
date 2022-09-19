import 'dart:io';

import 'package:args/args.dart';
import 'package:binaural/tone.dart';
import 'package:wav/wav.dart';

void main(List<String> args) {
  final argParser = ArgParser();
  argParser
    ..addFlag(
      'help',
      abbr: 'h',
      help: 'Shows the program usage.',
      negatable: false,
      callback: (value) {
        if (value) {
          stdout.writeln(argParser.usage);
          exit(0);
        }
      },
    )
    ..addOption(
      'sample-rate',
      abbr: 'r',
      help: 'The sample rate of the resulting audio file.',
      defaultsTo: '44100',
    )
    ..addOption(
      'base-freq',
      abbr: 'b',
      help: 'The base frequency to play on the left channel.',
      mandatory: true,
    )
    ..addOption(
      'diff-freq',
      abbr: 'd',
      help: 'The offset for the base frequency to play on the right channel.',
      mandatory: true,
    )
    ..addOption(
      'duration',
      abbr: 't',
      help: 'The duration in seconds for the audio file.',
      defaultsTo: '5',
    )
    ..addOption(
      'output',
      abbr: 'o',
      help: 'The location of the output file.',
      mandatory: true,
    );

  final options = argParser.parse(args);

  try {
    final sampleRate = int.parse(options['sample-rate']! as String);
    final baseFreq = double.parse(options['base-freq']! as String);
    final diffFreq = double.parse(options['diff-freq']! as String);
    final duration = int.parse(options['duration']! as String);
    final output = options['output'] as String;

    final tones = Tone(
      sampleRate: sampleRate,
      durationInSeconds: duration,
      baseFrequency: baseFreq,
      diffFrequency: diffFreq,
    ).generateTones();

    final metadata = WavMetadata(
      sampleRate: sampleRate,
      numberOfSamples: tones.first.length,
    );

    final wav = Wav(
      metadata: metadata,
      channelData: tones,
    );

    final wavBytes = wav.toBytes();

    File(output).writeAsBytesSync(
      wavBytes,
      mode: FileMode.writeOnly,
    );
  } catch (e) {
    stderr.writeln(e.toString());
    exit(1);
  }
}
