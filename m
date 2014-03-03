From: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Subject: Re: [PATCH] spi: xcomm: Remove duplicate code to set default bits_per_word
 and max speed
Date: Mon, 03 Mar 2014 09:54:21 +0100
Message-ID: <5314433D.10104@metafoo.de>
References: <1393771721.4044.7.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1393771721.4044.7.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 03/02/2014 03:48 PM, Axel Lin wrote:
> In the implementation of __spi_validate(), spi core will set transfer
> bits_per_word and max speed as spi device default if it is not set for
> this transfer. So we can remove the same logic in spi_xcomm_setup_transfer().
> Also remove a redundant code to initialize is_first variable.
>
> Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>

Acked-by: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>

> ---
>   drivers/spi/spi-xcomm.c | 12 ++++--------
>   1 file changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/spi/spi-xcomm.c b/drivers/spi/spi-xcomm.c
> index 350a76b..bb478dc 100644
> --- a/drivers/spi/spi-xcomm.c
> +++ b/drivers/spi/spi-xcomm.c
> @@ -73,15 +73,13 @@ static void spi_xcomm_chipselect(struct spi_xcomm *spi_xcomm,
>   static int spi_xcomm_setup_transfer(struct spi_xcomm *spi_xcomm,
>   	struct spi_device *spi, struct spi_transfer *t, unsigned int *settings)
>   {
> -	unsigned int speed;
> -
>   	if (t->len > 62)
>   		return -EINVAL;
>
> -	speed = t->speed_hz ? t->speed_hz : spi->max_speed_hz;
> +	if (t->speed_hz != spi_xcomm->current_speed) {
> +		unsigned int divider;
>
> -	if (speed != spi_xcomm->current_speed) {
> -		unsigned int divider = DIV_ROUND_UP(SPI_XCOMM_CLOCK, speed);
> +		divider = DIV_ROUND_UP(SPI_XCOMM_CLOCK, t->speed_hz);
>   		if (divider >= 64)
>   			*settings |= SPI_XCOMM_SETTINGS_CLOCK_DIV_64;
>   		else if (divider >= 16)
> @@ -89,7 +87,7 @@ static int spi_xcomm_setup_transfer(struct spi_xcomm *spi_xcomm,
>   		else
>   			*settings |= SPI_XCOMM_SETTINGS_CLOCK_DIV_4;
>
> -		spi_xcomm->current_speed = speed;
> +		spi_xcomm->current_speed = t->speed_hz;
>   	}
>
>   	if (spi->mode & SPI_CPOL)
> @@ -147,8 +145,6 @@ static int spi_xcomm_transfer_one(struct spi_master *master,
>   	int status = 0;
>   	bool is_last;
>
> -	is_first = true;
> -
>   	spi_xcomm_chipselect(spi_xcomm, spi, true);
>
>   	list_for_each_entry(t, &msg->transfers, transfer_list) {
>

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
