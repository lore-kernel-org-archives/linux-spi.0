From: Rini van Zetten <rini@arvoo.nl>
Subject: [PATCH][POWERPC] mpc83xx : allow SPI without cs.
Date: Thu, 11 Jun 2009 11:10:55 +0200
Message-ID: <4A30CA1F.4000702@arvoo.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
To: galak@kernel.crashing.org,
	spi-devel-general@lists.sourceforge.net, Linuxppc-dev@ozlabs.org
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org
List-Id: linux-spi.vger.kernel.org

This patch adds the possibility to have a spi device without a cs.

For example, the dts file should look something like this:

spi-controller {
        gpios = <&pio1 1 0      /* cs0 */
                 0              /* cs1, no GPIO */
                 &pio2 2 0>;    /* cs2 */



Signed-off-by: Rini van Zetten <rini@arvoo.nl>
---
  drivers/spi/spi_mpc83xx.c |   44 +++++++++++++++++++++++---------------------
  1 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/drivers/spi/spi_mpc83xx.c b/drivers/spi/spi_mpc83xx.c
index f4573a9..d06027e 100644
--- a/drivers/spi/spi_mpc83xx.c
+++ b/drivers/spi/spi_mpc83xx.c
@@ -687,9 +687,10 @@ static void mpc83xx_spi_cs_control(struct spi_device *spi, bool on)
  	struct mpc83xx_spi_probe_info *pinfo = to_of_pinfo(dev->platform_data);
  	u16 cs = spi->chip_select;
  	int gpio = pinfo->gpios[cs];
-	bool alow = pinfo->alow_flags[cs];
-
-	gpio_set_value(gpio, on ^ alow);
+	if ( gpio != -EEXIST ) {
+		bool alow = pinfo->alow_flags[cs];
+		gpio_set_value(gpio, on ^ alow);
+	}
  }

  static int of_mpc83xx_spi_get_chipselects(struct device *dev)
@@ -728,27 +729,28 @@ static int of_mpc83xx_spi_get_chipselects(struct device *dev)
  		enum of_gpio_flags flags;

  		gpio = of_get_gpio_flags(np, i, &flags);
-		if (!gpio_is_valid(gpio)) {
+		if (gpio_is_valid(gpio)) {
+			ret = gpio_request(gpio, dev_name(dev));
+			if (ret) {
+				dev_err(dev, "can't request gpio #%d: %d\n", i, ret);
+				goto err_loop;
+			}
+			pinfo->gpios[i] = gpio;
+			pinfo->alow_flags[i] = flags & OF_GPIO_ACTIVE_LOW;
+
+			ret = gpio_direction_output(pinfo->gpios[i],
+					pinfo->alow_flags[i]);
+			if (ret) {
+				dev_err(dev, "can't set output direction for gpio "
+						"#%d: %d\n", i, ret);
+				goto err_loop;
+			}
+		} else if (gpio == -EEXIST) {
+			pinfo->gpios[i] = -EEXIST;
+		} else {
  			dev_err(dev, "invalid gpio #%d: %d\n", i, gpio);
  			goto err_loop;
  		}
-
-		ret = gpio_request(gpio, dev_name(dev));
-		if (ret) {
-			dev_err(dev, "can't request gpio #%d: %d\n", i, ret);
-			goto err_loop;
-		}
-
-		pinfo->gpios[i] = gpio;
-		pinfo->alow_flags[i] = flags & OF_GPIO_ACTIVE_LOW;
-
-		ret = gpio_direction_output(pinfo->gpios[i],
-					    pinfo->alow_flags[i]);
-		if (ret) {
-			dev_err(dev, "can't set output direction for gpio "
-				"#%d: %d\n", i, ret);
-			goto err_loop;
-		}
  	}

  	pdata->max_chipselect = ngpios;
-- 
