From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] spi: sh-msiof: Reduce delays in sh_msiof_modify_ctr_wait()
Date: Mon, 27 May 2019 14:19:35 +0200
Message-ID: <20190527121935.5370-1-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

While the Hardware User Manual does not document the maximum time needed
for modifying bits in the MSIOF Control Register, experiments on R-Car
Gen2/Gen3 and SH-Mobile AG5 revealed the following typical modification
times for the various bits:
  - CTR.TXE and CTR.RXE: no delay,
  - CTR.TSCKE: less than 10 ns,
  - CTR.TFSE: up to a few hundred ns (depending on SPI transfer clock,
    i.e. less for faster transfers).
There are no reasons to believe these figures are different for
SH-MobileR2 SoCs (SH7723/SH7724).

Hence the minimum busy-looping delay of 10 µs is excessive.
Reduce the delay per loop iteration from 10 to 1 us, and the maximum
delay from 1000 to 100 µs.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/spi/spi-sh-msiof.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 6aab7b2136dbcadc..b50bdbc27e5899cc 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -229,7 +229,7 @@ static int sh_msiof_modify_ctr_wait(struct sh_msiof_spi_priv *p,
 	sh_msiof_write(p, CTR, data);
 
 	return readl_poll_timeout_atomic(p->mapbase + CTR, data,
-					 (data & mask) == set, 10, 1000);
+					 (data & mask) == set, 1, 100);
 }
 
 static irqreturn_t sh_msiof_spi_irq(int irq, void *data)
-- 
2.17.1
