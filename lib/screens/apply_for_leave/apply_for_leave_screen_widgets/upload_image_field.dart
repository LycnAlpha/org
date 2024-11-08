import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:org_connect_pt/common/error_snackbar.dart';
import 'package:org_connect_pt/screens/apply_for_leave/apply_for_leave_screen_widgets/custom_background.dart';
import 'package:org_connect_pt/utils/basic_colors.dart';

class UploadImageField extends StatefulWidget {
  const UploadImageField({super.key});

  @override
  State<UploadImageField> createState() => _UploadImageFieldState();
}

class _UploadImageFieldState extends State<UploadImageField> {
  final String fieldName = 'Add Attachment*';

  XFile? imageFile;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              builder: ((builder) => bottomSheetAttachmentOptions()),
            );
          },
          child: CustomBackground(
            child: Padding(
                padding: const EdgeInsets.only(
                  top: 20.0,
                  bottom: 20.0,
                  left: 15.0,
                  right: 10.0,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(imageFile?.name ?? fieldName,
                          maxLines: 2,
                          textAlign: TextAlign.start,
                          style: customTextStyle()),
                    ),
                    Visibility(
                      visible: imageFile == null,
                      child: const Icon(
                        Icons.image_search,
                        color: Color(0xff1C577D),
                        size: 20.0,
                      ),
                    ),
                    Visibility(
                      visible: imageFile != null,
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            imageFile = null;
                          });
                        },
                        icon: Icon(
                          Icons.cancel,
                          color: Colors.red.withOpacity(0.8),
                          size: 25.0,
                        ),
                      ),
                    )
                  ],
                )
                /* Consumer<ApplyForLeaveDataProvider>(
                      builder: (context, applyForLeaveDataProvider, child) {
                    return Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            applyForLeaveDataProvider
                                    .medicalRecordImage?.name ??
                                fieldName,
                            maxLines: 2,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                              color:
                                  Color(BasicColors.displayTextBlueGreyLight),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        Visibility(
                          visible:
                              applyForLeaveDataProvider.medicalRecordImage ==
                                  null,
                          child: Icon(
                            Icons.image_search,
                            color: Colors.black.withOpacity(0.5),
                            size: 20.0,
                          ),
                        ),
                        Visibility(
                          visible:
                              applyForLeaveDataProvider.medicalRecordImage !=
                                  null,
                          child: IconButton(
                            onPressed: () {
                              applyForLeaveDataProvider
                                  .removeMedicalRecordImage();
                            },
                            icon: Icon(
                              Icons.cancel,
                              color: Colors.red.withOpacity(0.8),
                              size: 25.0,
                            ),
                          ),
                        )
                      ],
                    );
                  }),*/
                ),
          )),
    );
  }

  Future<void> getImage(ImageSource source) async {
    imageFile = await ImagePicker().pickImage(source: source);
    if (imageFile != null) {
      String path = imageFile!.path.toLowerCase();
      if (path.endsWith('.png') ||
          path.endsWith('.jpg') ||
          path.endsWith('.jpeg')) {
        final bytes = await imageFile!.length();
        double mb = bytes / (1024.0 * 1024.0);
        if (mb <= 5.0) {
          setState(() {});
        } else {
          imageFile = null;
          ErrorSnackBar.showErrorSnackBar(context,
              'Selected image is too large.\nPlease choose an image under 5 MB.');
        }
      } else {
        imageFile = null;
        ErrorSnackBar.showErrorSnackBar(context,
            'Selected image not supported.\nSupported image types: PNG/ JPG/ JPEG');
      }
    }
    Navigator.pop(context);
  }

  Widget bottomSheetAttachmentOptions() {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: customBoxDecoration(),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextButton(
                    onPressed: () {
                      getImage(ImageSource.camera);
                    },
                    style: customButtonStyle(),
                    child: Text(
                      "Take Photo",
                      style: customTextStyle(),
                    ),
                  ),
                  const Divider(
                    height: 5.0,
                    thickness: 1.0,
                    color: Colors.black12,
                  ),
                  TextButton(
                    onPressed: () {
                      getImage(ImageSource.gallery);
                    },
                    style: customButtonStyle(),
                    child: Text(
                      "Choose From Gallery",
                      style: customTextStyle(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
          Container(
            decoration: customBoxDecoration(),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: customButtonStyle(),
                child: Text(
                  "Cancel",
                  style: customTextStyle(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration customBoxDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
      color: const Color(BasicColors.tertiary),
    );
  }

  ButtonStyle customButtonStyle() {
    return ButtonStyle(
      overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
    );
  }

  TextStyle customTextStyle() {
    return const TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w700,
      color: Color(0xff1C577D),
      overflow: TextOverflow.fade,
    );
  }
}
