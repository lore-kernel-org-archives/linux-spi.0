From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: spi-meson-spifc: update with SPDX Licence identifier" to the spi tree
Date: Tue, 28 May 2019 16:07:22 +0100 (BST)
Message-ID: <20190528150722.8F921440046@finisterre.sirena.org.uk>
References: <20190527134124.3034-1-narmstrong@baylibre.com>
Cc: broonie@kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
To: Neil Armstrong <narmstrong@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190527134124.3034-1-narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: spi-meson-spifc: update with SPDX Licence identifier

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

>From 891100dfa2d6eeca6913b45c883b72efee7c229b Mon Sep 17 00:00:00 2001
From: Neil Armstrong <narmstrong@baylibre.com>
Date: Mon, 27 May 2019 15:41:24 +0200
Subject: [PATCH] spi: spi-meson-spifc: update with SPDX Licence identifier

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-meson-spifc.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-meson-spifc.c b/drivers/spi/spi-meson-spifc.c
index 616566e793c6..f7fe9b13d122 100644
--- a/drivers/spi/spi-meson-spifc.c
+++ b/drivers/spi/spi-meson-spifc.c
@@ -1,15 +1,9 @@
-/*
- * Driver for Amlogic Meson SPI flash controller (SPIFC)
- *
- * Copyright (C) 2014 Beniamino Galvani <b.galvani@gmail.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 as published by the Free Software Foundation.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// Driver for Amlogic Meson SPI flash controller (SPIFC)
+//
+// Copyright (C) 2014 Beniamino Galvani <b.galvani@gmail.com>
+//
 
 #include <linux/clk.h>
 #include <linux/delay.h>
-- 
2.20.1
