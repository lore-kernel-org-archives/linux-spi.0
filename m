From: Stanimir Varbanov <svarbanov@mm-sol.com>
Subject: [PATCH/RFC 1/2] spi: flash: Add power method into flash platform data
Date: Thu, 25 Aug 2011 16:29:11 +0300
Message-ID: <6cd6bb457380caea3e69735485ab2bc58c5aafd3.1314278151.git.svarbanov@mm-sol.com>
References: <cover.1314278151.git.svarbanov@mm-sol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: grant.likely@secretlab.ca, Stanimir Varbanov <svarbanov@mm-sol.com>,
	artem.bityutskiy@intel.com, dwmw2@infradead.org
To: spi-devel-general@lists.sourceforge.net,
	linux-mtd@lists.infradead.org
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <cover.1314278151.git.svarbanov@mm-sol.com>
In-Reply-To: <cover.1314278151.git.svarbanov@mm-sol.com>
References: <cover.1314278151.git.svarbanov@mm-sol.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
	<mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
	<mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: linux-mtd-bounces@lists.infradead.org
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

For embedded devices or devices sensible to the power consumption
is reasonable to have a way to control the flash chips power. This
change in flash_platform_data makes possible to control the power
supply of the flash memory chip by adding a "power" method to it.

The platform then could attach a callback and control power supply
by it's choice. For example by other regulator driver, GPIO or
do nothing.

Signed-off-by: Stanimir Varbanov <svarbanov@mm-sol.com>
---
 include/linux/spi/flash.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/include/linux/spi/flash.h b/include/linux/spi/flash.h
index 3f22932..045a6fc 100644
--- a/include/linux/spi/flash.h
+++ b/include/linux/spi/flash.h
@@ -10,6 +10,7 @@ struct mtd_partition;
  * @nr_parts: number of mtd_partitions for static partitoning
  * @type: optional flash device type (e.g. m25p80 vs m25p64), for use
  *	with chips that can't be queried for JEDEC or other IDs
+ * @power: method called to enable or disable Vcc
  *
  * Board init code (in arch/.../mach-xxx/board-yyy.c files) can
  * provide information about SPI flash parts (such as DataFlash) to
@@ -26,6 +27,9 @@ struct flash_platform_data {
 	char		*type;
 
 	/* we'll likely add more ... use JEDEC IDs, etc */
+
+	/* on = 0 disable Vcc, on != 0 enable Vcc */
+	void (*power)(int on);
 };
 
 #endif
-- 
1.7.4.1


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
