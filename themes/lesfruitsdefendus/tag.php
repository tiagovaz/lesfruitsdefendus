<?php
/**
 * The template for displaying Tag pages
 *
 * Used to display archive-type pages for posts in a tag.
 *
 * @link http://codex.wordpress.org/Template_Hierarchy
 *
 * @package WordPress
 * @subpackage Twenty_Thirteen
 * @since Twenty Thirteen 1.0
 */

get_header(); ?>

	<div id="primary" class="content-area">
		<div id="content" class="site-content" role="main">

		<?php if ( have_posts() ) : ?>
			<header class="archive-header">
				<h1 class="archive-title"><?php printf( __( 'Tag Archives: %s', 'twentythirteen' ), single_tag_title( '', false ) ); ?></h1>

				<?php if ( tag_description() ) : // Show an optional tag description ?>
				<div class="archive-meta"><?php echo tag_description(); ?></div>
				<?php endif; ?>
			</header><!-- .archive-header -->
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
			<?php twentythirteen_paging_nav(); ?>

		<?php else : ?>
			<?php get_template_part( 'content', 'none' ); ?>
		<?php endif; ?>

		</div><!-- #content -->
	</div><!-- #primary -->

<?php get_sidebar(); ?>
<?php get_footer(); ?>