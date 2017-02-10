From: Frode Isaksen <fisaksen@baylibre.com>
Subject: [PATCH 8/8] spi: loopback-test: limit length to
 spi_max_transfer_size()
Date: Fri, 10 Feb 2017 16:29:44 +0100
Message-ID: <1486740584-17875-9-git-send-email-fisaksen@baylibre.com>
References: <1486740584-17875-1-git-send-email-fisaksen@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Frode Isaksen <fisaksen@baylibre.com>, broonie@kernel.org,
 linux-spi@vger.kernel.org
To: nsekhar@ti.com, khilman@baylibre.com, ptitiano@baylibre.com,
 linux-arm-kernel@lists.infradead.org
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1486740584-17875-1-git-send-email-fisaksen@baylibre.com>
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

Limit length to spi_max_transfer_size() in the
spi loopback test driver.

Signed-off-by: Frode Isaksen <fisaksen@baylibre.com>
---
 drivers/spi/spi-loopback-test.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-loopback-test.c b/drivers/spi/spi-loopback-test.c
index 5618df3..e1e698e 100644
--- a/drivers/spi/spi-loopback-test.c
+++ b/drivers/spi/spi-loopback-test.c
@@ -796,6 +796,9 @@ static int spi_test_run_iter(struct spi_device *spi,
 		return 0;
 	}
 
+	/* limit length to spi max transfer size */
+	len = min(spi_max_transfer_size(spi), len);
+
 	/* write out info */
 	if (!(len || tx_off || rx_off)) {
 		dev_info(&spi->dev, "Running test %s\n", test.description);
-- 
2.7.4
