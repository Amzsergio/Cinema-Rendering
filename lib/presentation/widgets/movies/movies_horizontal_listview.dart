import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http_cinema/config/helpers/human_formats.dart';
import 'package:http_cinema/domain/entities/movie.dart';

class MoviesHorizontalListview extends StatefulWidget {
  final List<Movie> movies;
  final String? title;
  final String? subTitle;
  final VoidCallback? loadNextPage;

  const MoviesHorizontalListview({
    super.key,
    required this.movies,
    this.title,
    this.subTitle,
    this.loadNextPage,
  });

  @override
  State<MoviesHorizontalListview> createState() =>
      _MoviesHorizontalListviewState();
}

class _MoviesHorizontalListviewState extends State<MoviesHorizontalListview> {
  final scrollController = ScrollController();

  @override
  void initState() {
    scrollController.addListener(() {
      if (widget.loadNextPage == null) return;

      if (scrollController.position.pixels + 200 >=
          scrollController.position.maxScrollExtent) {
        widget.loadNextPage!();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Column(
        children: [
          if (widget.title != null || widget.subTitle != null)
            _Title(title: widget.title, subTitle: widget.subTitle),
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: widget.movies.length,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => FadeInRight(
                child: _Slide(
                  movie: widget.movies[index],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Movie movie;

  const _Slide({required this.movie});

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    final goldenColor = Colors.yellow.shade800;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: SizedBox(
              width: 150,
              height: 225,
              child: Image.network(
                movie.posterPath,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) {
                    // log('loading image: ${movie.title}');
                    return const Padding(
                      padding: EdgeInsets.all(8),
                      child: Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      ),
                    );
                  }
                  return GestureDetector(
                    onTap: () => context.push("/movie/${movie.id}"),
                    child: FadeIn(child: child),
                  );
                },
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
                  // log('error image: $exception');
                  return Image.network(
                    'https://img.freepik.com/premium-vector/error-404-with-cute-blue-sticky-notes-mascot_152558-79971.jpg?w=740',
                    fit: BoxFit.cover,
                  );
                },
                width: 150,
              ),
            ),
          ),
          const SizedBox(height: 5),
          SizedBox(
            width: 150,
            child: Text(
              movie.title,
              maxLines: 2,
              style: textStyles.bodySmall,
            ),
          ),
          SizedBox(
            width: 135,
            child: Row(
              children: [
                Icon(Icons.star_half_outlined, color: goldenColor),
                const SizedBox(width: 3),
                Text('${movie.voteAverage}',
                    style: textStyles.bodyMedium?.copyWith(color: goldenColor)),
                const Spacer(),
                Text(
                  HumanFormat.number(movie.voteCount),
                  style: textStyles.bodySmall,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  final String? title;
  final String? subTitle;

  const _Title({this.title, this.subTitle});

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          if (title != null)
            Text(
              title!,
              style: titleStyle,
            ),
          const Spacer(),
          if (subTitle != null)
            FilledButton.tonal(
              style: const ButtonStyle(visualDensity: VisualDensity.compact),
              child: Text(subTitle!),
              onPressed: () {},
            )
        ],
      ),
    );
  }
}
