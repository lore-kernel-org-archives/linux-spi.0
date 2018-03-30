From: Sergey Suloev <ssuloev@orpaltech.com>
Subject: [PATCH 0/6] spi: Add support for DMA transfers in sun6i SPI driver
Date: Fri, 30 Mar 2018 10:22:37 +0300
Message-ID: <20180330072243.19368-1-ssuloev@orpaltech.com>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Sergey Suloev <ssuloev@orpaltech.com>
To: Mark Brown <broonie@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The following patchset provides corrections for PIO-mode
and support for DMA transfers in sun6i SPI driver.

Sergey Suloev (6):
  spi: sun6i: coding style/readability improvements
  spi: sun6i: handle chip select polarity flag
  spi: sun6i: restrict transfer length in PIO-mode
  spi: sun6i: use completion provided by SPI core
  spi: sun6i: introduce register set/unset helpers
  spi: sun6i: add DMA transfers support

 drivers/spi/spi-sun6i.c | 501 ++++++++++++++++++++++++++++++++++++------------
 1 file changed, 378 insertions(+), 123 deletions(-)

-- 
2.16.2
