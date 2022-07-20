import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class CameraPage extends StatefulWidget {
  final List<CameraDescription>? cameras;
  const CameraPage({Key? key, this.cameras}) : super(key: key);


  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController controller;
  XFile? pictureFile;

  @override
  void initState() {
    super.initState();
    controller = CameraController(
        widget.cameras![0],
        ResolutionPreset.max);

    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    if(!controller.value.isInitialized){
      return const SizedBox(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Column(
      children: [
        Padding(padding: const EdgeInsets.all(8.0),
        child:Center(
          child: SizedBox(
            height: 400,
            width: 400,
            child: CameraPreview(controller),
          ),
        ),
        ),
        Padding(padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: ()async{
            pictureFile = await controller.takePicture();
            setState(() {});
          }, child: const Text('Capture image'),
        ),
        ),
        if(pictureFile != null )
          Image.network(
            height: 200,
          pictureFile!.path,

          ),
        //Android,ios

        // Image.file(File(pictureFile!.path)))
      ],
    );
  }
}