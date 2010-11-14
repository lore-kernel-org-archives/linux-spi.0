From: Gabor Juhos <juhosg@openwrt.org>
Subject: Re: [RFC 11/18] spi: add SPI controller driver for the Atheros AR71XX/AR724X/AR913X
 SoCs
Date: Sun, 14 Nov 2010 22:03:56 +0100
Message-ID: <4CE04EBC.4080701@openwrt.org>
References: <1289598684-30624-1-git-send-email-juhosg@openwrt.org> <1289598684-30624-12-git-send-email-juhosg@openwrt.org> <20101114082242.GA3137@angua.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        "Luis R. Rodriguez" <mcgrof@gmail.com>,
        Cliff Holden <Cliff.Holden@Atheros.com>,
        David Brownell <dbrownell@users.sourceforge.net>,
        spi-devel-general@lists.sourceforge.net,
        Imre Kaloz <kaloz@openwrt.org>
To: Grant Likely <grant.likely@secretlab.ca>
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <20101114082242.GA3137@angua.secretlab.ca>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-Id: linux-spi.vger.kernel.org

Hi Grant,

>> <...>
>> +#include <asm/mach-ath79/ath79_spi_platform.h>
>> +
>> +#define DRV_DESC	"SPI controller driver for Atheros AR71XX/AR724X/AR91X"
> 
> Used exactly once.  Don't bother with a #define

Ok.

>> +#define DRV_NAME	"ath79-spi"
>> +
>> +struct ath79_spi {
>> +	struct	spi_bitbang	bitbang;
>> +	u32			ioc_base;
>> +	u32			reg_ctrl;
>> +
>> +	void __iomem		*base;
>> +
>> +	struct platform_device	*pdev;
>> +};
>> +
>> +static inline u32 ath79_spi_rr(struct ath79_spi *sp, unsigned reg)
>> +{
>> +	return __raw_readl(sp->base + reg);
>> +}
>> +
>> +static inline void ath79_spi_wr(struct ath79_spi *sp, unsigned reg, u32 val)
>> +{
>> +	__raw_writel(val, sp->base + reg);
>> +}
> 
> This is suspect.  Why is __raw_{readl,writel} being used instead of
> ioread32/iowrite32?  The __raw versions don't provide any kind of
> ordering barriers.

Mainly because the resulting code is smaller, and the performance is a bit
better with the use of the __raw versions. The controller is embedded into the
SoC and the registers are memory mapped, so i think it is safe to access them
with __raw_{readl,writel}. However I can change it if that is the preferred method.

>> <...>
>> +static int ath79_spi_probe(struct platform_device *pdev)
> 
> __devinit

I will add this.

> 
>> +{
>> +	struct spi_master *master;
>> +	struct ath79_spi *sp;
>> +	struct ath79_spi_platform_data *pdata;
>> +	struct resource	*r;
>> +	int ret;
>> +
>> +	master = spi_alloc_master(&pdev->dev, sizeof(*sp));
>> +	if (master == NULL) {
>> +		dev_err(&pdev->dev, "failed to allocate spi master\n");
>> +		return -ENOMEM;
>> +	}
>> +
>> +	sp = spi_master_get_devdata(master);
>> +	platform_set_drvdata(pdev, sp);
>> +
>> +	pdata = pdev->dev.platform_data;
>> +
>> +	master->setup = ath79_spi_setup;
>> +	master->cleanup = ath79_spi_cleanup;
>> +	if (pdata) {
>> +		master->bus_num = pdata->bus_num;
>> +		master->num_chipselect = pdata->num_chipselect;
>> +	} else {
>> +		master->bus_num = 0;
> 
> Use -1 so that a bus number can be dynamically assigned

All right.

>> <...>
>> +static int ath79_spi_remove(struct platform_device *pdev)
> 
> __devexit
> 
>> +{
>> +	struct ath79_spi *sp = platform_get_drvdata(pdev);
>> +
>> +	spi_bitbang_stop(&sp->bitbang);
>> +	iounmap(sp->base);
>> +	platform_set_drvdata(pdev, NULL);
>> +	spi_master_put(sp->bitbang.master);
>> +
>> +	return 0;
>> +}
>> +
>> +static struct platform_driver ath79_spi_drv = {
>> +	.probe		= ath79_spi_probe,
>> +	.remove		= ath79_spi_remove,
> 
> __devexit_p(ath79_spi_remove),
> 

I will add these annotations as well.

Thank you,
Gabor
