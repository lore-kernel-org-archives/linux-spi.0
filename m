From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 1/4 v2] spi/bfin_spi: fix handling
 of default bits per word setting
Date: Fri, 17 Jun 2011 08:37:19 -0600
Message-ID: <20110617143719.GA21412@ponder.secretlab.ca>
References: <1308298618-23461-1-git-send-email-vapier@gentoo.org>
	<1308299737-3806-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
        David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
        uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
To: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1308299737-3806-1-git-send-email-vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://blackfin.uclinux.org/mailman/options/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://blackfin.uclinux.org/pipermail/uclinux-dist-devel>
List-Post: <mailto:uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
List-Help: <mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Errors-To: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Fri, Jun 17, 2011 at 04:35:37AM -0400, Mike Frysinger wrote:
> The default bits per word setting should be 8 bits, but since most of our
> devices have been explicitly setting this up, we didn't notice when the
> default stopped working.
> 
> At the moment, any default transfers without an explicit bit size setting
> error out with:
> bfin-spi bfin-spi.0: transfer: unsupported bits_per_word
> 
> So in the transfer logic, have a bits_per_word setting of 0 fall into the
> 8 bit transfer logic.
> 
> Signed-off-by: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>

Merged for v3.0, thanks.

g.

> ---
> v2
> 	- wasn't quite as simple as i'd hope ...
> 
>  drivers/spi/spi_bfin5xx.c |    7 ++++---
>  1 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/spi/spi_bfin5xx.c b/drivers/spi/spi_bfin5xx.c
> index ae30fa3..1f123b9 100644
> --- a/drivers/spi/spi_bfin5xx.c
> +++ b/drivers/spi/spi_bfin5xx.c
> @@ -681,13 +681,14 @@ static void bfin_spi_pump_transfers(unsigned long data)
>  	drv_data->cs_change = transfer->cs_change;
>  
>  	/* Bits per word setup */
> -	bits_per_word = transfer->bits_per_word ? : message->spi->bits_per_word;
> -	if ((bits_per_word > 0) && (bits_per_word % 16 == 0)) {
> +	bits_per_word = transfer->bits_per_word ? :
> +		message->spi->bits_per_word ? : 8;
> +	if (bits_per_word % 16 == 0) {
>  		drv_data->n_bytes = bits_per_word/8;
>  		drv_data->len = (transfer->len) >> 1;
>  		cr_width = BIT_CTL_WORDSIZE;
>  		drv_data->ops = &bfin_bfin_spi_transfer_ops_u16;
> -	} else if ((bits_per_word > 0) && (bits_per_word % 8 == 0)) {
> +	} else if (bits_per_word % 8 == 0) {
>  		drv_data->n_bytes = bits_per_word/8;
>  		drv_data->len = transfer->len;
>  		cr_width = 0;
> -- 
> 1.7.5.3
> 
