From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: [PATCH V3 7/9] spi: bcm2835aux: setup gpio-cs to output and correct
 level during setup
Date: Sat, 30 Mar 2019 09:31:04 +0000
Message-ID: <20190330093106.20723-8-kernel@martin.sperl.org>
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

Setup gpio-cs to the correct levels during setup and also make the
gpio definitely an output GPIO.

This is transparently fixing some badly configured DTs in the process
where cs-gpio is set but the gpios are still configured with native cs.

It also makes 100% sure that the initial CS levels are as expected -
especially on systems with devices on a bus with mixed CS_HIGH/CS_LOW
settings.

Fixes: 1ea29b39f4c812ec ("spi: bcm2835aux: add bcm2835 auxiliary spi device...")

Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

---

Changelog:
  V2 -> V3: rebased duo to changes in Patch 6

 drivers/spi/spi-bcm2835aux.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-bcm2835aux.c b/drivers/spi/spi-bcm2835aux.c
index a105db371417..99414319001a 100644
--- a/drivers/spi/spi-bcm2835aux.c
+++ b/drivers/spi/spi-bcm2835aux.c
@@ -403,8 +403,20 @@ static int bcm2835aux_spi_setup(struct spi_device *spi)
 	/* sanity check for native cs */
 	if (spi->mode & SPI_NO_CS)
 		return 0;
-	if (gpio_is_valid(spi->cs_gpio))
-		return 0;
+	if (gpio_is_valid(spi->cs_gpio)) {
+		/* with gpio-cs set the GPIO to the correct level
+		 * and as output (in case the dt has the gpio not configured
+		 * as output but native cs)
+		 */
+		ret = gpio_direction_output(spi->cs_gpio,
+					    (spi->mode & SPI_CS_HIGH) ? 0 : 1);
+		if (ret)
+			dev_err(&spi->dev,
+				"could not set gpio %i as output: %i\n",
+				spi->cs_gpio, ret);
+
+		return ret;
+	}

 	/* for dt-backwards compatibility: only support native on CS0
 	 * known things not supported with broken native CS:
--
2.11.0
