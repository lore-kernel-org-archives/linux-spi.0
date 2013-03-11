From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: Re: [PATCH v6 12/16] spi/spi-atmel: add pinctrl support for atmel
 spi
Date: Mon, 11 Mar 2013 14:11:26 +0100
Message-ID: <20130311131126.GB2001@game.jcrosoft.org>
References: <1362626715-6549-1-git-send-email-wenyou.yang@atmel.com>
 <1362627243-9351-1-git-send-email-wenyou.yang@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-arm-kernel@lists.infradead.org, grant.likely@secretlab.ca,
	nicolas.ferre@atmel.com, richard.genoud@gmail.com,
	JM.Lin@atmel.com, spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
To: Wenyou Yang <wenyou.yang@atmel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1362627243-9351-1-git-send-email-wenyou.yang@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 11:34 Thu 07 Mar     , Wenyou Yang wrote:
> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> Cc: spi-devel-general@lists.sourceforge.net
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/spi/spi-atmel.c |    8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
> index 1e212d1..6b166f4 100644
> --- a/drivers/spi/spi-atmel.c
> +++ b/drivers/spi/spi-atmel.c
> @@ -23,6 +23,7 @@
>  #include <linux/platform_data/atmel.h>
>  #include <linux/platform_data/dma-atmel.h>
>  #include <linux/of.h>
> +#include <linux/pinctrl/consumer.h>
>  
>  #include <linux/io.h>
>  #include <linux/gpio.h>
> @@ -1493,11 +1494,18 @@ static int atmel_spi_probe(struct platform_device *pdev)
>  	int			ret;
>  	struct spi_master	*master;
>  	struct atmel_spi	*as;
> +	struct pinctrl		*pinctrl;
>  
>  	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	if (!regs)
>  		return -ENXIO;
>  
> +	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
> +	if (IS_ERR(pinctrl)) {
> +		dev_err(&pdev->dev, "Failed to request pinctrl\n");
> +		return PTR_ERR(pinctrl);
> +	}

drop this, this is handled at bus level

Best Regards,
J.
> +
>  	irq = platform_get_irq(pdev, 0);
>  	if (irq < 0)
>  		return irq;
> -- 
> 1.7.9.5
> 
