From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: [patch 2.6.25-rc2] spi: pxa2xx_spi "sparse"
	fixes
Date: Wed, 20 Feb 2008 17:29:24 -0800
Message-ID: <200802201729.24641.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Stephen Street <stephen-nl6u4wocdmy51APUEpUfAkEOCMrvLtNR@public.gmane.org>
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Various cleanups to pxa2xx_spi suggested by "sparse":  make sure
that register addresess are "void __iomem *", and make a few
functions properly static.

Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
 drivers/spi/pxa2xx_spi.c |   52 +++++++++++++++++++++++++----------------------
 1 file changed, 28 insertions(+), 24 deletions(-)

--- a/drivers/spi/pxa2xx_spi.c	2008-02-20 17:17:16.000000000 -0800
+++ b/drivers/spi/pxa2xx_spi.c	2008-02-20 17:19:06.000000000 -0800
@@ -66,8 +66,11 @@ MODULE_LICENSE("GPL");
 				| SSCR1_SPH | SSCR1_SPO | SSCR1_LBM)
 
 #define DEFINE_SSP_REG(reg, off) \
-static inline u32 read_##reg(void *p) { return __raw_readl(p + (off)); } \
-static inline void write_##reg(u32 v, void *p) { __raw_writel(v, p + (off)); }
+static inline u32 read_##reg(void const __iomem *p) \
+{ return __raw_readl(p + (off)); } \
+\
+static inline void write_##reg(u32 v, void __iomem *p) \
+{ __raw_writel(v, p + (off)); }
 
 DEFINE_SSP_REG(SSCR0, 0x00)
 DEFINE_SSP_REG(SSCR1, 0x04)
