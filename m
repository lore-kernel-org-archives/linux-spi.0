From: Prarit Bhargava <prarit-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Documentation/spi/* compile warning fix
Date: Wed, 19 May 2010 14:01:06 -0400
Message-ID: <20100519175712.10378.62717.sendpatchset@prarit.bos.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Prarit Bhargava <prarit-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, randy.dunlap-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Fix this warning:

Documentation/spi/spidev_fdx.c: In function `do_msg':
Documentation/spi/spidev_fdx.c:61: warning: cast from pointer to integer of different size
Documentation/spi/spidev_fdx.c:64: warning: cast from pointer to integer of different size

buf should be unsigned long to match native arch on 32-bit x86 compile.

Signed-off-by: Prarit Bhargava <prarit-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

diff --git a/Documentation/spi/spidev_fdx.c b/Documentation/spi/spidev_fdx.c
index fc354f7..36ec077 100644
--- a/Documentation/spi/spidev_fdx.c
+++ b/Documentation/spi/spidev_fdx.c
@@ -58,10 +58,10 @@ static void do_msg(int fd, int len)
 		len = sizeof buf;
 
 	buf[0] = 0xaa;
-	xfer[0].tx_buf = (__u64) buf;
+	xfer[0].tx_buf = (unsigned long)buf;
 	xfer[0].len = 1;
 
-	xfer[1].rx_buf = (__u64) buf;
+	xfer[1].rx_buf = (unsigned long) buf;
 	xfer[1].len = len;
 
 	status = ioctl(fd, SPI_IOC_MESSAGE(2), xfer);

------------------------------------------------------------------------------
