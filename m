From: <tthayer@opensource.altera.com>
Subject: [PATCHv3 1/2] spi: Add Flag to Enable Slave Select with GPIO Chip Select.
Date: Mon, 10 Oct 2016 09:25:24 -0500
Message-ID: <1476109525-21213-1-git-send-email-tthayer@opensource.altera.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <andriy.shevchenko@linux.intel.com>,
        <jarkko.nikula@linux.intel.com>, <jszhang@marvell.com>,
        <michael@smart-africa.com>, <kernel@mseidel.net>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <tthayer@opensource.altera.com>
To: <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Thor Thayer <tthayer@opensource.altera.com>

Some SPI masters require slave selection before the transfer
can begin [1]. The SPI framework currently selects the chip using
either 1) the internal CS mechanism or 2) the GPIO CS, but not both.

This patch adds a new master->flags define to indicate both the GPIO
CS and the internal chip select mechanism should be used.

Tested On:
    Altera CycloneV development kit
    Compile tested for build errors on x86_64 (allyesconfigs)

[1] DesignWare dw_apb_ssi Databook, Version 3.20a (page 39)

Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
---
v2  Move changes to SPI framework based on maintainer comments
    Add a new SPI master boolean variable.
v3  Change boolean variable to master->flags based on comments
---
 drivers/spi/spi.c       |    9 +++++++--
 include/linux/spi/spi.h |    1 +
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 5787b72..cbe15ab 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -697,10 +697,15 @@ static void spi_set_cs(struct spi_device *spi, bool enable)
 	if (spi->mode & SPI_CS_HIGH)
 		enable = !enable;
 
-	if (gpio_is_valid(spi->cs_gpio))
+	if (gpio_is_valid(spi->cs_gpio)) {
 		gpio_set_value(spi->cs_gpio, !enable);
-	else if (spi->master->set_cs)
+		/* Some SPI masters need both GPIO CS & slave_select */
+		if ((spi->master->flags & SPI_MASTER_GPIO_SS) &&
+		    spi->master->set_cs)
+			spi->master->set_cs(spi, !enable);
+	} else if (spi->master->set_cs) {
 		spi->master->set_cs(spi, !enable);
+	}
 }
 
 #ifdef CONFIG_HAS_DMA
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 4b743ac..75c6bd0 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -442,6 +442,7 @@ struct spi_master {
 #define SPI_MASTER_NO_TX	BIT(2)		/* can't do buffer write */
 #define SPI_MASTER_MUST_RX      BIT(3)		/* requires rx */
 #define SPI_MASTER_MUST_TX      BIT(4)		/* requires tx */
+#define SPI_MASTER_GPIO_SS      BIT(5)		/* GPIO CS must select slave */
 
 	/*
 	 * on some hardware transfer / message size may be constrained
-- 
1.7.9.5
