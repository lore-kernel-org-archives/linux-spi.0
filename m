From: Linus Walleij <linus.walleij@stericsson.com>
Subject: [PATCH] spi/pl022: rid dangling labels
Date: Wed, 16 Feb 2011 09:40:26 +0100
Message-ID: <1297845626-13332-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Linus Walleij <linus.walleij@linaro.org>, Lee Jones <lee.jones@linaro.org>,
	linux-arm-kernel@lists.infradead.org
To: Grant Likely <grant.likely@secretlab.ca>,
	<spi-devel-general@lists.sourceforge.net>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

From: Linus Walleij <linus.walleij@linaro.org>

Remove a compilation error regarding unused labels that came about
when simplifying the DMA code.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/spi/amba-pl022.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/amba-pl022.c b/drivers/spi/amba-pl022.c
index 4cd05cc..14a451b 100644
--- a/drivers/spi/amba-pl022.c
+++ b/drivers/spi/amba-pl022.c
@@ -1030,8 +1030,6 @@ static int configure_dma(struct pl022 *pl022)
 
 	return 0;
 
-err_submit_tx:
-err_submit_rx:
 err_txdesc:
 	dmaengine_terminate_all(txchan);
 err_rxdesc:
-- 
1.7.3.2
