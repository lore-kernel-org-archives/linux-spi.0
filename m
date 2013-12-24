From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
Subject: [PATCH 3/5] spi: rspi: Make more pointers const
Date: Tue, 24 Dec 2013 10:49:32 +0100
Message-ID: <1387878574-21445-4-git-send-email-geert+renesas@linux-m68k.org>
References: <1387878574-21445-1-git-send-email-geert+renesas@linux-m68k.org>
Cc: linux-spi@vger.kernel.org, linux-sh@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@linux-m68k.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1387878574-21445-1-git-send-email-geert+renesas@linux-m68k.org>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
---
 drivers/spi/spi-rspi.c |   37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index a0038687a8fd..4e376db1ca4f 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -170,34 +170,35 @@ struct rspi_data {
 	unsigned dma_callbacked:1;
 };
 
-static void rspi_write8(struct rspi_data *rspi, u8 data, u16 offset)
+static void rspi_write8(const struct rspi_data *rspi, u8 data, u16 offset)
 {
 	iowrite8(data, rspi->addr + offset);
 }
 
-static void rspi_write16(struct rspi_data *rspi, u16 data, u16 offset)
+static void rspi_write16(const struct rspi_data *rspi, u16 data, u16 offset)
 {
 	iowrite16(data, rspi->addr + offset);
 }
 
-static void rspi_write32(struct rspi_data *rspi, u32 data, u16 offset)
+static void rspi_write32(const struct rspi_data *rspi, u32 data, u16 offset)
 {
 	iowrite32(data, rspi->addr + offset);
 }
 
-static u8 rspi_read8(struct rspi_data *rspi, u16 offset)
+static u8 rspi_read8(const struct rspi_data *rspi, u16 offset)
 {
 	return ioread8(rspi->addr + offset);
 }
 
-static u16 rspi_read16(struct rspi_data *rspi, u16 offset)
+static u16 rspi_read16(const struct rspi_data *rspi, u16 offset)
 {
 	return ioread16(rspi->addr + offset);
 }
 
 /* optional functions */
 struct spi_ops {
-	int (*set_config_register)(struct rspi_data *rspi, int access_size);
+	int (*set_config_register)(const struct rspi_data *rspi,
+				   int access_size);
 	int (*send_pio)(struct rspi_data *rspi, struct spi_message *mesg,
 			struct spi_transfer *t);
 	int (*receive_pio)(struct rspi_data *rspi, struct spi_message *mesg,
@@ -208,7 +209,8 @@ struct spi_ops {
 /*
  * functions for RSPI
  */
-static int rspi_set_config_register(struct rspi_data *rspi, int access_size)
+static int rspi_set_config_register(const struct rspi_data *rspi,
+				    int access_size)
 {
 	int spbr;
 
@@ -243,7 +245,8 @@ static int rspi_set_config_register(struct rspi_data *rspi, int access_size)
 /*
  * functions for QSPI
  */
-static int qspi_set_config_register(struct rspi_data *rspi, int access_size)
+static int qspi_set_config_register(const struct rspi_data *rspi,
+				    int access_size)
 {
 	u16 spcmd;
 	int spbr;
@@ -292,12 +295,12 @@ static int qspi_set_config_register(struct rspi_data *rspi, int access_size)
 
 #define set_config_register(spi, n) spi->ops->set_config_register(spi, n)
 
-static void rspi_enable_irq(struct rspi_data *rspi, u8 enable)
+static void rspi_enable_irq(const struct rspi_data *rspi, u8 enable)
 {
 	rspi_write8(rspi, rspi_read8(rspi, RSPI_SPCR) | enable, RSPI_SPCR);
 }
 
-static void rspi_disable_irq(struct rspi_data *rspi, u8 disable)
+static void rspi_disable_irq(const struct rspi_data *rspi, u8 disable)
 {
 	rspi_write8(rspi, rspi_read8(rspi, RSPI_SPCR) & ~disable, RSPI_SPCR);
 }
@@ -316,12 +319,12 @@ static int rspi_wait_for_interrupt(struct rspi_data *rspi, u8 wait_mask,
 	return 0;
 }
 
-static void rspi_assert_ssl(struct rspi_data *rspi)
+static void rspi_assert_ssl(const struct rspi_data *rspi)
 {
 	rspi_write8(rspi, rspi_read8(rspi, RSPI_SPCR) | SPCR_SPE, RSPI_SPCR);
 }
 
-static void rspi_negate_ssl(struct rspi_data *rspi)
+static void rspi_negate_ssl(const struct rspi_data *rspi)
 {
 	rspi_write8(rspi, rspi_read8(rspi, RSPI_SPCR) & ~SPCR_SPE, RSPI_SPCR);
 }
@@ -507,7 +510,7 @@ end_nomap:
 	return ret;
 }
 
-static void rspi_receive_init(struct rspi_data *rspi)
+static void rspi_receive_init(const struct rspi_data *rspi)
 {
 	unsigned char spsr;
 
@@ -555,7 +558,7 @@ static int rspi_receive_pio(struct rspi_data *rspi, struct spi_message *mesg,
 	return 0;
 }
 
-static void qspi_receive_init(struct rspi_data *rspi)
+static void qspi_receive_init(const struct rspi_data *rspi)
 {
 	unsigned char spsr;
 
@@ -703,7 +706,7 @@ end_nomap:
 	return ret;
 }
 
-static int rspi_is_dma(struct rspi_data *rspi, struct spi_transfer *t)
+static int rspi_is_dma(const struct rspi_data *rspi, struct spi_transfer *t)
 {
 	if (t->tx_buf && rspi->chan_tx)
 		return 1;
@@ -824,7 +827,7 @@ static irqreturn_t rspi_irq(int irq, void *_sr)
 static int rspi_request_dma(struct rspi_data *rspi,
 				      struct platform_device *pdev)
 {
-	struct rspi_plat_data *rspi_pd = dev_get_platdata(&pdev->dev);
+	const struct rspi_plat_data *rspi_pd = dev_get_platdata(&pdev->dev);
 	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	dma_cap_mask_t mask;
 	struct dma_slave_config cfg;
@@ -898,7 +901,7 @@ static int rspi_probe(struct platform_device *pdev)
 	struct rspi_data *rspi;
 	int ret, irq;
 	char clk_name[16];
-	struct rspi_plat_data *rspi_pd = dev_get_platdata(&pdev->dev);
+	const struct rspi_plat_data *rspi_pd = dev_get_platdata(&pdev->dev);
 	const struct spi_ops *ops;
 	const struct platform_device_id *id_entry = pdev->id_entry;
 
-- 
1.7.9.5

