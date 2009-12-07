From: Florian Fainelli <ffainelli-MmRyKUhfbQ9GWvitb5QawA@public.gmane.org>
Subject: [PATCH] fix spidev compilation failure when
	VERBOSE is defined
Date: Mon, 7 Dec 2009 15:28:43 +0100
Message-ID: <200912071528.44001.ffainelli@freebox.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
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

Grant,

I am sending this patch to you as you have taken over the
maintainership of the spi tree. Thanks!
--
From: Florian Fainelli <ffainelli-MmRyKUhfbQ9GWvitb5QawA@public.gmane.org>
Subject: [PATCH] fix spidev compilation failure when VERBOSE is defined

When VERBOSE is defined in the spidev module, the compilation
will throw an error on 'spi' not being defined:

CC [M]  drivers/spi/spidev.o                   
drivers/spi/spidev.c: In function 'spidev_message':
drivers/spi/spidev.c:266: error: 'spi' undeclared (first use in this function)
drivers/spi/spidev.c:266: error: (Each undeclared identifier is reported only once
drivers/spi/spidev.c:266: error: for each function it appears in.) 

instead of using spi-> we should actually use spidev->spi.
This patch fixes the build failure.

Signed-off-by: Florian Fainelli <ffainelli-MmRyKUhfbQ9GWvitb5QawA@public.gmane.org>
---
diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 5d869c4..c80c31b 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -262,15 +262,15 @@ static int spidev_message(struct spidev_data *spidev,
 		k_tmp->delay_usecs = u_tmp->delay_usecs;
 		k_tmp->speed_hz = u_tmp->speed_hz;
 #ifdef VERBOSE
-		dev_dbg(&spi->dev,
+		dev_dbg(&spidev->spi->dev,
 			"  xfer len %zd %s%s%s%dbits %u usec %uHz\n",
 			u_tmp->len,
 			u_tmp->rx_buf ? "rx " : "",
 			u_tmp->tx_buf ? "tx " : "",
 			u_tmp->cs_change ? "cs " : "",
-			u_tmp->bits_per_word ? : spi->bits_per_word,
+			u_tmp->bits_per_word ? : spidev->spi->bits_per_word,
 			u_tmp->delay_usecs,
-			u_tmp->speed_hz ? : spi->max_speed_hz);
+			u_tmp->speed_hz ? : spidev->spi->max_speed_hz);
 #endif
 		spi_message_add_tail(k_tmp, &msg);
 	}




------------------------------------------------------------------------------
Join us December 9, 2009 for the Red Hat Virtual Experience,
a free event focused on virtualization and cloud computing. 
Attend in-depth sessions from your desk. Your couch. Anywhere.
http://p.sf.net/sfu/redhat-sfdev2dev
