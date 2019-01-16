From: Alban Bedel <albeu@free.fr>
Subject: [PATCH 5/6] spi: ath79: Remove some useless includes
Date: Wed, 16 Jan 2019 19:55:48 +0100
Message-ID: <20190116185549.23295-5-albeu@free.fr>
References: <20190116185549.23295-1-albeu@free.fr>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Alban Bedel <albeu@free.fr>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org
To: linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190116185549.23295-1-albeu@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Several include are not needed, remove them to keep the list clean.

Signed-off-by: Alban Bedel <albeu@free.fr>
---
 drivers/spi/spi-ath79.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/spi/spi-ath79.c b/drivers/spi/spi-ath79.c
index 847f354ebef1..257acfb07819 100644
--- a/drivers/spi/spi-ath79.c
+++ b/drivers/spi/spi-ath79.c
@@ -12,15 +12,12 @@
  *
  */
 
-#include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/delay.h>
-#include <linux/spinlock.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/spi_bitbang.h>
-#include <linux/bitops.h>
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/platform_data/spi-ath79.h>
-- 
2.19.1
