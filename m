From: Dirk Behme <dirk.behme-V5te9oGctAVWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 7/8] spi: sh-msiof: Fix gpio function
Date: Wed, 6 Sep 2017 09:05:06 +0200
Message-ID: <20170906070507.26223-8-dirk.behme@de.bosch.com>
References: <20170906070507.26223-1-dirk.behme@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Hiromitsu Yamasaki <hiromitsu.yamasaki.ym-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>,
        Dirk Behme <dirk.behme-V5te9oGctAVWk0Htik3J/w@public.gmane.org>
To: <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170906070507.26223-1-dirk.behme-V5te9oGctAVWk0Htik3J/w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Hiromitsu Yamasaki <hiromitsu.yamasaki.ym-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>

This patch adds a function to control chip select by GPIO.
In order to use this patch, it is necessary to define it to
devicetree. <refer Documentation/devicetree/bindings/spi/spi-bus.txt>

<devicetree example>

&pfc {
        ...
        /* MSIOF_SYMC Pin delete. */
        msiof1_pins: spi2 {
                /* The definition of sync, ss1 and ss2 are
                   unnecessary because of using GPIO as chip
                   select. */
                groups = "msiof1_clk_c",
                                "msiof1_rxd_c",  "msiof1_txd_c";
                function = "msiof1";
        };
        ...
};

&msiof1 {
        pinctrl-0 = <&msiof1_pins>;
        pinctrl-names = "default";
        cs-gpios = <&gpio6 21 GPIO_ACTIVE_LOW>,
                    <&gpio6 27 GPIO_ACTIVE_LOW>;
        status = "okay";

        spidev@0 {
                ...
                reg = <0>;
		...
        };
        spidev@1 {
                ...
                reg = <1>;
		...
        };
};

Signed-off-by: Hiromitsu Yamasaki <hiromitsu.yamasaki.ym-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Dirk Behme <dirk.behme-V5te9oGctAVWk0Htik3J/w@public.gmane.org>
---
 drivers/spi/spi-sh-msiof.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 2c53fc3f73af..fdad8d852602 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -541,6 +541,7 @@ static int sh_msiof_spi_setup(struct spi_device *spi)
 {
 	struct device_node	*np = spi->master->dev.of_node;
 	struct sh_msiof_spi_priv *p = spi_master_get_devdata(spi->master);
+	int ret;
 
 	pm_runtime_get_sync(&p->pdev->dev);
 
@@ -559,8 +560,12 @@ static int sh_msiof_spi_setup(struct spi_device *spi)
 				  !!(spi->mode & SPI_LSB_FIRST),
 				  !!(spi->mode & SPI_CS_HIGH));
 
-	if (spi->cs_gpio >= 0)
-		gpio_set_value(spi->cs_gpio, !(spi->mode & SPI_CS_HIGH));
+	if (gpio_is_valid(spi->cs_gpio)) {
+		ret = gpio_request(spi->cs_gpio, dev_name(&spi->dev));
+		if (!ret)
+			gpio_direction_output(spi->cs_gpio,
+					!(spi->mode & SPI_CS_HIGH));
+	}
 
 
 	pm_runtime_put(&p->pdev->dev);
-- 
2.14.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
