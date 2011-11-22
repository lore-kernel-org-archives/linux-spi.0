From: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Subject: [PATCH 1/7] spi/pl022: only enable RX interrupts when TX is complete
Date: Tue, 22 Nov 2011 09:24:18 +0100
Message-ID: <1321950258-4683-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>,
	Chris Blair <chris.blair-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

From: Chris Blair <chris.blair-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>

For interrupt mode transfers, start with only TX interrupts enabled
to reduce the overall number of interrupts received. Once TX is
complete, enable RX interrupts to complete the transfer.

Reviewed-by: Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>
Signed-off-by: Chris Blair <chris.blair-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Signed-off-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
ChangeLog v1->v2:
- Fix comment style, add Viresh's Reviewed-by
---
 drivers/spi/spi-pl022.c |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index 5559b22..5b7209f 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -1244,9 +1244,9 @@ static irqreturn_t pl022_interrupt_handler(int irq, void *dev_id)
 
 	if ((pl022->tx == pl022->tx_end) && (flag == 0)) {
 		flag = 1;
-		/* Disable Transmit interrupt */
-		writew(readw(SSP_IMSC(pl022->virtbase)) &
-		       (~SSP_IMSC_MASK_TXIM),
+		/* Disable Transmit interrupt, enable receive interrupt */
+		writew((readw(SSP_IMSC(pl022->virtbase)) &
+		       ~SSP_IMSC_MASK_TXIM) | SSP_IMSC_MASK_RXIM,
 		       SSP_IMSC(pl022->virtbase));
 	}
 
@@ -1379,12 +1379,17 @@ static void pump_transfers(unsigned long data)
 	}
 
 err_config_dma:
-	writew(ENABLE_ALL_INTERRUPTS, SSP_IMSC(pl022->virtbase));
+	/* enable all interrupts except RX */
+	writew(ENABLE_ALL_INTERRUPTS & ~SSP_IMSC_MASK_RXIM, SSP_IMSC(pl022->virtbase));
 }
 
 static void do_interrupt_dma_transfer(struct pl022 *pl022)
 {
-	u32 irqflags = ENABLE_ALL_INTERRUPTS;
+	/*
+	 * Default is to enable all interrupts except RX -
+	 * this will be enabled once TX is complete
+	 */
+	u32 irqflags = ENABLE_ALL_INTERRUPTS & ~SSP_IMSC_MASK_RXIM;
 
 	/* Enable target chip */
 	pl022->cur_chip->cs_control(SSP_CHIP_SELECT);
-- 
1.7.3.2


------------------------------------------------------------------------------
All the data continuously generated in your IT infrastructure 
contains a definitive record of customers, application performance, 
security threats, fraudulent activity, and more. Splunk takes this 
data and makes sense of it. IT sense. And common sense.
http://p.sf.net/sfu/splunk-novd2d
