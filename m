From: Fabien Lahoudere <fabien.lahoudere@collabora.co.uk>
Subject: [PATCH v2 1/1] Add device to spidev device tree compatibility list
Date: Thu,  6 Oct 2016 16:44:27 +0200
Message-ID: <1475765067-29403-1-git-send-email-fabien.lahoudere@collabora.co.uk>
References: <20160930160832.fnnvxkwdh5ex4xqt@sirena.org.uk>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Fabien Lahoudere <fabien.lahoudere@collabora.co.uk>
To: broonie@kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160930160832.fnnvxkwdh5ex4xqt@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Entries are needed in the spidev ID list to configure configure it from a
device tree. Add entry for the following device:
- "ge,achc" :  GE Healthcare USB Management Controller

The USB Management Controller does not expose USB to the host, but acts as
an offload engine, communicating with specific USB based data acquisition
devices which are connected to it, extracting the required data and
providing it to the host via other methods. SPI is used as an out-of-band
configuration channel.

Signed-off-by: Fabien Lahoudere <fabien.lahoudere@collabora.co.uk>
---
 drivers/spi/spidev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 2e05046..9e2e099 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -696,6 +696,7 @@ static struct class *spidev_class;
 static const struct of_device_id spidev_dt_ids[] = {
 	{ .compatible = "rohm,dh2228fv" },
 	{ .compatible = "lineartechnology,ltc2488" },
+	{ .compatible = "ge,achc" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, spidev_dt_ids);
-- 
2.1.4
