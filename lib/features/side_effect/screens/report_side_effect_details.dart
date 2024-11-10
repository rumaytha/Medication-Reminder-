import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../logic/side_effect_cubit.dart';
import '../logic/side_effect_state.dart';

class ReportSideEffectDetails extends StatefulWidget {
  const ReportSideEffectDetails({super.key});

  @override
  State<ReportSideEffectDetails> createState() =>
      _ReportSideEffectDetailsState();
}

class _ReportSideEffectDetailsState extends State<ReportSideEffectDetails> {
  final ImagePicker picker = ImagePicker();
  XFile? image;

  @override
  Widget build(BuildContext context) {
    Future<void> pickImage(ImageSource source) async {
      image = await picker.pickImage(source: source);

      log(image!.path.toString());
      setState(() {});

      Navigator.of(context).pop();
    }

    void showPickerDialog() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Pick Image"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: const Text("Camera"),
                  onTap: () => pickImage(ImageSource.camera),
                ),
                ListTile(
                  leading: const Icon(Icons.photo),
                  title: const Text("Gallery"),
                  onTap: () => pickImage(ImageSource.gallery),
                ),
              ],
            ),
          );
        },
      );
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFf8f7fc),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text(
            'Enter Description',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w800,
              fontSize: 21,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: BlocListener<SideEffectCubit, SideEffectState>(
            listener: (context, state) => handleStates(state, context),
            child: Column(
              children: [
                TextField(
                  controller: context.read<SideEffectCubit>().reportController,
                  maxLines: 6,
                  decoration: const InputDecoration(
                    hintText: "Description",
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                if (image != null)
                  Image.file(
                    File(image!.path),
                    width: 300,
                    height: 300,
                    fit: BoxFit.contain,
                  ),
                if (image == null)
                  const SizedBox(
                    height: 300,
                  ),
                const SizedBox(
                  height: 12,
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle Report Side Effects action
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF9a90ff),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text(
                    "Report Side Effects",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    // Handle Share Reports action
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF9a90ff),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text(
                    "Share Reports",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.camera_alt, color: Colors.grey),
                          onPressed: showPickerDialog,
                        ),
                        const SizedBox(width: 8),
                        const Expanded(
                          child: TextField(
                            readOnly: true,
                            decoration: InputDecoration(
                              hintText: "Share reports..",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        BlocBuilder<SideEffectCubit, SideEffectState>(
                            builder: (context, state) {
                          if (state is ReportSideEffectLoading) {
                            return const CircularProgressIndicator();
                          }
                          return IconButton(
                            onPressed: () {
                              // Handle send action
                              context.read<SideEffectCubit>().reportSideEffect();
                            },
                            icon: const Icon(Icons.send, color: Colors.green),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  void handleStates(SideEffectState state, BuildContext context) {
    if (state is ReportSideEffectFailure) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(state.message),
          backgroundColor: Colors.red,
        ),
      );
    }

    if (state is ReportSideEffectSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Report sent successfully"),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.of(context).pop();
    }
  }
}
