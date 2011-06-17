From: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 1/4 v2] spi/bfin_spi: fix handling of default bits per word
	setting
Date: Fri, 17 Jun 2011 04:35:37 -0400
Message-ID: <1308299737-3806-1-git-send-email-vapier@gentoo.org>
References: <1308298618-23461-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1308298618-23461-1-git-send-email-vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

The default bits per word setting should be 8 bits, but since most of our
devices have been explicitly setting this up, we didn't notice when the
default stopped working.

At the moment, any default transfers without an explicit bit size setting
error out with:
bfin-spi bfin-spi.0: transfer: unsupported bits_per_word

So in the transfer logic, have a bits_per_word setting of 0 fall into the
8 bit transfer logic.

Signed-off-by: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
---
v2
	- wasn't quite as simple as i'd hope ...

 drivers/spi/spi_bfin5xx.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi_bfin5xx.c b/drivers/spi/spi_bfin5xx.c
index ae30fa3..1f123b9 100644
--- a/drivers/spi/spi_bfin5xx.c
+++ b/drivers/spi/spi_bfin5xx.c
@@ -681,13 +681,14 @@ static void bfin_spi_pump_transfers(unsigned long data)
 	drv_data->cs_change = transfer->cs_change;
 
 	/* Bits per word setup */
-	bits_per_word = transfer->bits_per_word ? : message->spi->bits_per_word;
-	if ((bits_per_word > 0) && (bits_per_word % 16 == 0)) {
+	bits_per_word = transfer->bits_per_word ? :
+		message->spi->bits_per_word ? : 8;
+	if (bits_per_word % 16 == 0) {
 		drv_data->n_bytes = bits_per_word/8;
 		drv_data->len = (transfer->len) >> 1;
 		cr_width = BIT_CTL_WORDSIZE;
 		drv_data->ops = &bfin_bfin_spi_transfer_ops_u16;
-	} else if ((bits_per_word > 0) && (bits_per_word % 8 == 0)) {
+	} else if (bits_per_word % 8 == 0) {
 		drv_data->n_bytes = bits_per_word/8;
 		drv_data->len = transfer->len;
 		cr_width = 0;
-- 
1.7.5.3


------------------------------------------------------------------------------
EditLive Enterprise is the world's most technically advanced content
authoring tool. Experience the power of Track Changes, Inline Image
Editing and ensure content is compliant with Accessibility Checking.
http://p.sf.net/sfu/ephox-dev2dev
