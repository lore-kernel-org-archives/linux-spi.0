From: <tthayer@opensource.altera.com>
Subject: [PATCHv3 2/2] spi: dw: Set GPIO_SS flag to toggle Slave Select on GPIO CS
Date: Mon, 10 Oct 2016 09:25:25 -0500
Message-ID: <1476109525-21213-2-git-send-email-tthayer@opensource.altera.com>
References: <1476109525-21213-1-git-send-email-tthayer@opensource.altera.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <andriy.shevchenko@linux.intel.com>,
        <jarkko.nikula@linux.intel.com>, <jszhang@marvell.com>,
        <michael@smart-africa.com>, <kernel@mseidel.net>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <tthayer@opensource.altera.com>
To: <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1476109525-21213-1-git-send-email-tthayer@opensource.altera.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Thor Thayer <tthayer@opensource.altera.com>

The Designware SPI master requires slave selection before the transfer
can begin [1].

This patch uses the new master flag to indicate both the GPIO CS and
the internal chip select should be used.

Tested On:
    Altera CycloneV development kit
    Compile tested for build errors on x86_64 (allyesconfigs)

[1] DesignWare dw_apb_ssi Databook, Version 3.20a (page 39)

Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
---
v3  Use SPI_MASTER_GPIO_SS
---
 drivers/spi/spi-dw.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index 27960e4..b715a26 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -502,6 +502,7 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
 	master->handle_err = dw_spi_handle_err;
 	master->max_speed_hz = dws->max_freq;
 	master->dev.of_node = dev->of_node;
+	master->flags = SPI_MASTER_GPIO_SS;
 
 	/* Basic HW init */
 	spi_hw_init(dev, dws);
-- 
1.7.9.5
