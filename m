From: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] spi/dw_spi: add a FIFO depth detection
Date: Thu, 21 Jan 2010 10:51:39 +0800
Message-ID: <20100121105139.3d0fbd42@feng-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: spi-devel-list <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Grant Likely
	<grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
	David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

>From aa51023622a3393dc8f412b11e9db2f5fc0334ad Mon Sep 17 00:00:00 2001
From: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Date: Thu, 21 Jan 2010 10:41:10 +0800
Subject: [PATCH] spi/dw_spi: add a FIFO depth detection

FIFO depth is configurable for each implementation of DW core,
so add a depth detection for those interface drivers who don't set
the fifo_len explicitly

Signed-off-by: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/dw_spi.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/drivers/spi/dw_spi.c b/drivers/spi/dw_spi.c
index 4e2774c..0e76a6e 100644
--- a/drivers/spi/dw_spi.c
+++ b/drivers/spi/dw_spi.c
@@ -990,6 +990,22 @@ static void spi_hw_init(struct dw_spi *dws)
 	spi_mask_intr(dws, 0xff);
 	spi_enable_chip(dws, 1);
 	flush(dws);
+
+	/*
+	 * Try to detect the FIFO depth if not set by interface driver,
+	 * the depth could be from 2 to 256 from HW spec
+	 */
+	if (!dws->fifo_len) {
+		u32 fifo;
+		for (fifo = 2; fifo <= 257; fifo++) {
+			dw_writew(dws, txfltr, fifo);
+			if (fifo != dw_readw(dws, txfltr))
+				break;
+		}
+
+		dws->fifo_len = (fifo == 257) ? 0 : fifo;
+		dw_writew(dws, txfltr, 0);
+	}
 }
 
 int __devinit dw_spi_add_host(struct dw_spi *dws)
-- 
1.6.0.4

------------------------------------------------------------------------------
Throughout its 18-year history, RSA Conference consistently attracts the
world's best and brightest in the field, creating opportunities for Conference
attendees to learn about information security's most important issues through
interactions with peers, luminaries and emerging and established companies.
http://p.sf.net/sfu/rsaconf-dev2dev
