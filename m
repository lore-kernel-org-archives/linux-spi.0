From: dmitry pervushin <dpervushin-L1vi/lXTdtvkgf6YlCu6wwC/G2K4zDHf@public.gmane.org>
Subject: Re: [PATCH] Freescale STMP spi driver, revised
Date: Fri, 03 Jul 2009 14:23:00 +0400
Message-ID: <1246616580.3709.17.camel@hp.diimka.lan>
References: <1243971638.4011.16.camel@hp.diimka.lan>
	<20090603042746.GB8721@tarshish>
	<1244045746.4074.5.camel@hp.diimka.lan>
	<200907022147.44892.david-b@pacbell.net>
Reply-To: dpervushin-L1vi/lXTdtvkgf6YlCu6wwC/G2K4zDHf@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200907022147.44892.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Thanks for your attention; I tested the change on the board and the
updated patch is in the following message.

On Thu, 2009-07-02 at 21:47 -0700, David Brownell wrote:
> On Wednesday 03 June 2009, dmitry pervushin wrote:
> > Add the SPI driver for Freescale STMP 3xxx-based boards
> > 
> > Signed-off-by: dmitry pervushin <dpervushin-L1vi/lXTdtvkgf6YlCu6wwC/G2K4zDHf@public.gmane.org>
> 
> Needs the appended fixups for current kernels ...
> technical comments in a bit.
> 
> - Dave
> 
> 
> --- g26.orig/drivers/spi/spi_stmp.c	2009-07-02 21:46:32.000000000 -0700
> +++ g26/drivers/spi/spi_stmp.c	2009-07-02 21:22:25.000000000 -0700
> @@ -171,22 +171,16 @@ static int stmp_spi_setup_transfer(struc
>  	return 0;
>  }
>  
> -/* the spi->mode bits understood by this driver: */
> -#define MODEBITS (SPI_CPOL | SPI_CPHA)
>  static int stmp_spi_setup(struct spi_device *spi)
>  {
> -	struct stmp_spi *ss;
> -
> -	ss = spi_master_get_devdata(spi->master);
> -	if (!spi->bits_per_word)
> -		spi->bits_per_word = 8;
> -	if (spi->mode & ~MODEBITS) {
> -		dev_err(&spi->dev, "%s: unsupported mode bits %x\n",
> -			__func__, spi->mode & ~MODEBITS);
> +	/* spi_setup() does basic checks,
> +	 * stmp_spi_setup_transfer() does more later
> +	 */
> +	if (spi->bits_per_word != 8) {
> +		dev_err(&spi->dev, "%s, unsupported bits_per_word=%d\n",
> +			__func__, bits_per_word);
>  		return -EINVAL;
>  	}
> -	dev_dbg(&spi->dev, "%s, mode %d, %u bits/w\n",
> -		__func__, spi->mode & MODEBITS, spi->bits_per_word);
>  	return 0;
>  }
>  
> @@ -497,6 +491,8 @@ static int __devinit stmp_spi_probe(stru
>  	master->transfer = stmp_spi_transfer;
>  	master->setup = stmp_spi_setup;
>  
> +	/* the spi->mode bits understood by this driver: */
> +	master->mode_bits = SPI_CPOL | SPI_CPHA;
>  
>  	ss->irq = platform_get_irq(dev, 0);
>  	if (ss->irq < 0) {
> 


------------------------------------------------------------------------------
