import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CommonCircleAvatar extends StatefulWidget {
  Function? onChange;
  CommonCircleAvatar({Key? key, this.onChange}) : super(key: key);

  @override
  State<CommonCircleAvatar> createState() => _CommonCircleAvatarState();
}

class _CommonCircleAvatarState extends State<CommonCircleAvatar> {
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _avatarImg;

  Future<void> _pickImg() async {
    XFile? img = await _imagePicker.pickImage(
      source: ImageSource.gallery,
    );

    setState(() {
      _avatarImg = img;
    });

    if (widget.onChange != null) {
      widget.onChange!(img!.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return (IconButton(
      iconSize: 60,
      onPressed: _pickImg,
      icon: CircleAvatar(
        radius: 60,
        backgroundColor: Colors.grey,
        child: _avatarImg == null
            ? Icon(
                Icons.person,
                size: 50,
                color: Colors.white,
              )
            : null,
        backgroundImage:
            _avatarImg != null ? NetworkImage(_avatarImg!.path) : null,
      ),
    ));
  }
}
