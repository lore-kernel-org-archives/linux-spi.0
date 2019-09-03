From: Keiji Hayashibara <hayashibara.keiji@socionext.com>
Subject: [PATCH 0/3] spi: uniphier: introduce polling mode and fix bug
Date: Tue,  3 Sep 2019 14:30:58 +0900
Message-ID: <1567488661-11428-1-git-send-email-hayashibara.keiji@socionext.com>
Cc: masami.hiramatsu@linaro.org, jaswinder.singh@linaro.org,
        linux-kernel@vger.kernel.org, hayashibara.keiji@socionext.com
To: broonie@kernel.org, yamada.masahiro@socionext.com,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This series introduces new polling mode and fixes bug.

- Introduce new polling mode for short size transfer. Either the estimated
  transfer time is estimated to exceed 200us, or polling loop actually exceeds
  200us, it switches to irq mode.
- Fix a bug of register overwrite.
- Minor corrections.

Keiji Hayashibara (3):
  spi: uniphier: fix wrong register overwrite
  spi: uniphier: remove unnecessary code
  spi: uniphier: introduce polling mode

 drivers/spi/spi-uniphier.c | 85 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 68 insertions(+), 17 deletions(-)

-- 
2.7.4
