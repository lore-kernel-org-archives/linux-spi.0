From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 3/3] SPI: spi_sh_msiof: fix wrong address calculation,
 which leads to an Oops
Date: Fri, 21 Jan 2011 09:27:43 -0700
Message-ID: <20110121162743.GA7477@angua.secretlab.ca>
References: <Pine.LNX.4.64.1101211655550.18867@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: spi-devel-general@lists.sourceforge.net, linux-sh@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1101211655550.18867@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, Jan 21, 2011 at 04:56:47PM +0100, Guennadi Liakhovetski wrote:
> NULL + <small offset> != NULL, but reading from that <small offset> address
> is usually not a very good idea and often leads to problems, like kernel
> Oopses in this case, easily reproducible by writing to an SD-card, used in
> SPI mode.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Applied, thanks.  Since this is an oops fix, I'll push this one to
Linus before the next -rc.  The other two can go into linux-next for
2.6.39.

g.

> ---
>  drivers/spi/spi_sh_msiof.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi_sh_msiof.c b/drivers/spi/spi_sh_msiof.c
> index 658bd05..6d30829 100644
> --- a/drivers/spi/spi_sh_msiof.c
> +++ b/drivers/spi/spi_sh_msiof.c
> @@ -568,9 +568,11 @@ static int sh_msiof_spi_txrx(struct spi_device *spi, struct spi_transfer *t)
>  	bytes_done = 0;
>  
>  	while (bytes_done < t->len) {
> +		void *rx_buf = t->rx_buf ? t->rx_buf + bytes_done : NULL;
> +		const void *tx_buf = t->tx_buf ? t->tx_buf + bytes_done : NULL;
>  		n = sh_msiof_spi_txrx_once(p, tx_fifo, rx_fifo,
> -					   t->tx_buf + bytes_done,
> -					   t->rx_buf + bytes_done,
> +					   tx_buf,
> +					   rx_buf,
>  					   words, bits);
>  		if (n < 0)
>  			break;
> -- 
> 1.7.2.3
> 
> 
> ------------------------------------------------------------------------------
> Special Offer-- Download ArcSight Logger for FREE (a $49 USD value)!
> Finally, a world-class log management solution at an even better price-free!
> Download using promo code Free_Logger_4_Dev2Dev. Offer expires 
> February 28th, so secure your free ArcSight Logger TODAY! 
> http://p.sf.net/sfu/arcsight-sfd2d
> _______________________________________________
> spi-devel-general mailing list
> spi-devel-general@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/spi-devel-general
