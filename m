From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH 0/3] spi: spi-mem: Minor fixes/improvements
Date: Thu, 20 Sep 2018 09:31:09 +0200
Message-ID: <20180920073112.7897-1-boris.brezillon@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>,
 Boris Brezillon <boris.brezillon@bootlin.com>, linux-mtd@lists.infradead.org,
 Brian Norris <computersforpeace@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>
To: Mark Brown <broonie@kernel.org>,
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

Hello Mark,

Here is a patchset which, IMO, is improving spi-mem support. The first
2 patches are fixing/improving the kerneldoc header associated to the
spi_mem_op struct, and the last one is adding checks on the spi_mem_op
object passed to spi_mem_{exec,supports}_op().

Regards,

Boris

Boris Brezillon (3):
  spi: spi-mem: Add missing description for data.nbytes field
  spi: spi-mem: Move the DMA-able constraint doc to the kerneldoc header
  spi: spi-mem: Add extra sanity checks on the op param

 drivers/spi/spi-mem.c       | 54 ++++++++++++++++++++++++++++++++++++++++-----
 include/linux/spi/spi-mem.h |  7 +++---
 2 files changed, 52 insertions(+), 9 deletions(-)

-- 
2.14.1


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
