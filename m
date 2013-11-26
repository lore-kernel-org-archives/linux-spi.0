From: Sourav Poddar <sourav.poddar@ti.com>
Subject: [PATCH 11/17] spi/qspi: set "mmap" flag to true.
Date: Tue, 26 Nov 2013 13:05:07 +0530
Message-ID: <1385451313-1875-12-git-send-email-sourav.poddar@ti.com>
References: <1385451313-1875-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <balbi@ti.com>, <linux-omap@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <bcousson@baylibre.com>,
	Sourav Poddar <sourav.poddar@ti.com>
To: <computersforpeace@gmail.com>, <broonie@kernel.org>,
	<linux-mtd@lists.infradead.org>, <linux-spi@vger.kernel.org>
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1385451313-1875-1-git-send-email-sourav.poddar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Set mmap flag to true to indicate that the qspi controller
supports memory mapped operations.

Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
---
 drivers/spi/spi-ti-qspi.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index 10bcb37..d21d40d 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -532,6 +532,7 @@ static int ti_qspi_probe(struct platform_device *pdev)
 	master->configure_from_slave = ti_qspi_configure_from_slave;
 	master->get_buf = ti_qspi_get_mem_buf;
 	master->put_buf = ti_qspi_put_mem_buf;
+	master->mmap = true;
 
 	if (!of_property_read_u32(np, "num-cs", &num_cs))
 		master->num_chipselect = num_cs;
-- 
1.7.1

