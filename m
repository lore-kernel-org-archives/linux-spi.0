From: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v1 4/5] mtd: m25p80: Check if the spi flash device has pm
 support
Date: Mon, 6 Feb 2017 12:01:27 +0100
Message-ID: <9108d13d-0f06-172f-5e8d-91ff80fdd510@atmel.com>
References: <1486164676-12912-1-git-send-email-kdasu.kdev@gmail.com>
 <1486164676-12912-5-git-send-email-kdasu.kdev@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Cc: <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
To: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        <marex-ynQEQJNshbs@public.gmane.org>, <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1486164676-12912-5-git-send-email-kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Kamal,

Le 04/02/2017 à 00:31, Kamal Dasu a écrit :
> Call the spi_nor_rescan() only if the controller driver needs this
> support. This way SoCs that need this feature can use it.
> 
> Signed-off-by: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/mtd/devices/m25p80.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
> index 4528e33..ffdec60 100644
> --- a/drivers/mtd/devices/m25p80.c
> +++ b/drivers/mtd/devices/m25p80.c
> @@ -328,8 +328,13 @@ static int m25p_suspend(struct device *dev)
>  static int m25p_resume(struct device *dev)
>  {
>  	struct m25p *flash = dev_get_drvdata(dev);
> +	struct spi_device *spi = flash->spi;
> +	int ret = 0;
> +
> +	if (spi_flash_pm_supported(spi))
> +		ret = spi_nor_pm_rescan(&flash->spi_nor, NULL);
>

Why don't you squash patch 2 into this one? Patch 2 suggests that
spi_nor_pm_rescan() could safely be called in any case but now this patch
suggests that calling that function is not so safe.

I see two cases:

1/ either calling spi_nor_pm_rescan() is safe in any case, then patches 3,
4 and 5 are needless.

2/ or calling spi_nor_pm_rescan() has unwanted side effects in some cases,
then patch 2 should be squashed into this patch: patch 2 will never be
taken alone in the spi-nor tree if it may introduce bugs or regressions.

If something has to be done in the SPI sub-system, I guess it should be
done first: for sure applying patches 3 and 5 would not create any issue.
Then patches 2 and 4 squashed into a single patch may be safely applied after.

However, patches 3 and 5 still need to be discussed first.

Best regards,

Cyrille

> -	return spi_nor_pm_rescan(&flash->spi-nor, NULL);
> +	return ret;
>  }
>  #endif
>  static SIMPLE_DEV_PM_OPS(m25p_pm_ops, m25p_suspend, m25p_resume);
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
