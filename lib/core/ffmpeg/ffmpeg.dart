// ignore_for_file: non_constant_identifier_names

library ffmpeg;

import 'dart:convert';
import 'dart:io';
 

class FFmpeg {
  late String path_ffmpeg = "ffmpeg";
  FFmpeg({String? pathFFmpeg}) {
    pathFFmpeg ??= path_ffmpeg;
  }

  Future<FFmpegRawResponse> invoke({
    String? pathFFmpeg,
    FFmpegArgs? fFmpegArgs,
    String? workingDirectory,
    Map<String, String>? environment,
    bool includeParentEnvironment = true,
    bool runInShell = false,
  }) async {
    fFmpegArgs ??= FFmpegArgs([]);
    pathFFmpeg ??= path_ffmpeg;
    ProcessResult res = await Process.run(
      pathFFmpeg,
      fFmpegArgs.toList(),
      workingDirectory: workingDirectory,
      environment: environment,
      includeParentEnvironment: includeParentEnvironment,
      runInShell: runInShell,
    );
    if (res.exitCode == 0) {
      return FFmpegRawResponse(
        rawData: {"@type": "ok", "message": res.stdout},
        processResult: res,
      );
    } else {
      return FFmpegRawResponse(
        rawData: {"@type": "error", "message": res.stderr},
        processResult: res,
      );
    }
  }

  FFmpegRawResponse invokeSync({
    String? pathFFmpeg,
    FFmpegArgs? fFmpegArgs,
    String? workingDirectory,
    Map<String, String>? environment,
    bool includeParentEnvironment = true,
    bool runInShell = false,
  }) {
    fFmpegArgs ??= FFmpegArgs([]);
    pathFFmpeg ??= path_ffmpeg;
    ProcessResult res = Process.runSync(
      pathFFmpeg,
      fFmpegArgs.toList(),
      workingDirectory: workingDirectory,
      environment: environment,
      includeParentEnvironment: includeParentEnvironment,
      runInShell: runInShell,
    );
    if (res.exitCode == 0) {
      return FFmpegRawResponse(
        rawData: {"@type": "ok", "message": res.stdout},
        processResult: res,
      );
    } else {
      return FFmpegRawResponse(
        rawData: {"@type": "error", "message": res.stderr},
        processResult: res,
      );
    }
  }
}

class FFmpegArgs {
  late List<String> rawData;
  late ProcessResult processResult;
  FFmpegArgs(this.rawData);

  List<String> toList() {
    return rawData;
  }
}

class FFmpegRawResponse {
  late Map rawData;
  late ProcessResult processResult;
  FFmpegRawResponse({
    required this.rawData,
    required this.processResult,
  });

  String? get special_type {
    try {
      return rawData["@type"] as String;
    } catch (e) {
      return null;
    }
  }

  Map toJson() {
    return rawData;
  }

  Map toMap() {
    return rawData;
  }

  @override
  String toString() {
    return json.encode(rawData);
  }
}

class FFmpegResponse {
  FFmpegResponse();
}
