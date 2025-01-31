import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '../../controllers/book_details_controller.dart';
import '../../controllers/bookmarks_controller.dart';
import '../../models/book_details_model.dart';
import '../../models/book_model.dart';
import '../../utils/colors.dart';
import '../base/custom_button.dart';
import '../base/custom_snackbar.dart';

class BookDetailsContent extends StatelessWidget {
  final BookDetails book;
  final Book bookForFavorites;
  final BookmarksController bookmarksController;
  final BookDetailsController bookDetailsController;

  const BookDetailsContent({
    super.key,
    required this.book,
    required this.bookForFavorites,
    required this.bookmarksController,
    required this.bookDetailsController,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImageSection(),
          const SizedBox(height: 16),
          _buildAuthorAndBookmarkRow(),
          const SizedBox(height: 16),
          _buildBookTitleAndSubtitle(),
          const SizedBox(height: 16),
          Text(
            book.description,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 24),
          _buildDownloadButton(),
        ],
      ),
    );
  }

  Widget _buildImageSection() {
    return Stack(
      children: [
        Image.network(
          book.image,
          width: double.infinity,
          height: 300,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return const Center(
              child: Icon(
                Icons.broken_image,
                size: 50,
                color: Colors.grey,
              ),
            );
          },
        ),
        Positioned(
          top: 16,
          left: 16,
          child: GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black.withAlpha((0.6 * 255).toInt()),
              ),
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAuthorAndBookmarkRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            book.authors,
            style: const TextStyle(
              color: AppColors.primaryColor,
              fontSize: 16,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            softWrap: true,
          ),
        ),
        Obx(() {
          final isFavorite = bookmarksController.isFavorite(bookForFavorites);
          return GestureDetector(
            onTap: () {
              if (isFavorite) {
                bookmarksController.removeFromFavorites(bookForFavorites);
              } else {
                bookmarksController.addToFavorites(bookForFavorites);
              }
            },
            child: Container(
              width: 24,
              height: 24,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black,
              ),
              child: Icon(
                isFavorite ? Icons.bookmark_outlined : Icons.bookmark_outline,
                color: Colors.white,
                size: 16,
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildBookTitleAndSubtitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          book.title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        if (book.subtitle.isNotEmpty) const SizedBox(height: 8),
        if (book.subtitle.isNotEmpty)
          Text(
            book.subtitle,
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
      ],
    );
  }

  Widget _buildDownloadButton() {
    return Obx(() {
      final isLoading = bookDetailsController.isDownloading.value;
      return StyledButton(
        onPressed: isLoading
            ? null
            : () async {
                bookDetailsController.setDownloading(true);
                await _handleDownload();
              },
        text: isLoading ? 'Downloading...' : 'Download',
      );
    });
  }

  Future<void> _handleDownload() async {
    final Uri downloadUri = Uri.parse(book.download);

    try {
      final response = await http.head(downloadUri);

      if (response.statusCode == 200) {
        if (await canLaunchUrl(downloadUri)) {
          await launchUrl(downloadUri, mode: LaunchMode.externalApplication);
        } else {
          showErrorSnackbar("Unable to open the browser.");
        }
      } else {
        showErrorSnackbar("Download link is not available.");
      }
    } catch (e) {
      showErrorSnackbar("Failed to check the download link.");
    } finally {
      bookDetailsController.setDownloading(false);
    }
  }
}
