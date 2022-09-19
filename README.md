# binaural

A binaural beat generator using pulse-code modulation.

# Getting started

Install this program: `dart pub global activate -s git https://github.com/tytydraco/binaural`.

# Usage

```
-h, --help                     Shows the program usage.
-r, --sample-rate              The sample rate of the resulting audio file.
                               (defaults to "44100")
-b, --base-freq (mandatory)    The base frequency to play on the left channel.
-d, --diff-freq (mandatory)    The offset for the base frequency to play on the right channel.
-t, --duration                 The duration in seconds for the audio file.
                               (defaults to "5")
-o, --output (mandatory)       The location of the output file.
```
