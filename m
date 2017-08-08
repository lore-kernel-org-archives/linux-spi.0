From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: qup: Fix error handling in spi_qup_prep_sg" to the spi tree
Date: Tue, 08 Aug 2017 12:18:28 +0100
Message-ID: <E1df2Wq-0006Mr-55@finisterre>
References: <1500882445-29008-6-git-send-email-varada@codeaurora.org>
Cc: Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, andy.gross@linaro.org,
        david.brown@linaro.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-spi@vger.kernel.org
To: Varadarajan Narayanan <varada@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1500882445-29008-6-git-send-email-varada@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: qup: Fix error handling in spi_qup_prep_sg

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

>From d9a09a6c0c98d57e5a248c3b9bb10f63d475dfdb Mon Sep 17 00:00:00 2001
From: Varadarajan Narayanan <varada@codeaurora.org>
Date: Fri, 28 Jul 2017 12:22:52 +0530
Subject: [PATCH] spi: qup: Fix error handling in spi_qup_prep_sg

Signed-off-by: Varadarajan Narayanan <varada@codeaurora.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-qup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index f1aa5c15d180..ef952946375a 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -311,8 +311,8 @@ static int spi_qup_prep_sg(struct spi_master *master, struct spi_transfer *xfer,
 	}
 
 	desc = dmaengine_prep_slave_sg(chan, sgl, nents, dir, flags);
-	if (!desc)
-		return -EINVAL;
+	if (IS_ERR_OR_NULL(desc))
+		return desc ? PTR_ERR(desc) : -EINVAL;
 
 	desc->callback = callback;
 	desc->callback_param = qup;
-- 
2.13.2
