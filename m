From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: pxa2xx_spi: fix for SPI_CS_HIGH
Date: Fri, 8 May 2009 09:33:16 -0700
Message-ID: <200905080933.17128.david-b@pacbell.net>
References: <1241790769.10342.35.camel@brutus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>,
	spi-devel-general <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	openezx-devel <openezx-devel-ZwoEplunGu3n3BO9LpVK+9i2O/JbrIOy@public.gmane.org>,
	Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-arm-kernel <linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
To: Daniel Ribeiro <drwyrm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1241790769.10342.35.camel@brutus>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Friday 08 May 2009, Daniel Ribeiro wrote:
> Commit a7bb3909b3293d503211d7f6af8ed62c1644b686 introduces chipselect
> GPIO, and configures the CS polarity using SPI_CS_HIGH spi->mode flag,
> but the SPI_CS_HIGH is not allowed by setup().
> 
> Signed-off-by: Daniel Ribeiro <drwyrm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

This doesn't need to merge before 2.6.31, right?
(That is, is is true that nothing in mainline is
yet *relyings* on CS_HIGH working with this driver?)

Assuming that's true, this patch needs to be updated to
apply properly against modebits changes in the MM tree.


> 
> diff --git a/drivers/spi/pxa2xx_spi.c b/drivers/spi/pxa2xx_spi.c
> index 885194a..150f06b 100644
> --- a/drivers/spi/pxa2xx_spi.c
> +++ b/drivers/spi/pxa2xx_spi.c
> @@ -1186,7 +1186,7 @@ static int transfer(struct spi_device *spi, struct spi_message *msg)
>  }
>  
>  /* the spi->mode bits understood by this driver: */
> -#define MODEBITS (SPI_CPOL | SPI_CPHA)
> +#define MODEBITS (SPI_CPOL | SPI_CPHA | SPI_CS_HIGH)
>  
>  static int setup_cs(struct spi_device *spi, struct chip_data *chip,
>  		    struct pxa2xx_spi_chip *chip_info)
> 
> -- 
> Daniel Ribeiro
> 
> 



------------------------------------------------------------------------------
The NEW KODAK i700 Series Scanners deliver under ANY circumstances! Your
production scanning environment may not be a perfect world - but thanks to
Kodak, there's a perfect scanner to get the job done! With the NEW KODAK i700
Series Scanner you'll get full speed at 300 dpi even with all image 
processing features enabled. http://p.sf.net/sfu/kodak-com
