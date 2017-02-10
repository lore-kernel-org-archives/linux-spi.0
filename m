From: Frode Isaksen <fisaksen@baylibre.com>
Subject: [PATCH 6/8] spi: loopback-test: set HW loopback mode if loopback set
Date: Fri, 10 Feb 2017 16:29:42 +0100
Message-ID: <1486740584-17875-7-git-send-email-fisaksen@baylibre.com>
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

Set the internal HW loopback mode if the loopback option
is set.

Signed-off-by: Frode Isaksen <fisaksen@baylibre.com>
---
 drivers/spi/spi-loopback-test.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/spi/spi-loopback-test.c b/drivers/spi/spi-loopback-test.c
index 50e620f..ce552af 100644
--- a/drivers/spi/spi-loopback-test.c
+++ b/drivers/spi/spi-loopback-test.c
@@ -285,6 +285,11 @@ static int spi_loopback_test_probe(struct spi_device *spi)
 
 	dev_info(&spi->dev, "Executing spi-loopback-tests\n");
 
+	if (loopback) {
+		spi->mode |= SPI_LOOP;
+		ret = spi_setup(spi);
+		dev_info(&spi->dev, "configure loopback return: %i\n", ret);
+	}
 	ret = spi_test_run_tests(spi, spi_tests);
 
 	dev_info(&spi->dev, "Finished spi-loopback-tests with return: %i\n",
-- 
2.7.4
