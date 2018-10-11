From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: rockchip: mark use_dma as bool" to the spi tree
Date: Thu, 11 Oct 2018 15:56:00 +0100 (BST)
Message-ID: <20181011145600.9F3DC11223ED@debutante.sirena.org.uk>
References: <20181010090038.20834-6-kernel@esmil.dk>
Cc: Mark Brown <broonie@kernel.org>,
        linux-rockchip@lists.infradead.org,
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
        linux-spi@vger.kernel.org
To: Emil Renner Berthing <kernel@esmil.dk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181010090038.20834-6-kernel@esmil.dk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: rockchip: mark use_dma as bool

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

>From f340b920511a666b02d371e88801d3817ea7a880 Mon Sep 17 00:00:00 2001
From: Emil Renner Berthing <kernel@esmil.dk>
Date: Wed, 10 Oct 2018 11:00:36 +0200
Subject: [PATCH] spi: rockchip: mark use_dma as bool

The driver data has a u32 field use_dma which is
only ever used as a boolean, so change its type
to reflect that.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-rockchip.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 6a53b940f2f5..99943aa71bc1 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -202,7 +202,7 @@ struct rockchip_spi {
 
 	bool cs_asserted[ROCKCHIP_SPI_MAX_CS_NUM];
 
-	u32 use_dma;
+	bool use_dma;
 	struct sg_table tx_sg;
 	struct sg_table rx_sg;
 	struct rockchip_spi_dma_data dma_rx;
@@ -628,9 +628,9 @@ static int rockchip_spi_transfer_one(
 
 	/* we need prepare dma before spi was enabled */
 	if (master->can_dma && master->can_dma(master, spi, xfer))
-		rs->use_dma = 1;
+		rs->use_dma = true;
 	else
-		rs->use_dma = 0;
+		rs->use_dma = false;
 
 	rockchip_spi_config(rs);
 
-- 
2.19.0.rc2
