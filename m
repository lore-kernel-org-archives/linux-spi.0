From: Franklin S Cooper Jr <fcooper@ti.com>
Subject: [RFC][PATCH] spi: Setup the master controller driver before setting the chipselect
Date: Mon, 12 Oct 2015 16:01:11 -0500
Message-ID: <1444683671-15570-2-git-send-email-fcooper@ti.com>
References: <1444683671-15570-1-git-send-email-fcooper@ti.com>
Cc: Franklin S Cooper Jr <fcooper@ti.com>
To: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	broonie@kernel.org, nsekhar@ti.com, ssantosh@kernel.org,
	iivanov@mm-sol.com, m-karicheri2@ti.com
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1444683671-15570-1-git-send-email-fcooper@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Some devices depend on the master controller driver setup function being
called before calling any chipselect functions.

Insure that this is done otherwise uninitialized structures may be
accessed causing a kernel panic.

Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
---
 drivers/spi/spi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 38006cc..9374d82 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2053,11 +2053,11 @@ int spi_setup(struct spi_device *spi)
 	if (!spi->max_speed_hz)
 		spi->max_speed_hz = spi->master->max_speed_hz;
 
-	spi_set_cs(spi, false);
-
 	if (spi->master->setup)
 		status = spi->master->setup(spi);
 
+	spi_set_cs(spi, false);
+
 	dev_dbg(&spi->dev, "setup mode %d, %s%s%s%s%u bits/w, %u Hz max --> %d\n",
 			(int) (spi->mode & (SPI_CPOL | SPI_CPHA)),
 			(spi->mode & SPI_CS_HIGH) ? "cs_high, " : "",
-- 
2.6.1
