import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';

createIcon(context, isListening, _listen) {
  return AvatarGlow(
    animate: isListening,
    glowColor: Theme.of(context).primaryColor,
    endRadius: 75.0,
    duration: const Duration(milliseconds: 2000),
    repeatPauseDuration: const Duration(milliseconds: 100),
    repeat: true,
    child: FloatingActionButton(
      onPressed: _listen,
      child: Icon(isListening ? Icons.mic : Icons.mic_off),
    ),
  );
}
