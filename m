From: Esben Haabendal <esben.haabendal@gmail.com>
Subject: [PATCH 00/12] XSPI mode for LS1021A DSPI
Date: Wed, 20 Jun 2018 09:34:30 +0200
Message-ID: <20180620073442.20913-1-esben.haabendal@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Kurt Kanzenbach <kurt@linutronix.de>,
        Angelo Dureghello <angelo@sysam.it>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Sanchayan Maity <maitysanchayan@gmail.com>,
        Yuan Yao <yao.yuan@nxp.com>, linux-kernel@vger.kernel.org,
        Esben Haabendal <eha@deif.com>
To: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Esben Haabendal <eha@deif.com>

This patch series contains a number of fixes and cleanups for the spi-fsl-dspi
driver (commit 1-7), and on top of that, implementation of XSPI mode for
LS1021A allowing for SPI transfers larger than 16 bits (commit 8-12).

User visible changes (improvements) are:

* Support for all transfer sizes between 4 and 16, not just 4 (which I believe
  were broken anyway), 8 and 16 bits per word.  

* Full support for transfer->cs_change flag.  Setting cs_change in last
  transfer leaves CS asserted.

* Support for all transfers sizes between 4 and 32 bits per word for LS1021A.

The XSPI mode can be trivially enabled for other target using TCQF mode.
Enable for targets using EOQ mode requires additional work due to the split
of TX FIFO into command and data FIFO.

If you like, I will happily squash the last 5 commits into a single XSPI mode
commit.

Esben Haabendal (12):
  spi: spi-fsl-dspi: Drop unreachable else if statement
  spi: spi-fsl-dspi: Drop unneeded use of dataflags bits
  spi: spi-fsl-dspi: Fix per transfer cs_change handling
  spi: spi-fsl-dspi: Simplify transfer counter handling
  spi: spi-fsl-dspi: Support 4 to 16 bits per word transfers
  spi: spi-fsl-dspi: Fixup regmap configuration
  spi: spi-fsl-dspi: Fix MCR register handling
  spi: spi-fsl-dspi: Add support for XSPI mode registers
  spi: spi-fsl-dspi: Framesize control for XSPI mode
  spi: spi-fsl-dspi: XSPI FIFO handling (in TCFQ mode)
  spi: spi-fsl-dspi: Advertise 32 bit for XSPI mode
  spi: spi-fsl-dspi: Enable extended SPI mode

 drivers/spi/spi-fsl-dspi.c | 458 ++++++++++++++++++++-----------------
 1 file changed, 250 insertions(+), 208 deletions(-)

-- 
2.17.1
