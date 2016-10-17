From: Ralf Ramsauer <ralf@ramses-pyramidenbau.de>
Subject: [PATCH v2 0/2] spi, i2c: mark device nodes only in case of successful instantiation
Date: Mon, 17 Oct 2016 15:59:55 +0200
Message-ID: <20161017135957.20297-1-ralf@ramses-pyramidenbau.de>
Cc: Ralf Ramsauer <ralf@ramses-pyramidenbau.de>,
        "linux-kernel @ vger . kernel . org" <linux-kernel@vger.kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>
To: Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Linux SPI <linux-spi@vger.kernel.org>,
        Linux I2C <linux-i2c@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi,

this one fixes initialisation of I2C/SPI nodes.  Upon failure during
intialisation, nodes were erroneously populated and never unmarked.

This lead to the problem that re-loaded drivers will never probe those devices
again and can easily be fixed by clearing the OF_POPULATE flag when the node
doesn't successfully initialise.

For the discussion of v1, see
https://lkml.org/lkml/2016/10/14/483

  Ralf

changes since v1:
  - also fix I2C core driver
  - keep the atomic test-and-set, as Geert suggested

Ralf Ramsauer (2):
  spi: mark device nodes only in case of successful instantiation
  i2c: mark device nodes only in case of successful instantiation

 drivers/i2c/i2c-core.c | 11 ++++++++++-
 drivers/spi/spi.c      |  5 ++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

-- 
2.10.1
