From: Chao Fu <b44548@freescale.com>
Subject: [PATCH v4 2/2] spi:dspi:Remove some coding sytle not in standard
Date: Wed, 12 Feb 2014 15:29:06 +0800
Message-ID: <1392190146-18852-2-git-send-email-b44548@freescale.com>
References: <1392190146-18852-1-git-send-email-b44548@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Chao Fu <b44548@freescale.com>
To: <linux-spi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <broonie@kernel.org>, <grant.likely@linaro.org>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1392190146-18852-1-git-send-email-b44548@freescale.com>
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

From: Chao Fu <B44548@freescale.com>

Remove some coding sytle not in standard in former code.

Signed-off-by: Chao Fu      <b44548@freescale.com>
---
Change in v4:
None.
Change in v3:
None.
Change in v2:
New.
 drivers/spi/spi-fsl-dspi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index fb16575..42ede0d 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -111,9 +111,9 @@ struct fsl_dspi {
 
 	struct regmap		*regmap;
 	int			irq;
-	struct clk 		*clk;
+	struct clk		*clk;
 
-	struct spi_transfer 	*cur_transfer;
+	struct spi_transfer	*cur_transfer;
 	struct chip_data	*cur_chip;
 	size_t			len;
 	void			*tx;
@@ -124,8 +124,8 @@ struct fsl_dspi {
 	u8			cs;
 	u16			void_write_data;
 
-	wait_queue_head_t 	waitq;
-	u32 			waitflags;
+	wait_queue_head_t	waitq;
+	u32			waitflags;
 };
 
 static inline int is_double_byte_mode(struct fsl_dspi *dspi)
-- 
1.8.4
