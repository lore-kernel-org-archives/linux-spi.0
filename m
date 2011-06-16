From: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Subject: [PATCH 3/4] spi/pl022: strengthen FIFO watermark level checks
Date: Thu, 16 Jun 2011 10:14:46 +0200
Message-ID: <1308212086-22553-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
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

From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

The platform configuration can select custom FIFO watermarks, but
these may conflict the actual FIFO size of the PL022 variant if
set too high. So strengthen the sanity checks to deny any
conflicting settings.

Signed-off-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-pl022.c |   48 +++++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index 48fa8b0..eba88c7 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -1678,17 +1678,57 @@ static int verify_controller_parameters(struct pl022 *pl022,
 			"Communication mode is configured incorrectly\n");
 		return -EINVAL;
 	}
-	if ((chip_info->rx_lev_trig < SSP_RX_1_OR_MORE_ELEM)
-	    || (chip_info->rx_lev_trig > SSP_RX_32_OR_MORE_ELEM)) {
+	switch (chip_info->rx_lev_trig) {
+	case SSP_RX_1_OR_MORE_ELEM:
+	case SSP_RX_4_OR_MORE_ELEM:
+	case SSP_RX_8_OR_MORE_ELEM:
+		/* These are always OK, all variants can handle this */
+		break;
+	case SSP_RX_16_OR_MORE_ELEM:
+		if (pl022->vendor->fifodepth < 16) {
+			dev_err(&pl022->adev->dev,
+			"RX FIFO Trigger Level is configured incorrectly\n");
+			return -EINVAL;
+		}
+		break;
+	case SSP_RX_32_OR_MORE_ELEM:
+		if (pl022->vendor->fifodepth < 32) {
+			dev_err(&pl022->adev->dev,
+			"RX FIFO Trigger Level is configured incorrectly\n");
+			return -EINVAL;
+		}
+		break;
+	default:
 		dev_err(&pl022->adev->dev,
 			"RX FIFO Trigger Level is configured incorrectly\n");
 		return -EINVAL;
+		break;
 	}
-	if ((chip_info->tx_lev_trig < SSP_TX_1_OR_MORE_EMPTY_LOC)
-	    || (chip_info->tx_lev_trig > SSP_TX_32_OR_MORE_EMPTY_LOC)) {
+	switch (chip_info->tx_lev_trig) {
+	case SSP_TX_1_OR_MORE_EMPTY_LOC:
+	case SSP_TX_4_OR_MORE_EMPTY_LOC:
+	case SSP_TX_8_OR_MORE_EMPTY_LOC:
+		/* These are always OK, all variants can handle this */
+		break;
+	case SSP_TX_16_OR_MORE_EMPTY_LOC:
+		if (pl022->vendor->fifodepth < 16) {
+			dev_err(&pl022->adev->dev,
+			"TX FIFO Trigger Level is configured incorrectly\n");
+			return -EINVAL;
+		}
+		break;
+	case SSP_TX_32_OR_MORE_EMPTY_LOC:
+		if (pl022->vendor->fifodepth < 32) {
+			dev_err(&pl022->adev->dev,
+			"TX FIFO Trigger Level is configured incorrectly\n");
+			return -EINVAL;
+		}
+		break;
+	default:
 		dev_err(&pl022->adev->dev,
 			"TX FIFO Trigger Level is configured incorrectly\n");
 		return -EINVAL;
+		break;
 	}
 	if (chip_info->iface == SSP_INTERFACE_NATIONAL_MICROWIRE) {
 		if ((chip_info->ctrl_len < SSP_BITS_4)
-- 
1.7.3.2


------------------------------------------------------------------------------
EditLive Enterprise is the world's most technically advanced content
authoring tool. Experience the power of Track Changes, Inline Image
Editing and ensure content is compliant with Accessibility Checking.
http://p.sf.net/sfu/ephox-dev2dev
