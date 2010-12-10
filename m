From: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Subject: [PATCH] dw_spi: Fix missing final read in some polling situations
Date: Fri, 10 Dec 2010 10:13:49 +0000
Message-ID: <20101210101241.12295.35368.stgit@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
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

From: Major Lee <major_lee-8+ZHUTgF1KZBDgjK7y7TUQ@public.gmane.org>

There is a possibility that the last word of a transaction will be lost if
data is not ready.  Re-read in poll_transfer() to solve this issue when
poll_mode is enabled.

Patch is against mainline (2.6.37-rc5).
Verified on SPI touch screen device.

Signed-off-by: Major Lee <major_lee-8+ZHUTgF1KZBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---

 drivers/spi/dw_spi.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)


diff --git a/drivers/spi/dw_spi.c b/drivers/spi/dw_spi.c
index 9c1d07b..497ecb3 100644
--- a/drivers/spi/dw_spi.c
+++ b/drivers/spi/dw_spi.c
@@ -419,6 +419,11 @@ static void poll_transfer(struct dw_spi *dws)
 {
 	while (dws->write(dws))
 		dws->read(dws);
+	/*
+	 * There is a possibility that the last word of a transaction
+	 * will be lost if data is not ready. Re-read to solve this issue.
+	 */
+	dws->read(dws);
 
 	dw_spi_xfer_done(dws);
 }


------------------------------------------------------------------------------
