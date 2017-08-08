From: Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v3 0/7] spi: spi-ep93xx: cleanup and update driver to modern API
Date: Wed,  9 Aug 2017 08:51:24 +1200
Message-ID: <20170808205131.30874-1-chris.packham@alliedtelesis.co.nz>
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>
To: broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com,
        hsweeten@visionengravers.com
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Cleanup and update this driver to use the default master transfer queueing
mechanism provided by the core.

I've been carrying these changes locally to use as a basis for other SPI work.
Mark Brown pointed out that he's simply missed seeing it, Andy Shevchenko had
some minor comment's which I've now addressed. I'm just re-sending this on
Hartley Sweeten's behalf.

Changes in v3:
- add my sign-off to all the patches in this series

H Hartley Sweeten (7):
  spi: spi-ep93xx: remove io wrappers
  spi: spi-ep93xx: use 32-bit read/write for all registers
  spi: spi-ep93xx: add spi master prepare_transfer_hardware()
  spi: spi-ep93xx: absorb the interrupt enable/disable helpers
  spi: spi-ep93xx: pass the spi_master pointer around
  spi: spi-ep93xx: remove private data 'current_msg'
  spi: spi-ep93xx: use the default master transfer queueing mechanism

 drivers/spi/spi-ep93xx.c | 501 +++++++++++++++++------------------------------
 1 file changed, 177 insertions(+), 324 deletions(-)

-- 
2.13.0
