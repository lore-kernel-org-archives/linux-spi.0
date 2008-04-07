From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: [patch 2.6.25-rc8] spi doc tweaks
Date: Mon, 7 Apr 2008 14:32:45 -0700
Message-ID: <200804071432.45500.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Update SPI documentation to clarify some areas of recent confusion:
clock polarity takes effect when chipselect goes active; and zero
length buffers are OK in certain cases.

Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
 Documentation/spi/spi-summary |   15 ++++++++++++++-
 1 files changed, 14 insertions(+), 1 deletion(-)

--- ngw.orig/Documentation/spi/spi-summary	2007-10-16 14:03:48.000000000 -0700
+++ ngw/Documentation/spi/spi-summary	2008-02-22 12:36:46.000000000 -0800
@@ -116,6 +116,13 @@ low order bit.  So when a chip's timing 
 starting low (CPOL=0) and data stabilized for sampling during the
 trailing clock edge (CPHA=1), that's SPI mode 1.
 
+Note that the clock mode is relevant as soon as the chipselect goes
+active.  So the master must set the clock to inactive before selecting
+a slave, and the slave can tell the chosen polarity by sampling the
+clock level when its select line goes active.  That's why many devices
+support for example both modes 0 and 3:  they don't care about polarity,
+and alway clock data in/out on rising clock edges.
+
 
 How do these driver programming interfaces work?
 ------------------------------------------------
@@ -379,8 +386,14 @@ any more such messages.
       + when bidirectional reads and writes start ... by how its
         sequence of spi_transfer requests is arranged;
 
+      + which I/O buffers are used ... each spi_transfer wraps a
+        buffer for each transfer direction, supporting full duplex
+        (two pointers, maybe the same one in both cases) and half
+        duplex (one pointer is NULL) transfers;
+
       + optionally defining short delays after transfers ... using
-        the spi_transfer.delay_usecs setting;
+        the spi_transfer.delay_usecs setting (this delay can be the
+        only protocol effect, if the buffer length is zero);
 
       + whether the chipselect becomes inactive after a transfer and
         any delay ... by using the spi_transfer.cs_change flag;

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Register now and save $200. Hurry, offer ends at 11:59 p.m., 
Monday, April 7! Use priority code J8TLD2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
