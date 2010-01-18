From: jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: [PATCH 1/6] SPI: S3C64XX: Rename
	s3c64xx_spi_cntrlr_info
Date: Mon, 18 Jan 2010 18:50:10 +0900
Message-ID: <1263808215-16544-1-git-send-email-jassisinghbrar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, ben-SMNkleLxa3Z6Wcw2j4pizdi2O/JbrIOy@public.gmane.org
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Jassi Brar <jassi.brar-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

Rename 'struct s3c64xx_spi_cntrlr_info' to lesser wordy
'struct s3c64xx_spi_info'

Signed-off-by: Jassi Brar <jassi.brar-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/spi/spi_s3c64xx.c |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi_s3c64xx.c b/drivers/spi/spi_s3c64xx.c
index 88a456d..ad93d5d 100644
--- a/drivers/spi/spi_s3c64xx.c
+++ b/drivers/spi/spi_s3c64xx.c
@@ -160,7 +160,7 @@ struct s3c64xx_spi_driver_data {
 	struct platform_device          *pdev;
 	struct spi_master               *master;
 	struct workqueue_struct	        *workqueue;
-	struct s3c64xx_spi_cntrlr_info  *cntrlr_info;
+	struct s3c64xx_spi_info  *cntrlr_info;
 	struct spi_device               *tgl_spi;
 	struct work_struct              work;
 	struct list_head                queue;
@@ -180,7 +180,7 @@ static struct s3c2410_dma_client s3c64xx_spi_dma_client = {
 
 static void flush_fifo(struct s3c64xx_spi_driver_data *sdd)
 {
-	struct s3c64xx_spi_cntrlr_info *sci = sdd->cntrlr_info;
+	struct s3c64xx_spi_info *sci = sdd->cntrlr_info;
 	void __iomem *regs = sdd->regs;
 	unsigned long loops;
 	u32 val;
@@ -225,7 +225,7 @@ static void enable_datapath(struct s3c64xx_spi_driver_data *sdd,
 				struct spi_device *spi,
 				struct spi_transfer *xfer, int dma_mode)
 {
-	struct s3c64xx_spi_cntrlr_info *sci = sdd->cntrlr_info;
+	struct s3c64xx_spi_info *sci = sdd->cntrlr_info;
 	void __iomem *regs = sdd->regs;
 	u32 modecfg, chcfg;
 
@@ -310,7 +310,7 @@ static inline void enable_cs(struct s3c64xx_spi_driver_data *sdd,
 static int wait_for_xfer(struct s3c64xx_spi_driver_data *sdd,
 				struct spi_transfer *xfer, int dma_mode)
 {
-	struct s3c64xx_spi_cntrlr_info *sci = sdd->cntrlr_info;
+	struct s3c64xx_spi_info *sci = sdd->cntrlr_info;
 	void __iomem *regs = sdd->regs;
 	unsigned long val;
 	int ms;
@@ -389,7 +389,7 @@ static inline void disable_cs(struct s3c64xx_spi_driver_data *sdd,
 
 static void s3c64xx_spi_config(struct s3c64xx_spi_driver_data *sdd)
 {
-	struct s3c64xx_spi_cntrlr_info *sci = sdd->cntrlr_info;
+	struct s3c64xx_spi_info *sci = sdd->cntrlr_info;
 	void __iomem *regs = sdd->regs;
 	u32 val;
 
@@ -558,7 +558,7 @@ static void s3c64xx_spi_unmap_mssg(struct s3c64xx_spi_driver_data *sdd,
 static void handle_msg(struct s3c64xx_spi_driver_data *sdd,
 					struct spi_message *msg)
 {
-	struct s3c64xx_spi_cntrlr_info *sci = sdd->cntrlr_info;
+	struct s3c64xx_spi_info *sci = sdd->cntrlr_info;
 	struct spi_device *spi = msg->spi;
 	struct s3c64xx_spi_csinfo *cs = spi->controller_data;
 	struct spi_transfer *xfer;
@@ -786,7 +786,7 @@ static int s3c64xx_spi_setup(struct spi_device *spi)
 {
 	struct s3c64xx_spi_csinfo *cs = spi->controller_data;
 	struct s3c64xx_spi_driver_data *sdd;
-	struct s3c64xx_spi_cntrlr_info *sci;
+	struct s3c64xx_spi_info *sci;
 	struct spi_message *msg;
 	u32 psr, speed;
 	unsigned long flags;
@@ -867,7 +867,7 @@ setup_exit:
 
 static void s3c64xx_spi_hwinit(struct s3c64xx_spi_driver_data *sdd, int channel)
 {
-	struct s3c64xx_spi_cntrlr_info *sci = sdd->cntrlr_info;
+	struct s3c64xx_spi_info *sci = sdd->cntrlr_info;
 	void __iomem *regs = sdd->regs;
 	unsigned int val;
 
@@ -902,7 +902,7 @@ static int __init s3c64xx_spi_probe(struct platform_device *pdev)
 {
 	struct resource	*mem_res, *dmatx_res, *dmarx_res;
 	struct s3c64xx_spi_driver_data *sdd;
-	struct s3c64xx_spi_cntrlr_info *sci;
+	struct s3c64xx_spi_info *sci;
 	struct spi_master *master;
 	int ret;
 
@@ -1078,7 +1078,7 @@ static int s3c64xx_spi_remove(struct platform_device *pdev)
 {
 	struct spi_master *master = spi_master_get(platform_get_drvdata(pdev));
 	struct s3c64xx_spi_driver_data *sdd = spi_master_get_devdata(master);
-	struct s3c64xx_spi_cntrlr_info *sci = sdd->cntrlr_info;
+	struct s3c64xx_spi_info *sci = sdd->cntrlr_info;
 	struct resource	*mem_res;
 	unsigned long flags;
 
@@ -1118,7 +1118,7 @@ static int s3c64xx_spi_suspend(struct platform_device *pdev, pm_message_t state)
 {
 	struct spi_master *master = spi_master_get(platform_get_drvdata(pdev));
 	struct s3c64xx_spi_driver_data *sdd = spi_master_get_devdata(master);
-	struct s3c64xx_spi_cntrlr_info *sci = sdd->cntrlr_info;
+	struct s3c64xx_spi_info *sci = sdd->cntrlr_info;
 	struct s3c64xx_spi_csinfo *cs;
 	unsigned long flags;
 
@@ -1144,7 +1144,7 @@ static int s3c64xx_spi_resume(struct platform_device *pdev)
 {
 	struct spi_master *master = spi_master_get(platform_get_drvdata(pdev));
 	struct s3c64xx_spi_driver_data *sdd = spi_master_get_devdata(master);
-	struct s3c64xx_spi_cntrlr_info *sci = sdd->cntrlr_info;
+	struct s3c64xx_spi_info *sci = sdd->cntrlr_info;
 	unsigned long flags;
 
 	sci->cfg_gpio(pdev);
-- 
1.6.2.5


------------------------------------------------------------------------------
Throughout its 18-year history, RSA Conference consistently attracts the
world's best and brightest in the field, creating opportunities for Conference
attendees to learn about information security's most important issues through
interactions with peers, luminaries and emerging and established companies.
http://p.sf.net/sfu/rsaconf-dev2dev
