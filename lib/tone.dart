import 'dart:math';
import 'dart:typed_data';

/// Generates 16-bit PCM tones.
class Tone {
  /// Creates a new [Tone] given some audio information.
  Tone({
    required this.sampleRate,
    required this.durationInSeconds,
    required this.baseFrequency,
    required this.diffFrequency,
  });

  /// The sample rate to use in hertz.
  final int sampleRate;

  /// The duration of the tone in seconds.
  final int durationInSeconds;

  /// The starting frequency to use in hertz (left channel).
  final double baseFrequency;

  /// The frequency difference to use in hertz (right channel).
  final double diffFrequency;

  /// Returns a 16-bit PCM sine wave tone for a given frequency.
  Float64List generateTone(double frequency) {
    final samplesPerCycle = sampleRate / frequency;
    final totalSamples = durationInSeconds * sampleRate;

    final rawAudio = List.generate(
      totalSamples,
      (sample) => sin(sample / samplesPerCycle * 2 * pi),
    );

    return Float64List.fromList(rawAudio);
  }

  /// Returns two offset 16-bit PCM sine wave tones.
  List<Float64List> generateTones() {
    return [
      generateTone(baseFrequency),
      generateTone(baseFrequency + diffFrequency),
    ];
  }
}
