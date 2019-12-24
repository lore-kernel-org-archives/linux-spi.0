From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 0/5] spi: uniphier: Introduce DMA transfer mode
Date: Tue, 24 Dec 2019 09:58:22 +0900
Message-ID: <1577149107-30670-1-git-send-email-hayashi.kunihiko@socionext.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Keiji Hayashibara <hayashibara.keiji@socionext.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This series introduces DMA transfer mode into UniPhier SPI driver.
This only supports UniPhier XDMAC implemented in the SoC.

The DMA transfer mode uses FIFO threshold as a trigger to start DMA transfer,
however, the FIFO is limited to one word width due to alignment restiction
of the DMA controller.

Kunihiko Hayashi (5):
  spi: uniphier: Fix FIFO threshold
  spi: uniphier: Change argument of irq functions to private structure
  spi: uniphier: Add handle_err callback function
  spi: uniphier: Add SPI_LOOP to the capabilities
  spi: uniphier: Add DMA transfer mode support

 drivers/spi/spi-uniphier.c | 261 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 241 insertions(+), 20 deletions(-)

-- 
2.7.4
