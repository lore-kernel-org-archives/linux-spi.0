From: Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Subject: [PATCH 6/9] spi_mpc83xx: Split
	mpc83xx_spi_work() into two routines
Date: Fri, 1 May 2009 03:48:29 +0400
Message-ID: <20090430234829.GF7901@oksana.dev.rtsoft.ru>
References: <20090430234739.GA27709@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,
	David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090430234739.GA27709-wnGakbxT3iijyJ0x5qLZdcN33GVbZNy3@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

mpc83xx_spi_work() is quite large, with up to five indentation
levels and is quite difficult to read.

So, split the function in two parts:
1. mpc83xx_spi_work() now only traverse queued spi messages;
2. mpc83xx_spi_do_one_msg() only manages single messages.

There should be no functional changes.

Signed-off-by: Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
---
 drivers/spi/spi_mpc83xx.c |  115 +++++++++++++++++++++++---------------------
 1 files changed, 60 insertions(+), 55 deletions(-)

diff --git a/drivers/spi/spi_mpc83xx.c b/drivers/spi/spi_mpc83xx.c
index 40f7448..50112a5 100644
--- a/drivers/spi/spi_mpc83xx.c
+++ b/drivers/spi/spi_mpc83xx.c
@@ -350,71 +350,76 @@ static int mpc83xx_spi_bufs(struct spi_device *spi, struct spi_transfer *t)
 	return mpc83xx_spi->count;
 }
 
-static void mpc83xx_spi_work(struct work_struct *work)
+static void mpc83xx_spi_do_one_msg(struct spi_message *m)
 {
-	struct mpc83xx_spi *mpc83xx_spi =
-		container_of(work, struct mpc83xx_spi, work);
-
-	spin_lock_irq(&mpc83xx_spi->lock);
-	mpc83xx_spi->busy = 1;
-	while (!list_empty(&mpc83xx_spi->queue)) {
-		struct spi_message *m;
-		struct spi_device *spi;
-		struct spi_transfer *t = NULL;
-		unsigned cs_change;
-		int status, nsecs = 50;
-
-		m = container_of(mpc83xx_spi->queue.next,
-				struct spi_message, queue);
-		list_del_init(&m->queue);
-		spin_unlock_irq(&mpc83xx_spi->lock);
-
-		spi = m->spi;
-		cs_change = 1;
-		status = 0;
-		list_for_each_entry(t, &m->transfers, transfer_list) {
-			if (t->bits_per_word || t->speed_hz) {
-				/* Don't allow changes if CS is active */
-				status = -EINVAL;
-
-				if (cs_change)
-					status = mpc83xx_spi_setup_transfer(spi, t);
-				if (status < 0)
-					break;
-			}
-
-			if (cs_change) {
-				mpc83xx_spi_chipselect(spi, BITBANG_CS_ACTIVE);
-				ndelay(nsecs);
-			}
-			cs_change = t->cs_change;
-			if (t->len)
-				status = mpc83xx_spi_bufs(spi, t);
-			if (status) {
-				status = -EMSGSIZE;
+	struct spi_device *spi = m->spi;
+	struct spi_transfer *t;
+	unsigned int cs_change;
+	const int nsecs = 50;
+	int status;
+
+	cs_change = 1;
+	status = 0;
+	list_for_each_entry(t, &m->transfers, transfer_list) {
+		if (t->bits_per_word || t->speed_hz) {
+			/* Don't allow changes if CS is active */
+			status = -EINVAL;
+
+			if (cs_change)
+				status = mpc83xx_spi_setup_transfer(spi, t);
+			if (status < 0)
 				break;
-			}
-			m->actual_length += t->len;
-
-			if (t->delay_usecs)
-				udelay(t->delay_usecs);
+		}
 
-			if (cs_change) {
-				ndelay(nsecs);
-				mpc83xx_spi_chipselect(spi, BITBANG_CS_INACTIVE);
-				ndelay(nsecs);
-			}
+		if (cs_change) {
+			mpc83xx_spi_chipselect(spi, BITBANG_CS_ACTIVE);
+			ndelay(nsecs);
+		}
+		cs_change = t->cs_change;
+		if (t->len)
+			status = mpc83xx_spi_bufs(spi, t);
+		if (status) {
+			status = -EMSGSIZE;
+			break;
 		}
+		m->actual_length += t->len;
 
-		m->status = status;
-		m->complete(m->context);
+		if (t->delay_usecs)
+			udelay(t->delay_usecs);
 
-		if (status || !cs_change) {
+		if (cs_change) {
 			ndelay(nsecs);
 			mpc83xx_spi_chipselect(spi, BITBANG_CS_INACTIVE);
+			ndelay(nsecs);
 		}
+	}
+
+	m->status = status;
+	m->complete(m->context);
+
+	if (status || !cs_change) {
+		ndelay(nsecs);
+		mpc83xx_spi_chipselect(spi, BITBANG_CS_INACTIVE);
+	}
+
+	mpc83xx_spi_setup_transfer(spi, NULL);
+}
+
+static void mpc83xx_spi_work(struct work_struct *work)
+{
+	struct mpc83xx_spi *mpc83xx_spi = container_of(work, struct mpc83xx_spi,
+						       work);
+
+	spin_lock_irq(&mpc83xx_spi->lock);
+	mpc83xx_spi->busy = 1;
+	while (!list_empty(&mpc83xx_spi->queue)) {
+		struct spi_message *m = container_of(mpc83xx_spi->queue.next,
+						   struct spi_message, queue);
+
+		list_del_init(&m->queue);
+		spin_unlock_irq(&mpc83xx_spi->lock);
 
-		mpc83xx_spi_setup_transfer(spi, NULL);
+		mpc83xx_spi_do_one_msg(m);
 
 		spin_lock_irq(&mpc83xx_spi->lock);
 	}
-- 
1.6.2.2


------------------------------------------------------------------------------
Register Now & Save for Velocity, the Web Performance & Operations 
Conference from O'Reilly Media. Velocity features a full day of 
expert-led, hands-on workshops and two days of sessions from industry 
leaders in dedicated Performance & Operations tracks. Use code vel09scf 
and Save an extra 15% before 5/3. http://p.sf.net/sfu/velocityconf
