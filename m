From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: rockchip: initialize dma_slave_config properly" to the spi tree
Date: Thu, 11 Oct 2018 15:56:11 +0100 (BST)
Message-ID: <20181011145611.E2B9B11223ED@debutante.sirena.org.uk>
References: <20181010090038.20834-2-kernel@esmil.dk>
Cc: Emil Renner Berthing <kernel@esmil.dk>,
        Mark Brown <broonie@kernel.org>,
        linux-rockchip@lists.infradead.org,
        Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Mark Brown <broonie@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        Nickey Yang <nickey.yang@rock-chips.com>,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        Randy Li <ayaka@soulik.info>, Chris Zhong <zyw@rock-chips.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-spi@vger.k
To: Huibin Hong <huibin.hong@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181010090038.20834-2-kernel@esmil.dk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: rockchip: initialize dma_slave_config properly

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

>From dd8fd2cbc73f8650f651da71fc61a6e4f30c1566 Mon Sep 17 00:00:00 2001
From: Huibin Hong <huibin.hong@rock-chips.com>
Date: Wed, 10 Oct 2018 11:00:32 +0200
Subject: [PATCH] spi: rockchip: initialize dma_slave_config properly

The rxconf and txconf structs are allocated on the
stack, so make sure we zero them before filling out
the relevant fields.

Signed-off-by: Huibin Hong <huibin.hong@rock-chips.com>
Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-rockchip.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index fdcf3076681b..185bbdce62b1 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -445,6 +445,9 @@ static int rockchip_spi_prepare_dma(struct rockchip_spi *rs)
 	struct dma_slave_config rxconf, txconf;
 	struct dma_async_tx_descriptor *rxdesc, *txdesc;
 
+	memset(&rxconf, 0, sizeof(rxconf));
+	memset(&txconf, 0, sizeof(txconf));
+
 	spin_lock_irqsave(&rs->lock, flags);
 	rs->state &= ~RXBUSY;
 	rs->state &= ~TXBUSY;
-- 
2.19.0.rc2
