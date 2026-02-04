part of '../../discover_page.dart';

final class _PosterRow extends StatelessWidget {
  const _PosterRow({required this.works});

  final List<Work> works;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemCount: works.length,
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final work = works[index];
          return _PosterItem(work: work);
        },
      ),
    );
  }
}
