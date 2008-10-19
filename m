From: Lennert Buytenhek <buytenh@wantstofly.org>
Subject: [PATCH] mtd m25p80: add support for Macronix MX25L12805D
Date: Sun, 19 Oct 2008 19:32:52 +0200
Message-ID: <20081019173252.GA16094@xi.wantstofly.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: nico@marvell.com, prafulla@marvell.com
To: dbrownell@users.sourceforge.net,
	spi-devel-general@lists.sourceforge.net
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
Content-Disposition: inline
Resent-Message-Id: <20081019193440.0945B7FAB3@xi.wantstofly.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
	<mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
	<mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: linux-mtd-bounces@lists.infradead.org
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

Signed-off-by: Lennert Buytenhek <buytenh@marvell.com>

diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index b35c333..299047e 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -467,6 +467,9 @@ static struct flash_info __devinitdata m25p_data [] = {
 	{ "at26df161a", 0x1f4601, 64 * 1024, 32, SECT_4K, },
 	{ "at26df321",  0x1f4701, 64 * 1024, 64, SECT_4K, },
 
+	/* Macronix */
+	{ "mx25l12805d", 0xc22018, 64 * 1024, 256, SECT_4K, },
+
 	/* Spansion -- single (large) sector size only, at least
 	 * for the chips listed here (without boot sectors).
 	 */

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
