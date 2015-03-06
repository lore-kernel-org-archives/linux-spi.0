From: "Ivan T. Ivanov" <iivanov@mm-sol.com>
Subject: [RFC PATCH] spi: Ensure that CS line is in non-active state after setup
Date: Fri,  6 Mar 2015 17:45:15 +0200
Message-ID: <1425656716-25363-1-git-send-email-iivanov@mm-sol.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

When drivers didn't provide setup() method, SPI core should ensure
that CS line is driven in non-active state after spi_setup().

Signed-off-by: Ivan T. Ivanov <iivanov@mm-sol.com>
---
 drivers/spi/spi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index c64a3e5..bfba2d9 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1895,6 +1895,8 @@ int spi_setup(struct spi_device *spi)

 	if (spi->master->setup)
 		status = spi->master->setup(spi);
+	else
+		spi_set_cs(spi, false);

 	dev_dbg(&spi->dev, "setup mode %d, %s%s%s%s%u bits/w, %u Hz max --> %d\n",
 			(int) (spi->mode & (SPI_CPOL | SPI_CPHA)),
--
1.9.1
