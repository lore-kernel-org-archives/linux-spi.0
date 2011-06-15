From: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Subject: [PATCH] spi/bfin_spi: fix reverse condition during interrupt mode
Date: Wed, 15 Jun 2011 15:41:11 -0400
Message-ID: <1308166871-27312-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, Bob Liu <lliubbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
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

From: Bob Liu <lliubbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Commit 4d676fc5c39a677aa72148 "drivers:spi_bfin5xx: add support for
multiples of 8bits" introduced a bug during interrupt mode.  The if
condition was inverted which can cause some bugs such as the SPI
mmc in interrupt mode fails to detect SD cards.

Signed-off-by: Bob Liu <lliubbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi_bfin5xx.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi_bfin5xx.c b/drivers/spi/spi_bfin5xx.c
index f706dba..ae30fa3 100644
--- a/drivers/spi/spi_bfin5xx.c
+++ b/drivers/spi/spi_bfin5xx.c
@@ -436,7 +436,7 @@ static irqreturn_t bfin_spi_pio_irq_handler(int irq, void *dev_id)
 		/* last read */
 		if (drv_data->rx) {
 			dev_dbg(&drv_data->pdev->dev, "last read\n");
-			if (n_bytes % 2) {
+			if (!(n_bytes % 2)) {
 				u16 *buf = (u16 *)drv_data->rx;
 				for (loop = 0; loop < n_bytes / 2; loop++)
 					*buf++ = read_RDBR(drv_data);
@@ -464,7 +464,7 @@ static irqreturn_t bfin_spi_pio_irq_handler(int irq, void *dev_id)
 	if (drv_data->rx && drv_data->tx) {
 		/* duplex */
 		dev_dbg(&drv_data->pdev->dev, "duplex: write_TDBR\n");
-		if (n_bytes % 2) {
+		if (!(n_bytes % 2)) {
 			u16 *buf = (u16 *)drv_data->rx;
 			u16 *buf2 = (u16 *)drv_data->tx;
 			for (loop = 0; loop < n_bytes / 2; loop++) {
@@ -482,7 +482,7 @@ static irqreturn_t bfin_spi_pio_irq_handler(int irq, void *dev_id)
 	} else if (drv_data->rx) {
 		/* read */
 		dev_dbg(&drv_data->pdev->dev, "read: write_TDBR\n");
-		if (n_bytes % 2) {
+		if (!(n_bytes % 2)) {
 			u16 *buf = (u16 *)drv_data->rx;
 			for (loop = 0; loop < n_bytes / 2; loop++) {
 				*buf++ = read_RDBR(drv_data);
@@ -498,7 +498,7 @@ static irqreturn_t bfin_spi_pio_irq_handler(int irq, void *dev_id)
 	} else if (drv_data->tx) {
 		/* write */
 		dev_dbg(&drv_data->pdev->dev, "write: write_TDBR\n");
-		if (n_bytes % 2) {
+		if (!(n_bytes % 2)) {
 			u16 *buf = (u16 *)drv_data->tx;
 			for (loop = 0; loop < n_bytes / 2; loop++) {
 				read_RDBR(drv_data);
-- 
1.7.5.3


------------------------------------------------------------------------------
EditLive Enterprise is the world's most technically advanced content
authoring tool. Experience the power of Track Changes, Inline Image
Editing and ensure content is compliant with Accessibility Checking.
http://p.sf.net/sfu/ephox-dev2dev
