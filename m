From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: spi-geni-qcom: Don't initialize completion for normal message" to the spi tree
Date: Mon, 14 Jan 2019 22:09:58 +0000 (GMT)
Message-ID: <20190114220958.B623E1127AD0@debutante.sirena.org.uk>
References: <20190110210253.23219-1-swboyd@chromium.org>
Cc: Girish Mahadevan <girishm@codeaurora.org>,
        Dilip Kota <dkota@codeaurora.org>,
        Alok Chauhan <alokc@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Girish Mahadevan <girishm@codeaurora.org>,
        Dilip Kota <dkota@codeaurora.org>,
        Alok Chauhan <alokc@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-spi@vger.kernel.org
To: Stephen Boyd <swboyd@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190110210253.23219-1-swboyd@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: spi-geni-qcom: Don't initialize completion for normal message

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

>From 0357a3daada3236da59be5d692f02ae07e2a145e Mon Sep 17 00:00:00 2001
From: Stephen Boyd <swboyd@chromium.org>
Date: Thu, 10 Jan 2019 13:02:52 -0800
Subject: [PATCH] spi: spi-geni-qcom: Don't initialize completion for normal
 message

We only use this completion when we're doing something that isn't a
message transfer. For example, changing CS or aborting/canceling a
command. All of those situations properly reinitialize the completion
before sending the GENI the special command to change CS or cancel, etc.
Given that, let's remove the initialization here.

Cc: Girish Mahadevan <girishm@codeaurora.org>
Cc: Dilip Kota <dkota@codeaurora.org>
Cc: Alok Chauhan <alokc@codeaurora.org>
Cc: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-geni-qcom.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index fdb7cb88fb56..c3e9464027d4 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -233,7 +233,6 @@ static int spi_geni_prepare_message(struct spi_master *spi,
 	struct geni_se *se = &mas->se;
 
 	geni_se_select_mode(se, GENI_SE_FIFO);
-	reinit_completion(&mas->xfer_done);
 	ret = setup_fifo_params(spi_msg->spi, spi);
 	if (ret)
 		dev_err(mas->dev, "Couldn't select mode %d\n", ret);
-- 
2.20.1
