From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [RFC / PATCH] [SPI] get_module while using
	it.
Date: Thu, 1 May 2008 11:08:38 -0700
Message-ID: <200805011108.38240.david-b@pacbell.net>
References: <20080414194549.GA1363@www.tglx.de>
	<20080424092605.GC7371@www.tglx.de>
	<200804241126.01158.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Sebastian Siewior <bigeasy-kttTfShzVuc@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200804241126.01158.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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

On Thursday 24 April 2008, David Brownell wrote:
> 
> > Aha. So you mean that the read function which was spidev_read() while
> > the controller was available should point to something else once the
> > controller is gone?
> 
> No, I mean that the issue is most likely a spidev bug.
> 

Does the appended patch resolve the problem you observed?

- Dave


============ CUT HERE
Somehow the spidev code forgot to include a critical mechanism:
when the underlying device is removed (e.g. spi_master rmmod),
open file descriptors must be prevented from issuing new I/O
requests to that device.  On penalty of the oopsing reported
by Sebastian Siewior <bigeasy-kttTfShzVuc@public.gmane.org> ...

RFC: NYET-Signed-off-by: author
---
 drivers/spi/spidev.c |   82 ++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 72 insertions(+), 10 deletions(-)

--- g26.orig/drivers/spi/spidev.c	2008-05-01 10:33:50.000000000 -0700
+++ g26/drivers/spi/spidev.c	2008-05-01 11:02:57.000000000 -0700
@@ -68,6 +68,7 @@ static unsigned long	minors[N_SPI_MINORS
 
 struct spidev_data {
 	struct device		dev;
+	spinlock_t		spi_lock;
 	struct spi_device	*spi;
 	struct list_head	device_entry;
 
@@ -85,12 +86,72 @@ MODULE_PARM_DESC(bufsiz, "data bytes in 
 
 /*-------------------------------------------------------------------------*/
 
+/*
+ * We can't use the standard synchronous wrappers for file I/O; we
+ * need to protect against async removal of the underlying spi_device.
+ */
+static void spidev_complete(void *arg)
+{
+	complete(arg);
+}
+
+static int spidev_sync(struct spidev_data *spidev, struct spi_message *message)
+{
+	DECLARE_COMPLETION_ONSTACK(done);
+	int status;
+
+	message->complete = spidev_complete;
+	message->context = &done;
+
+	spin_lock_irq(&spidev->spi_lock);
+	if (spidev->spi == NULL)
+		status = -ESHUTDOWN;
+	else
+		status = spi_async(spidev->spi, message);
+	spin_unlock_irq(&spidev->spi_lock);
+
+	if (status == 0) {
+		wait_for_completion(&done);
+		status = message->status;
+	}
+	return status;
+}
+
+static inline int
+spidev_sync_write(struct spidev_data *spidev, size_t len)
+{
+	struct spi_transfer	t = {
+			.tx_buf		= spidev->buffer,
+			.len		= len,
+		};
+	struct spi_message	m;
+
+	spi_message_init(&m);
+	spi_message_add_tail(&t, &m);
+	return spidev_sync(spidev, &m);
+}
+
+static inline int
+spidev_sync_read(struct spidev_data *spidev, size_t len)
+{
+	struct spi_transfer	t = {
+			.rx_buf		= spidev->buffer,
+			.len		= len,
+		};
+	struct spi_message	m;
+
+	spi_message_init(&m);
+	spi_message_add_tail(&t, &m);
+	return spidev_sync(spidev, &m);
+}
+
+/*-------------------------------------------------------------------------*/
+
 /* Read-only message with current device setup */
 static ssize_t
 spidev_read(struct file *filp, char __user *buf, size_t count, loff_t *f_pos)
 {
 	struct spidev_data	*spidev;
-	struct spi_device	*spi;
 	ssize_t			status = 0;
 
 	/* chipselect only toggles at start or end of operation */
@@ -98,10 +159,9 @@ spidev_read(struct file *filp, char __us
 		return -EMSGSIZE;
 
 	spidev = filp->private_data;
-	spi = spidev->spi;
 
 	mutex_lock(&spidev->buf_lock);
-	status = spi_read(spi, spidev->buffer, count);
+	status = spidev_sync_read(spidev, count);
 	if (status == 0) {
 		unsigned long	missing;
 
@@ -122,7 +182,6 @@ spidev_write(struct file *filp, const ch
 		size_t count, loff_t *f_pos)
 {
 	struct spidev_data	*spidev;
-	struct spi_device	*spi;
 	ssize_t			status = 0;
 	unsigned long		missing;
 
@@ -131,12 +190,11 @@ spidev_write(struct file *filp, const ch
 		return -EMSGSIZE;
 
 	spidev = filp->private_data;
-	spi = spidev->spi;
 
 	mutex_lock(&spidev->buf_lock);
 	missing = copy_from_user(spidev->buffer, buf, count);
 	if (missing == 0) {
-		status = spi_write(spi, spidev->buffer, count);
+		status = spidev_sync_write(spidev, count);
 		if (status == 0)
 			status = count;
 	} else
@@ -153,7 +211,6 @@ static int spidev_message(struct spidev_
 	struct spi_transfer	*k_xfers;
 	struct spi_transfer	*k_tmp;
 	struct spi_ioc_transfer *u_tmp;
-	struct spi_device	*spi = spidev->spi;
 	unsigned		n, total;
 	u8			*buf;
 	int			status = -EFAULT;
@@ -215,7 +272,7 @@ static int spidev_message(struct spidev_
 		spi_message_add_tail(k_tmp, &msg);
 	}
 
-	status = spi_sync(spi, &msg);
+	status = spidev_sync(spidev, &msg);
 	if (status < 0)
 		goto done;
 
@@ -488,6 +545,7 @@ static int spidev_probe(struct spi_devic
 
 	/* Initialize the driver data */
 	spidev->spi = spi;
+	spin_lock_init(&spidev->spi_lock);
 	mutex_init(&spidev->buf_lock);
 
 	INIT_LIST_HEAD(&spidev->device_entry);
@@ -526,13 +584,17 @@ static int spidev_remove(struct spi_devi
 {
 	struct spidev_data	*spidev = dev_get_drvdata(&spi->dev);
 
-	mutex_lock(&device_list_lock);
+	/* first make sure ops on existing fds can abort cleanly */
+	spin_lock_irq(&spidev->spi_lock);
+	spidev->spi = NULL;
+	spin_unlock_irq(&spidev->spi_lock);
 
+	/* then prevent new opens */
+	mutex_lock(&device_list_lock);
 	list_del(&spidev->device_entry);
 	dev_set_drvdata(&spi->dev, NULL);
 	clear_bit(MINOR(spidev->dev.devt), minors);
 	device_unregister(&spidev->dev);
-
 	mutex_unlock(&device_list_lock);
 
 	return 0;


-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