@@ -105,7 +108,7 @@ struct driver_data {
 	u32 *null_dma_buf;
 
 	/* SSP register addresses */
-	void *ioaddr;
+	void __iomem *ioaddr;
 	u32 ssdr_physical;
 
 	/* SSP masks*/
@@ -172,7 +175,7 @@ static int flush(struct driver_data *drv
 {
 	unsigned long limit = loops_per_jiffy << 1;
 
-	void *reg = drv_data->ioaddr;
+	void __iomem *reg = drv_data->ioaddr;
 
 	do {
 		while (read_SSSR(reg) & SSSR_RNE) {
@@ -190,7 +193,7 @@ static void null_cs_control(u32 command)
 
 static int null_writer(struct driver_data *drv_data)
 {
-	void *reg = drv_data->ioaddr;
+	void __iomem *reg = drv_data->ioaddr;
 	u8 n_bytes = drv_data->n_bytes;
 
 	if (((read_SSSR(reg) & 0x00000f00) == 0x00000f00)
@@ -205,7 +208,7 @@ static int null_writer(struct driver_dat
 
 static int null_reader(struct driver_data *drv_data)
 {
-	void *reg = drv_data->ioaddr;
+	void __iomem *reg = drv_data->ioaddr;
 	u8 n_bytes = drv_data->n_bytes;
 
 	while ((read_SSSR(reg) & SSSR_RNE)
@@ -219,7 +222,7 @@ static int null_reader(struct driver_dat
 
 static int u8_writer(struct driver_data *drv_data)
 {
-	void *reg = drv_data->ioaddr;
+	void __iomem *reg = drv_data->ioaddr;
 
 	if (((read_SSSR(reg) & 0x00000f00) == 0x00000f00)
 		|| (drv_data->tx == drv_data->tx_end))
@@ -233,7 +236,7 @@ static int u8_writer(struct driver_data 
 
 static int u8_reader(struct driver_data *drv_data)
 {
-	void *reg = drv_data->ioaddr;
+	void __iomem *reg = drv_data->ioaddr;
 
 	while ((read_SSSR(reg) & SSSR_RNE)
 		&& (drv_data->rx < drv_data->rx_end)) {
@@ -246,7 +249,7 @@ static int u8_reader(struct driver_data 
 
 static int u16_writer(struct driver_data *drv_data)
 {
-	void *reg = drv_data->ioaddr;
+	void __iomem *reg = drv_data->ioaddr;
 
 	if (((read_SSSR(reg) & 0x00000f00) == 0x00000f00)
 		|| (drv_data->tx == drv_data->tx_end))
@@ -260,7 +263,7 @@ static int u16_writer(struct driver_data
 
 static int u16_reader(struct driver_data *drv_data)
 {
-	void *reg = drv_data->ioaddr;
+	void __iomem *reg = drv_data->ioaddr;
 
 	while ((read_SSSR(reg) & SSSR_RNE)
 		&& (drv_data->rx < drv_data->rx_end)) {
@@ -273,7 +276,7 @@ static int u16_reader(struct driver_data
 
 static int u32_writer(struct driver_data *drv_data)
 {
-	void *reg = drv_data->ioaddr;
+	void __iomem *reg = drv_data->ioaddr;
 
 	if (((read_SSSR(reg) & 0x00000f00) == 0x00000f00)
 		|| (drv_data->tx == drv_data->tx_end))
@@ -287,7 +290,7 @@ static int u32_writer(struct driver_data
 
 static int u32_reader(struct driver_data *drv_data)
 {
-	void *reg = drv_data->ioaddr;
+	void __iomem *reg = drv_data->ioaddr;
 
 	while ((read_SSSR(reg) & SSSR_RNE)
 		&& (drv_data->rx < drv_data->rx_end)) {
@@ -411,7 +414,7 @@ static void giveback(struct driver_data 
 		msg->complete(msg->context);
 }
 
-static int wait_ssp_rx_stall(void *ioaddr)
+static int wait_ssp_rx_stall(void const __iomem *ioaddr)
 {
 	unsigned long limit = loops_per_jiffy << 1;
 
@@ -431,9 +434,9 @@ static int wait_dma_channel_stop(int cha
 	return limit;
 }
 
-void dma_error_stop(struct driver_data *drv_data, const char *msg)
+static void dma_error_stop(struct driver_data *drv_data, const char *msg)
 {
-	void *reg = drv_data->ioaddr;
+	void __iomem *reg = drv_data->ioaddr;
 
 	/* Stop and reset */
 	DCSR(drv_data->rx_channel) = RESET_DMA_CHANNEL;
@@ -455,7 +458,7 @@ void dma_error_stop(struct driver_data *
 
 static void dma_transfer_complete(struct driver_data *drv_data)
 {
-	void *reg = drv_data->ioaddr;
+	void __iomem *reg = drv_data->ioaddr;
 	struct spi_message *msg = drv_data->cur_msg;
 
 	/* Clear and disable interrupts on SSP and DMA channels*/
@@ -535,7 +538,7 @@ static void dma_handler(int channel, voi
 static irqreturn_t dma_transfer(struct driver_data *drv_data)
 {
 	u32 irq_status;
-	void *reg = drv_data->ioaddr;
+	void __iomem *reg = drv_data->ioaddr;
 
 	irq_status = read_SSSR(reg) & drv_data->mask_sr;
 	if (irq_status & SSSR_ROR) {
@@ -569,7 +572,7 @@ static irqreturn_t dma_transfer(struct d
 
 static void int_error_stop(struct driver_data *drv_data, const char* msg)
 {
-	void *reg = drv_data->ioaddr;
+	void __iomem *reg = drv_data->ioaddr;
 
 	/* Stop and reset SSP */
 	write_SSSR(drv_data->clear_sr, reg);
@@ -587,7 +590,7 @@ static void int_error_stop(struct driver
 
 static void int_transfer_complete(struct driver_data *drv_data)
 {
-	void *reg = drv_data->ioaddr;
+	void __iomem *reg = drv_data->ioaddr;
 
 	/* Stop SSP */
 	write_SSSR(drv_data->clear_sr, reg);
@@ -613,7 +616,7 @@ static void int_transfer_complete(struct
 
 static irqreturn_t interrupt_transfer(struct driver_data *drv_data)
 {
-	void *reg = drv_data->ioaddr;
+	void __iomem *reg = drv_data->ioaddr;
 
 	u32 irq_mask = (read_SSCR1(reg) & SSCR1_TIE) ?
 			drv_data->mask_sr : drv_data->mask_sr & ~SSSR_TFS;
@@ -674,7 +677,7 @@ static irqreturn_t interrupt_transfer(st
 static irqreturn_t ssp_int(int irq, void *dev_id)
 {
 	struct driver_data *drv_data = dev_id;
-	void *reg = drv_data->ioaddr;
+	void __iomem *reg = drv_data->ioaddr;
 
 	if (!drv_data->cur_msg) {
 
@@ -694,7 +697,8 @@ static irqreturn_t ssp_int(int irq, void
 	return drv_data->transfer_handler(drv_data);
 }
 
-int set_dma_burst_and_threshold(struct chip_data *chip, struct spi_device *spi,
+static int set_dma_burst_and_threshold(struct chip_data *chip,
+				struct spi_device *spi,
 				u8 bits_per_word, u32 *burst_code,
 				u32 *threshold)
 {
@@ -808,7 +812,7 @@ static void pump_transfers(unsigned long
 	struct spi_transfer *previous = NULL;
 	struct chip_data *chip = NULL;
 	struct ssp_device *ssp = drv_data->ssp;
-	void *reg = drv_data->ioaddr;
+	void __iomem *reg = drv_data->ioaddr;
 	u32 clk_div = 0;
 	u8 bits = 0;
 	u32 speed = 0;
@@ -1337,7 +1341,7 @@ static int __init pxa2xx_spi_probe(struc
 	struct device *dev = &pdev->dev;
 	struct pxa2xx_spi_master *platform_info;
 	struct spi_master *master;
-	struct driver_data *drv_data = 0;
+	struct driver_data *drv_data = NULL;
 	struct ssp_device *ssp;
 	int status = 0;
 

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
