From: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Subject: Re: [patch 2.6.25-rc9 1/3] spi_s3c24xx must
 initialize num_chipselect
Date: Tue, 15 Apr 2008 12:30:06 -0700
Message-ID: <20080415123006.b8e229d6.akpm@linux-foundation.org>
References: <200804151056.43830.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200804151056.43830.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org


The title is "spi_s3c24xx must initialize num_chipselect"


On Tue, 15 Apr 2008 10:56:43 -0700
David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> wrote:

> From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
> 
> The s3c24xx_spi_txrx() function should initialise the completion
> each time before using it, otherwise we end up with the possibility
> of returning success before the interrupt handler has processed
> all the data.
> 
> Signed-off-by: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
> Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
> ---
>  drivers/spi/spi_s3c24xx.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> --- at91.orig/drivers/spi/spi_s3c24xx.c	2008-04-15 10:30:32.000000000 -0700
> +++ at91/drivers/spi/spi_s3c24xx.c	2008-04-15 10:30:35.000000000 -0700
> @@ -192,8 +192,11 @@ static int s3c24xx_spi_txrx(struct spi_d
>  	hw->len = t->len;
>  	hw->count = 0;
>  
> +	init_completion(&hw->done);
> +
>  	/* send the first byte */
>  	writeb(hw_txbyte(hw, 0), hw->regs + S3C2410_SPTDAT);
> +
>  	wait_for_completion(&hw->done);
>  
>  	return hw->count;

But you (re)sent a copy of "spi_s3c24xx driver must init completion"

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
