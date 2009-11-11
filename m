From: Roel Kluin <roel.kluin@gmail.com>
Subject: [PATCH] spi: Should error status be negative?
Date: Wed, 11 Nov 2009 23:07:57 +0100
Message-ID: <4AFB35BD.2040100@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	David Brownell <dbrownell@users.sourceforge.net>,
	spi-devel-general@lists.sourceforge.net
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759418AbZKKVzz@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Return a negative error value instead of a positive

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
 drivers/spi/spi_stmp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

is this maybe required?

diff --git a/drivers/spi/spi_stmp.c b/drivers/spi/spi_stmp.c
index d871dc2..2552bb3 100644
--- a/drivers/spi/spi_stmp.c
+++ b/drivers/spi/spi_stmp.c
@@ -242,7 +242,7 @@ static int stmp_spi_txrx_dma(struct stmp_spi *ss, int cs,
 	wait_for_completion(&ss->done);
 
 	if (!busy_wait(readl(ss->regs + HW_SSP_CTRL0) & BM_SSP_CTRL0_RUN))
-		status = ETIMEDOUT;
+		status = -ETIMEDOUT;
 
 	if (!dma_buf)
 		dma_unmap_single(ss->master_dev, spi_buf_dma, len, dir);
