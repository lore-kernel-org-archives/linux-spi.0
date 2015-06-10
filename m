From: Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 3/4] spi: davinci: change the lower limit of pre-scale
 divider to 1
Date: Wed, 10 Jun 2015 03:22:50 -0400
Message-ID: <5577E5CA.80902@ti.com>
References: <1433920705-13068-1-git-send-email-m-karicheri2@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
To: <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1433920705-13068-1-git-send-email-m-karicheri2-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 06/10/2015 03:18 AM, Murali Karicheri wrote:
> SPI hardware spec for Keystone specifies a lower value of 0 for pre-scale
> divider that is used for generating spi clock which translates to a
> clock divider of 2. So fix the lower limit to allow using a higher SPI
> clock.
>
> Signed-off-by: Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
> Acked-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
> ---
>   drivers/spi/spi-davinci.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
> index 5e99106..987afeb 100644
> --- a/drivers/spi/spi-davinci.c
> +++ b/drivers/spi/spi-davinci.c
> @@ -265,7 +265,7 @@ static inline int davinci_spi_get_prescale(struct davinci_spi *dspi,
>
>   	ret = DIV_ROUND_UP(clk_get_rate(dspi->clk), max_speed_hz);
>
> -	if (ret < 3 || ret > 256)
> +	if (ret < 1 || ret > 256)
>   		return -EINVAL;
>
>   	return ret - 1;
>
Please ignore this as I messed up the PATCH prefix. I will re-send it 
with v1 and some updates to the commit log.

-- 
Murali Karicheri
Linux Kernel, Keystone
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
