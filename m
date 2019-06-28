From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: stm32-qspi: remove signal sensitive on completion" to
 the spi tree
Date: Fri, 28 Jun 2019 17:56:33 +0100 (BST)
Message-ID: <20190628165633.E5C44440046@finisterre.sirena.org.uk>
References: <1561621439-7305-2-git-send-email-ludovic.Barre@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: devicetree@vger.kernel.org, Alexandre Torgue <alexandre.torgue@st.com>,
 Boris Brezillon <bbrezillon@kernel.org>, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, linux-spi@vger.kernel.org,
 Marek Vasut <marek.vasut@gmail.com>, Mark Brown <broonie@kernel.org>,
 linux-mtd@lists.infradead.org, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
To: Ludovic Barre <ludovic.barre@st.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1561621439-7305-2-git-send-email-ludovic.Barre@st.com>
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

   spi: stm32-qspi: remove signal sensitive on completion

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.3

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

>From 775c4c0032c408b8a57a3fc2695eeda101da003a Mon Sep 17 00:00:00 2001
From: Ludovic Barre <ludovic.barre@st.com>
Date: Thu, 27 Jun 2019 09:43:59 +0200
Subject: [PATCH] spi: stm32-qspi: remove signal sensitive on completion

On umount step a sigkill signal is set (without user specific
action), due to sigkill signal the completion will be interrupted and
the data transfer can't be finished if a sync is needed.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-stm32-qspi.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-stm32-qspi.c b/drivers/spi/spi-stm32-qspi.c
index 42f8e3c6aa1f..0b07182f5660 100644
--- a/drivers/spi/spi-stm32-qspi.c
+++ b/drivers/spi/spi-stm32-qspi.c
@@ -245,12 +245,8 @@ static int stm32_qspi_tx_dma(struct stm32_qspi *qspi,
 	writel_relaxed(cr | CR_DMAEN, qspi->io_base + QSPI_CR);
 
 	t_out = sgt.nents * STM32_COMP_TIMEOUT_MS;
-	if (!wait_for_completion_interruptible_timeout(&qspi->dma_completion,
-						       msecs_to_jiffies(t_out)))
-		err = -ETIMEDOUT;
-
-	if (dma_async_is_tx_complete(dma_ch, cookie,
-				     NULL, NULL) != DMA_COMPLETE)
+	if (!wait_for_completion_timeout(&qspi->dma_completion,
+					 msecs_to_jiffies(t_out)))
 		err = -ETIMEDOUT;
 
 	if (err)
@@ -304,7 +300,7 @@ static int stm32_qspi_wait_cmd(struct stm32_qspi *qspi,
 	cr = readl_relaxed(qspi->io_base + QSPI_CR);
 	writel_relaxed(cr | CR_TCIE | CR_TEIE, qspi->io_base + QSPI_CR);
 
-	if (!wait_for_completion_interruptible_timeout(&qspi->data_completion,
+	if (!wait_for_completion_timeout(&qspi->data_completion,
 				msecs_to_jiffies(STM32_COMP_TIMEOUT_MS))) {
 		err = -ETIMEDOUT;
 	} else {
-- 
2.20.1
