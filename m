From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [PATCH 1/2] spi: spi-gpio: Add checks for the dt properties
Date: Thu, 27 Dec 2012 22:54:47 +0100
Message-ID: <1356645288-10110-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1356645288-10110-1-git-send-email-maxime.ripard@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Grant Likely <grant.likely@secretlab.ca>,
 spi-devel-general@lists.sourceforge.net, Brian Lilly <brian@crystalfontz.com>
To: linux-arm-kernel@lists.infradead.org,
	Shawn Guo <shawn.guo@linaro.org>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1356645288-10110-1-git-send-email-maxime.ripard@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

The bindings assumed that the gpios properties were always there, which
made the NO_TX and NO_RX mode not usable from device tree. Add extra
checks to make sure that the driver can work if either MOSI or MISO is
not used.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/spi/spi-gpio.c |   23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-gpio.c b/drivers/spi/spi-gpio.c
index c7cf0b7..9ddef55 100644
--- a/drivers/spi/spi-gpio.c
+++ b/drivers/spi/spi-gpio.c
@@ -365,9 +365,26 @@ static int spi_gpio_probe_dt(struct platform_device *pdev)
 	if (!pdata)
 		return -ENOMEM;
 
-	pdata->sck = of_get_named_gpio(np, "gpio-sck", 0);
-	pdata->miso = of_get_named_gpio(np, "gpio-miso", 0);
-	pdata->mosi = of_get_named_gpio(np, "gpio-mosi", 0);
+	ret = of_get_named_gpio(np, "gpio-sck", 0);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "gpio-sck property not found\n");
+		goto error_free;
+	}
+	pdata->sck = ret;
+
+	ret = of_get_named_gpio(np, "gpio-miso", 0);
+	if (ret < 0) {
+		dev_info(&pdev->dev, "gpio-miso property not found, switching to no-rx mode\n");
+		pdata->miso = SPI_GPIO_NO_MISO;
+	} else
+		pdata->miso = ret;
+
+	ret = of_get_named_gpio(np, "gpio-mosi", 0);
+	if (ret < 0) {
+		dev_info(&pdev->dev, "gpio-mosi property not found, switching to no-tx mode\n");
+		pdata->mosi = SPI_GPIO_NO_MOSI;
+	} else
+		pdata->mosi = ret;
 
 	ret = of_property_read_u32(np, "num-chipselects", &tmp);
 	if (ret < 0) {
-- 
1.7.9.5
