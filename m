From: Cosmin-Gabriel Samoila <gabrielcsmo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] spi: spi-adi-v3: fixed coding style issues.
Date: Sun, 13 Mar 2016 20:51:54 +0200
Message-ID: <1457895114-4946-1-git-send-email-gabrielcsmo@gmail.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Cosmin-Gabriel Samoila <gabrielcsmo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Fixed coding style issues detected using checkpatch.pl.

Signed-off-by: Cosmin-Gabriel Samoila <gabrielcsmo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-adi-v3.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-adi-v3.c b/drivers/spi/spi-adi-v3.c
index a16b25d..06121cc 100644
--- a/drivers/spi/spi-adi-v3.c
+++ b/drivers/spi/spi-adi-v3.c
@@ -43,9 +43,9 @@ enum adi_spi_state {
 struct adi_spi_master;
 
 struct adi_spi_transfer_ops {
-	void (*write) (struct adi_spi_master *);
-	void (*read) (struct adi_spi_master *);
-	void (*duplex) (struct adi_spi_master *);
+	void (*write)(struct adi_spi_master *);
+	void (*read)(struct adi_spi_master *);
+	void (*duplex)(struct adi_spi_master *);
 };
 
 /* runtime info for spi master */
@@ -150,10 +150,12 @@ static int adi_spi_flush(struct adi_spi_master *drv_data)
 }
 
 /* Chip select operation functions for cs_change flag */
-static void adi_spi_cs_active(struct adi_spi_master *drv_data, struct adi_spi_device *chip)
+static void adi_spi_cs_active(struct adi_spi_master *drv_data,
+			      struct adi_spi_device *chip)
 {
 	if (likely(chip->cs < MAX_CTRL_CS)) {
 		u32 reg;
+
 		reg = ioread32(&drv_data->regs->ssel);
 		reg &= ~chip->ssel;
 		iowrite32(reg, &drv_data->regs->ssel);
@@ -167,6 +169,7 @@ static void adi_spi_cs_deactive(struct adi_spi_master *drv_data,
 {
 	if (likely(chip->cs < MAX_CTRL_CS)) {
 		u32 reg;
+
 		reg = ioread32(&drv_data->regs->ssel);
 		reg |= chip->ssel;
 		iowrite32(reg, &drv_data->regs->ssel);
@@ -185,6 +188,7 @@ static inline void adi_spi_cs_enable(struct adi_spi_master *drv_data,
 {
 	if (chip->cs < MAX_CTRL_CS) {
 		u32 reg;
+
 		reg = ioread32(&drv_data->regs->ssel);
 		reg |= chip->ssel >> 8;
 		iowrite32(reg, &drv_data->regs->ssel);
@@ -196,6 +200,7 @@ static inline void adi_spi_cs_disable(struct adi_spi_master *drv_data,
 {
 	if (chip->cs < MAX_CTRL_CS) {
 		u32 reg;
+
 		reg = ioread32(&drv_data->regs->ssel);
 		reg &= ~(chip->ssel >> 8);
 		iowrite32(reg, &drv_data->regs->ssel);
@@ -686,8 +691,9 @@ static int adi_spi_setup(struct spi_device *spi)
 			}
 		} else {
 			chip->cs_gpio = chip->cs - MAX_CTRL_CS;
-			ret = gpio_request_one(chip->cs_gpio, GPIOF_OUT_INIT_HIGH,
-						dev_name(&spi->dev));
+			ret = gpio_request_one(chip->cs_gpio,
+					       GPIOF_OUT_INIT_HIGH,
+					       dev_name(&spi->dev));
 			if (ret) {
 				dev_err(&spi->dev, "gpio_request_one() error\n");
 				goto error;
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
