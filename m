From: Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH] spi: spi-meson-spifc: update with SPDX Licence identifier
Date: Mon, 20 May 2019 16:04:52 +0200
Message-ID: <20190520140452.30167-1-narmstrong@baylibre.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-spi@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
To: broonie@kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/spi/spi-meson-spifc.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/spi/spi-meson-spifc.c b/drivers/spi/spi-meson-spifc.c
index 616566e793c6..20413def4cfb 100644
--- a/drivers/spi/spi-meson-spifc.c
+++ b/drivers/spi/spi-meson-spifc.c
@@ -1,14 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Driver for Amlogic Meson SPI flash controller (SPIFC)
  *
  * Copyright (C) 2014 Beniamino Galvani <b.galvani@gmail.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 as published by the Free Software Foundation.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <linux/clk.h>
-- 
2.21.0
