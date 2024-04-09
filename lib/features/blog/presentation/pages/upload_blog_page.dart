import 'dart:io';

import 'package:blog_app/core/common/cubits/user_cubit/user_cubit.dart';
import 'package:blog_app/core/common/widgets/loading_screen.dart';
import 'package:blog_app/core/router/app_router_config.dart';
import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/utils/image_picker.dart';
import 'package:blog_app/core/utils/show_scanbar.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog_app/features/blog/presentation/widgets/editing_text_field.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class UploadBlogPage extends StatefulWidget {
  const UploadBlogPage({super.key});

  @override
  State<UploadBlogPage> createState() => _UploadBlogPageState();
}

class _UploadBlogPageState extends State<UploadBlogPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController blogController = TextEditingController();
  File? image;
  List<String> catagories = [];
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    blogController.dispose();
  }

  void pickImage() async {
    final img = await imagePicker();
    if (img != null) {
      setState(() {
        image = img;
      });
    }
  }

  void uploadBlog() {
    if (_formKey.currentState!.validate() &&
        image != null &&
        catagories.isNotEmpty) {
      final posterId =
          (context.read<UserCubit>().state as UserPresent).user!.id;
      context.read<BlogBloc>().add(BlogUpload(
            posterId,
            titleController.text.trim(),
            blogController.text.trim(),
            image!,
            catagories,
          ));
    } else if (image == null) {
      snackBar(context, "Add an Image");
    } else if (catagories.isEmpty) {
      snackBar(context, "Add some catagories");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Blog'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: uploadBlog,
            icon: const Icon(
              Icons.done_rounded,
            ),
          )
        ],
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogFailure) {
            snackBar(context, state.error);
          }
          if (state is BlogUploadSucess) {
            context.pushReplacement(RouterConstants.homePageRoughtPath);
          }
        },
        builder: (context, state) {
          if (state is BlogLoading) {
            return const Loader();
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    image != null
                        ? GestureDetector(
                            onTap: pickImage,
                            child: SizedBox(
                              height: 150,
                              width: double.infinity,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(
                                  image!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          )
                        : GestureDetector(
                            onTap: pickImage,
                            child: DottedBorder(
                              color: AppPallete.borderColor,
                              dashPattern: const [10, 4],
                              radius: const Radius.circular(10),
                              borderType: BorderType.RRect,
                              child: const SizedBox(
                                height: 150,
                                width: double.infinity,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.folder_open,
                                      size: 40,
                                    ),
                                    SizedBox(height: 15),
                                    Text(
                                      'Pick an image',
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                    const SizedBox(height: 20),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          'Technology',
                          'Food',
                          'Travel',
                          'Devlopment',
                          'Programing',
                          'Sports'
                        ]
                            .map(
                              (e) => Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: GestureDetector(
                                  onTap: () {
                                    if (catagories.contains(e)) {
                                      catagories.remove(e);
                                    } else {
                                      catagories.add(e);
                                    }
                                    setState(() {});
                                  },
                                  child: Chip(
                                    label: Text(e),
                                    color: catagories.contains(e)
                                        ? const MaterialStatePropertyAll(
                                            AppPallete.gradient1)
                                        : null,
                                    side: catagories.contains(e)
                                        ? null
                                        : const BorderSide(
                                            color: AppPallete.borderColor,
                                          ),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    EditingTextField(
                      hintText: 'Blog Title',
                      controller: titleController,
                    ),
                    const SizedBox(height: 20),
                    EditingTextField(
                      hintText: 'Blog Content',
                      controller: blogController,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
