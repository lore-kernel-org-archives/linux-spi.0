From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 4/7] spi: pxa2xx: Save other reg_cs_ctrl bits when configuring chip select
Date: Thu, 22 Oct 2015 16:44:42 +0300
Message-ID: <1445521485-2029-4-git-send-email-jarkko.nikula@linux.intel.com>
References: <1445521485-2029-1-git-send-email-jarkko.nikula@linux.intel.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
	Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1445521485-2029-1-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Upcoming Intel platforms use LPSS SPI_CS_CONTROL register bits 15:12 for
configuring the chip select polarities. Touch only chip select SW mode and
state bits when enabling the software chip select control in order to not
clear any other bits in the register.

Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-pxa2xx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 48fdcb6a7f79..615f6c57a090 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -249,7 +249,9 @@ static void lpss_ssp_setup(struct driver_data *drv_data)
 	drv_data->lpss_base = drv_data->ioaddr + config->offset;
 
 	/* Enable software chip select control */
-	value = SPI_CS_CONTROL_SW_MODE | SPI_CS_CONTROL_CS_HIGH;
+	value = __lpss_ssp_read_priv(drv_data, config->reg_cs_ctrl);
+	value &= ~(SPI_CS_CONTROL_SW_MODE | SPI_CS_CONTROL_CS_HIGH);
+	value |= SPI_CS_CONTROL_SW_MODE | SPI_CS_CONTROL_CS_HIGH;
 	__lpss_ssp_write_priv(drv_data, config->reg_cs_ctrl, value);
 
 	/* Enable multiblock DMA transfers */
-- 
2.6.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
