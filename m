From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi: rockchip: return 0 if tx_buf and rx_buf are NULL
Date: Thu, 14 Aug 2014 13:09:36 -0700
Message-ID: <20140814200936.GA13458@core.coreip.homeip.net>
References: <1407977544-2989-1-git-send-email-addy.ke@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org,
	grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, hj-TNX95d0MmH7DzftRWevZcw@public.gmane.org, kever.yang-TNX95d0MmH7DzftRWevZcw@public.gmane.org,
	xjq-TNX95d0MmH7DzftRWevZcw@public.gmane.org, huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, zyw-TNX95d0MmH7DzftRWevZcw@public.gmane.org,
	yzq-TNX95d0MmH7DzftRWevZcw@public.gmane.org, zhenfu.fang-TNX95d0MmH7DzftRWevZcw@public.gmane.org, cf-TNX95d0MmH7DzftRWevZcw@public.gmane.org,
	zhangqing-TNX95d0MmH7DzftRWevZcw@public.gmane.org, hl-TNX95d0MmH7DzftRWevZcw@public.gmane.org, wei.luo-TNX95d0MmH7DzftRWevZcw@public.gmane.org
To: Addy Ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1407977544-2989-1-git-send-email-addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Addy,

On Thu, Aug 14, 2014 at 08:52:24AM +0800, Addy Ke wrote:
> To do so, spi communication can use an empty buf to pull up CS.
> 
> This patch merged from ChromiumOS tree.
> Cros_ec use this function to turn off CS and add a delay to ensure
> the rising edge doesn't come too soon after the end of the data.
> 
> Tested-by: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> Signed-off-by: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> Signed-off-by: Addy Ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> ---
>  drivers/spi/spi-rockchip.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
> index 72fb287..1e3bcfa 100644
> --- a/drivers/spi/spi-rockchip.c
> +++ b/drivers/spi/spi-rockchip.c
> @@ -511,8 +511,8 @@ static int rockchip_spi_transfer_one(struct spi_master *master,
>  	WARN_ON((readl_relaxed(rs->regs + ROCKCHIP_SPI_SR) & SR_BUSY));
>  
>  	if (!xfer->tx_buf && !xfer->rx_buf) {
> -		dev_err(rs->dev, "No buffer for transfer\n");
> -		return -EINVAL;
> +		dev_dbg(rs->dev, "No buffer for transfer\n");
> +		return 0;
>  	}

Maybe we should only return 0 if xfer->len is also 0, otherwise keep
complaining loudly?

	if (!xfer->tx_buf && !xfer->rx_buf) {
		if (xfer->len == 0)
			return 0;

		dev_err(rs->dev, "Missing transfer buffer\n");
		return -EINVAL;
	}

Thanks.

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
