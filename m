From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: sifive: Remove redundant dev_err call in
 sifive_spi_probe()" to the spi tree
Date: Tue, 26 Feb 2019 12:07:07 +0000 (GMT)
Message-ID: <20190226120707.0798011284E3@debutante.sirena.org.uk>
References: <20190222054632.4610-1-weiyongjun1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Palmer Dabbelt <palmer@sifive.com>, kernel-janitors@vger.kernel.org,
 linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, linux-riscv@lists.infradead.org
To: Wei Yongjun <weiyongjun1@huawei.com>
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190222054632.4610-1-weiyongjun1@huawei.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+glpr-linux-riscv=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: sifive: Remove redundant dev_err call in sifive_spi_probe()

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

>From daad4d2a0a60b0b2879e66194100b43c41e96ca9 Mon Sep 17 00:00:00 2001
From: Wei Yongjun <weiyongjun1@huawei.com>
Date: Fri, 22 Feb 2019 05:46:32 +0000
Subject: [PATCH] spi: sifive: Remove redundant dev_err call in
 sifive_spi_probe()

There is a error message within devm_ioremap_resource
already, so remove the dev_err call to avoid redundant
error message.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-sifive.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-sifive.c b/drivers/spi/spi-sifive.c
index ebca3fc4d345..93ec2c6cdbfd 100644
--- a/drivers/spi/spi-sifive.c
+++ b/drivers/spi/spi-sifive.c
@@ -310,7 +310,6 @@ static int sifive_spi_probe(struct platform_device *pdev)
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	spi->regs = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(spi->regs)) {
-		dev_err(&pdev->dev, "Unable to map IO resources\n");
 		ret = PTR_ERR(spi->regs);
 		goto put_master;
 	}
-- 
2.20.1
