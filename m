From: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Subject: Re: [PATCH v2 lora-next 1/4] net: lora: sx1301: convert burst spi
 functions to regmap raw
Date: Wed, 10 Oct 2018 09:59:29 +0200
Message-ID: <3959c93b-edb5-c6ff-ec36-57f84ab8623f@suse.de>
References: <1539089532-2481-1-git-send-email-ben.whitten@lairdtech.com>
 <1539089532-2481-2-git-send-email-ben.whitten@lairdtech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: starnight@g.ncu.edu.tw, hasnain.virk@arm.com,
        netdev@vger.kernel.org, liuxuenetmail@gmail.com, shess@hessware.de,
        Ben Whitten <ben.whitten@lairdtech.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Stefan Popa <stefan.popa@analog.com>
To: Ben Whitten <ben.whitten@gmail.com>,
        Mark Brown <broonie@kernel.org>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1539089532-2481-2-git-send-email-ben.whitten@lairdtech.com>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Ben and Mark,

Am 09.10.18 um 14:52 schrieb Ben Whitten:
> As we have caching disabled we can access the regmap using raw for our
> firmware reading and writing bursts.
> We also remove the now defunct spi element from the structure as this
> completes the move to regmap.
> 
> Signed-off-by: Ben Whitten <ben.whitten@lairdtech.com>
> ---
>  drivers/net/lora/sx1301.c | 26 +++++++++++++++++---------
>  drivers/net/lora/sx1301.h |  2 --
>  2 files changed, 17 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/lora/sx1301.c b/drivers/net/lora/sx1301.c
> index fd29258..5ab0e2d 100644
> --- a/drivers/net/lora/sx1301.c
> +++ b/drivers/net/lora/sx1301.c
> @@ -76,19 +76,28 @@ static struct regmap_config sx1301_regmap_config = {
>  
>  static int sx1301_read_burst(struct sx1301_priv *priv, u8 reg, u8 *val, size_t len)
>  {
> -	u8 addr = reg & 0x7f;
> -	return spi_write_then_read(priv->spi, &addr, 1, val, len);
> +	size_t max;
> +
> +	max = regmap_get_raw_read_max(priv->regmap);
> +	if (max && max < len) {
> +		dev_err(priv->dev, "Burst greater then max raw read\n");
> +		return -EINVAL;
> +	}
> +
> +	return regmap_raw_read(priv->regmap, reg, val, len);

I believe the way we are using it with a single register needs
regmap_noinc_read() instead, in case we ever want to enable caching? ...

>  }
>  
>  static int sx1301_write_burst(struct sx1301_priv *priv, u8 reg, const u8 *val, size_t len)
>  {
> -	u8 addr = reg | BIT(7);
> -	struct spi_transfer xfr[2] = {
> -		{ .tx_buf = &addr, .len = 1 },
> -		{ .tx_buf = val, .len = len },
> -	};
> +	size_t max;
> +
> +	max = regmap_get_raw_write_max(priv->regmap);
> +	if (max && max < len) {
> +		dev_err(priv->dev, "Burst greater then max raw write\n");
> +		return -EINVAL;
> +	}
>  
> -	return spi_sync_transfer(priv->spi, xfr, 2);
> +	return regmap_raw_write(priv->regmap, reg, val, len);

... Which would mean we are lacking a noinc API for write here!

@Mark/Stefan, any reason noinc was not implemented symmetrically?

For sx1276 I have local regmap conversion patches, but I kept getting
-EINVAL for bursts and haven't figured out why yet. Need to compare to
your code - I assume you successfully tested this, Ben.

Regards,
Andreas

>  }
>  
>  static int sx1301_soft_reset(struct sx1301_priv *priv)
> @@ -566,7 +575,6 @@ static int sx1301_probe(struct spi_device *spi)
>  
>  	spi_set_drvdata(spi, netdev);
>  	priv->dev = &spi->dev;
> -	priv->spi = spi;
>  
>  	priv->regmap = devm_regmap_init_spi(spi, &sx1301_regmap_config);
>  	if (IS_ERR(priv->regmap)) {
> diff --git a/drivers/net/lora/sx1301.h b/drivers/net/lora/sx1301.h
> index e939c02..e6400f8 100644
> --- a/drivers/net/lora/sx1301.h
> +++ b/drivers/net/lora/sx1301.h
> @@ -12,7 +12,6 @@
>  #include <linux/regmap.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/lora/dev.h>
> -#include <linux/spi/spi.h>
>  
>  #define SX1301_CHIP_VERSION 103
>  
> @@ -64,7 +63,6 @@
>  struct sx1301_priv {
>  	struct lora_dev_priv lora;
>  	struct device		*dev;
> -	struct spi_device	*spi;
>  	struct gpio_desc *rst_gpio;
>  	struct regmap		*regmap;
>  };
> 


-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
