From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: fix kernel-doc warnings about missing return desc in spi.h" to the spi tree
Date: Sat, 24 Oct 2015 02:47:58 +0900
Message-ID: <E1ZpgRa-0006fh-W4@finisterre>
References: <1445533163-3366-2-git-send-email-javier@osg.samsung.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1445533163-3366-2-git-send-email-javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: fix kernel-doc warnings about missing return desc in spi.h

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From a1fdeaa71c95e5c6eba40245f84f762202dc69bb Mon Sep 17 00:00:00 2001
From: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Date: Thu, 22 Oct 2015 18:59:22 +0200
Subject: [PATCH] spi: fix kernel-doc warnings about missing return desc in
 spi.h

When building docs with make htmldocs, warnings about not having
a description for the return value are reported, i.e:

warning: No description found for return value of 'spi_write'

Fix these by following the kernel-doc conventions explained in
Documentation/kernel-doc-nano-HOWTO.txt.

Signed-off-by: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 include/linux/spi/spi.h | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index e1f2177..635bff6 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -847,8 +847,10 @@ extern int spi_bus_unlock(struct spi_master *master);
  * @len: data buffer size
  * Context: can sleep
  *
- * This writes the buffer and returns zero or a negative error code.
+ * This function writes the buffer @buf.
  * Callable only from contexts that can sleep.
+ *
+ * Return: zero on success, else a negative error code.
  */
 static inline int
 spi_write(struct spi_device *spi, const void *buf, size_t len)
@@ -871,8 +873,10 @@ spi_write(struct spi_device *spi, const void *buf, size_t len)
  * @len: data buffer size
  * Context: can sleep
  *
- * This reads the buffer and returns zero or a negative error code.
+ * This function reads the buffer @buf.
  * Callable only from contexts that can sleep.
+ *
+ * Return: zero on success, else a negative error code.
  */
 static inline int
 spi_read(struct spi_device *spi, void *buf, size_t len)
@@ -899,7 +903,7 @@ spi_read(struct spi_device *spi, void *buf, size_t len)
  *
  * For more specific semantics see spi_sync().
  *
- * It returns zero on success, else a negative error code.
+ * Return: Return: zero on success, else a negative error code.
  */
 static inline int
 spi_sync_transfer(struct spi_device *spi, struct spi_transfer *xfers,
@@ -923,9 +927,10 @@ extern int spi_write_then_read(struct spi_device *spi,
  * @cmd: command to be written before data is read back
  * Context: can sleep
  *
- * This returns the (unsigned) eight bit number returned by the
- * device, or else a negative error code.  Callable only from
- * contexts that can sleep.
+ * Callable only from contexts that can sleep.
+ *
+ * Return: the (unsigned) eight bit number returned by the
+ * device, or else a negative error code.
  */
 static inline ssize_t spi_w8r8(struct spi_device *spi, u8 cmd)
 {
@@ -944,12 +949,13 @@ static inline ssize_t spi_w8r8(struct spi_device *spi, u8 cmd)
  * @cmd: command to be written before data is read back
  * Context: can sleep
  *
- * This returns the (unsigned) sixteen bit number returned by the
- * device, or else a negative error code.  Callable only from
- * contexts that can sleep.
- *
  * The number is returned in wire-order, which is at least sometimes
  * big-endian.
+ *
+ * Callable only from contexts that can sleep.
+ *
+ * Return: the (unsigned) sixteen bit number returned by the
+ * device, or else a negative error code.
  */
 static inline ssize_t spi_w8r16(struct spi_device *spi, u8 cmd)
 {
@@ -968,13 +974,13 @@ static inline ssize_t spi_w8r16(struct spi_device *spi, u8 cmd)
  * @cmd: command to be written before data is read back
  * Context: can sleep
  *
- * This returns the (unsigned) sixteen bit number returned by the device in cpu
- * endianness, or else a negative error code. Callable only from contexts that
- * can sleep.
- *
  * This function is similar to spi_w8r16, with the exception that it will
  * convert the read 16 bit data word from big-endian to native endianness.
  *
+ * Callable only from contexts that can sleep.
+ *
+ * Return: the (unsigned) sixteen bit number returned by the device in cpu
+ * endianness, or else a negative error code.
  */
 static inline ssize_t spi_w8r16be(struct spi_device *spi, u8 cmd)
 
-- 
2.6.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
