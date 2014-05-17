<?php
/**
 * The main template file
 *
 * This is the most generic template file in a WordPress theme and one of the
 * two required files for a theme (the other being style.css).
 * It is used to display a page when nothing more specific matches a query.
 * For example, it puts together the home page when no home.php file exists.
 *
 * @link http://codex.wordpress.org/Template_Hierarchy
 *
 * @package WordPress
 * @subpackage Twenty_Thirteen
 * @since Twenty Thirteen 1.0
 */

get_header(); ?>

	<div id="primary" class="content-area">
		<?php
			 	$terms = get_terms("category", array(
				 	'orderby'    => 'count',
				 	'hide_empty' => 0,
				 	'parent'	 => 0,
				 ));
			 	$count = count($terms); ?>
			 	
				<div id="content" class="site-content" role="main">

					<ul id="filters">
				 	<a href="#" data-filter="*" class="active">Show all |</a>
				 	<?php
				 	if ( $count > 0 ){
				    foreach ( $terms as $term ) {
				    $category_name = $term->name;
				    $category = $term->slug;
				    echo '<a href="#" data-filter=".'. $category .'">'. $category_name .' | </a>';   
				    }
				    echo "</ul>";
					}
					?>
					<div id="iso-content">
						<?php /* The loop */ ?>
			<?php while ( have_posts() ) : the_post(); ?>
						<div class="item normal element <?php foreach(get_the_category() as $category) {
						echo $category->slug . ' ';} ?>">
							<article id="post-<?php the_ID(); ?>" <?php post_class(); ?>>
								<header class="entry-header">
									<?php if ( has_post_thumbnail() && ! post_password_required() ) : ?>
									<div class="entry-thumbnail">
										<?php the_post_thumbnail(); ?>
									</div>
									<?php endif; ?>
									<h4 class="entry-title"><a href="<?php echo esc_url( get_permalink() ); ?>"><?php the_title(); ?></a></h4>
								</header><!-- .entry-header -->

								<div class="entry-content">
									
								</div><!-- .entry-content -->
								<footer class="entry-meta">
									
								</footer><!-- .entry-meta -->
							</article><!-- #post -->
						</div>
						<?php endwhile; ?>
					</div>
				</div><!-- #content -->
	</div><!-- #primary -->

<?php get_sidebar(); ?>
<?php get_footer(); ?>