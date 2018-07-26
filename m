From: Keiji Hayashibara <hayashibara.keiji@socionext.com>
Subject: [PATCH v2 0/2] add SPI controller driver for UniPhier SoCs
Date: Thu, 26 Jul 2018 16:09:01 +0900
Message-ID: <1532588943-19481-1-git-send-email-hayashibara.keiji@socionext.com>
Cc: masami.hiramatsu@linaro.org, jaswinder.singh@linaro.org,
        linux-kernel@vger.kernel.org, hayashibara.keiji@socionext.com
To: broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        yamada.masahiro@socionext.com, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This series adds support for SPI controller driver implemented on UniPhier SoCs.

Changes since v1:
- modify not to config SPI in master->setup method.
- fix internal bug of uniphier_spi_fill_tx_fifo().
- replace macro of BYTES_PER_WORD to inline function.
- use IRQ_NONE in irq handler.
- modify the handling of word size in uniphier_spi_send() and uniphier_spi_recv().
- modify help in Kconfig.
- other trivial change.


Keiji Hayashibara (1):
  spi: add SPI controller driver for UniPhier SoC

Kunihiko Hayashi (1):
  dt-bindings: spi: add DT bindings for UniPhier SPI controller

 .../devicetree/bindings/spi/spi-uniphier.txt       |  22 +
 drivers/spi/Kconfig                                |  13 +
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-uniphier.c                         | 539 +++++++++++++++++++++
 4 files changed, 575 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-uniphier.txt
 create mode 100644 drivers/spi/spi-uniphier.c

-- 
2.7.4
