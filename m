From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 01/17 v2] spi: hspi: fixup long delay time
Date: Sat, 25 May 2013 10:47:40 +0900
Message-ID: <20130525014739.GA28458@verge.net.au>
References: <87li7fwgk8.wl%kuninori.morimoto.gx@renesas.com>
 <87d2si4cdn.wl%kuninori.morimoto.gx@renesas.com>
 <87bo824cbu.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Magnus <magnus.damm@gmail.com>,
	Linux-SH <linux-sh@vger.kernel.org>,
	Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Mark Brown <broonie@kernel.org>,
	Grant Likely <grant.likely@linaro.org>,
	spi-devel-general@lists.sourceforge.net
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87bo824cbu.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, May 22, 2013 at 08:14:33PM -0700, Kuninori Morimoto wrote:
> Current HSPI driver is using msleep(20) on hspi_status_check_timeout(),
> but it was too long delay for SPI device.
> Bock-W board SPI access was too slow without this patch.
> This patch uses udelay(10) for it.
> 
> Tested-by: Yusuke Goda <yusuke.goda.sx@renesas.com>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

I'm not quite sure of the history of this patch,
but I have added Mark Brown, Grant Likely and spi-devel-general
to the recipients of this email. Mark, Grant, is it possible
for you to pick this patch up?

> ---
> v1 -> v2
> 
>  - no change
> 
>  drivers/spi/spi-sh-hspi.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-sh-hspi.c b/drivers/spi/spi-sh-hspi.c
> index 60cfae5..eab593e 100644
> --- a/drivers/spi/spi-sh-hspi.c
> +++ b/drivers/spi/spi-sh-hspi.c
> @@ -89,7 +89,7 @@ static int hspi_status_check_timeout(struct hspi_priv *hspi, u32 mask, u32 val)
>  		if ((mask & hspi_read(hspi, SPSR)) == val)
>  			return 0;
>  
> -		msleep(20);
> +		udelay(10);
>  	}
>  
>  	dev_err(hspi->dev, "timeout\n");
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
