From: Sourav Poddar <sourav.poddar@ti.com>
Subject: [PATCH 0/3]Add quad/memory mapped support for SPI flash.
Date: Wed, 9 Oct 2013 20:54:41 +0530
Message-ID: <1381332284-21822-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general@lists.sourceforge.net,
 Sourav Poddar <sourav.poddar@ti.com>, linux-mtd@lists.infradead.org,
 balbi@ti.com
To: <broonie@kernel.org>, <dwmw2@infradead.org>, <computersforpeace@gmail.com>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

This patch add quad/memory mapped support in flash driver(m25p80).

Added support for quad memory mapped for TI qspi controller also.

This patch has been tested with some internal dts data.

Sourav Poddar (3):
  spi/qspi: Add memory mapped read support.
  drivers: mtd: devices: Add quad read support.
  drivers: mtd: devices: Add memory mapped read support.

 drivers/mtd/devices/m25p80.c |  193 ++++++++++++++++++++++++++++++++++++++++--
 drivers/spi/spi-ti-qspi.c    |  140 +++++++++++++++++++++++++++---
 include/linux/spi/spi.h      |    2 +
 3 files changed, 312 insertions(+), 23 deletions(-)


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
