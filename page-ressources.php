<?php
/**
 * Template Name: Ressource Page
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
		<div id="content" class="site-content" role="main">
			<div id="iso-content">
				<?php /* The loop */ ?>
				<?php
				$args = array( 'post_type' => array('recette','lecture','bonplans'));
				$loop = new WP_Query( $args ); 
				?>
				<?php while ( $loop->have_posts() ) : $loop->the_post(); ?>
				<div class="item normal element <?php foreach(get_the_category() as $category) {
				echo $category->slug . ' ';} ?>">
					<article id="post-<?php the_ID(); ?>" <?php post_class(); ?>>
						<header class="entry-header">
							<?php if ( has_post_thumbnail() && ! post_password_required() ) : ?>
							<div class="entry-thumbnail">
								<?php the_post_thumbnail(); ?>
							</div>
							<?php endif; ?>
							<h3 class="entry-title"><a href="<?php echo esc_url( get_permalink() ); ?>"><?php the_title(); ?></a></h3>
						</header><!-- .entry-header -->

						<div class="entry-content">
							<?php the_excerpt(); ?>
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