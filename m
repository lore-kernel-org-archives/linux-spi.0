From: Stephen Boyd <swboyd@chromium.org>
Subject: [PATCH 1/2] spi: spi-geni-qcom: Don't initialize completion for normal message
Date: Thu, 10 Jan 2019 13:02:52 -0800
Message-ID: <20190110210253.23219-1-swboyd@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Girish Mahadevan <girishm@codeaurora.org>,
        Dilip Kota <dkota@codeaurora.org>,
        Alok Chauhan <alokc@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

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
Sent by a computer through tubes
