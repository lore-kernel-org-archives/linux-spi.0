From: Michal Suchanek <hramrach@gmail.com>
Subject: [PATCH v5 00/10] add error checking to spi-nor read and write
Date: 1 Dec 2015 16:51:03 -0000
Message-ID: <cover.1448988089.git.hramrach@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Heiner Kallweit <hkallweit1@gmail.com>,
  David Woodhouse <dwmw2@infradead.org>,
  Brian Norris <computersforpeace@gmail.com>, Han Xu <han.xu@freescale.com>,
  Mark Brown <broonie@kernel.org>, Michal Suchanek <hramrach@gmail.com>,
  Boris Brezillon <boris.brezillon@free-electrons.com>,
  Javier Martinez Canillas <javier@osg.samsung.com>,
  Stephen Warren <swarren@nvidia.com>, "Andrew F. Davis" <afd@ti.com>,
  Marek Vasut <marex@denx.de>, "Rafał Miłecki" <zajec5@gmail.com>,
  Mika Westerberg <mika.westerberg@linux.intel.com>,
  Gabor Juhos <juhosg@openwrt.org>,
  "Bean Huo 霍斌斌 " <beanhuo@micron.com>,
  Furquan Shaikh <furquan@google.com>, linux-mtd@lists.infradead.org,
  linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
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

Hello,

as this is getting discussed a lot lately I am sending a rebase of the spi-nor patchset on top of current MTD patch queue.

I need to do some testing of the rebase with some actual SPI device.

However, I do not have the espi hardware and I hope to get testing on that platform as well.

Also I would like to get comments on the integration of the spi_max_transfer_size

Thanks

Michal

Michal Suchanek (10):
  mtd: spi-nor: change return value of read/write
  mtd: m25p80: return amount of data transferred or error in read/write
  mtd: fsl-quadspi: return amount of data read/written or error
  mtd: spi-nor: check return value from read/write
  mtd: spi-nor: stop passing around retlen
  mtd: spi-nor: simplify write loop
  mtd: spi-nor: add read loop
  spi: expose master transfer size limitation.
  spi: fsl-espi: expose maximum transfer size limit
  spi: m25p80: read in spi_max_transfer_size chunks

 drivers/mtd/devices/m25p80.c      | 34 +++++++++-----
 drivers/mtd/spi-nor/fsl-quadspi.c | 29 ++++++------
 drivers/mtd/spi-nor/spi-nor.c     | 95 +++++++++++++++++++++++++--------------
 drivers/spi/spi-fsl-espi.c        |  6 +++
 include/linux/mtd/spi-nor.h       |  8 ++--
 include/linux/spi/spi.h           | 15 +++++++
 6 files changed, 125 insertions(+), 62 deletions(-)

-- 
2.6.2


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
