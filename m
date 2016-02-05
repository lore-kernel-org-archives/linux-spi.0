From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [RFC PATCH] SPI/ACPI: DesignWare: Add ACPI support for Designware
 SPI driver
Date: Fri, 5 Feb 2016 17:55:42 +0200
Message-ID: <CAHp75VeSkUvHSd_JC-qPzwDjBWM8oxJP8jt3UD91uq1=fvEEqw@mail.gmail.com>
References: <1454656280-130658-1-git-send-email-qiujiang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie@kernel.org>,
	linux-spi <linux-spi@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linuxarm@huawei.com, haifeng.wei@huawei.com,
	charles.chenxin@huawei.com
To: qiujiang <qiujiang@huawei.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1454656280-130658-1-git-send-email-qiujiang@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, Feb 5, 2016 at 9:11 AM, qiujiang <qiujiang@huawei.com> wrote:
> This patch added ACPI support for DesignWare SPI mmio driver. It
> was based the corresponding DT driver and compatible for this two
> way. This patch has been tested on Hisilicon D02 board. It relies
> on the GPIO patchset.

My comments below.

> @@ -84,8 +87,6 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
>         dws->num_cs = num_cs;
>
>         if (pdev->dev.of_node) {
> -               int i;
> -
>                 for (i = 0; i < dws->num_cs; i++) {
>                         int cs_gpio = of_get_named_gpio(pdev->dev.of_node,
>                                         "cs-gpios", i);

It seems the driver was never validated with more than one chip select.
Perhaps someone has to switch to use of_spi_register_master() here.

> @@ -104,6 +105,18 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
>                 }
>         }
>
> +       if (ACPI_COMPANION(&pdev->dev)) {
> +               for (i = 0; i < dws->num_cs; i++) {
> +                       snprintf(propname, sizeof(propname), "cs%d", i);
> +                       gpiod = devm_gpiod_get(&pdev->dev,
> +                               propname, GPIOD_ASIS);
> +                       if (IS_ERR(gpiod)) {
> +                               dev_err(&pdev->dev, "Get gpio desc failed!\n");
> +                               return PTR_ERR(gpiod);
> +                       }
> +               }
> +       }

Like Mark noticed there is also same issue. Do you indeed check the
configuration with different chip select signals?

-- 
With Best Regards,
Andy Shevchenko
