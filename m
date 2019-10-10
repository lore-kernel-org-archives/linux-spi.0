From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 25/36] ARM: s3c: spi: avoid hardcoding fiq number in driver
Date: Thu, 10 Oct 2019 22:30:09 +0200
Message-ID: <20191010203043.1241612-25-arnd@arndb.de>
References: <20191010202802.1132272-1-arnd@arndb.de>
 <20191010203043.1241612-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-samsung-soc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 linus.walleij@linaro.org, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
To: Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20191010203043.1241612-1-arnd@arndb.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

The IRQ_EINT0 constant is a platform detail that is
defined in mach/irqs.h and not visible to drivers once
that header is made private.

Since the same calculation already happens in s3c24xx_set_fiq,
just return the value from there.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-s3c24xx/irq-s3c24xx.c | 12 +++++++++---
 drivers/spi/spi-s3c24xx.c           | 18 ++----------------
 include/linux/spi/s3c24xx.h         |  2 +-
 3 files changed, 12 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/irq-s3c24xx.c b/arch/arm/mach-s3c24xx/irq-s3c24xx.c
index b0e879ee14c1..3965347cacf0 100644
--- a/arch/arm/mach-s3c24xx/irq-s3c24xx.c
+++ b/arch/arm/mach-s3c24xx/irq-s3c24xx.c
@@ -376,14 +376,17 @@ asmlinkage void __exception_irq_entry s3c24xx_handle_irq(struct pt_regs *regs)
 /**
  * s3c24xx_set_fiq - set the FIQ routing
  * @irq: IRQ number to route to FIQ on processor.
+ * @ack_ptr: pointer to a location for storing the bit mask
  * @on: Whether to route @irq to the FIQ, or to remove the FIQ routing.
  *
  * Change the state of the IRQ to FIQ routing depending on @irq and @on. If
  * @on is true, the @irq is checked to see if it can be routed and the
  * interrupt controller updated to route the IRQ. If @on is false, the FIQ
  * routing is cleared, regardless of which @irq is specified.
+ *
+ * returns the mask value for the register.
  */
-int s3c24xx_set_fiq(unsigned int irq, bool on)
+int s3c24xx_set_fiq(unsigned int irq, u32 *ack_ptr, bool on)
 {
 	u32 intmod;
 	unsigned offs;
@@ -391,15 +394,18 @@ int s3c24xx_set_fiq(unsigned int irq, bool on)
 	if (on) {
 		offs = irq - FIQ_START;
 		if (offs > 31)
-			return -EINVAL;
+			return 0;
 
 		intmod = 1 << offs;
 	} else {
 		intmod = 0;
 	}
 
+	if (ack_ptr)
+		*ack_ptr = intmod;
 	writel_relaxed(intmod, S3C2410_INTMOD);
-	return 0;
+
+	return intmod;
 }
 
 EXPORT_SYMBOL_GPL(s3c24xx_set_fiq);
diff --git a/drivers/spi/spi-s3c24xx.c b/drivers/spi/spi-s3c24xx.c
index 464146fc8420..58025876a081 100644
--- a/drivers/spi/spi-s3c24xx.c
+++ b/drivers/spi/spi-s3c24xx.c
@@ -229,17 +229,6 @@ struct spi_fiq_code {
 	u8	data[0];
 };
 
-/**
- * ack_bit - turn IRQ into IRQ acknowledgement bit
- * @irq: The interrupt number
- *
- * Returns the bit to write to the interrupt acknowledge register.
- */
-static inline u32 ack_bit(unsigned int irq)
-{
-	return 1 << (irq - IRQ_EINT0);
-}
-
 /**
  * s3c24xx_spi_tryfiq - attempt to claim and setup FIQ for transfer
  * @hw: The hardware state.
@@ -256,6 +245,7 @@ static void s3c24xx_spi_tryfiq(struct s3c24xx_spi *hw)
 	struct pt_regs regs;
 	enum spi_fiq_mode mode;
 	struct spi_fiq_code *code;
+	u32 *ack_ptr = NULL;
 	int ret;
 
 	if (!hw->fiq_claimed) {
@@ -282,8 +272,6 @@ static void s3c24xx_spi_tryfiq(struct s3c24xx_spi *hw)
 	set_fiq_regs(&regs);
 
 	if (hw->fiq_mode != mode) {
-		u32 *ack_ptr;
-
 		hw->fiq_mode = mode;
 
 		switch (mode) {
@@ -303,12 +291,10 @@ static void s3c24xx_spi_tryfiq(struct s3c24xx_spi *hw)
 		BUG_ON(!code);
 
 		ack_ptr = (u32 *)&code->data[code->ack_offset];
-		*ack_ptr = ack_bit(hw->irq);
-
 		set_fiq_handler(&code->data, code->length);
 	}
 
-	s3c24xx_set_fiq(hw->irq, true);
+	s3c24xx_set_fiq(hw->irq, ack_ptr, true);
 
 	hw->fiq_mode = mode;
 	hw->fiq_inuse = 1;
diff --git a/include/linux/spi/s3c24xx.h b/include/linux/spi/s3c24xx.h
index c91d10b82f08..440a71593162 100644
--- a/include/linux/spi/s3c24xx.h
+++ b/include/linux/spi/s3c24xx.h
@@ -20,6 +20,6 @@ struct s3c2410_spi_info {
 	void (*set_cs)(struct s3c2410_spi_info *spi, int cs, int pol);
 };
 
-extern int s3c24xx_set_fiq(unsigned int irq, bool on);
+extern int s3c24xx_set_fiq(unsigned int irq, u32 *ack_ptr, bool on);
 
 #endif /* __LINUX_SPI_S3C24XX_H */
-- 
2.20.0
