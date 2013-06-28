From: Ryan Mallon <rmallon-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/8] spi: spi-ep93xx: use read,write instead of __raw_*
	variants
Date: Sat, 29 Jun 2013 09:15:09 +1000
Message-ID: <51CE18FD.8010806@gmail.com>
References: <201306281142.36525.hartleys@visionengravers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	mika.westerberg-X3B1VOXEql0@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	Linux Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: H Hartley Sweeten <hartleys-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <201306281142.36525.hartleys-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 29/06/13 04:42, H Hartley Sweeten wrote:

> The memory resource used by this driver is ioremap()'d and the normal
> read,write calls can be used instead of the __raw_* variants.
> 
> Remove the inline read,write helpers and just do the read,write
> directly in the callers.
> 
> Signed-off-by: H Hartley Sweeten <hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
> Cc: Ryan Mallon <rmallon-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Mika Westerberg <mika.westerberg-X3B1VOXEql0@public.gmane.org>
> Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Cc: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>  drivers/spi/spi-ep93xx.c | 64 +++++++++++++++---------------------------------
>  1 file changed, 20 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/spi/spi-ep93xx.c b/drivers/spi/spi-ep93xx.c
> index d7bac60..c633cd0 100644
> --- a/drivers/spi/spi-ep93xx.c
> +++ b/drivers/spi/spi-ep93xx.c
> @@ -158,30 +158,6 @@ struct ep93xx_spi_chip {
>  /* converts bits per word to CR0.DSS value */
>  #define bits_per_word_to_dss(bpw)	((bpw) - 1)
>  
> -static inline void
> -ep93xx_spi_write_u8(const struct ep93xx_spi *espi, u16 reg, u8 value)
> -{
> -	__raw_writeb(value, espi->regs_base + reg);
> -}
> -
> -static inline u8
> -ep93xx_spi_read_u8(const struct ep93xx_spi *spi, u16 reg)
> -{
> -	return __raw_readb(spi->regs_base + reg);
> -}


Is there a particular reason to drop these functions? It's basically just
bike-shedding, but they can make the code more readable at very little
cost. Even dropping the inline (which is preferred nowdays) the compiler
will still inline these, and it would also make this patch much smaller
to keep them.

~Ryan

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
