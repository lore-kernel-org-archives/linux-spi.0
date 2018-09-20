From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH 1/3] spi: spi-mem: Add missing description for data.nbytes
 field
Date: Thu, 20 Sep 2018 09:31:10 +0200
Message-ID: <20180920073112.7897-2-boris.brezillon@bootlin.com>
References: <20180920073112.7897-1-boris.brezillon@bootlin.com>
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
In-Reply-To: <20180920073112.7897-1-boris.brezillon@bootlin.com>
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

Add a description for spi_mem_op.data.nbytes to the kerneldoc header.

Fixes: c36ff266dc82 ("spi: Extend the core to ease integration of SPI memory controllers")
Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
 include/linux/spi/spi-mem.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
index b2bd4b4127c4..aeb87c02cf1d 100644
--- a/include/linux/spi/spi-mem.h
+++ b/include/linux/spi/spi-mem.h
@@ -81,6 +81,8 @@ enum spi_mem_data_dir {
  * @dummy.buswidth: number of IO lanes used to transmit the dummy bytes
  * @data.buswidth: number of IO lanes used to send/receive the data
  * @data.dir: direction of the transfer
+ * @data.nbytes: number of data bytes to send/receive. Can be zero if the
+ *		 operation does not involve transferring data
  * @data.buf.in: input buffer
  * @data.buf.out: output buffer
  */
-- 
2.14.1


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
