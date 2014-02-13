From: Andreas Larsson <andreas-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2] spi: fsl-spi: Convert to let spi core validate xfer->bits_per_word
Date: Thu, 13 Feb 2014 10:20:17 +0100
Message-ID: <52FC8E51.2040307@gaisler.com>
References: <1392280906.8200.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1392280906.8200.0.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 2014-02-13 09:41, Axel Lin wrote:
> Set bits_per_word_mask so spi core will reject transfers that attempt to use
> an unsupported bits_per_word value.
>
> Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
> ---
> v2:
> Make sure bits_per_word can not be greater than mpc8xxx_spi->max_bits_per_word.
>
>   drivers/spi/spi-fsl-spi.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
> index 4dcb292..c4f9143 100644
> --- a/drivers/spi/spi-fsl-spi.c
> +++ b/drivers/spi/spi-fsl-spi.c
> @@ -239,10 +239,7 @@ static int fsl_spi_setup_transfer(struct spi_device *spi,
>   	if (!bits_per_word)
>   		bits_per_word = spi->bits_per_word;
>
> -	/* Make sure its a bit width we support [4..16, 32] */
> -	if ((bits_per_word < 4)
> -	    || ((bits_per_word > 16) && (bits_per_word != 32))
> -	    || (bits_per_word > mpc8xxx_spi->max_bits_per_word))
> +	if (bits_per_word > mpc8xxx_spi->max_bits_per_word)
>   		return -EINVAL;

Instead of keeping this check here...

>
>   	if (!hz)
> @@ -631,6 +628,8 @@ static struct spi_master * fsl_spi_probe(struct device *dev,
>
>   	master->setup = fsl_spi_setup;
>   	master->cleanup = fsl_spi_cleanup;
> +	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 16) |
> +				     SPI_BPW_MASK(32);
>
>   	mpc8xxx_spi = spi_master_get_devdata(master);
>   	mpc8xxx_spi->spi_do_one_msg = fsl_spi_do_one_msg;
>

...I think it would be better to take max_bits_per_word into account 
when setting up master->bits_per_word_mask so that it tells the whole truth.

For instance:
	master->bits_per_word_mask =
		(SPI_BPW_RANGE_MASK(4, 16) | SPI_BPW_MASK(32)) &
		SPI_BPW_RANGE_MASK(1, mpc8xxx_spi->max_bits_per_word);

It then needs to be set it up later in fsl_spi_probe. After the call to 
fsl_spi_grlib_probe(), max_bits_per_word is never changed anymore.

Best regards,
Andreas Larsson
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
