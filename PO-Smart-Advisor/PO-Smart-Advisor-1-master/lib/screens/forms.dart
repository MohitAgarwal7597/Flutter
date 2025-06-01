import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:po_smart_advisor/model/all_schemes.dart';
import 'package:po_smart_advisor/theme/app_color.dart';
import 'package:toastification/toastification.dart';

class FormsScreen extends StatefulWidget {
  const FormsScreen({super.key});

  @override
  State<FormsScreen> createState() => _FormsScreenState();
}

class _FormsScreenState extends State<FormsScreen> {
  final TextEditingController searchController = TextEditingController();
  List<DownloadForm> filteredForms = List.from(DownloadForm.forms);

  void reorderForms(
    String query,
  ) {
    if (query.isEmpty) {
      setState(() {
        filteredForms = List.from(DownloadForm.forms);
      });
      return;
    }

    final lowerQuery = query.toLowerCase();

    filteredForms = List.from(DownloadForm.forms)
      ..sort((a, b) {
        int scoreA = _matchScore(a.title.toLowerCase(), lowerQuery);
        int scoreB = _matchScore(b.title.toLowerCase(), lowerQuery);
        return scoreB.compareTo(scoreA); // high score first
      });

    setState(() {});
  }

  int _matchScore(String text, String query) {
    if (text.startsWith(query)) return 2;
    if (text.contains(query)) return 1;
    return 0;
  }

  Future<void> downloadAndOpenPDF(
      BuildContext context, String pdfUrl, String fileName) async {
    final dio = Dio();
    final dir = await getApplicationDocumentsDirectory();
    // final dir = await DownloadDestinations.publicDownloads;
    FileDownloader.downloadFile(url: pdfUrl, name: fileName);
    final filePath =
        '${dir.path}/file_${DateTime.now().millisecondsSinceEpoch}.pdf';

    toastification.show(
      showIcon: true, // show or hide the icon
      primaryColor: AppColor.containerDarkBlue,
      backgroundColor: AppColor.elevatedButtonWhite,
      foregroundColor: AppColor.elevatedButtonWhite,
      type: ToastificationType.info,
      style: ToastificationStyle.fillColored,
      // ignore: use_build_context_synchronously
      context: context, // optional if you use ToastificationWrapper
      title: const Text('Downloading...'),
      autoCloseDuration: const Duration(seconds: 5),
    );

    try {
      await dio.download(pdfUrl, filePath);
      toastification.dismissAll();
      toastification.show(
        description: TextButton(
            onPressed: () {
              OpenFilex.open(filePath);
            },
            child: const Text(
              'Open',
              style: TextStyle(
                  color: AppColor.elevatedButtonWhite,
                  fontWeight: FontWeight.bold),
            )),
        showIcon: true, // show or hide the icon
        primaryColor: const Color.fromARGB(255, 7, 146, 58),
        backgroundColor: AppColor.elevatedButtonWhite,
        foregroundColor: AppColor.elevatedButtonWhite,
        type: ToastificationType.success,
        style: ToastificationStyle.fillColored,
        // ignore: use_build_context_synchronously
        context: context, // optional if you use ToastificationWrapper
        title: const Text('Downloaded successfully'),
        autoCloseDuration: const Duration(seconds: 5),
      );
    } catch (e) {
      toastification.dismissAll();
      toastification.show(
        showIcon: true, // show or hide the icon
        primaryColor: const Color.fromARGB(255, 183, 7, 7),
        backgroundColor: AppColor.elevatedButtonWhite,
        foregroundColor: AppColor.elevatedButtonWhite,
        type: ToastificationType.error,
        style: ToastificationStyle.fillColored,
        // ignore: use_build_context_synchronously
        context: context, // optional if you use ToastificationWrapper
        title: Text(e.toString()),
        autoCloseDuration: const Duration(seconds: 5),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              24.verticalSpace,
              Text(
                "Download Forms",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              8.verticalSpace,
              Text(
                "All official forms for Post Office savings schemes in one place",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              16.verticalSpace,
              Container(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(40.r),
                ),
                child: Row(
                  children: [
                    8.horizontalSpace,
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        onChanged: reorderForms,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            label: Text(
                                "Search for a form (e.g., KYC, Account Opening)",
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 14.sp))),
                      ),
                    ),
                    IconButton(
                        onPressed: () => reorderForms(searchController.text),
                        icon: const Icon(Icons.search),
                        color: AppColor.containerLightBlue)
                  ],
                ),
              ),
              16.verticalSpace,
              Expanded(
                child: CustomScrollView(
                  slivers: [
                    SliverPadding(
                      padding: EdgeInsets.fromLTRB(4.w, 2.h, 4.w, 16.h),
                      sliver: SliverList(
                          delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final form = filteredForms[index];
                          return Padding(
                              padding: const EdgeInsets.all(0),
                              child: _buildFormTile(
                                  link: form.link,
                                  index: index,
                                  title: form.title,
                                  subtitle: form.subtitle,
                                  tag: form.tag,
                                  context: context));
                        },
                        childCount: filteredForms.length,
                      )),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormTile({
    required String link,
    required int index,
    required String title,
    required String subtitle,
    required String tag,
    required BuildContext context,
  }) {
    return Card(
      margin: EdgeInsets.only(bottom: 16.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      elevation: 0.5,
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.picture_as_pdf,
                    color: AppColor.containerDarkBlue),
                12.horizontalSpace,
                Expanded(
                    child: Text('${index + 1}. $title',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 14.sp))),
              ],
            ),
            8.verticalSpace,
            Text(subtitle, style: TextStyle(fontSize: 13.sp)),
            8.verticalSpace,
            Chip(label: Text(tag), backgroundColor: Colors.grey.shade100),
            8.verticalSpace,
            Row(
              children: [
                Flexible(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      downloadAndOpenPDF(context, link, title);
                    },
                    icon: const Icon(Icons.download),
                    label: const Text("Download PDF"),
                  ),
                ),
                16.horizontalSpace,
                Flexible(
                  child: ElevatedButton.icon(
                    style: TextButton.styleFrom(
                        backgroundColor: AppColor.elevatedButtonWhite,
                        foregroundColor: AppColor.elevatedButtonblue),
                    onPressed: () {
                      downloadAndOpenPDF(context, link, title);
                    },
                    icon: const Icon(Icons.language),
                    label: const Text("Download in Hindi"),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
