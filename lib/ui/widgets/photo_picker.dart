import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class PhotoPicker extends StatelessWidget {
  const PhotoPicker({
    super.key, required this.onTap, this.selectedPhoto,
  });

  final VoidCallback onTap;
  final XFile ? selectedPhoto;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        width: double.maxFinite,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5)
        ),
        child: Row(
          children: [
            Container(
              child: Text('Photo',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                ),
              ),
              alignment: Alignment.center,
              width: 100,
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    bottomLeft: Radius.circular(5),
                  )
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Text(selectedPhoto == null ? 'no photo selected': selectedPhoto!.name,
              style: TextStyle(
                overflow: TextOverflow.ellipsis,
              ),
                maxLines: 1,
              ),
      
            ),
          ],
        ),
      ),
    );
  }
}