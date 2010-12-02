From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: [PATCH 2/9] spi/pxa2xx: add support for shared IRQ handler
Date: Thu,  2 Dec 2010 18:47:30 +0100
Message-ID: <1291312057-7933-3-git-send-email-bigeasy@linutronix.de>
References: <1291312057-7933-1-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
	Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, sodaville-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org,
	Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1291312057-7933-1-git-send-email-bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

This is required in case the interrupt line is shared with other
devices.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Signed-off-by: Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/pxa2xx_spi.c |   15 ++++++++++++++-
 1 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/pxa2xx_spi.c b/drivers/spi/pxa2xx_spi.c
index 4e169b5..1865c23 100644
--- a/drivers/spi/pxa2xx_spi.c
+++ b/drivers/spi/pxa2xx_spi.c
@@ -742,6 +742,18 @@ static irqreturn_t ssp_int(int irq, void *dev_id)
 {
 	struct driver_data *drv_data = dev_id;
 	void __iomem *reg = drv_data->ioaddr;
+	u32 sccr1_reg = read_SSCR1(reg);
+	u32 mask = drv_data->mask_sr;
+	u32 status;
+
+	status = read_SSSR(reg);
+
+	/* Ignore possible writes if we don't need to write */
+	if (!(sccr1_reg & SSCR1_TIE))
+		mask &= ~SSSR_TFS;
+
+	if (!(status & mask))
+		return IRQ_NONE;
 
 	if (!drv_data->cur_msg) {
 
@@ -1512,7 +1524,8 @@ static int __devinit pxa2xx_spi_probe(struct platform_device *pdev)
 		drv_data->mask_sr = SSSR_TINT | SSSR_RFS | SSSR_TFS | SSSR_ROR;
 	}
 
-	status = request_irq(ssp->irq, ssp_int, 0, dev_name(dev), drv_data);
+	status = request_irq(ssp->irq, ssp_int, IRQF_SHARED, dev_name(dev),
+			drv_data);
 	if (status < 0) {
 		dev_err(&pdev->dev, "cannot get IRQ %d\n", ssp->irq);
 		goto out_error_master_alloc;
-- 
1.7.3.2


------------------------------------------------------------------------------
Increase Visibility of Your 3D Game App & Earn a Chance To Win $500!
Tap into the largest installed PC base & get more eyes on your game by
optimizing for Intel(R) Graphics Technology. Get started today with the
Intel(R) Software Partner Program. Five $500 cash prizes are up for grabs.
http://p.sf.net/sfu/intelisp-dev2dev
