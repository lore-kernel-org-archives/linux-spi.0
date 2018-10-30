From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH v2 0/7] spi: spi-mem: Add a direct mapping API
Date: Tue, 30 Oct 2018 14:36:31 +0100
Message-ID: <20181030133638.3322-1-boris.brezillon@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
 Vignesh R <vigneshr@ti.com>, Tudor Ambarus <tudor.ambarus@microchip.com>,
 Frieder Schrempf <frieder.schrempf@exceet.de>,
 Cyrille Pitchen <cyrille.pitchen@microchip.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>
To: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
 David Woodhouse <dwmw2@infradead.org>,
 Brian Norris <computersforpeace@gmail.com>,
 Boris Brezillon <boris.brezillon@bootlin.com>,
 Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>,
 linux-mtd@lists.infradead.org
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

I didn't have much review on the RFC, so I'm resending this series
without "RFC" in the subject. Maybe I'll get more reviews this time.

A few things have changed since I submitted the RFC
- The spi-nand framework has been merged, and I can thus patch this
  driver to use the dirmap API
- The MXIC controller has been submitted, and since I did my tests
  with this controller, I can also add a patch showing how to
  implement the dirmap hooks

Other changes are addressing the comments I received from Miquel.

I'd still like to get feedback on the API and controller interface if
anyone is interested in reviewing it.

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

 drivers/mtd/devices/m25p80.c | 142 +++++++++++-------
 drivers/mtd/nand/spi/core.c  | 231 +++++++++++++++++-------------
 drivers/spi/spi-mem.c        | 269 ++++++++++++++++++++++++++++++++---
 drivers/spi/spi-mxic.c       | 140 ++++++++++++++----
 include/linux/mtd/spinand.h  |   7 +
 include/linux/spi/spi-mem.h  |  84 ++++++++++-
 6 files changed, 670 insertions(+), 203 deletions(-)

-- 
2.17.1


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
