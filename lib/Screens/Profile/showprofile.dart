import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';



class ProfileInfo extends StatefulWidget {
  ProfileInfo({Key? key}) : super(key: key);


  @override
  _ProfileInfoState createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  File? _image;
  Future<void> getImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) {
      return;
    }
    final imageTemporary = File(image.path);

    setState(() {
      this._image = imageTemporary;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Profile Information"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    CircleAvatar(
                      radius: 100,
                      backgroundColor: Colors.white,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: _image != null
                            ? Image.file(
                          _image!,
                          fit: BoxFit.cover,
                        )
                            : Image.network(
                          "https://imgs.search.brave.com/VfOlmssamn3NTAP14DFpqr1z9pxdR7P4czo10TKxRuk/rs:fit:860:681:1/g:ce/aHR0cHM6Ly93d3cu/cG5naXRlbS5jb20v/cGltZ3MvbS8xNDYt/MTQ2ODQ3OV9teS1w/cm9maWxlLWljb24t/YmxhbmstcHJvZmls/ZS1waWN0dXJlLWNp/cmNsZS1oZC5wbmc",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 125,
                      left: 100,
                      width: 90,
                      height: 30,
                      child: ActionChip(
                        label: Text("Change"),
                        onPressed: () => getImage(ImageSource.gallery),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Card(
                child: Column(
                  children: const [
                    ListTile(
                      leading: Icon(Icons.person_outline),
                      title: Text("Full name"),
                      subtitle: Text("Rabin Shahi"),
                    ),
                    ListTile(
                      leading: Icon(Icons.email_outlined),
                      title: Text("Email"),
                      subtitle: Text("rabinshahi@gmail.com"),
                    ),
                    ListTile(
                      leading: Icon(Icons.lock_open),
                      title: Text("Password"),
                      subtitle: Text("adfafddafere"),
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
