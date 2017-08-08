From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: qup: Enable chip select support" to the spi tree
Date: Tue, 08 Aug 2017 12:18:43 +0100
Message-ID: <E1df2X5-0006R8-H4@finisterre>
References: <1497419551-21834-2-git-send-email-varada@codeaurora.org>
Cc: Sham Muthayyan <smuthayy@codeaurora.org>,
        Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, andy.gross@linaro.org,
        david.brown@linaro.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        Sham Muthayyan <smuthayy@codeaurora.org>,
        linux-spi@vger.kernel.org
To: Varadarajan Narayanan <varada@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1497419551-21834-2-git-send-email-varada@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: qup: Enable chip select support

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

>From b702b9fb393ed1c19ab3ecb1552757522c982746 Mon Sep 17 00:00:00 2001
From: Varadarajan Narayanan <varada@codeaurora.org>
Date: Fri, 28 Jul 2017 12:22:48 +0530
Subject: [PATCH] spi: qup: Enable chip select support

Enable chip select support for QUP versions later than v1. The
chip select support was broken in QUP version 1. Hence the chip
select support was removed earlier in an earlier commit
(4a8573abe "spi: qup: Remove chip select function"). Since the
chip select support is functional in recent versions of QUP,
re-enabling it for QUP versions later than v1.

Signed-off-by: Sham Muthayyan <smuthayy@codeaurora.org>
Signed-off-by: Varadarajan Narayanan <varada@codeaurora.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-qup.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index 1bfa889b8427..c0d4defc1c13 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -750,6 +750,24 @@ static int spi_qup_init_dma(struct spi_master *master, resource_size_t base)
 	return ret;
 }
 
+static void spi_qup_set_cs(struct spi_device *spi, bool val)
+{
+	struct spi_qup *controller;
+	u32 spi_ioc;
+	u32 spi_ioc_orig;
+
+	controller = spi_master_get_devdata(spi->master);
+	spi_ioc = readl_relaxed(controller->base + SPI_IO_CONTROL);
+	spi_ioc_orig = spi_ioc;
+	if (!val)
+		spi_ioc |= SPI_IO_C_FORCE_CS;
+	else
+		spi_ioc &= ~SPI_IO_C_FORCE_CS;
+
+	if (spi_ioc != spi_ioc_orig)
+		writel_relaxed(spi_ioc, controller->base + SPI_IO_CONTROL);
+}
+
 static int spi_qup_probe(struct platform_device *pdev)
 {
 	struct spi_master *master;
@@ -846,6 +864,9 @@ static int spi_qup_probe(struct platform_device *pdev)
 	if (of_device_is_compatible(dev->of_node, "qcom,spi-qup-v1.1.1"))
 		controller->qup_v1 = 1;
 
+	if (!controller->qup_v1)
+		master->set_cs = spi_qup_set_cs;
+
 	spin_lock_init(&controller->lock);
 	init_completion(&controller->done);
 
-- 
2.13.2
