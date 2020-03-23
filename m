From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: spi-s3c24xx: Replace zero-length array with
 flexible-array member" to the spi tree
Date: Mon, 23 Mar 2020 18:37:20 +0000
Message-ID: <applied-20200320232556.GA24989@embeddedor.com>
References: <20200320232556.GA24989@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-samsung-soc@vger.kernel.org,
 "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>, linux-spi@vger.kernel.org,
 Kukjin Kim <kgene@kernel.org>, Andi Shyti <andi@etezian.org>,
 linux-arm-kernel@lists.infradead.org
To: Gustavo A. R. Silva <gustavo@embeddedor.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
In-Reply-To: <20200320232556.GA24989@embeddedor.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: spi-s3c24xx: Replace zero-length array with flexible-array member

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

>From 2d4ccc2ac61b1a407a1c75633a3bf2f878ff44b5 Mon Sep 17 00:00:00 2001
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date: Fri, 20 Mar 2020 18:25:56 -0500
Subject: [PATCH] spi: spi-s3c24xx: Replace zero-length array with
 flexible-array member

The current codebase makes use of the zero-length array language
extension to the C90 standard, but the preferred mechanism to declare
variable-length types such as these ones is a flexible array member[1][2],
introduced in C99:

struct foo {
        int stuff;
        struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last in the structure, which
will help us prevent some kind of undefined behavior bugs from being
inadvertently introduced[3] to the codebase from now on.

Also, notice that, dynamic memory allocations won't be affected by
this change:

"Flexible array members have incomplete type, and so the sizeof operator
may not be applied. As a quirk of the original implementation of
zero-length arrays, sizeof evaluates to zero."[1]

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Reviewed-by: Andi Shyti <andi@etezian.org>
Link: https://lore.kernel.org/r/20200320232556.GA24989@embeddedor.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-s3c24xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-s3c24xx.c b/drivers/spi/spi-s3c24xx.c
index 2d6e37f25e2d..2cb3b611c294 100644
--- a/drivers/spi/spi-s3c24xx.c
+++ b/drivers/spi/spi-s3c24xx.c
@@ -227,7 +227,7 @@ static inline unsigned int hw_txbyte(struct s3c24xx_spi *hw, int count)
 struct spi_fiq_code {
 	u32	length;
 	u32	ack_offset;
-	u8	data[0];
+	u8	data[];
 };
 
 extern struct spi_fiq_code s3c24xx_spi_fiq_txrx;
-- 
2.20.1
