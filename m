From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: stm32: switch to SPDX identifier" to the spi tree
Date: Mon,  7 Jan 2019 18:59:18 +0000 (GMT)
Message-ID: <20190107185918.7ACEA1127491@debutante.sirena.org.uk>
References: <1545688840-23992-2-git-send-email-cezary.gapinski@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Amelie Delaunay <amelie.delaunay@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-spi@vger.kernel.org
To: Cezary Gapinski <cezary.gapinski@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1545688840-23992-2-git-send-email-cezary.gapinski@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: stm32: switch to SPDX identifier

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

>From d57a984ff7aa1f8aac617c5ccfcd4cca061d2eb3 Mon Sep 17 00:00:00 2001
From: Cezary Gapinski <cezary.gapinski@gmail.com>
Date: Mon, 24 Dec 2018 23:00:27 +0100
Subject: [PATCH] spi: stm32: switch to SPDX identifier

Adopt the SPDX license identifier headers to ease license compliance
management.

Signed-off-by: Cezary Gapinski <cezary.gapinski@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-stm32.c | 27 +++++++--------------------
 1 file changed, 7 insertions(+), 20 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index ad1e55d3d5d5..5f30578a4224 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -1,23 +1,10 @@
-/*
- * STMicroelectronics STM32 SPI Controller driver (master mode only)
- *
- * Copyright (C) 2017, STMicroelectronics - All Rights Reserved
- * Author(s): Amelie Delaunay <amelie.delaunay@st.com> for STMicroelectronics.
- *
- * License terms: GPL V2.0.
- *
- * spi_stm32 driver is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
- *
- * spi_stm32 driver is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
- * details.
- *
- * You should have received a copy of the GNU General Public License along with
- * spi_stm32 driver. If not, see <http://www.gnu.org/licenses/>.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// STMicroelectronics STM32 SPI Controller driver (master mode only)
+//
+// Copyright (C) 2017, STMicroelectronics - All Rights Reserved
+// Author(s): Amelie Delaunay <amelie.delaunay@st.com> for STMicroelectronics.
+
 #include <linux/debugfs.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
-- 
2.20.1
