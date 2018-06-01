From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [RFC PATCH 0/2] spi: spi-mem: Add a direct mapping API
Date: Fri,  1 Jun 2018 16:36:01 +0200
Message-ID: <20180601143603.4047-1-boris.brezillon@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Cyrille Pitchen <cyrille.pitchen@microchip.com>,
 Vignesh R <vigneshr@ti.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
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

I know this topic has come up several times during the development of
the spi-mem layer, so I'm finally proposing something to expose this
feature to SPI mem drivers.

Right now it's a rather simple implementation where only on spi_mem_op
operation can be attached to a direct mapping, meaning that write
access to SPI NOR devices will still require manually sending the WR_EN
operation before using the direct mapping, but it should still improve
perfs overall, and should match how most SPI controller drivers describe
direct mappings (a SPI memory operation attached to the range of memory
that you want to directly map in the CPU address space).

Feel free to comment on this implementation.

Thanks,

Boris

Boris Brezillon (2):
  spi: spi-mem: Add a new API to support direct mapping
  mtd: m25p80: Use the SPI mem direct API to possibly improve
    performances

 drivers/mtd/devices/m25p80.c | 149 ++++++++++++++----------
 drivers/spi/spi-mem.c        | 267 +++++++++++++++++++++++++++++++++++++++----
 include/linux/spi/spi-mem.h  |  72 ++++++++++++
 3 files changed, 407 insertions(+), 81 deletions(-)

-- 
2.14.1


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
