import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:nutriapp/constant/colors.dart';
import 'package:provider/provider.dart';
import '../providers/getdishprovider.dart';
import 'additems.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  void initState() {
    super.initState();
    Provider.of<GetDishProvider>(context, listen: false).getMenu();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GetDishProvider>(
      builder: (context, getmenu, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: ColorClass.baseColor,
          ),
          body: Center(
            child: Container(
              child: Column(
                children: [
                  Row(
                    children: [
                      const Spacer(),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 10, 15, 0),
                        child: Container(
                          child: ElevatedButton(
                            onPressed: () async {
                              try {
                                // Open the file picker to allow the user to select files
                                FilePickerResult? result =
                                    await FilePicker.platform.pickFiles(
                                  type: FileType.any,
                                  allowMultiple: true,
                                );

                                if (result != null) {
                                  print("file12$result");
                                  // Get the paths of the selected files
                                  List<String> filePaths = result.paths
                                      .map((path) => path!)
                                      .toList();

                                  // Handle the selected files here
                                  print('Selected files: $filePaths');
                                }
                              } catch (e) {
                                print('Error selecting files: $e');
                              }
                            },
                            child: Container(
                              child: const Text(
                                'Upload Files',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorClass.baseColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              padding: const EdgeInsets.all(12),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 10, 15, 0),
                        child: Container(
                          child: ElevatedButton(
                            onPressed: () {
                              getmenu.clear();
                              Navigator.pushNamed(context, "/additems");
                            },
                            child: Container(
                              child: const Text(
                                'Add Items',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorClass.baseColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              padding: const EdgeInsets.all(12),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  const Center(
                    child: Text(
                      'Menu',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: getmenu.menudata.menu == null
                          ? 0
                          : getmenu.menudata.menu?.length,
                      itemBuilder: (context, index) {
                        if (getmenu.menudata.menu == null) {
                          return Container();
                        } else {
                          return Container(
                            margin: const EdgeInsets.all(20),
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      height: 80,
                                      width: 80,
                                      child: Image.network(
                                        getmenu.menudata.menu![index].image ??
                                            "",
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        getmenu.menudata.menu![index]
                                                .dishName ??
                                            "",
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Row(
                                        children: [
                                          const Icon(Icons.attach_money),
                                          Text(
                                            getmenu.menudata.menu![index].price
                                                .toString(),
                                            style:
                                                const TextStyle(fontSize: 18),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          ElevatedButton(
                                            onPressed: () async {
                                              getmenu.modifydish([
                                                getmenu.menudata.menu![index]
                                              ]);
                                              Navigator.pushNamed(
                                                  context, "/additems");
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  ColorClass.baseColor,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              padding: const EdgeInsets.all(8),
                                            ),
                                            child: Container(
                                              child: const Text(
                                                'Modify',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 7,
                                          ),
                                          ElevatedButton(
                                            onPressed: () async {
                                              bool response = await getmenu
                                                  .deleteDish(getmenu
                                                          .menudata
                                                          .menu![index]
                                                          .menuNumber ??
                                                      0);

                                              if (response) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    content: Text(
                                                        'Dish deleted Successfylly '),
                                                    backgroundColor:
                                                        ColorClass.baseColor,
                                                  ),
                                                );
                                              }
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  ColorClass.baseColor,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              padding: const EdgeInsets.all(8),
                                            ),
                                            child: Container(
                                              child: const Text(
                                                'Delete',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
