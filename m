From: Sergey Suloev <ssuloev@orpaltech.com>
Subject: [PATCH v2 0/6] spi: Add support for DMA transfers in sun4i SPI driver
Date: Tue,  3 Apr 2018 18:28:59 +0300
Message-ID: <20180403152905.1524-1-ssuloev@orpaltech.com>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Sergey Suloev <ssuloev@orpaltech.com>
To: Mark Brown <broonie@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The following patchset provides corrections for PIO-mode
and support for DMA transfers in sun4i SPI driver.

Changes in v2:
1) Restored processing of 3/4 FIFO full interrupt.

2) Debug log enhancements.

Sergey Suloev (6):
  spi: core: handle timeout error from transfer_one()
  spi: sun4i: restrict transfer length in PIO-mode
  spi: sun4i: coding style/readability improvements
  spi: sun4i: use completion provided by SPI core driver
  spi: sun4i: introduce register set/unset helpers
  spi: sun4i: add DMA transfers support

 drivers/spi/spi-sun4i.c | 442 +++++++++++++++++++++++++++++++++++++-----------
 drivers/spi/spi.c       |   5 +-
 2 files changed, 347 insertions(+), 100 deletions(-)

-- 
2.16.2
