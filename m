From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH v3 0/9] spi: Extend the framework to generically support
 memory devices
Date: Sun, 22 Apr 2018 20:35:13 +0200
Message-ID: <20180422183522.11118-1-boris.brezillon@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>, Vignesh R <vigneshr@ti.com>,
 Kamal Dasu <kdasu.kdev@gmail.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Peter Pan <peterpansjtu@gmail.com>,
 Frieder Schrempf <frieder.schrempf@exceet.de>,
 =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
To: David Woodhouse <dwmw2@infradead.org>,
 Brian Norris <computersforpeace@gmail.com>,
 Boris Brezillon <boris.brezillon@bootlin.com>,
 Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>,
 Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
 linux-mtd@lists.infradead.org, Miquel Raynal <miquel.raynal@bootlin.com>,
 Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
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

Shrinking a bit the explanation on why the spi-mem abstraction is
needed (a detailed explanation is available here [2]). In addition to
what as been said in my initial explanation I'll add that making it part
of the SPI framework instead of as an extra independent layer is
justified by the fact that some controllers support both SPI memory
operations and regular SPI transfers, and it's cleaner to have both
features exposed through a single driver.

For those who want to have the full picture, here is a branch [1]
containing the SPI NAND framework based on top of this spi-mem layer.

Thanks,

Boris

[1]https://github.com/bbrezillon/linux/tree/spi-mem
[2]https://www.spinics.net/lists/linux-spi/msg12058.html


Boris Brezillon (9):
  spi: Expose spi_{map,unmap}_buf() for internal use
  spi: Add an helper to flush the message queue
  spi: Extend the core to ease integration of SPI memory controllers
  spi: Make support for regular transfers optional when ->mem_ops !=
    NULL
  spi: bcm-qspi: Implement the spi_mem interface
  spi: bcm53xx: Implement the spi_mem interface
  spi: ti-qspi: Implement the spi_mem interface
  mtd: spi-nor: Use the spi_mem_xx() API
  spi: Get rid of the spi_flash_read() API

 drivers/mtd/devices/Kconfig  |   1 +
 drivers/mtd/devices/m25p80.c | 236 +++++++++----------------
 drivers/spi/Kconfig          |   7 +
 drivers/spi/Makefile         |   1 +
 drivers/spi/internals.h      |  43 +++++
 drivers/spi/spi-bcm-qspi.c   | 162 ++++++++---------
 drivers/spi/spi-bcm53xx.c    |  37 ++--
 drivers/spi/spi-mem.c        | 410 +++++++++++++++++++++++++++++++++++++++++++
 drivers/spi/spi-ti-qspi.c    |  85 +++++----
 drivers/spi/spi.c            | 131 ++++++--------
 include/linux/spi/spi-mem.h  | 249 ++++++++++++++++++++++++++
 include/linux/spi/spi.h      |  60 +------
 12 files changed, 1007 insertions(+), 415 deletions(-)
 create mode 100644 drivers/spi/internals.h
 create mode 100644 drivers/spi/spi-mem.c
 create mode 100644 include/linux/spi/spi-mem.h

-- 
2.14.1


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
