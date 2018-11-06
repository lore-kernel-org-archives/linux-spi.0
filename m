From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH v3 0/7] spi: spi-mem: Add a direct mapping API
Date: Tue,  6 Nov 2018 17:05:29 +0100
Message-ID: <20181106160536.13415-1-boris.brezillon@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
 Vignesh R <vigneshr@ti.com>, Tudor Ambarus <tudor.ambarus@microchip.com>,
 Piotr Bugalski <bugalski.piotr@gmail.com>,
 Frieder Schrempf <frieder.schrempf@exceet.de>,
 Cyrille Pitchen <cyrille.pitchen@microchip.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>
To: David Woodhouse <dwmw2@infradead.org>,
 Brian Norris <computersforpeace@gmail.com>,
 Boris Brezillon <boris.brezillon@bootlin.com>,
 Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>,
 linux-mtd@lists.infradead.org, Mark Brown <broonie@kernel.org>,
 linux-spi@vger.kernel.org
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

Here is a v3 addressing the comment I received from Yogesh on the
m25p80 modifications. Note that this part is still untested (I only
tested on a spinand device so far), so that'd be great if someone
could test it.

Thanks,

Boris

Boris Brezillon (7):
  spi: spi-mem: Add missing word in the SPI_MEM_DATA_OUT description
  spi: spi-mem: Add SPI_MEM_NO_DATA to the spi_mem_data_dir enum
  spi: spi-mem: Split spi_mem_exec_op() code
  spi: spi-mem: Add a new API to support direct mapping
  mtd: devices: m25p80: Use the spi-mem dirmap API
  mtd: spinand: Use the spi-mem dirmap API
  spi: mxic: Add support for direct mapping

 drivers/mtd/devices/m25p80.c | 102 ++++++++++++-
 drivers/mtd/nand/spi/core.c  | 231 +++++++++++++++++-------------
 drivers/spi/spi-mem.c        | 269 ++++++++++++++++++++++++++++++++---
 drivers/spi/spi-mxic.c       | 137 ++++++++++++++----
 include/linux/mtd/spinand.h  |   7 +
 include/linux/spi/spi-mem.h  |  84 ++++++++++-
 6 files changed, 677 insertions(+), 153 deletions(-)

-- 
2.17.1


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
