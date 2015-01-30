From: Ian Abbott <abbotti@mev.co.uk>
Subject: [PATCH] spi: spidev: Convert buf pointers for 32-bit compat SPI_IOC_MESSAGE(n)
Date: Fri, 30 Jan 2015 18:43:33 +0000
Message-ID: <1422643413-21796-1-git-send-email-abbotti@mev.co.uk>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
	Ian Abbott <abbotti@mev.co.uk>
To: linux-spi@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The SPI_IOC_MESSAGE(n) ioctl commands' argument points to an array of n
struct spi_ioc_transfer elements.  The spidev's compat_ioctl handler
just converts this pointer and passes it on to the unlocked_ioctl
handler to process it.

The tx_buf and rx_buf members of struct spi_ioc_transfer are of type
__u64 and hold pointer values.  A 32-bit userspace application running
in a 64-bit kernel might not have widened the 32-bit pointers correctly
for the kernel.  The application might have sign-extended the pointer to
when the kernel expects it to be zero-extended, or vice versa, leading
to an -EFAULT being returned by spidev_message() if the widened pointer
is invalid.

Handle the SPI_IOC_MESSAGE(n) ioctl commands specially in the
compat_ioctl handler, calling new function spidev_compat_ioctl_message()
to handle them.  This processes them in the same way as the
unlocked_ioctl handler except that it uses compat_ptr() to convert the
tx_buf and rx_buf members of each struct spi_ioc_transfer element.

To save code, factor out part of the unlocked_ioctl handler into a new
function spidev_get_ioc_message().  This checks the ioctl command code
is a valid SPI_IOC_MESSAGE(n), determines n and copies the array of n
struct spi_ioc_transfer elements from userspace into dynamically
allocated memory, returning either a pointer to the memory, an
ERR_PTR(-err) value, or NULL (for SPI_IOC_MESSAGE(0)).

Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
---
 drivers/spi/spidev.c | 121 +++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 97 insertions(+), 24 deletions(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 6941e04..d1ccbfe 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -317,6 +317,37 @@ done:
 	return status;
 }
 
+static struct spi_ioc_transfer *
+spidev_get_ioc_message(unsigned int cmd, struct spi_ioc_transfer __user *u_ioc,
+		unsigned *n_ioc)
+{
+	struct spi_ioc_transfer	*ioc;
+	u32	tmp;
+
+	/* Check type, command number and direction */
+	if (_IOC_TYPE(cmd) != SPI_IOC_MAGIC
+			|| _IOC_NR(cmd) != _IOC_NR(SPI_IOC_MESSAGE(0))
+			|| _IOC_DIR(cmd) != _IOC_WRITE)
+		return ERR_PTR(-ENOTTY);
+
+	tmp = _IOC_SIZE(cmd);
+	if ((tmp % sizeof(struct spi_ioc_transfer)) != 0)
+		return ERR_PTR(-EINVAL);
+	*n_ioc = tmp / sizeof(struct spi_ioc_transfer);
+	if (*n_ioc == 0)
+		return NULL;
+
+	/* copy into scratch area */
+	ioc = kmalloc(tmp, GFP_KERNEL);
+	if (!ioc)
+		return ERR_PTR(-ENOMEM);
+	if (__copy_from_user(ioc, u_ioc, tmp)) {
+		kfree(ioc);
+		return ERR_PTR(-EFAULT);
+	}
+	return ioc;
+}
+
 static long
 spidev_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
@@ -456,32 +487,15 @@ spidev_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 
 	default:
 		/* segmented and/or full-duplex I/O request */
-		if (_IOC_NR(cmd) != _IOC_NR(SPI_IOC_MESSAGE(0))
-				|| _IOC_DIR(cmd) != _IOC_WRITE) {
-			retval = -ENOTTY;
-			break;
-		}
-
-		tmp = _IOC_SIZE(cmd);
-		if ((tmp % sizeof(struct spi_ioc_transfer)) != 0) {
-			retval = -EINVAL;
-			break;
-		}
-		n_ioc = tmp / sizeof(struct spi_ioc_transfer);
-		if (n_ioc == 0)
-			break;
-
-		/* copy into scratch area */
-		ioc = kmalloc(tmp, GFP_KERNEL);
-		if (!ioc) {
-			retval = -ENOMEM;
-			break;
-		}
-		if (__copy_from_user(ioc, (void __user *)arg, tmp)) {
-			kfree(ioc);
-			retval = -EFAULT;
+		/* Check message and copy into scratch area */
+		ioc = spidev_get_ioc_message(cmd,
+				(struct spi_ioc_transfer __user *)arg, &n_ioc);
+		if (IS_ERR(ioc)) {
+			retval = PTR_ERR(ioc);
 			break;
 		}
+		if (!ioc)
+			break;	/* n_ioc is also 0 */
 
 		/* translate to spi_message, execute */
 		retval = spidev_message(spidev, ioc, n_ioc);
@@ -496,8 +510,67 @@ spidev_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 
 #ifdef CONFIG_COMPAT
 static long
+spidev_compat_ioc_message(struct file *filp, unsigned int cmd,
+		unsigned long arg)
+{
+	struct spi_ioc_transfer __user	*u_ioc;
+	int				retval = 0;
+	struct spidev_data		*spidev;
+	struct spi_device		*spi;
+	unsigned			n_ioc, n;
+	struct spi_ioc_transfer		*ioc;
+
+	u_ioc = (struct spi_ioc_transfer __user *) compat_ptr(arg);
+	if (!access_ok(VERIFY_READ, u_ioc, _IOC_SIZE(cmd)))
+		return -EFAULT;
+
+	/* guard against device removal before, or while,
+	 * we issue this ioctl.
+	 */
+	spidev = filp->private_data;
+	spin_lock_irq(&spidev->spi_lock);
+	spi = spi_dev_get(spidev->spi);
+	spin_unlock_irq(&spidev->spi_lock);
+
+	if (spi == NULL)
+		return -ESHUTDOWN;
+
+	/* SPI_IOC_MESSAGE needs the buffer locked "normally" */
+	mutex_lock(&spidev->buf_lock);
+
+	/* Check message and copy into scratch area */
+	ioc = spidev_get_ioc_message(cmd, u_ioc, &n_ioc);
+	if (IS_ERR(ioc)) {
+		retval = PTR_ERR(ioc);
+		goto done;
+	}
+	if (!ioc)
+		goto done;	/* n_ioc is also 0 */
+
+	/* Convert buffer pointers */
+	for (n = 0; n < n_ioc; n++) {
+		ioc[n].rx_buf = (uintptr_t) compat_ptr(ioc[n].rx_buf);
+		ioc[n].tx_buf = (uintptr_t) compat_ptr(ioc[n].tx_buf);
+	}
+
+	/* translate to spi_message, execute */
+	retval = spidev_message(spidev, ioc, n_ioc);
+	kfree(ioc);
+
+done:
+	mutex_unlock(&spidev->buf_lock);
+	spi_dev_put(spi);
+	return retval;
+}
+
+static long
 spidev_compat_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
+	if (_IOC_TYPE(cmd) == SPI_IOC_MAGIC
+			&& _IOC_NR(cmd) == _IOC_NR(SPI_IOC_MESSAGE(0))
+			&& _IOC_DIR(cmd) == _IOC_WRITE)
+		return spidev_compat_ioc_message(filp, cmd, arg);
+
 	return spidev_ioctl(filp, cmd, (unsigned long)compat_ptr(arg));
 }
 #else
-- 
2.1.4
