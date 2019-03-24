From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: [PATCH V2 7/9] spi: bcm2835aux: setup gpio-cs to output and correct
 level during setup
Date: Sun, 24 Mar 2019 17:50:00 +0000
Message-ID: <20190324175002.28969-8-kernel@martin.sperl.org>
References: <20190324175002.28969-1-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>,
 Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>,
 Hubert Denkmair <h.denkmair-4pT7WzY1KUiELgA04lAiVw@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
 linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20190324175002.28969-1-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
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

Setup gpio-cs to the correct levels during setup and also make the
gpio definitely an output GPIO.

This is transparently fixing some badly configured DTs in the process
where cs-gpio is set but the gpios are still configured with native cs.

It also makes 100% sure that the initial CS levels are as expected -
especially on systems with devices on a bus with mixed CS_HIGH/CS_LOW
settings.

Fixes: 1ea29b39f4c812ece2f936065a0a3d6fe44a263e
Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
---
 drivers/spi/spi-bcm2835aux.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-bcm2835aux.c b/drivers/spi/spi-bcm2835aux.c
index 6af07dec5fdc..dd0446968da6 100644
--- a/drivers/spi/spi-bcm2835aux.c
+++ b/drivers/spi/spi-bcm2835aux.c
@@ -425,7 +425,17 @@ static int bcm2835aux_spi_setup(struct spi_device *spi)
 		return -EINVAL;
 	}

-	return 0;
+	/* with gpio-cs set the GPIO to the correct level
+	 * and as output (in case the dt has the gpio not configured
+	 * as output but native cs)
+	 */
+	ret = gpio_direction_output(spi->cs_gpio,
+				    (spi->mode & SPI_CS_HIGH) ? 0 : 1);
+	if (ret)
+		dev_err(&spi->dev, "could not set gpio %i as output: %i\n",
+			spi->cs_gpio, ret);
+
+	return ret;
 }

 static int bcm2835aux_spi_probe(struct platform_device *pdev)
--
2.11.0
