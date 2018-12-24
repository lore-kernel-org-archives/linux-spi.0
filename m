From: cezary.gapinski@gmail.com
Subject: [PATCH v2 01/14] spi: stm32: switch to SPDX identifier
Date: Mon, 24 Dec 2018 23:00:27 +0100
Message-ID: <1545688840-23992-2-git-send-email-cezary.gapinski@gmail.com>
References: <1545688840-23992-1-git-send-email-cezary.gapinski@gmail.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Cezary Gapinski <cezary.gapinski@gmail.com>
To: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Amelie Delaunay <amelie.delaunay@st.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1545688840-23992-1-git-send-email-cezary.gapinski@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Cezary Gapinski <cezary.gapinski@gmail.com>

Adopt the SPDX license identifier headers to ease license compliance
management.

Signed-off-by: Cezary Gapinski <cezary.gapinski@gmail.com>
---
 drivers/spi/spi-stm32.c | 27 +++++++--------------------
 1 file changed, 7 insertions(+), 20 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index ad1e55d..5f30578 100644
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
2.7.4
