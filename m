From: Anatolij Gustschin <agust-ynQEQJNshbs@public.gmane.org>
Subject: [PATCH] spi: bitbang: initialize bits_per_word as specified by spi
	message
Date: Wed,  1 Jun 2011 18:36:49 +0200
Message-ID: <1306946209-28553-1-git-send-email-agust@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Anatolij Gustschin <agust-ynQEQJNshbs@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
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

SPI protocol drivers can submit messages specifying needed bits_per_word
parameter for a message transfer. The bitbang driver currently ignores
bits_per_word given by a singe message and always uses master's
bits_per_word parameter. Only use master's bits_per_word when a
message didn't specify needed bits_per_word for ongoing transfer.

Signed-off-by: Anatolij Gustschin <agust-ynQEQJNshbs@public.gmane.org>
---
 drivers/spi/spi_bitbang.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi_bitbang.c b/drivers/spi/spi_bitbang.c
index 14a63f6..bb38c83 100644
--- a/drivers/spi/spi_bitbang.c
+++ b/drivers/spi/spi_bitbang.c
@@ -68,7 +68,7 @@ static unsigned bitbang_txrx_8(
 	unsigned		ns,
 	struct spi_transfer	*t
 ) {
-	unsigned		bits = spi->bits_per_word;
+	unsigned		bits = t->bits_per_word ? : spi->bits_per_word;
 	unsigned		count = t->len;
 	const u8		*tx = t->tx_buf;
 	u8			*rx = t->rx_buf;
@@ -94,7 +94,7 @@ static unsigned bitbang_txrx_16(
 	unsigned		ns,
 	struct spi_transfer	*t
 ) {
-	unsigned		bits = spi->bits_per_word;
+	unsigned		bits = t->bits_per_word ? : spi->bits_per_word;
 	unsigned		count = t->len;
 	const u16		*tx = t->tx_buf;
 	u16			*rx = t->rx_buf;
@@ -120,7 +120,7 @@ static unsigned bitbang_txrx_32(
 	unsigned		ns,
 	struct spi_transfer	*t
 ) {
-	unsigned		bits = spi->bits_per_word;
+	unsigned		bits = t->bits_per_word ? : spi->bits_per_word;
 	unsigned		count = t->len;
 	const u32		*tx = t->tx_buf;
 	u32			*rx = t->rx_buf;
-- 
1.7.1


------------------------------------------------------------------------------
Simplify data backup and recovery for your virtual environment with vRanger. 
Installation's a snap, and flexible recovery options mean your data is safe,
secure and there when you need it. Data protection magic?
Nope - It's vRanger. Get your free trial download today. 
http://p.sf.net/sfu/quest-sfdev2dev
