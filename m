From: Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH 03/12] spi: spi-fsl-dspi: Don't mask off undefined bits
Date: Thu,  5 Mar 2020 00:00:35 +0200
Message-ID: <20200304220044.11193-4-olteanv@gmail.com>
References: <20200304220044.11193-1-olteanv@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        eha@deif.com, angelo@sysam.it, andrew.smirnov@gmail.com,
        gustavo@embeddedor.com, weic@nvidia.com, mhosny@nvidia.com
To: broonie@kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200304220044.11193-1-olteanv@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Vladimir Oltean <vladimir.oltean@nxp.com>

This is a useless operation, and if the driver needs to do that, there's
something deeply wrong going on.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/spi/spi-fsl-dspi.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 63ec1d634d08..b92c2b84a94b 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -274,9 +274,6 @@ static void dspi_push_rx(struct fsl_dspi *dspi, u32 rxdata)
 	if (!dspi->rx)
 		return;
 
-	/* Mask off undefined bits */
-	rxdata &= (1 << dspi->bits_per_word) - 1;
-
 	memcpy(dspi->rx, &rxdata, dspi->bytes_per_word);
 	dspi->rx += dspi->bytes_per_word;
 }
-- 
2.17.1
