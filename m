From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 9/9 v3] spi: add Broadcom BCM63xx SPI controller driver
Date: Tue, 31 Jan 2012 13:19:22 -0700
Message-ID: <20120131201922.GE22611@ponder.secretlab.ca>
References: <1328019048-5892-1-git-send-email-florian@openwrt.org>
 <1328019048-5892-10-git-send-email-florian@openwrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: ralf@linux-mips.org, linux-mips@linux-mips.org,
        spi-devel-general@lists.sourceforge.net,
        Tanguy Bouzeloc <tanguy.bouzeloc@efixo.com>
To: Florian Fainelli <florian@openwrt.org>
Return-path: <linux-mips-bounce@linux-mips.org>
Content-Disposition: inline
In-Reply-To: <1328019048-5892-10-git-send-email-florian@openwrt.org>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-Id: linux-spi.vger.kernel.org

On Tue, Jan 31, 2012 at 03:10:48PM +0100, Florian Fainelli wrote:
> This patch adds support for the SPI controller found on the Broadcom BCM63xx
> SoCs.
> 
> Signed-off-by: Tanguy Bouzeloc <tanguy.bouzeloc@efixo.com>
> Signed-off-by: Florian Fainelli <florian@openwrt.org>
> ---
> Changes since v2:
> - reworked bcm63xx_spi_setup_transfer to choose closest spi transfer
>   frequency
> - removed invalid 25Mhz frequency
> - fixed some minor checkpatch issues
> 
> Changes since v1:
> - switched to the devm_* API which frees resources automatically
> - switched to dev_pm_ops
> - use module_platform_driver
> - remove MODULE_VERSION()
> - fixed return value when clock is not present using PTR_ERR()
> - fixed probe() error path to disable clock in case of failure
> 
>  drivers/spi/Kconfig       |    6 +
>  drivers/spi/Makefile      |    1 +
>  drivers/spi/spi-bcm63xx.c |  486 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 493 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/spi/spi-bcm63xx.c
> 

Looks okay.  There are a couple of problems that needs to be fixed
below, but otherwise:

Acked-by: Grant Likely <grant.likely@secretlab.ca>

Merge this through the same tree as patches 1-8

g.

> +static int __init bcm63xx_spi_probe(struct platform_device *pdev)

__devinit

> +static int __exit bcm63xx_spi_remove(struct platform_device *pdev)

__devexit

> +static const struct dev_pm_ops bcm63xx_spi_pm_ops = {
> +	.suspend	= bcm63xx_spi_suspend,
> +	.resume		= bcm63xx_spi_resume,
> +};
> +
> +#define BCM63XX_SPI_PM_OPS	(&bcm63xx_spi_pm_ops)
> +#else
> +#define BCM63XX_SPI_PM_OPS	NULL

A bit ugly.  Do this instead in the else clause and drop the BCM63XX_SPI_PM_OPS:

#define bcm63xx_spi_pm_ops NULL

> +#endif
> +
> +static struct platform_driver bcm63xx_spi_driver = {
> +	.driver = {
> +		.name	= "bcm63xx-spi",
> +		.owner	= THIS_MODULE,
> +		.pm	= BCM63XX_SPI_PM_OPS,
> +	},
> +	.probe		= bcm63xx_spi_probe,
> +	.remove		= __exit_p(bcm63xx_spi_remove),

__devexit_p

> +};
> +
> +module_platform_driver(bcm63xx_spi_driver);
> +
> +MODULE_ALIAS("platform:bcm63xx_spi");
> +MODULE_AUTHOR("Florian Fainelli <florian@openwrt.org>");
> +MODULE_AUTHOR("Tanguy Bouzeloc <tanguy.bouzeloc@efixo.com>");
> +MODULE_DESCRIPTION("Broadcom BCM63xx SPI Controller driver");
> +MODULE_LICENSE("GPL");
> -- 
> 1.7.5.4
> 
