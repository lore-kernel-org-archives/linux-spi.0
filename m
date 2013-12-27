From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH 4/5] spi: rspi: Use DUMMY_DATA macro instead of hardcoded value
Date: Fri, 27 Dec 2013 15:36:12 +0100
Message-ID: <51418828.lCh7RnWjxA@avalon>
References: <1387878574-21445-1-git-send-email-geert+renesas@linux-m68k.org> <1387878574-21445-5-git-send-email-geert+renesas@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1387878574-21445-5-git-send-email-geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Geert,

Thank you for the patch.

On Tuesday 24 December 2013 10:49:33 Geert Uytterhoeven wrote:
> Make it more obvious that this value is dummy data.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
> ---
>  drivers/spi/spi-rspi.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
> index 4e376db1ca4f..51fe3bdacb18 100644
> --- a/drivers/spi/spi-rspi.c
> +++ b/drivers/spi/spi-rspi.c
> @@ -149,6 +149,8 @@
>  #define SPBFCR_TXRST		0x80	/* qspi only */
>  #define SPBFCR_RXRST		0x40	/* qspi only */
> 
> +#define DUMMY_DATA		0x00
> +
>  struct rspi_data {
>  	void __iomem *addr;
>  	u32 max_speed_hz;
> @@ -541,7 +543,7 @@ static int rspi_receive_pio(struct rspi_data *rspi,
> struct spi_message *mesg, return -ETIMEDOUT;
>  		}
>  		/* dummy write for generate clock */
> -		rspi_write16(rspi, 0x00, RSPI_SPDR);
> +		rspi_write16(rspi, DUMMY_DATA, RSPI_SPDR);

Doesn't the comment make it obvious already ?

>  		if (rspi_wait_for_interrupt(rspi, SPSR_SPRF, SPCR_SPRIE) < 0) {
>  			dev_err(&rspi->master->dev,
> @@ -586,7 +588,7 @@ static int qspi_receive_pio(struct rspi_data *rspi,
> struct spi_message *mesg, return -ETIMEDOUT;
>  		}
>  		/* dummy write for generate clock */
> -		rspi_write8(rspi, 0x00, RSPI_SPDR);
> +		rspi_write8(rspi, DUMMY_DATA, RSPI_SPDR);
> 
>  		if (rspi_wait_for_interrupt(rspi, SPSR_SPRF, SPCR_SPRIE) < 0) {
>  			dev_err(&rspi->master->dev,
-- 
Regards,

Laurent Pinchart

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
