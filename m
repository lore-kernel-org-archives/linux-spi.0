From: Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 17/28] spi: topcliff-pch: allow build for MIPS platforms
Date: Mon, 30 Nov 2015 16:21:42 +0000
Message-ID: <1448900513-20856-18-git-send-email-paul.burton@imgtec.com>
References: <1448900513-20856-1-git-send-email-paul.burton@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Paul Burton <paul.burton@imgtec.com>,
	Mark Brown <broonie@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>
To: <linux-mips@linux-mips.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1448900513-20856-1-git-send-email-paul.burton@imgtec.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Allow the topcliff-pch driver to be built for MIPS platforms, in
preparation for use on the MIPS Boston board.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 drivers/spi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 8b9c2a3..7c78d52 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -585,7 +585,7 @@ config SPI_TEGRA20_SLINK
 
 config SPI_TOPCLIFF_PCH
 	tristate "Intel EG20T PCH/LAPIS Semicon IOH(ML7213/ML7223/ML7831) SPI"
-	depends on PCI && (X86_32 || COMPILE_TEST)
+	depends on PCI && (X86_32 || MIPS || COMPILE_TEST)
 	help
 	  SPI driver for the Topcliff PCH (Platform Controller Hub) SPI bus
 	  used in some x86 embedded processors.
-- 
2.6.2
