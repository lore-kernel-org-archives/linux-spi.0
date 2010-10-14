From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [Patch] atmel_spi.c - let transfers through if not changing
	bits_per_word
Date: Wed, 13 Oct 2010 23:16:06 -0600
Message-ID: <20101014051606.GA2248@angua.secretlab.ca>
References: <4CB5D566.2040301@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: drivers-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org, David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	kernel-o2ulR9ObcgE/ohRxsw7f2g@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	matthias <mensch0815-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>,
	Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
	Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4CB5D566.2040301-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, Oct 13, 2010 at 05:51:02PM +0200, Matthias Brugger wrote:
> - bits_per_word option in spi_transfer are allowed if it does not change
> the csr register.
> 
> This is necessary for the driver in
> drivers/staging/iio/adis16260_core.c, as it uses this option.
> 
> Signed-off-by: Matthias Brugger <mensch0815-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Applied, thanks.

However, the patch is line-wrap damaged and I needed to fix it up by
hand.  Please check your email client configuration.

g.

> ---
>  drivers/spi/atmel_spi.c |   14 +++++++++++++-
>  1 files changed, 13 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/spi/atmel_spi.c b/drivers/spi/atmel_spi.c
> index c4e0442..5c03a5b 100644
> --- a/drivers/spi/atmel_spi.c
> +++ b/drivers/spi/atmel_spi.c
> @@ -654,6 +654,8 @@ static int atmel_spi_transfer(struct spi_device
> *spi, struct spi_message *msg)
>  	struct spi_transfer	*xfer;
>  	unsigned long		flags;
>  	struct device		*controller = spi->master->dev.parent;
> +	u8			bits;
> +	struct atmel_spi_device	*asd;
> 
>  	as = spi_master_get_devdata(spi->master);
> 
> @@ -672,8 +674,18 @@ static int atmel_spi_transfer(struct spi_device
> *spi, struct spi_message *msg)
>  			return -EINVAL;
>  		}
> 
> +		if (xfer->bits_per_word) {
> +			asd = spi->controller_state;
> +			bits = (asd->csr >> 4) & 0xf;
> +			if (bits != xfer->bits_per_word - 8) {
> +				dev_dbg(&spi->dev, "you can't yet change "
> +					 "bit_per_word in transfers\n");
> +				return -ENOPROTOOPT;
> +			}
> +		}
> +
>  		/* FIXME implement these protocol options!! */
> -		if (xfer->bits_per_word || xfer->speed_hz) {
> +		if (xfer->speed_hz) {
>  			dev_dbg(&spi->dev, "no protocol options yet\n");
>  			return -ENOPROTOOPT;
>  		}
> -- 
> 1.5.6.5

------------------------------------------------------------------------------
Beautiful is writing same markup. Internet Explorer 9 supports
standards for HTML5, CSS3, SVG 1.1,  ECMAScript5, and DOM L2 & L3.
Spend less time writing and  rewriting code and more time creating great
experiences on the web. Be a part of the beta today.
http://p.sf.net/sfu/beautyoftheweb
