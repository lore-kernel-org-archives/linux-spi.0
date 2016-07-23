From: Jan Glauber <jglauber@cavium.com>
Subject: [PATCH 2/6] spi: octeon: Store system clock freqency in struct octeon_spi
Date: Sat, 23 Jul 2016 12:42:51 +0200
Message-ID: <b0ca252dc316a20b4111412b5f08e79644b867b1.1469174814.git.jglauber@cavium.com>
References: <cover.1469174814.git.jglauber@cavium.com>
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	"Steven J. Hill" <steven.hill@cavium.com>,
	David Daney <david.daney@cavium.com>,
	Jan Glauber <jglauber@cavium.com>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1469174814.git.jglauber@cavium.com>
In-Reply-To: <cover.1469174814.git.jglauber@cavium.com>
References: <cover.1469174814.git.jglauber@cavium.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Storing the system clock frequency in struct octeon_spi avoids
calling the MIPS specific octeon_get_io_clock_rate() for every transfer.

Signed-off-by: Jan Glauber <jglauber@cavium.com>
Tested-by: Steven J. Hill <steven.hill@cavium.com>
---
 drivers/spi/spi-octeon.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-octeon.c b/drivers/spi/spi-octeon.c
index b53ba53..e722040 100644
--- a/drivers/spi/spi-octeon.c
+++ b/drivers/spi/spi-octeon.c
@@ -30,6 +30,7 @@ struct octeon_spi {
 	void __iomem *register_base;
 	u64 last_cfg;
 	u64 cs_enax;
+	int sys_freq;
 };
 
 static void octeon_spi_wait_ready(struct octeon_spi *p)
@@ -53,7 +54,6 @@ static int octeon_spi_do_transfer(struct octeon_spi *p,
 	union cvmx_mpi_cfg mpi_cfg;
 	union cvmx_mpi_tx mpi_tx;
 	unsigned int clkdiv;
-	unsigned int speed_hz;
 	int mode;
 	bool cpha, cpol;
 	const u8 *tx_buf;
@@ -65,9 +65,7 @@ static int octeon_spi_do_transfer(struct octeon_spi *p,
 	cpha = mode & SPI_CPHA;
 	cpol = mode & SPI_CPOL;
 
-	speed_hz = xfer->speed_hz;
-
-	clkdiv = octeon_get_io_clock_rate() / (2 * speed_hz);
+	clkdiv = p->sys_freq / (2 * xfer->speed_hz);
 
 	mpi_cfg.u64 = 0;
 
@@ -194,6 +192,7 @@ static int octeon_spi_probe(struct platform_device *pdev)
 	}
 
 	p->register_base = reg_base;
+	p->sys_freq = octeon_get_io_clock_rate();
 
 	master->num_chipselect = 4;
 	master->mode_bits = SPI_CPHA |
-- 
2.9.0.rc0.21.g7777322
