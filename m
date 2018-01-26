From: =?UTF-8?q?Jan=20Kundr=C3=A1t?= <jan.kundrat-xoNZbkdr4U2lVyrhU4qvOw@public.gmane.org>
Subject: [PATCH v2] spi: orion: Rework GPIO CS handling
Date: Fri, 26 Jan 2018 23:56:10 +0100
Message-ID: <92369661c99f83e656004288fcc06a510b4b8c58.1517007569.git.jan.kundrat@cesnet.cz>
References: <CAMuHMdUaLV522qihJibmTO1NR6NK0DNjMT8soGvLsi=ffGg71A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
        Christophe JAILLET <christophe.jaillet-39ZsbGIQGT5GWvitb5QawA@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
        Chris Packham <Chris.Packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMuHMdUaLV522qihJibmTO1NR6NK0DNjMT8soGvLsi=ffGg71A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

- Claim the GPIO from the driver, not via DT bindings or through the
  platform code
- Find an unused HW CS signal because Orion needs to drive one for each
  SPI transaction

The spi-orion.c was the only driver which supported (or cared about) the
CS GPIO, while it wasn't actually requesting it. This change means that
the DT bindings should stop hogging the GPIO CS pins because it's now
being handled by the driver.

Signed-off-by: Jan Kundrát <jan.kundrat-xoNZbkdr4U2lVyrhU4qvOw@public.gmane.org>
---
Changes v1..v2:
  A complete rework of "spi: orion: Allow specifying which HW CS to use with a GPIO CS"
  (https://patchwork.kernel.org/patch/10182583/)
---
 drivers/spi/spi-orion.c | 47 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 44 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
index deca63e82ff6..b341235d2947 100644
--- a/drivers/spi/spi-orion.c
+++ b/drivers/spi/spi-orion.c
@@ -96,6 +96,7 @@ struct orion_spi {
 	struct clk              *clk;
 	struct clk              *axi_clk;
 	const struct orion_spi_dev *devdata;
+	int			unused_hw_gpio;
 
 	struct orion_direct_acc	direct_access[ORION_NUM_CHIPSELECTS];
 };
@@ -324,13 +325,13 @@ static void orion_spi_set_cs(struct spi_device *spi, bool enable)
 	struct orion_spi *orion_spi;
 	int cs;
 
+	orion_spi = spi_master_get_devdata(spi->master);
+
 	if (gpio_is_valid(spi->cs_gpio))
-		cs = 0;
+		cs = orion_spi->unused_hw_gpio;
 	else
 		cs = spi->chip_select;
 
-	orion_spi = spi_master_get_devdata(spi->master);
-
 	orion_spi_clrbits(orion_spi, ORION_SPI_IF_CTRL_REG, ORION_SPI_CS_MASK);
 	orion_spi_setbits(orion_spi, ORION_SPI_IF_CTRL_REG,
 				ORION_SPI_CS(cs));
@@ -498,6 +499,9 @@ static int orion_spi_transfer_one(struct spi_master *master,
 
 static int orion_spi_setup(struct spi_device *spi)
 {
+	if (gpio_is_valid(spi->cs_gpio)) {
+		gpio_direction_output(spi->cs_gpio, !(spi->mode & SPI_CS_HIGH));
+	}
 	return orion_spi_setup_transfer(spi, NULL);
 }
 
@@ -620,6 +624,7 @@ static int orion_spi_probe(struct platform_device *pdev)
 
 	spi = spi_master_get_devdata(master);
 	spi->master = master;
+	spi->unused_hw_gpio = -1;
 
 	of_id = of_match_device(orion_spi_of_match_table, &pdev->dev);
 	devdata = (of_id) ? of_id->data : &orion_spi_dev_data;
@@ -731,8 +736,44 @@ static int orion_spi_probe(struct platform_device *pdev)
 	if (status < 0)
 		goto out_rel_pm;
 
+	if (master->cs_gpios) {
+		int i;
+		for (i = 0; i < master->num_chipselect; ++i) {
+			char *gpio_name;
+
+			if (!gpio_is_valid(master->cs_gpios[i])) {
+				continue;
+			}
+
+			gpio_name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
+					"%s-CS%d", dev_name(&pdev->dev), i);
+			if (!gpio_name) {
+				status = -ENOMEM;
+				goto out_rel_master;
+			}
+
+			status = devm_gpio_request(&pdev->dev,
+					master->cs_gpios[i], gpio_name);
+			if (status) {
+				dev_err(&pdev->dev,
+					"Can't request GPIO for CS %d\n",
+					master->cs_gpios[i]);
+				goto out_rel_master;
+			}
+			if (spi->unused_hw_gpio == -1) {
+				dev_info(&pdev->dev,
+					"Selected unused HW CS#%d "
+					"for any GPIO CSes\n", i);
+				spi->unused_hw_gpio = i;
+			}
+		}
+	}
+
+
 	return status;
 
+out_rel_master:
+	spi_unregister_master(master);
 out_rel_pm:
 	pm_runtime_disable(&pdev->dev);
 out_rel_axi_clk:
-- 
2.14.3


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
