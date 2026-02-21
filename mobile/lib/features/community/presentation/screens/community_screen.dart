import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/ui/layout/app_scaffold.dart';
import '../widgets/community_post_card.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _posts = [];
  List<Map<String, dynamic>> _filteredPosts = [];

  @override
  void initState() {
    super.initState();
    _posts = List.generate(5, (index) => {
      "id": index,
      "userName": "Usuario ${index + 1}",
      "routineTitle": index % 2 == 0 ? "Rutina de Mañana Productiva" : "Rutina de Noche Relajante",
      "description": "Esta rutina me ha ayudado a mejorar mi enfoque y energía durante todo el día. ¡Recomendada!",
      "likes": 120 + index * 5,
      "comments": 14 + index,
      "isLiked": index % 2 == 0,
    });
    _filteredPosts = List.from(_posts);
    _searchController.addListener(_filterPosts);
  }

  void _filterPosts() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredPosts = _posts.where((post) {
        final title = (post["routineTitle"] as String).toLowerCase();
        final user = (post["userName"] as String).toLowerCase();
        return title.contains(query) || user.contains(query);
      }).toList();
    });
  }

  void _toggleLike(int index) {
    setState(() {
      final postIndex = _posts.indexWhere((p) => p["id"] == _filteredPosts[index]["id"]);
      if (postIndex != -1) {
        _posts[postIndex]["isLiked"] = !_posts[postIndex]["isLiked"];
        if (_posts[postIndex]["isLiked"]) {
          _posts[postIndex]["likes"]++;
        } else {
          _posts[postIndex]["likes"]--;
        }
        // Update filtered list item reference if needed, but since we rebuild from _posts effectively or use same objects if reference managed well. 
        // Here we are modifying the map inside the list, so filtered list pointing to same map should update.
      }
    });
  }

  void _showCommentDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            const SizedBox(height: 12),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Comentarios",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: 3,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CircleAvatar(
                        radius: 16,
                        backgroundColor: AppTheme.neutralBg,
                        child: Icon(Icons.person, size: 18, color: AppTheme.grayCustom),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Usuario ${index + 5}",
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              "¡Qué buena rutina! Me encantaría probarla mañana mismo.",
                              style: TextStyle(fontSize: 14, color: AppTheme.dark),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom + 16,
                left: 16,
                right: 16,
                top: 8,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Escribe un comentario...",
                        filled: true,
                        fillColor: AppTheme.neutralBg,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  CircleAvatar(
                    backgroundColor: AppTheme.greenDark,
                    child: IconButton(
                      icon: const Icon(Icons.send, color: Colors.white, size: 20),
                      onPressed: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Comentario enviado")),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      // title: "Comunidad", // Custom title with search
      child: Column(
        children: [
          const SizedBox(height: AppSpacing.md),
          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Buscar rutinas...",
                prefixIcon: const Icon(Icons.search, color: AppTheme.grayCustom),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          
          // Post List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(top: AppSpacing.sm),
              itemCount: _filteredPosts.length,
              itemBuilder: (context, index) {
                final post = _filteredPosts[index];
                return CommunityPostCard(
                  userName: post["userName"],
                  routineTitle: post["routineTitle"],
                  description: post["description"],
                  likes: post["likes"],
                  comments: post["comments"],
                  isLiked: post["isLiked"],
                  onLike: () => _toggleLike(index),
                  onComment: () => _showCommentDialog(context),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
