From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: [PATCH 2/9] spi: bcm2835aux: warn in dmesg that native cs is not
 really supported
Date: Sun, 24 Feb 2019 12:54:33 +0000
Message-ID: <20190224125440.16117-3-kernel@martin.sperl.org>
References: <20190224125440.16117-1-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>,
 Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>,
 Hubert Denkmair <h.denkmair-4pT7WzY1KUiELgA04lAiVw@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
 linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20190224125440.16117-1-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rpi-kernel/>
List-Post: <mailto:linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "linux-rpi-kernel" <linux-rpi-kernel-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

>From personal bad experience (even as the author of the original driver)
it shows that native-cs is "somewhat" supported by the spi bus driver
when using a buggy device tree.

So make sure that the driver is warning in dmesg about this fact
that we are running in a not supported mode that may have surprizing
limitations.

Fixes: 1ea29b39f4c812ece2f936065a0a3d6fe44a263e
Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
---
 drivers/spi/spi-bcm2835aux.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/spi/spi-bcm2835aux.c b/drivers/spi/spi-bcm2835aux.c
index 2ece25250d86..4b6fdcb2cf4b 100644
--- a/drivers/spi/spi-bcm2835aux.c
+++ b/drivers/spi/spi-bcm2835aux.c
@@ -420,6 +420,38 @@ static void bcm2835aux_spi_handle_err(struct spi_master *master,
 	bcm2835aux_spi_reset_hw(bs);
 }

+static int bcm2835aux_spi_setup(struct spi_device *spi)
+{
+	int ret;
+
+	if (spi->mode & SPI_NO_CS)
+		return 0;
+	/* sanity check for native cs */
+	if (!gpio_is_valid(spi->cs_gpio)) {
+		/* for dt-backwards compatibility: only support native on CS0
+		 * known things not supported with broken native CS:
+		 * * multiple chip-selects: cs0-cs2 are all
+		 *     simultaniously asserted whenever there is a transfer
+		 *     this even includes SPI_NO_CS
+		 * * SPI_CS_HIGH: cs are always asserted low
+		 * * cs_change: cs is deasserted after each spi_transfer
+		 * * cs_delay_usec: cs is always deasserted one SCK cycle
+		 *     after the last transfer
+		 * probably more...
+		 */
+		if (spi->chip_select == 0) {
+			dev_err(&spi->dev,
+				"native CS is not supported but may work for some use-cases for cs = 0 -  please define a valid value cs-gpios in DT for complete feature set\n");
+			return 0;
+		}
+		dev_err(&spi->dev,
+			"native CS is not supported for cs > 0 -  please define a valid value cs-gpios in DT to enable multiple cs\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int bcm2835aux_spi_probe(struct platform_device *pdev)
 {
 	struct spi_master *master;
@@ -449,6 +481,7 @@ static int bcm2835aux_spi_probe(struct platform_device *pdev)
 	 *     a spi_transfer
 	 */
 	master->num_chipselect = 1;
+	master->setup = bcm2835aux_spi_setup;
 	master->transfer_one = bcm2835aux_spi_transfer_one;
 	master->handle_err = bcm2835aux_spi_handle_err;
 	master->prepare_message = bcm2835aux_spi_prepare_message;
--
2.11.0
