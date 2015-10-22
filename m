From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 1/2] spi: fix kernel-doc warnings about missing return desc in spi.h
Date: Thu, 22 Oct 2015 18:59:22 +0200
Message-ID: <1445533163-3366-2-git-send-email-javier@osg.samsung.com>
References: <1445533163-3366-1-git-send-email-javier@osg.samsung.com>
Cc: Javier Martinez Canillas <javier@osg.samsung.com>,
	Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
To: linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445533163-3366-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

When building docs with make htmldocs, warnings about not having
a description for the return value are reported, i.e:

warning: No description found for return value of 'spi_write'

Fix these by following the kernel-doc conventions explained in
Documentation/kernel-doc-nano-HOWTO.txt.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 include/linux/spi/spi.h | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index e1f21778cb54..635bff60eda5 100644
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
2.4.3
