From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 2/2] spi: qup: Request CS GPIO's during probe
Date: Fri, 06 Mar 2015 10:34:02 -0800
Message-ID: <54F9F31A.3050501@codeaurora.org>
References: <1425655578-22400-1-git-send-email-iivanov@mm-sol.com> <1425655578-22400-2-git-send-email-iivanov@mm-sol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
To: "Ivan T. Ivanov" <iivanov@mm-sol.com>,
	Mark Brown <broonie@kernel.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1425655578-22400-2-git-send-email-iivanov@mm-sol.com>
Sender: linux-arm-msm-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 03/06/15 07:26, Ivan T. Ivanov wrote:
> Ensure that driver is owner of the GPIO's used for CS signals.

Why? What happens if we don't?

>
> Signed-off-by: Ivan T. Ivanov <iivanov@mm-sol.com>
> ---
>  drivers/spi/spi-qup.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
> index 2b2c359..a07ba46 100644
> --- a/drivers/spi/spi-qup.c
> +++ b/drivers/spi/spi-qup.c
> @@ -14,11 +14,13 @@
>  #include <linux/clk.h>
>  #include <linux/delay.h>
>  #include <linux/err.h>
> +#include <linux/gpio.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/list.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/of_gpio.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/spi/spi.h>
> @@ -499,7 +501,7 @@ static int spi_qup_probe(struct platform_device *pdev)
>  	struct device *dev;
>  	void __iomem *base;
>  	u32 max_freq, iomode, num_cs;
> -	int ret, irq, size;
> +	int ret, irq, size, cs, cs_gpio;
>
>  	dev = &pdev->dev;
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> @@ -556,6 +558,19 @@ static int spi_qup_probe(struct platform_device *pdev)
>  	else
>  		master->num_chipselect = num_cs;
>
> +	for (cs = 0; cs < master->num_chipselect; cs++) {
> +		cs_gpio = of_get_named_gpio(dev->of_node, "cs-gpios", cs);
> +
> +		if (!gpio_is_valid(cs_gpio))
> +			continue;
> +
> +		ret = devm_gpio_request(&pdev->dev, cs_gpio, "spi-qup-cs");
> +		if (ret) {
> +			dev_err(&pdev->dev, "can't get cs gpios\n");
> +			goto error;
> +		}
> +	}
> +
>  	master->bus_num = pdev->id;

Is this related to [1]? In that case I was just relying on DT/pinctrl to
properly request the gpios.

[1] https://lkml.org/lkml/2014/5/27/784

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
