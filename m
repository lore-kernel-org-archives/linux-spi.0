From: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Subject: Re: [PATCH] spi: mediatek: fix spi incorrect endian usage and remove
 redundant clock
Date: Tue, 18 Aug 2015 14:19:54 +0200
Message-ID: <CAOiHx=nBOtm3c7QQpA-SSxXzJGjUEJQBtR9CynoeqsXRoz4fRg@mail.gmail.com>
References: <1439895231-17778-1-git-send-email-leilk.liu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1439895231-17778-1-git-send-email-leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi,

On Tue, Aug 18, 2015 at 12:53 PM, Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org> wrote:
> This patch fixes incorrect endian usage, removes redundant
> clock in prepare_hardware/unprepare_hardware and revises
> coding styles.
>
> Signed-off-by: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
>
> ---
> Change in this patch:
> 1. fix incorrect endian usage on big-endian system.
> 2. delete redundant clock in prepare/unprepare_hardware.
> 3. revise coding styles.

The usual philosophy is to have one change per patch, so this might be
better as three patches. But this is Mark's call. Since the driver
isn't yet in Linus' tree, it might be a-ok to mix style improvements
and actual fixes, but as soon as it landed in Linus' tree you need to
keep them separate, so fixes can be easily backported.

Regarding the content ...

> ---
>  drivers/spi/spi-mt65xx.c                 | 163 +++++++++++++------------------
>  include/linux/platform_data/spi-mt65xx.h |   2 -
>  2 files changed, 69 insertions(+), 96 deletions(-)
>
> diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
> index 519f50c..a9da887 100644
> --- a/drivers/spi/spi-mt65xx.c
> +++ b/drivers/spi/spi-mt65xx.c
> @@ -694,6 +662,7 @@ static int mtk_spi_resume(struct device *dev)
>         if (!pm_runtime_suspended(dev)) {
>                 ret = clk_prepare_enable(mdata->spi_clk);
>                 if (ret < 0)
> +                       dev_err(dev, "failed to enable spi_clk (%d)\n", ret);
>                         return ret;

You need to add braces here, else the "return ret" isn't covered by
the if () anymore and you always return at this place.

>         }
>
> @@ -720,8 +689,14 @@ static int mtk_spi_runtime_resume(struct device *dev)
>  {
>         struct spi_master *master = dev_get_drvdata(dev);
>         struct mtk_spi *mdata = spi_master_get_devdata(master);
> +       int ret;
> +
> +       ret = clk_prepare_enable(mdata->spi_clk);
> +       if (ret < 0)
> +               dev_err(dev, "failed to enable spi_clk (%d)\n", ret);
> +               return ret;

Same here. Although at least here it should be harmless, as
clk_prepare_enable doesn't return > 0.

>
> -       return clk_prepare_enable(mdata->spi_clk);
> +       return 0;
>  }
>  #endif /* CONFIG_PM */
>


Jonas
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
