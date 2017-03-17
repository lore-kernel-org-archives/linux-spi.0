From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: davinci: add comment about dummy tx buffer usage" to
 the spi tree
Date: Fri, 17 Mar 2017 22:01:10 +0000
Message-ID: <E1cozvq-0002ly-L9@debutante>
References: <1489765270-17950-1-git-send-email-fisaksen@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: khilman@baylibre.com, nsekhar@ti.com, linux-spi@vger.kernel.org,
 broonie@kernel.org, ptitiano@baylibre.com,
 linux-arm-kernel@lists.infradead.org
To: Frode Isaksen <fisaksen@baylibre.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1489765270-17950-1-git-send-email-fisaksen@baylibre.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: davinci: add comment about dummy tx buffer usage

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

>From 1234e8398fe03267bf2e353e36825dbd0abc2fc6 Mon Sep 17 00:00:00 2001
From: Frode Isaksen <fisaksen@baylibre.com>
Date: Fri, 17 Mar 2017 16:41:10 +0100
Subject: [PATCH] spi: davinci: add comment about dummy tx buffer usage

Add explanation about using the the rx buffer as the
dummy tx buffer.

Signed-off-by: Frode Isaksen <fisaksen@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-davinci.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index f37bbdd18d61..595acdcfc7d0 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -660,7 +660,11 @@ static int davinci_spi_bufs(struct spi_device *spi, struct spi_transfer *t)
 			goto err_desc;
 
 		if (!t->tx_buf) {
-			/* use rx buffer as dummy tx buffer */
+			/* To avoid errors when doing rx-only transfers with
+			 * many SG entries (> 20), use the rx buffer as the
+			 * dummy tx buffer so that dma reloads are done at the
+			 * same time for rx and tx.
+			 */
 			t->tx_sg.sgl = t->rx_sg.sgl;
 			t->tx_sg.nents = t->rx_sg.nents;
 		}
-- 
2.11.0
