From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [RFC / PATCH] [SPI] get_module while using
	it.
Date: Fri, 2 May 2008 10:55:11 -0700
Message-ID: <200805021055.11267.david-b@pacbell.net>
References: <20080414194549.GA1363@www.tglx.de>
	<200805011108.38240.david-b@pacbell.net>
	<20080502103205.GA15651@www.tglx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Sebastian Siewior <bigeasy-kttTfShzVuc@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20080502103205.GA15651-Hfxr4Dq0UpYb1SvskN2V4Q@public.gmane.org>
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

On Friday 02 May 2008, Sebastian Siewior wrote:

> >> No, I mean that the issue is most likely a spidev bug.
> >
> > Does the appended patch resolve the problem you observed?
> 
> Nope. The backtrace:

... shows *new and different* behavior -- right? 

 
> Sending SPI_IOC_[    4.294967] ------------[ cut here ]------------
> [    4.294967] Badness at /home/bigeasy/git/linux-2.6-powerpc/kernel/mutex.c:134
> 			...
> [    4.294967] Call Trace:
> [    4.294967] [df273e10] [00000001] 0x1 (unreliable)
> [    4.294967] [df273e50] [c01b5148] spidev_ioctl+0x4c8/0x6ec
> [    4.294967] [df273ec0] [c00861c0] vfs_ioctl+0x88/0xa8
> [    4.294967] [df273ee0] [c00865e0] do_vfs_ioctl+0x400/0x444
> [    4.294967] [df273f10] [c0086664] sys_ioctl+0x40/0x70
> [    4.294967] [df273f40] [c000ded8] ret_from_syscall+0x0/0x3c
> 			... 
> [    4.294967] Unable to handle kernel paging request for data at address 0x6b6b6b6b
> 
> I started my spidev user, removed the module and then I started to write
> what results in an ioctl. spidev_ioctl+0x4c8/0x6ec is
> drivers/spi/spidev.c:228 and that is the first mutex_lock() in
> spidev_message().

Hmm, now it's referencing freed memory:  0x6b6b6b6b means it
used a pointer and got memory filled with POISON_FREE.  With
the particular memory dedicated to managing the spidev state.

That memory is freed only by spidev_classdev_release(), so
it looks like this particular issue is a refcounting bug.
I'll look at it later (unless you make time for it first).


> However you are touching spidev->spi and this is gone isn't it?

The appended update should catch a few spidev_ioctl() references
which the initial patch overlooked ... it goes on top of the patch
I sent first time.

But such a reference *COULD NOT* cause references to a mutex
in memory which has been deleted.

- Dave


--- g26.orig/drivers/spi/spidev.c	2008-05-02 10:16:04.000000000 -0700
+++ g26/drivers/spi/spidev.c	2008-05-02 10:14:39.000000000 -0700
@@ -326,8 +326,16 @@ spidev_ioctl(struct inode *inode, struct
 	if (err)
 		return -EFAULT;
 
+	/* guard against device removal before, or while,
+	 * we issue this ioctl.
+	 */
 	spidev = filp->private_data;
-	spi = spidev->spi;
+	spin_lock_irq(&spidev->spi_lock);
+	spi = spi_dev_get(spidev->spi);
+	spin_unlock_irq(&spidev->spi_lock);
+
+	if (spi == NULL)
+		return ESHUTDOWN;
 
 	switch (cmd) {
 	/* read requests */
@@ -413,8 +421,10 @@ spidev_ioctl(struct inode *inode, struct
 	default:
 		/* segmented and/or full-duplex I/O request */
 		if (_IOC_NR(cmd) != _IOC_NR(SPI_IOC_MESSAGE(0))
-				|| _IOC_DIR(cmd) != _IOC_WRITE)
-			return -ENOTTY;
+				|| _IOC_DIR(cmd) != _IOC_WRITE) {
+			retval = -ENOTTY;
+			break;
+		}
 
 		tmp = _IOC_SIZE(cmd);
 		if ((tmp % sizeof(struct spi_ioc_transfer)) != 0) {
@@ -442,6 +452,7 @@ spidev_ioctl(struct inode *inode, struct
 		kfree(ioc);
 		break;
 	}
+	spi_dev_put(spi);
 	return retval;
 }
 


-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
