From: <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
Subject: [PATCHv2 2/2] spi: Add Flag to Enable Slave Select with GPIO Chip Select.
Date: Fri, 7 Oct 2016 09:56:34 -0500
Message-ID: <1475852194-27690-2-git-send-email-tthayer@opensource.altera.com>
References: <1475852194-27690-1-git-send-email-tthayer@opensource.altera.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
        <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>,
        <michael-XrNoQAPr3WXM9gW82pYGhQ@public.gmane.org>, <kernel-NoMTM8u0nx3R7s880joybQ@public.gmane.org>,
        <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
To: <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1475852194-27690-1-git-send-email-tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Thor Thayer <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>

Some SPI masters require slave selection before the transfer
can begin [1]. The SPI framework currently selects the chip using
either 1) the internal CS mechanism or 2) the GPIO CS, but not both.

This patch adds a boolean variable to indicate both the GPIO CS and
the internal chip select should be used.

Tested On:
    Altera CycloneV development kit
    Compile tested for build errors on x86_64 (allyesconfigs)

[1] DesignWare dw_apb_ssi Databook, Version 3.20a (page 39)

Signed-off-by: Thor Thayer <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
---
v2  Move changes to SPI framework based on maintainer comments
    Add a new SPI master boolean variable.
---
 drivers/spi/spi.c       |   10 ++++++++--
 include/linux/spi/spi.h |    1 +
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 5787b72..c042a8c 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -697,10 +697,14 @@ static void spi_set_cs(struct spi_device *spi, bool enable)
 	if (spi->mode & SPI_CS_HIGH)
 		enable = !enable;
 
-	if (gpio_is_valid(spi->cs_gpio))
+	if (gpio_is_valid(spi->cs_gpio)) {
 		gpio_set_value(spi->cs_gpio, !enable);
-	else if (spi->master->set_cs)
+		/* Some SPI masters need both GPIO CS & slave_select */
+		if (spi->master->set_cs && spi->master->gpio_ss)
+			spi->master->set_cs(spi, !enable);
+	} else if (spi->master->set_cs) {
 		spi->master->set_cs(spi, !enable);
+	}
 }
 
 #ifdef CONFIG_HAS_DMA
@@ -1845,6 +1849,8 @@ static int of_spi_register_master(struct spi_master *master)
 	for (i = 0; i < nb; i++)
 		cs[i] = of_get_named_gpio(np, "cs-gpios", i);
 
+	master->gpio_ss = of_property_read_bool(np, "gpio-ss");
+
 	return 0;
 }
 #else
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 4b743ac..0437995 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -551,6 +551,7 @@ struct spi_master {
 
 	/* gpio chip select */
 	int			*cs_gpios;
+	bool			gpio_ss;
 
 	/* statistics */
 	struct spi_statistics	statistics;
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
