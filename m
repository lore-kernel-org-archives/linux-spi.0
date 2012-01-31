From: Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Subject: Re: [PATCH 9/9 v3] spi: add Broadcom BCM63xx SPI controller driver
Date: Tue, 31 Jan 2012 22:20:41 +0100
Message-ID: <201201312220.41561.florian@openwrt.org>
References: <1328019048-5892-1-git-send-email-florian@openwrt.org>
	<1328019048-5892-10-git-send-email-florian@openwrt.org>
	<20120131201922.GE22611@ponder.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Tanguy Bouzeloc <tanguy.bouzeloc-HH44TBFINEIAvxtiuMwx3w@public.gmane.org>, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org,
	ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20120131201922.GE22611-e0URQFbLeQY2iJbIjFUEsiwD8/FfD2ys@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hello Grant,

On Tuesday 31 January 2012 21:19:22 Grant Likely wrote:
> On Tue, Jan 31, 2012 at 03:10:48PM +0100, Florian Fainelli wrote:
> > This patch adds support for the SPI controller found on the Broadcom
> > BCM63xx SoCs.
> > 
> > Signed-off-by: Tanguy Bouzeloc <tanguy.bouzeloc-HH44TBFINEIAvxtiuMwx3w@public.gmane.org>
> > Signed-off-by: Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
> > ---
> > Changes since v2:
> > - reworked bcm63xx_spi_setup_transfer to choose closest spi transfer
> > 
> >   frequency
> > 
> > - removed invalid 25Mhz frequency
> > - fixed some minor checkpatch issues
> > 
> > Changes since v1:
> > - switched to the devm_* API which frees resources automatically
> > - switched to dev_pm_ops
> > - use module_platform_driver
> > - remove MODULE_VERSION()
> > - fixed return value when clock is not present using PTR_ERR()
> > - fixed probe() error path to disable clock in case of failure
> > 
> >  drivers/spi/Kconfig       |    6 +
> >  drivers/spi/Makefile      |    1 +
> >  drivers/spi/spi-bcm63xx.c |  486
> >  +++++++++++++++++++++++++++++++++++++++++++++ 3 files changed, 493
> >  insertions(+), 0 deletions(-)
> >  create mode 100644 drivers/spi/spi-bcm63xx.c
> 
> Looks okay.  There are a couple of problems that needs to be fixed
> below, but otherwise:
> 
> Acked-by: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
> 
> Merge this through the same tree as patches 1-8
> 
> g.
> 
> > +static int __init bcm63xx_spi_probe(struct platform_device *pdev)
> 
> __devinit
> 
> > +static int __exit bcm63xx_spi_remove(struct platform_device *pdev)
> 
> __devexit
> 
> > +static const struct dev_pm_ops bcm63xx_spi_pm_ops = {
> > +	.suspend	= bcm63xx_spi_suspend,
> > +	.resume		= bcm63xx_spi_resume,
> > +};
> > +
> > +#define BCM63XX_SPI_PM_OPS	(&bcm63xx_spi_pm_ops)
> > +#else
> > +#define BCM63XX_SPI_PM_OPS	NULL
> 
> A bit ugly.  Do this instead in the else clause and drop the
> BCM63XX_SPI_PM_OPS:
> 
> #define bcm63xx_spi_pm_ops NULL

This won't work, because driver.pm must be set to a pointer to a struct 
dev_pm_ops, that's why I used this trick to make it build fine in both cases. 
If I follow your advice, with driver.pm = &bcm63xx_spi_pm_ops, it won't build 
for CONFIG_PM=n.

> 
> > +#endif
> > +
> > +static struct platform_driver bcm63xx_spi_driver = {
> > +	.driver = {
> > +		.name	= "bcm63xx-spi",
> > +		.owner	= THIS_MODULE,
> > +		.pm	= BCM63XX_SPI_PM_OPS,
> > +	},
> > +	.probe		= bcm63xx_spi_probe,
> > +	.remove		= __exit_p(bcm63xx_spi_remove),
> 
> __devexit_p
> 
> > +};
> > +
> > +module_platform_driver(bcm63xx_spi_driver);
> > +
> > +MODULE_ALIAS("platform:bcm63xx_spi");
> > +MODULE_AUTHOR("Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>");
> > +MODULE_AUTHOR("Tanguy Bouzeloc <tanguy.bouzeloc-HH44TBFINEIAvxtiuMwx3w@public.gmane.org>");
> > +MODULE_DESCRIPTION("Broadcom BCM63xx SPI Controller driver");
> > +MODULE_LICENSE("GPL");

-- 
Florian

------------------------------------------------------------------------------
Keep Your Developer Skills Current with LearnDevNow!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-d2d
