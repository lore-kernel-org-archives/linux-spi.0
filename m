From: Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v4 00/19] spi: introduce `struct spi_delay` data-type
Date: Thu, 26 Sep 2019 13:51:28 +0300
Message-ID: <20190926105147.7839-1-alexandru.ardelean@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: f.fainelli@gmail.com, baolin.wang@linaro.org, zhang.lyra@gmail.com,
 linus.walleij@linaro.org, broonie@kernel.org, orsonzhai@gmail.com,
 Alexandru Ardelean <alexandru.ardelean@analog.com>, jic23@kernel.org
To: <bcm-kernel-feedback-list@broadcom.com>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
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

Initially, I started this patchset thinking: "we need a new delay for
something-something" (in case someone is curios, we needed a CS-hold-time
when CS is asserted, because the CS wakes a chip from sleep-mode).

Then I added the delay, and felt a bit dirty-inside about adding a new one
(just like that), and decided to look at maybe cleaning things up a bit,
and a few days/weeks later, I got here.

It's based on top of Jonathan's `iio/togreg` branch which also includes the
ADIS driver library changes for `cs_change_delay`.

The current v4 tries to be a complete change as possible about converting
all delays to the `struct delay` data-type; at least in the scope of the
SPI subsystem. Many external users of the SPI subsystem use the
`delay_usecs` field to specify delays for transfers; which is why this
field is still kept temporarily for backwards compatibility until all other
delays are switched to `delay`.

Thanks
Alex

Changelog v3 -> v4:
* re-unify all `spi_delay` changes into a single big series spanning SPI &
  IIO subsystems; patches are based on top of IIO, so patch
  `drivers/iio/imu/adis.c` does not apply on top of SPI/for-next tree

Changelog v2 -> v3:
* squash patches 3 & 4 into a single patch; otherwise the kernel is in
  broken state between those 2 patches

Changelog v1 -> v2:
* split away from the RFC patchset, which aims to be a broader explanation
  for this changeset; parts of v1 are not 100% defined yet, and may require
  some discussion and refinement.


Alexandru Ardelean (19):
  spi: move `cs_change_delay` backwards compat logic outside switch
  spi: introduce spi_delay struct as "value + unit" &  spi_delay_exec()
  spi: make `cs_change_delay` the first user of the `spi_delay` logic
  spi: sprd: convert transfer word delay to spi_delay struct
  spi: orion: use new `word_delay` field for SPI transfers
  spi: spidev: use new `word_delay` field for spi transfers
  spi: core,atmel: convert `word_delay_usecs` -> `word_delay` for
    spi_device
  spi: introduce `delay` field for `spi_transfer` +
    spi_transfer_delay_exec()
  spi: use new `spi_transfer_delay_exec` helper where straightforward
  spi: tegra114: use `spi_transfer_delay_exec` helper
  spi: tegra20-sflash: use to new `spi_transfer_delay_exec`
  spi: spi-loopback-test: use new `delay` field
  spi: spidev: use new `delay` field for spi transfers
  spi: tegra114: change format for `spi_set_cs_timing()` function
  spi: implement SW control for CS times
  spi: spi-fsl-espi: convert transfer delay to `spi_delay` format
  spi: spi-falcon: extend warning to `delay` as well
  spi: bcm63xx: extend error condition to `delay` as well
  spi: spi-axi: extend support for the `delay` field

 drivers/iio/imu/adis.c           |  24 ++---
 drivers/spi/spi-atmel.c          |  29 +++++-
 drivers/spi/spi-axi-spi-engine.c |  16 +++-
 drivers/spi/spi-bcm63xx-hsspi.c  |   3 +-
 drivers/spi/spi-bcm63xx.c        |   2 +-
 drivers/spi/spi-cavium.c         |   3 +-
 drivers/spi/spi-falcon.c         |   2 +-
 drivers/spi/spi-fsl-dspi.c       |   3 +-
 drivers/spi/spi-fsl-espi.c       |  19 +++-
 drivers/spi/spi-fsl-spi.c        |   3 +-
 drivers/spi/spi-loopback-test.c  |  12 ++-
 drivers/spi/spi-mpc512x-psc.c    |   3 +-
 drivers/spi/spi-mpc52xx-psc.c    |   3 +-
 drivers/spi/spi-omap-100k.c      |   3 +-
 drivers/spi/spi-orion.c          |   6 +-
 drivers/spi/spi-pl022.c          |  25 +++--
 drivers/spi/spi-sc18is602.c      |   3 +-
 drivers/spi/spi-sh-hspi.c        |   3 +-
 drivers/spi/spi-sprd.c           |  15 ++-
 drivers/spi/spi-tegra114.c       |  39 ++++----
 drivers/spi/spi-tegra20-sflash.c |   5 +-
 drivers/spi/spi-topcliff-pch.c   |   7 +-
 drivers/spi/spi-txx9.c           |   3 +-
 drivers/spi/spi-xcomm.c          |   3 +-
 drivers/spi/spi.c                | 158 +++++++++++++++++++++++++------
 drivers/spi/spidev.c             |   6 +-
 include/linux/spi/spi.h          |  66 +++++++++----
 27 files changed, 323 insertions(+), 141 deletions(-)

-- 
2.20.1
