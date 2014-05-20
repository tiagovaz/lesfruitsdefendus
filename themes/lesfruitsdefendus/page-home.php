<?php
/**
 * Template Name: Home Page
 * @package WordPress
 * @subpackage Twenty_Thirteen
 * @since Twenty Thirteen 1.0
 */



get_header(); ?>

	<div id="primary" class="content-area">
		
		<div id="content" class="site-content" role="main">
			
				<?php /* The loop */ ?>
				<?php 
				$nouvelles = new WP_Query(array(
				    'page_id' => 196,
				    'posts_per_page' => 6,
				));
				?>
				<?php while ( $nouvelles->have_posts() ) : $nouvelles->the_post(); ?>
					
					<article id="post-<?php the_ID(); ?>" <?php post_class(); ?>>
					
					<div class="entry-content">
						<div class="counter">
						<img src="<?php echo get_template_directory_uri(); ?>/images/counter.png">
						
						<h1>36 Kg</h1>
						<h2>recoltés</h2>
						</div>
						<?php the_content(); ?>
					</div><!-- .entry-content -->
				</article><!-- #post -->
				
				<?php endwhile; ?>
	

				
				<?php 
				$participer = new WP_Query(array(
				    'page_id' => 139,
				    'posts_per_page' => 6,
				));
				?>
				<?php while ( $participer->have_posts() ) : $participer->the_post(); ?>
				
					<article id="post-<?php the_ID(); ?>" <?php post_class(); ?>>
					<header class="entry-header">
						<h1 class="entry-title"><a href="<?php echo esc_url( get_permalink() ); ?>"><?php the_title(); ?></a></h1>
					</header><!-- .entry-header -->

					<div class="entry-content">
						<?php the_content(); ?>
					</div><!-- .entry-content -->
				</article><!-- #post -->
				
				<?php endwhile; ?>

				<?php 
				$calendrier = new WP_Query(array(
				    'page_id' => 323
				));
				?>
				<?php while ( $calendrier->have_posts() ) : $calendrier->the_post(); ?>
				
					<article id="post-<?php the_ID(); ?>" <?php post_class(); ?>>
					<header class="entry-header">
						<h1 class="entry-title"><a href="<?php echo esc_url( get_permalink() ); ?>"><?php the_title(); ?></a></h1>
					</header><!-- .entry-header -->

					<div class="entry-content">
						<?php the_content(); ?>
					</div><!-- .entry-content -->
				</article><!-- #post -->
				
				<?php endwhile; ?>

				<?php
			 	$terms = get_terms("category", array(
				 	'orderby'    => 'count',
				 	'hide_empty' => 0,
				 	'parent'	 => 0,
				 ));
			 	$count = count($terms); ?>
			 	
				<div class="entry-content" role="main">
					<header class="entry-header gallerie">
 						<h1 class="entry-title"><a href="<?php echo esc_url( get_permalink() ); ?>/medias">Nouvelles</a></h1>
					</header><!-- .entry-header -->
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
						<?php 
						$args = array('post_type' => 'post','showposts' => 6, 
					
						);
						$loop = new WP_Query( $args ); 
						?>
						<?php while ( $loop->have_posts() ) : $loop->the_post(); ?>
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
		</div><!-- #content -->
	</div><!-- #primary -->


<?php get_footer(); ?>

<script>
jQuery('body').removeClass('sidebar');
</script>