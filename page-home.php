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
						<?php the_content(); ?>
					</div><!-- .entry-content -->
				</article><!-- #post -->
				</article><!-- #post -->
				
				<?php endwhile; ?>
				<?php 
				$nouvelles = new WP_Query(array(
				    'page_id' => 155,
				    'posts_per_page' => 6,
				));
				?>
				<?php while ( $nouvelles->have_posts() ) : $nouvelles->the_post(); ?>
				
					<article id="post-<?php the_ID(); ?>" <?php post_class(); ?>>
					<header class="entry-header">
						<?php if ( has_post_thumbnail() && ! post_password_required() ) : ?>
						<div class="entry-thumbnail">
							<?php the_post_thumbnail(); ?>
						</div>
						<?php endif; ?>

						<h1 class="entry-title"><a href="<?php echo esc_url( get_permalink() ); ?>"><?php the_title(); ?></a></h1>
					</header><!-- .entry-header -->

					<div class="entry-content">
						<?php the_excerpt(); ?>
						<?php wp_link_pages( array( 'before' => '<div class="page-links"><span class="page-links-title">' . __( 'Pages:', 'twentythirteen' ) . '</span>', 'after' => '</div>', 'link_before' => '<span>', 'link_after' => '</span>' ) ); ?>
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
				<?php ?>
				<?php 
				$agenda = new WP_Query(array(
				    'page_id' => 147,
				    'posts_per_page' => 6,
				));
				?>
				<?php while ( $agenda->have_posts() ) : $agenda->the_post(); ?>
				
					<article id="post-<?php the_ID(); ?>" <?php post_class(); ?>>
					<header class="entry-header">
						<?php if ( has_post_thumbnail() && ! post_password_required() ) : ?>
						<div class="entry-thumbnail">
							<?php the_post_thumbnail(); ?>
						</div>
						<?php endif; ?>
						<h1 class="entry-title"><a href="<?php echo esc_url( get_permalink() ); ?>"><?php the_title(); ?></a></h1>
					</header><!-- .entry-header -->

					<div class="entry-content">
						<?php the_content(); ?>
						<?php wp_link_pages( array( 'before' => '<div class="page-links"><span class="page-links-title">' . __( 'Pages:', 'twentythirteen' ) . '</span>', 'after' => '</div>', 'link_before' => '<span>', 'link_after' => '</span>' ) ); ?>
					</div><!-- .entry-content -->
				</article><!-- #post -->
				
				<?php endwhile; ?>
				<?php ?>

				<?php
			 	$terms = get_terms("category", array(
				 	'orderby'    => 'count',
				 	'hide_empty' => 0,
				 	'parent'	 => 0,
				 ));
			 	$count = count($terms); ?>
			 	
				<div class="entry-content" role="main">
					<header class="entry-header gallerie">
 						<h1 class="entry-title"><a href="<?php echo esc_url( get_permalink() ); ?>/medias">Articles</a></h1>
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
						$args = array(
						'tax_query' => array(
								array( 'taxonomy' => 'post_format',
									  'field' => 'slug',
									  'terms' => array('post-format-video','post-format-gallery'),
									  )
								)
						);
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
									<h4 class="entry-title"><a href="<?php echo esc_url( get_permalink() ); ?>"><?php the_title(); ?></a></h4>
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
		</div><!-- #content -->
	</div><!-- #primary -->

<?php get_sidebar(); ?>
<?php get_footer(); ?>