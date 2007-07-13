From: Matthias Kaehlcke <matthias.kaehlcke-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/5] use mutex instead of semaphore in
	SPI core/init code
Date: Fri, 13 Jul 2007 21:23:47 +0200
Message-ID: <20070713192347.GE18159@traven>
References: <20070713192023.GD18159@traven>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20070713192023.GD18159@traven>
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

The SPI core/init code uses a semaphore as mutex. Use the mutex
API instead of the (binary) semaphore.

Signed-off-by: Matthias Kaehlcke <matthias.kaehlcke-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

--

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 4831edb..018884d 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -23,6 +23,7 @@
 #include <linux/device.h>
 #include <linux/init.h>
 #include <linux/cache.h>
+#include <linux/mutex.h>
 #include <linux/spi/spi.h>
 =

 =

@@ -185,7 +186,7 @@ struct boardinfo {
 };
 =

 static LIST_HEAD(board_list);
-static DECLARE_MUTEX(board_lock);
+static DEFINE_MUTEX(board_lock);
 =

 =

 /**
@@ -292,9 +293,9 @@ spi_register_board_info(struct spi_board_info const *in=
fo, unsigned n)
 	bi->n_board_info =3D n;
 	memcpy(bi->board_info, info, n * sizeof *info);
 =

-	down(&board_lock);
+	mutex_lock(&board_lock);
 	list_add_tail(&bi->list, &board_list);
-	up(&board_lock);
+	mutex_unlock(&board_lock);
 	return 0;
 }
 =

@@ -308,7 +309,7 @@ scan_boardinfo(struct spi_master *master)
 	struct boardinfo	*bi;
 	struct device		*dev =3D master->cdev.dev;
 =

-	down(&board_lock);
+	mutex_lock(&board_lock);
 	list_for_each_entry(bi, &board_list, list) {
 		struct spi_board_info	*chip =3D bi->board_info;
 		unsigned		n;
@@ -330,7 +331,7 @@ scan_boardinfo(struct spi_master *master)
 			(void) spi_new_device(master, chip);
 		}
 	}
-	up(&board_lock);
+	mutex_unlock(&board_lock);
 }
 =

 /*------------------------------------------------------------------------=
-*/

-- =

Matthias Kaehlcke
Linux Application Developer
Barcelona

    Ma patrie est o=F9 je suis, o=F9 personne ne me d=E9range, o=F9 personne
    ne me demande que je suis, d'o=F9 je viens et ce que je fais
                              (B. Traven)
                                                                 .''`.
    using free software / Debian GNU/Linux | http://debian.org  : :'  :
                                                                `. `'`
gpg --keyserver pgp.mit.edu --recv-keys 47D8E5D4                  `-

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
