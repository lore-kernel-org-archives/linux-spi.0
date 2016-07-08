From: Michael Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v2 5/7] spi: s3c64xx: add exynos5433 compatible for ioclk handling
Date: Fri, 08 Jul 2016 09:13:32 -0700
Message-ID: <146799441227.73491.13833003558807352160@resonance>
References: <1467989201-14661-1-git-send-email-andi.shyti@samsung.com>
 <1467989201-14661-6-git-send-email-andi.shyti@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Cc: "Chanwoo Choi" <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	"Jaehoon Chung" <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	"Andi Shyti" <andi.shyti-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	"Andi Shyti" <andi-ahk0KpmfxKRAfugRpC6u6w@public.gmane.org>
To: Andi Shyti <andi.shyti-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	"Rob Herring" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"Mark Rutland" <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	"Kukjin Kim" <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"Krzysztof Kozlowski" <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	"Mark Brown" <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"Sylwester Nawrocki" <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	"Tomasz Figa" <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	"Stephen Boyd" <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1467989201-14661-6-git-send-email-andi.shyti-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Quoting Andi Shyti (2016-07-08 07:46:39)
> @@ -1147,6 +1150,21 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
>                 goto err_disable_clk;
>         }
>  
> +       if (sdd->port_conf->clk_ioclk) {
> +               sdd->ioclk = devm_clk_get(&pdev->dev, "spi_ioclk");
> +               if (IS_ERR(sdd->ioclk)) {
> +                       dev_err(&pdev->dev, "Unable to acquire 'ioclk'\n");
> +                       ret = PTR_ERR(sdd->ioclk);
> +                       goto err_disable_src_clk;
> +               }
> +
> +               ret = clk_prepare_enable(sdd->ioclk);
> +               if (ret) {
> +                       dev_err(&pdev->dev, "Couldn't enable clock 'ioclk'\n");
> +                       goto err_disable_src_clk;
> +               }
> +       }
> +
>         pm_runtime_set_autosuspend_delay(&pdev->dev, AUTOSUSPEND_TIMEOUT);
>         pm_runtime_use_autosuspend(&pdev->dev);
>         pm_runtime_set_active(&pdev->dev);
> @@ -1193,6 +1211,8 @@ err_pm_put:
>         pm_runtime_disable(&pdev->dev);
>         pm_runtime_set_suspended(&pdev->dev);
>  
> +       clk_disable_unprepare(sdd->ioclk);
> +err_disable_src_clk:
>         clk_disable_unprepare(sdd->src_clk);
>  err_disable_clk:
>         clk_disable_unprepare(sdd->clk);

Why aren't these clocks enabled/disabled by calls to pm_runtime_get/put?

Regards,
Mike
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
