From: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Subject: [PATCH 21/28] drivers: spi: Call cpu_latency_qos_*() instead of pm_qos_*()
Date: Wed, 12 Feb 2020 00:26:04 +0100
Message-ID: <3093071.fpHvlHfnRF@kreacher>
References: <1654227.8mz0SueHsU@kreacher>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Amit Kucheria <amit.kucheria-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
        Han Xu <han.xu-3arQi8VN3Tc@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux PM <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1654227.8mz0SueHsU@kreacher>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

Call cpu_latency_qos_add/remove_request() instead of
pm_qos_add/remove_request(), respectively, because the
latter are going to be dropped.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-fsl-qspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
index e8a499cd1f13..02e5cba0a5bb 100644
--- a/drivers/spi/spi-fsl-qspi.c
+++ b/drivers/spi/spi-fsl-qspi.c
@@ -484,7 +484,7 @@ static int fsl_qspi_clk_prep_enable(struct fsl_qspi *q)
 	}
 
 	if (needs_wakeup_wait_mode(q))
-		pm_qos_add_request(&q->pm_qos_req, PM_QOS_CPU_DMA_LATENCY, 0);
+		cpu_latency_qos_add_request(&q->pm_qos_req, 0);
 
 	return 0;
 }
@@ -492,7 +492,7 @@ static int fsl_qspi_clk_prep_enable(struct fsl_qspi *q)
 static void fsl_qspi_clk_disable_unprep(struct fsl_qspi *q)
 {
 	if (needs_wakeup_wait_mode(q))
-		pm_qos_remove_request(&q->pm_qos_req);
+		cpu_latency_qos_remove_request(&q->pm_qos_req);
 
 	clk_disable_unprepare(q->clk);
 	clk_disable_unprepare(q->clk_en);
-- 
2.16.4
