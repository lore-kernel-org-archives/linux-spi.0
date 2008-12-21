From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: [patch 2.6.28-rc9] spi: spi_write_then_read()
	regression fix
Date: Sat, 20 Dec 2008 23:32:35 -0800
Message-ID: <200812202332.36281.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Vernon Sauder <vernoninhand-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,
	lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>

The recent "simplify spi_write_then_read()" patch included a small
regression from the 2.6.27 behavior with its performance win.

All SPI transfers are full duplex, and are packaged as half duplex
by either discarding the data that's read ("write only"), or else
by writing zeroes ("read only").  That patch wasn't ensuring that
zeroes were getting written out during the "half duplex read" part
of the transaction; instead, old RX bits were getting sent.

The fix is trivial:  zero the buffer before using it.

Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: Vernon Sauder <vernoninhand-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -677,11 +677,13 @@ int spi_write_then_read(struct spi_device *spi,
 
 	/* ... unless someone else is using the pre-allocated buffer */
 	if (!mutex_trylock(&lock)) {
-		local_buf = kmalloc(SPI_BUFSIZ, GFP_KERNEL);
+		local_buf = kzalloc(SPI_BUFSIZ, GFP_KERNEL);
 		if (!local_buf)
 			return -ENOMEM;
-	} else
+	} else {
 		local_buf = buf;
+		memset(local_buf, 0, x.len);
+	}
 
 	memcpy(local_buf, txbuf, n_tx);
 	x.tx_buf = local_buf;

------------------------------------------------------------------------------
