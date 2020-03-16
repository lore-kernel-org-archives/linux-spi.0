From: Douglas Anderson <dianders@chromium.org>
Subject: [PATCH] spi: spi-geni-qcom: Speculative fix of "nobody cared" about interrupt
Date: Mon, 16 Mar 2020 15:20:01 -0700
Message-ID: <20200316151939.1.I752ebdcfd5e8bf0de06d66e767b8974932b3620e@changeid>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Alok Chauhan <alokc@codeaurora.org>,
        Dilip Kota <dkota@codeaurora.org>, skakit@codeaurora.org,
        Girish Mahadevan <girishm@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Every once in a while (like once in a few months on a device) people
have seen warnings on devices using spi-geni-qcom like:

  irq ...: nobody cared (try booting with the "irqpoll" option)

...where the interrupt number listed matches up with "spi_geni" in
/proc/interrupts.

You can get "nobody cared" if the interrupt handler returns IRQ_NONE.
Once you get into this state the driver will just stop working.

Auditing the code makes me believe that it's probably not so good
checking "cur_mcmd" in the interrupt handler not under spinlock.
Let's move it to be under spinlock.  While we're at it, let's not
return IRQ_NONE.  IRQ_NONE is supposed to check the _hardware_ status
registers and only be returned if your hardware says that there's no
interrupt present.  It's not supposed to check software state.  In any
case, the whole point of IRQ_NONE is if two separate devices are
trying to share an interrupt line, which just isn't true for anyone
using geni.

Looking more closely at the code, it looks as if there are some other
places that could be under spinlock, so let's add.  It looks as if the
original code was assuming that by the time that the interrupt handler
got called that the write to "cur_mcmd" (to make it not CMD_NONE
anymore) would make it to the processor handling the interrupt.
Perhaps with weakly ordered memory this sometimes (though very rarely)
happened.

Patch is marked "speculative" because I have no way to reproduce this
problem, so I'm just hoping this fixes it.  Weakly ordered memory
makes my brain hurt.

Fixes: 561de45f72bd ("spi: spi-geni-qcom: Add SPI driver support for GENI based QUP")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/spi/spi-geni-qcom.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index c3972424af71..51290a3fd203 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -151,16 +151,19 @@ static void spi_geni_set_cs(struct spi_device *slv, bool set_flag)
 	struct geni_se *se = &mas->se;
 	unsigned long time_left;
 
-	reinit_completion(&mas->xfer_done);
 	pm_runtime_get_sync(mas->dev);
 	if (!(slv->mode & SPI_CS_HIGH))
 		set_flag = !set_flag;
 
+	spin_lock_irq(&mas->lock);
+	reinit_completion(&mas->xfer_done);
+
 	mas->cur_mcmd = CMD_CS;
 	if (set_flag)
 		geni_se_setup_m_cmd(se, SPI_CS_ASSERT, 0);
 	else
 		geni_se_setup_m_cmd(se, SPI_CS_DEASSERT, 0);
+	spin_unlock_irq(&mas->lock);
 
 	time_left = wait_for_completion_timeout(&mas->xfer_done, HZ);
 	if (!time_left)
@@ -307,6 +310,8 @@ static void setup_fifo_xfer(struct spi_transfer *xfer,
 	u32 spi_tx_cfg, len;
 	struct geni_se *se = &mas->se;
 
+	spin_lock_irq(&mas->lock);
+
 	spi_tx_cfg = readl(se->base + SE_SPI_TRANS_CFG);
 	if (xfer->bits_per_word != mas->cur_bits_per_word) {
 		spi_setup_word_len(mas, mode, xfer->bits_per_word);
@@ -376,6 +381,8 @@ static void setup_fifo_xfer(struct spi_transfer *xfer,
 	 */
 	if (m_cmd & SPI_TX_ONLY)
 		writel(mas->tx_wm, se->base + SE_GENI_TX_WATERMARK_REG);
+
+	spin_unlock_irq(&mas->lock);
 }
 
 static int spi_geni_transfer_one(struct spi_master *spi,
@@ -479,12 +486,17 @@ static irqreturn_t geni_spi_isr(int irq, void *data)
 	u32 m_irq;
 	unsigned long flags;
 
-	if (mas->cur_mcmd == CMD_NONE)
-		return IRQ_NONE;
-
 	spin_lock_irqsave(&mas->lock, flags);
 	m_irq = readl(se->base + SE_GENI_M_IRQ_STATUS);
 
+	/*
+	 * We don't expect to hit this, but if we do we should try our best
+	 * to clear the interrupts and return so we don't just get called
+	 * again.
+	 */
+	if (mas->cur_mcmd == CMD_NONE)
+		goto exit;
+
 	if ((m_irq & M_RX_FIFO_WATERMARK_EN) || (m_irq & M_RX_FIFO_LAST_EN))
 		geni_spi_handle_rx(mas);
 
@@ -523,6 +535,7 @@ static irqreturn_t geni_spi_isr(int irq, void *data)
 		complete(&mas->xfer_done);
 	}
 
+exit:
 	writel(m_irq, se->base + SE_GENI_M_IRQ_CLEAR);
 	spin_unlock_irqrestore(&mas->lock, flags);
 	return IRQ_HANDLED;
-- 
2.25.1.481.gfbce0eb801-goog
