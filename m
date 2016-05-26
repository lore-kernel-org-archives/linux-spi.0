From: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 3/5] spi: sunxi: expose maximum transfer size limit
Date: 26 May 2016 19:25:24 -0000
Message-ID: <5fffb7eca6f4b70853d92be2403595d6d06bede7.1464130597.git.hramrach@gmail.com>
References: <cover.1464130597.git.hramrach@gmail.com>
Reply-To: hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
  Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
  Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
  linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
Return-path: <linux-sunxi+bncBCQMLUOX54MBBJ43TW5AKGQEH3YF64A-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <cover.1464130597.git.hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
List-Id: linux-spi.vger.kernel.org

The sun4i spi hardware can trasfer at most 63 bytes of data without DMA
support so report the limitation. Same on sun6i.

Signed-off-by: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-sun4i.c | 6 ++++++
 drivers/spi/spi-sun6i.c | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
index 04f1b77..bf52b09 100644
--- a/drivers/spi/spi-sun4i.c
+++ b/drivers/spi/spi-sun4i.c
@@ -167,6 +167,11 @@ static void sun4i_spi_set_cs(struct spi_device *spi, bool enable)
 	sun4i_spi_write(sspi, SUN4I_CTL_REG, reg);
 }
 
+static size_t sun4i_spi_max_transfer_size(struct spi_device *spi)
+{
+	return SUN4I_FIFO_DEPTH - 1;
+}
+
 static int sun4i_spi_transfer_one(struct spi_master *master,
 				  struct spi_device *spi,
 				  struct spi_transfer *tfr)
@@ -407,6 +412,7 @@ static int sun4i_spi_probe(struct platform_device *pdev)
 	master->bits_per_word_mask = SPI_BPW_MASK(8);
 	master->dev.of_node = pdev->dev.of_node;
 	master->auto_runtime_pm = true;
+	master->max_transfer_size = sun4i_spi_max_transfer_size;
 
 	sspi->hclk = devm_clk_get(&pdev->dev, "ahb");
 	if (IS_ERR(sspi->hclk)) {
diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index 8954a62..f491a41 100644
--- a/drivers/spi/spi-sun6i.c
+++ b/drivers/spi/spi-sun6i.c
@@ -154,6 +154,11 @@ static void sun6i_spi_set_cs(struct spi_device *spi, bool enable)
 }
 
 
+static size_t sun6i_spi_max_transfer_size(struct spi_device *spi)
+{
+	return SUN6I_FIFO_DEPTH - 1;
+}
+
 static int sun6i_spi_transfer_one(struct spi_master *master,
 				  struct spi_device *spi,
 				  struct spi_transfer *tfr)
@@ -418,6 +423,7 @@ static int sun6i_spi_probe(struct platform_device *pdev)
 	master->bits_per_word_mask = SPI_BPW_MASK(8);
 	master->dev.of_node = pdev->dev.of_node;
 	master->auto_runtime_pm = true;
+	master->max_transfer_size = sun6i_spi_max_transfer_size;
 
 	sspi->hclk = devm_clk_get(&pdev->dev, "ahb");
 	if (IS_ERR(sspi->hclk)) {
-- 
2.8.1
