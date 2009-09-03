From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: [PATCH 1/2] txx9: Fix spi-baseclk value
Date: Thu,  3 Sep 2009 22:59:00 +0900
Message-ID: <1251986341-16938-1-git-send-email-anemo@mba.ocn.ne.jp>
Cc: ralf@linux-mips.org, spi-devel-general@lists.sourceforge.net,
	david-b@pacbell.net
To: linux-mips@linux-mips.org
Return-path: <linux-mips-bounce@linux-mips.org>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-Id: linux-spi.vger.kernel.org

TXx9 SPI bit rate is calculated by:
	fBR = fSPI / 2 / (n + 1)
	(fSPI is SPI master clock freq, i.e. imbusclk freq.)
So use imbus_clk / 2 as a spi-baseclk.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/txx9/generic/setup.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/txx9/generic/setup.c b/arch/mips/txx9/generic/setup.c
index a205e2b..b2613c1 100644
--- a/arch/mips/txx9/generic/setup.c
+++ b/arch/mips/txx9/generic/setup.c
@@ -85,7 +85,7 @@ int txx9_ccfg_toeon __initdata = 1;
 struct clk *clk_get(struct device *dev, const char *id)
 {
 	if (!strcmp(id, "spi-baseclk"))
-		return (struct clk *)((unsigned long)txx9_gbus_clock / 2 / 4);
+		return (struct clk *)((unsigned long)txx9_gbus_clock / 2 / 2);
 	if (!strcmp(id, "imbus_clk"))
 		return (struct clk *)((unsigned long)txx9_gbus_clock / 2);
 	return ERR_PTR(-ENOENT);
-- 
1.5.6.5
