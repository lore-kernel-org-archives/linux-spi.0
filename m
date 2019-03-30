From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: [PATCH V3 6/9] spi: bcm2835aux: warn in dmesg that native cs is not
 really supported
Date: Sat, 30 Mar 2019 09:31:03 +0000
Message-ID: <20190330093106.20723-7-kernel@martin.sperl.org>
References: <20190330093106.20723-1-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>,
 Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>,
 Hubert Denkmair <h.denkmair-4pT7WzY1KUiELgA04lAiVw@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
 linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20190330093106.20723-1-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
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

Fixes: 1ea29b39f4c812ec ("spi: bcm2835aux: add bcm2835 auxiliary spi device...")

Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
---

Changelog:
  V2 -> V3: use dev_warn
            made messages shorter

 drivers/spi/spi-bcm2835aux.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/spi/spi-bcm2835aux.c b/drivers/spi/spi-bcm2835aux.c
index c8acde017b6a..a105db371417 100644
--- a/drivers/spi/spi-bcm2835aux.c
+++ b/drivers/spi/spi-bcm2835aux.c
@@ -396,6 +396,38 @@ static void bcm2835aux_spi_handle_err(struct spi_master *master,
 	bcm2835aux_spi_reset_hw(bs);
 }

+static int bcm2835aux_spi_setup(struct spi_device *spi)
+{
+	int ret;
+
+	/* sanity check for native cs */
+	if (spi->mode & SPI_NO_CS)
+		return 0;
+	if (gpio_is_valid(spi->cs_gpio))
+		return 0;
+
+	/* for dt-backwards compatibility: only support native on CS0
+	 * known things not supported with broken native CS:
+	 * * multiple chip-selects: cs0-cs2 are all
+	 *     simultaniously asserted whenever there is a transfer
+	 *     this even includes SPI_NO_CS
+	 * * SPI_CS_HIGH: cs are always asserted low
+	 * * cs_change: cs is deasserted after each spi_transfer
+	 * * cs_delay_usec: cs is always deasserted one SCK cycle
+	 *     after the last transfer
+	 * probably more...
+	 */
+	dev_warn(&spi->dev,
+		 "Native CS is not supported - please configure cs-gpio in device-tree\n");
+
+	if (spi->chip_select == 0)
+		return 0;
+
+	dev_warn(&spi->dev, "Native CS is not working for cs > 0\n");
+
+	return -EINVAL;
+}
+
 static int bcm2835aux_spi_probe(struct platform_device *pdev)
 {
 	struct spi_master *master;
@@ -425,6 +457,7 @@ static int bcm2835aux_spi_probe(struct platform_device *pdev)
 	 *     a spi_transfer
 	 */
 	master->num_chipselect = 1;
+	master->setup = bcm2835aux_spi_setup;
 	master->transfer_one = bcm2835aux_spi_transfer_one;
 	master->handle_err = bcm2835aux_spi_handle_err;
 	master->prepare_message = bcm2835aux_spi_prepare_message;
--
2.11.0
