From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 1/2 v2] SPI: spi-sh-msiof: remove unbalanced spi_master_put()
Date: Mon, 12 Sep 2011 11:27:33 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1109121124550.9638@axis700.grange>
References: <Pine.LNX.4.64.1109021706480.4731@axis700.grange>
 <Pine.LNX.4.64.1109021712180.4731@axis700.grange>
 <Pine.LNX.4.64.1109121118500.9638@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-sh@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>,
	Magnus Damm <magnus.damm@gmail.com>
To: spi-devel-general@lists.sourceforge.net
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1109121118500.9638@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The call to spi_bitbang_stop() in sh_msiof_spi_remove() already releases
the master, which can be verified by checking, that the
spi_master_release() function gets called. Therefore the call to
spi_master_put() in sh_msiof_spi_remove() in this driver is superfluous.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/spi/spi-sh-msiof.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index e00d94b..722dad5 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -699,7 +699,6 @@ static int sh_msiof_spi_remove(struct platform_device *pdev)
 		free_irq(platform_get_irq(pdev, 0), p);
 		iounmap(p->mapbase);
 		clk_put(p->clk);
-		spi_master_put(p->bitbang.master);
 	}
 	return ret;
 }
-- 
1.7.2.5

