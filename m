From: Icenowy Zheng <icenowy@aosc.xyz>
Subject: [PATCH] spi: sun6i: update max transfer size reported
Date: Mon, 20 Mar 2017 22:38:49 +0800
Message-ID: <20170320143849.13213-1-icenowy@aosc.xyz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Martin Ayotte <martinayotte@gmail.com>, Icenowy Zheng <icenowy@aosc.xyz>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-spi@vger.kernel.org
To: Mark Brown <broonie@kernel.org>,
 Maxime Ripard <maxime.ripard@free-electrons.com>,
 Chen-Yu Tsai <wens@csie.org>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

The spi-sun6i driver have already got the ability to do large transfers.
However, the max transfer size reported is still fifo depth - 1.

Update the max transfer size reported to the max value possible.

Reported-by: Martin Ayotte <martinayotte@gmail.com>
Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
 drivers/spi/spi-sun6i.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index 6e9ca93db9bf..03a773a9531a 100644
--- a/drivers/spi/spi-sun6i.c
+++ b/drivers/spi/spi-sun6i.c
@@ -194,9 +194,7 @@ static void sun6i_spi_set_cs(struct spi_device *spi, bool enable)
 
 static size_t sun6i_spi_max_transfer_size(struct spi_device *spi)
 {
-	struct sun6i_spi *sspi = spi_master_get_devdata(spi->master);
-
-	return sspi->fifo_depth - 1;
+	return SUN6I_MAX_XFER_SIZE - 1;
 }
 
 static int sun6i_spi_transfer_one(struct spi_master *master,
-- 
2.12.0
