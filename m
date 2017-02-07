From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 2/2] spi: s3c64xx: fix potential division by zero
Date: Tue, 7 Feb 2017 22:49:24 +0200
Message-ID: <20170207204924.4ns7di66fep3fwbi@kozik-lap>
References: <20170207081025.9671-1-andi.shyti@samsung.com>
 <CGME20170207081032epcas5p3af837bbe00278da4029fc7bb9eba6961@epcas5p3.samsung.com>
 <20170207081025.9671-2-andi.shyti@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Mark Brown <broonie@kernel.org>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        linux-samsung-soc@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andi Shyti <andi@etezian.org>
To: Andi Shyti <andi.shyti@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170207081025.9671-2-andi.shyti@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, Feb 07, 2017 at 05:10:25PM +0900, Andi Shyti wrote:
> Even though it's quite unlikely to happen in this particular
> case, clk_get_rate can return '0' if sdd->src_clk is not set
> properly. In that case we would have a clear division by '0'.
> 

I do not think it is possible.
	if (IS_ERR(sdd->src_clk)) {
		ret = PTR_ERR(sdd->src_clk);
		goto err_deref_master;
	}

> Check the return value of clk_get_rate and fail in case it
> returns '0'.
> 
> This patch fixes '1397922 Division or modulo by zero' from
> scan.coverity.com

It is a false positive.

Best regards,
Krzysztof

> 
> Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
> ---
>  drivers/spi/spi-s3c64xx.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index f6ea9ae047ec..a2ec07f44e33 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -811,6 +811,8 @@ static int s3c64xx_spi_setup(struct spi_device *spi)
>  
>  		/* Max possible */
>  		speed = clk_get_rate(sdd->src_clk) / 2 / (0 + 1);
> +		if (!speed)
> +			goto setup_exit;
>  
>  		if (spi->max_speed_hz > speed)
>  			spi->max_speed_hz = speed;
> -- 
> 2.11.0
> 
