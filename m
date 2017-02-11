From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH v3 2/2] mtd: m25p80: Added pm ops support
Date: Sat, 11 Feb 2017 13:10:35 +0100
Message-ID: <0e0edea3-7dfe-bc10-eaa3-18330ae06874@denx.de>
References: <1486763369-31969-1-git-send-email-kdasu.kdev@gmail.com>
 <1486763369-31969-3-git-send-email-kdasu.kdev@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
        bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org
To: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1486763369-31969-3-git-send-email-kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 02/10/2017 10:49 PM, Kamal Dasu wrote:
> Added power management ops for resume to be able to resan spi-nor
> device and set it to right transfer modes in its probed state after
> poweron. Some SoC implementations might  power down the spi-nor flash
> and loose its initial settings on suspend. A resume should retore the
> part to its probed state.
> 
> Signed-off-by: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/mtd/devices/m25p80.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
> index c4df3b1..be94fba 100644
> --- a/drivers/mtd/devices/m25p80.c
> +++ b/drivers/mtd/devices/m25p80.c
> @@ -324,10 +324,26 @@ static int m25p_remove(struct spi_device *spi)
>  };
>  MODULE_DEVICE_TABLE(of, m25p_of_table);
>  
> +#ifdef CONFIG_PM_SLEEP
> +static int m25p_suspend(struct device *dev)
> +{
> +	return 0;

Can't you omit this function ?

> +}
> +
> +static int m25p_resume(struct device *dev)
> +{
> +	struct m25p *flash = dev_get_drvdata(dev);
> +
> +	return spi_nor_init(&flash->spi_nor);
> +}
> +#endif
> +static SIMPLE_DEV_PM_OPS(m25p_pm_ops, m25p_suspend, m25p_resume);
> +
>  static struct spi_driver m25p80_driver = {
>  	.driver = {
>  		.name	= "m25p80",
>  		.of_match_table = m25p_of_table,
> +		.pm     = &m25p_pm_ops,
>  	},
>  	.id_table	= m25p_ids,
>  	.probe	= m25p_probe,
> 


-- 
Best regards,
Marek Vasut
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
