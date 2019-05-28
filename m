From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: sh-msiof: Reduce delays in sh_msiof_modify_ctr_wait()" to the spi tree
Date: Tue, 28 May 2019 16:07:23 +0100 (BST)
Message-ID: <20190528150723.46DD7440046@finisterre.sirena.org.uk>
References: <20190527121935.5370-1-geert+renesas@glider.be>
Cc: linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190527121935.5370-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: sh-msiof: Reduce delays in sh_msiof_modify_ctr_wait()

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.3

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 635bdb7a3e1fe1531573ff87b92c2506adafe7f7 Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 27 May 2019 14:19:35 +0200
Subject: [PATCH] spi: sh-msiof: Reduce delays in sh_msiof_modify_ctr_wait()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-sh-msiof.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 6aab7b2136db..b50bdbc27e58 100644
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
2.20.1
