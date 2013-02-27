From: Joachim Eastwood <manabian@gmail.com>
Subject: Re: [PATCH Resend v5 12/16] spi/spi-atmel: add pinctrl support for
 atmel spi
Date: Wed, 27 Feb 2013 20:26:40 +0100
Message-ID: <CAGhQ9VxPee+dPRPr0XdAd+fT=Ngcz=MAHdvZ3PkdUawk39oJTA@mail.gmail.com>
References: <1361925297-11854-1-git-send-email-wenyou.yang@atmel.com>
	<1361926029-12518-1-git-send-email-wenyou.yang@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-arm-kernel@lists.infradead.org, grant.likely@secretlab.ca,
	nicolas.ferre@atmel.com, plagnioj@jcrosoft.com,
	richard.genoud@gmail.com, JM.Lin@atmel.com,
	spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
To: Wenyou Yang <wenyou.yang@atmel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1361926029-12518-1-git-send-email-wenyou.yang@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 27 February 2013 01:47, Wenyou Yang <wenyou.yang@atmel.com> wrote:
> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> Cc: spi-devel-general@lists.sourceforge.net
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/spi/spi-atmel.c |    8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
> index 00ca85f..0ed3e1a 100644
> --- a/drivers/spi/spi-atmel.c
> +++ b/drivers/spi/spi-atmel.c
> @@ -23,6 +23,7 @@
>  #include <linux/platform_data/atmel.h>
>  #include <linux/platform_data/dma-atmel.h>
>  #include <linux/of.h>
> +#include <linux/pinctrl/consumer.h>
>
>  #include <asm/io.h>
>  #include <asm/gpio.h>
> @@ -1503,11 +1504,18 @@ static int atmel_spi_probe(struct platform_device *pdev)
>         int                     ret;
>         struct spi_master       *master;
>         struct atmel_spi        *as;
> +       struct pinctrl          *pinctrl;
>
>         regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>         if (!regs)
>                 return -ENXIO;
>
> +       pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
> +       if (IS_ERR(pinctrl)) {
> +               dev_err(&pdev->dev, "Failed to request pinctrl\n");
> +               return PTR_ERR(pinctrl);
> +       }
> +

This patch should be dropped since driver core will now do this for us.

regards
Joachim Eastwood
