From: Greg Ungerer <gerg-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: [RFC] spi: imx: fix use of native chip-selects with devicetree
Date: Mon, 13 Mar 2017 14:08:59 +1000
Message-ID: <1489378139-11707-1-git-send-email-gerg@linux-m68k.org>
Cc: Greg Ungerer <gerg-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

I have an iMX253 based system with 2 SPI buses, one with a flash hanging
of it, and one with a SLIC. On modern kernels (I am using 4.9 - but I
think current mainline 4.11-rc2 is the same) the SPI bus with the SLIC
device can't be configured to work with a devicetree setup.

The problem is that the SLIC device hardware arrangement needs to use the
iMX SPI native chipselect to provide the neccessary hardware cycles.
Maybe I am missing something but I can't see how that can be made to work
with the current devicetree setup required on this platform.

It would appear that using a cs_gpio field of "<0>" is meant to indicate
use of a native chipselect - though I couldn't find that documented
anywhere. In any case I couldn't see any other way to do it either.

But with a cs_gpio field set to "<0>" the config code doesn't correctly
configure the iMX SPI registers to use a native chipselect. In fact it
actively looks wrong in the way it mangles the cs_gpio to calculate a
native chipselect when using a devicetree (it looks like it would be
correct for the platform setup case though).

Below is the patch I came up with to fix it for my hardware. This results
in the correct native chipselect being set for my SLIC hardware and it
all works nicely.

Is this on the right track or have I missed something comepletely?

--------

The commonly used mechanism of specifying the native chipselect on an
SPI device in devicetree (that is "cs-gpios = <0> ...") does not result
in the native chipselect being configured for use. So external SPI
devices that require use of the native chipselect will not work.

You can successfully specify native chipselects if using a platform
setup by specifying the cs-gpio as negative offset by 32. And that
looks to be working correctly.

The logic in the spi-imx.c driver during probe uses core spi function
of_spi_register_master() in spi.c to parse the "cs-gpios" devicetree tag.
For valid GPIO values that will be recorded for use, all other entries in
cs_gpios list will be set to -ENOENT. So entries like "<0>" will be set
to -ENOENT in the cs_gpios list.

When the SPI device registers are setup the code will use the GPIO
listed in the cs_gpios list for the desired chipselect. If the cs_gpio
is less then 0 then it is intended to be for a native chipselect, and
its cs_gpio value is added to 32 to get the chipselect number to use.
Problem is that with devicetree this can only ever be -ENOENT (which
is -2), and that alone results in an invalid chipselect number. But also
doesn't allow selection of the native chipselect at all.

To fix I modified the setup logic so that if cs_gpio is less than 0,
and it is -ENOENT, then we use the chipselect number associated with
this spi device. This will allow platform setups to continue to be able
to specify the chipselect number they want, and on devicetree systems
the absence of a valid GPIO will use the native chipselect.

Acked-by: Greg Ungerer <gerg-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
---
 drivers/spi/spi-imx.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 9a7c62f..c6e13f7 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -516,10 +516,12 @@ static int mx31_config(struct spi_device *spi, struct spi_imx_config *config)
 		reg |= MX31_CSPICTRL_POL;
 	if (spi->mode & SPI_CS_HIGH)
 		reg |= MX31_CSPICTRL_SSPOL;
-	if (spi->cs_gpio < 0)
-		reg |= (spi->cs_gpio + 32) <<
-			(is_imx35_cspi(spi_imx) ? MX35_CSPICTRL_CS_SHIFT :
-						  MX31_CSPICTRL_CS_SHIFT);
+	if (spi->cs_gpio < 0) {
+		int cs = (spi->cs_gpio == -ENOENT) ? spi->chip_select :
+						     spi->cs_gpio + 32;
+		reg |= cs << (is_imx35_cspi(spi_imx) ? MX35_CSPICTRL_CS_SHIFT :
+						       MX31_CSPICTRL_CS_SHIFT);
+	}
 
 	if (spi_imx->usedma)
 		reg |= MX31_CSPICTRL_SMC;
@@ -608,8 +610,11 @@ static int mx21_config(struct spi_device *spi, struct spi_imx_config *config)
 		reg |= MX21_CSPICTRL_POL;
 	if (spi->mode & SPI_CS_HIGH)
 		reg |= MX21_CSPICTRL_SSPOL;
-	if (spi->cs_gpio < 0)
-		reg |= (spi->cs_gpio + 32) << MX21_CSPICTRL_CS_SHIFT;
+	if (spi->cs_gpio < 0) {
+		int cs = (spi->cs_gpio == -ENOENT) ? spi->chip_select :
+						     spi->cs_gpio + 32;
+		reg |= cs << MX21_CSPICTRL_CS_SHIFT;
+	}
 
 	writel(reg, spi_imx->base + MXC_CSPICTRL);
 
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
