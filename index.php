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
						<?php if ( has_post_thumbnail() && ! post_password_required() ) {$thumb_id = get_post_thumbnail_id();
							$thumb_url_array = wp_get_attachment_image_src($thumb_id, 'thumbnail-size', true);
							$thumb_url = $thumb_url_array[0];
							$style = "
							background:url('".$thumb_url."');background-size:cover;"; } 
							else {$style = "background-color:#fff;background-size:cover"; ;}
							
							 ?>
							<article  style=" position:relative;
    position:absolute;
    z-index:9999;
    filter: blur(0px);" id="post-<?php the_ID(); ?>" <?php post_class(); ?>>
								<div style="<?php echo $style;?>;width: 100%;height: 100%;" class="thumbnailblur">

								<div style=" position:relative;
    position:absolute;
    z-index:9999;
    width: 100%;
	height: 100%;
	background-color: rgba(255, 255, 255, 0.1);">
								<header class="entry-header" class="background-color: rgba(255, 255, 255, 0.8);width:100%">
									
									
									<h5 class="entry-title"><a href="<?php echo esc_url( get_permalink() ); ?>"><?php the_title(); ?></a></h5>
								</header><!-- .entry-header -->

								<div class="entry-content">
								
								</div><!-- .entry-content -->
								<footer class="entry-meta">
									
								</footer><!-- .entry-meta -->
								</div>
								</div>
							</article><!-- #post -->
						</div>
						<?php endwhile; ?>
					</div>
				</div><!-- #content -->
	</div><!-- #primary -->

<?php get_sidebar(); ?>
<?php get_footer(); ?>