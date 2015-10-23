From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: fix kernel-doc warnings about missing return desc in spi.c" to the spi tree
Date: Sat, 24 Oct 2015 02:47:57 +0900
Message-ID: <E1ZpgRZ-0006fE-Si@finisterre>
References: <1445533163-3366-3-git-send-email-javier@osg.samsung.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1445533163-3366-3-git-send-email-javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: fix kernel-doc warnings about missing return desc in spi.c

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

>From 97d56dc6826896852dae1a2bdab7a42ecde32c6f Mon Sep 17 00:00:00 2001
From: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Date: Thu, 22 Oct 2015 18:59:23 +0200
Subject: [PATCH] spi: fix kernel-doc warnings about missing return desc in
 spi.c

When building docs with make htmldocs, warnings about not having
a description for the return value are reported, i.e:

warning: No description found for return value of 'spi_register_driver'

Fix these by following the kernel-doc conventions explained in
Documentation/kernel-doc-nano-HOWTO.txt.

Signed-off-by: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi.c | 41 ++++++++++++++++++++++++++++++++---------
 1 file changed, 32 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 11454d5..74825db 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -378,6 +378,8 @@ static void spi_drv_shutdown(struct device *dev)
  * spi_register_driver - register a SPI driver
  * @sdrv: the driver to register
  * Context: can sleep
+ *
+ * Return: zero on success, else a negative error code.
  */
 int spi_register_driver(struct spi_driver *sdrv)
 {
@@ -429,7 +431,7 @@ static DEFINE_MUTEX(board_lock);
  * needs to discard the spi_device without adding it, then it should
  * call spi_dev_put() on it.
  *
- * Returns a pointer to the new device, or NULL.
+ * Return: a pointer to the new device, or NULL.
  */
 struct spi_device *spi_alloc_device(struct spi_master *master)
 {
@@ -488,7 +490,7 @@ static int spi_dev_check(struct device *dev, void *data)
  * Companion function to spi_alloc_device.  Devices allocated with
  * spi_alloc_device can be added onto the spi bus with this function.
  *
- * Returns 0 on success; negative errno on failure
+ * Return: 0 on success; negative errno on failure
  */
 int spi_add_device(struct spi_device *spi)
 {
@@ -561,7 +563,7 @@ EXPORT_SYMBOL_GPL(spi_add_device);
  * this is exported so that for example a USB or parport based adapter
  * driver could add devices (which it would learn about out-of-band).
  *
- * Returns the new device, or NULL.
+ * Return: the new device, or NULL.
  */
 struct spi_device *spi_new_device(struct spi_master *master,
 				  struct spi_board_info *chip)
@@ -633,6 +635,8 @@ static void spi_match_master_to_boardinfo(struct spi_master *master,
  *
  * The board info passed can safely be __initdata ... but be careful of
  * any embedded pointers (platform_data, etc), they're copied as-is.
+ *
+ * Return: zero on success, else a negative error code.
  */
 int spi_register_board_info(struct spi_board_info const *info, unsigned n)
 {
@@ -1210,6 +1214,8 @@ static int spi_init_queue(struct spi_master *master)
  *
  * If there are more messages in the queue, the next message is returned from
  * this call.
+ *
+ * Return: the next message in the queue, else NULL if the queue is empty.
  */
 struct spi_message *spi_get_next_queued_message(struct spi_master *master)
 {
@@ -1373,6 +1379,8 @@ static int __spi_queued_transfer(struct spi_device *spi,
  * spi_queued_transfer - transfer function for queued transfers
  * @spi: spi device which is requesting transfer
  * @msg: spi message which is to handled is queued to driver queue
+ *
+ * Return: zero on success, else a negative error code.
  */
 static int spi_queued_transfer(struct spi_device *spi, struct spi_message *msg)
 {
@@ -1672,12 +1680,13 @@ static struct class spi_master_class = {
  * only ones directly touching chip registers.  It's how they allocate
  * an spi_master structure, prior to calling spi_register_master().
  *
- * This must be called from context that can sleep.  It returns the SPI
- * master structure on success, else NULL.
+ * This must be called from context that can sleep.
  *
  * The caller is responsible for assigning the bus number and initializing
  * the master's methods before calling spi_register_master(); and (after errors
  * adding the device) calling spi_master_put() to prevent a memory leak.
+ *
+ * Return: the SPI master structure on success, else NULL.
  */
 struct spi_master *spi_alloc_master(struct device *dev, unsigned size)
 {
@@ -1761,6 +1770,8 @@ static int of_spi_register_master(struct spi_master *master)
  * success, else a negative error code (dropping the master's refcount).
  * After a successful return, the caller is responsible for calling
  * spi_unregister_master().
+ *
+ * Return: zero on success, else a negative error code.
  */
 int spi_register_master(struct spi_master *master)
 {
@@ -1854,6 +1865,8 @@ static void devm_spi_unregister(struct device *dev, void *res)
  *
  * Register a SPI device as with spi_register_master() which will
  * automatically be unregister
+ *
+ * Return: zero on success, else a negative error code.
  */
 int devm_spi_register_master(struct device *dev, struct spi_master *master)
 {
@@ -1959,6 +1972,8 @@ static int __spi_master_match(struct device *dev, const void *data)
  * arch init time.  It returns a refcounted pointer to the relevant
  * spi_master (which the caller must release), or NULL if there is
  * no such master registered.
+ *
+ * Return: the SPI master structure on success, else NULL.
  */
 struct spi_master *spi_busnum_to_master(u16 bus_num)
 {
@@ -2012,6 +2027,8 @@ static int __spi_validate_bits_per_word(struct spi_master *master, u8 bits_per_w
  * that the underlying controller or its driver does not support.  For
  * example, not all hardware supports wire transfers using nine bit words,
  * LSB-first wire encoding, or active-high chipselects.
+ *
+ * Return: zero on success, else a negative error code.
  */
 int spi_setup(struct spi_device *spi)
 {
@@ -2230,6 +2247,8 @@ static int __spi_async(struct spi_device *spi, struct spi_message *message)
  * no other spi_message queued to that device will be processed.
  * (This rule applies equally to all the synchronous transfer calls,
  * which are wrappers around this core asynchronous primitive.)
+ *
+ * Return: zero on success, else a negative error code.
  */
 int spi_async(struct spi_device *spi, struct spi_message *message)
 {
@@ -2282,6 +2301,8 @@ EXPORT_SYMBOL_GPL(spi_async);
  * no other spi_message queued to that device will be processed.
  * (This rule applies equally to all the synchronous transfer calls,
  * which are wrappers around this core asynchronous primitive.)
+ *
+ * Return: zero on success, else a negative error code.
  */
 int spi_async_locked(struct spi_device *spi, struct spi_message *message)
 {
@@ -2397,7 +2418,7 @@ static int __spi_sync(struct spi_device *spi, struct spi_message *message,
  * Also, the caller is guaranteeing that the memory associated with the
  * message will not be freed before this call returns.
  *
- * It returns zero on success, else a negative error code.
+ * Return: zero on success, else a negative error code.
  */
 int spi_sync(struct spi_device *spi, struct spi_message *message)
 {
@@ -2419,7 +2440,7 @@ EXPORT_SYMBOL_GPL(spi_sync);
  * SPI bus. It has to be preceded by a spi_bus_lock call. The SPI bus must
  * be released by a spi_bus_unlock call when the exclusive access is over.
  *
- * It returns zero on success, else a negative error code.
+ * Return: zero on success, else a negative error code.
  */
 int spi_sync_locked(struct spi_device *spi, struct spi_message *message)
 {
@@ -2440,7 +2461,7 @@ EXPORT_SYMBOL_GPL(spi_sync_locked);
  * exclusive access is over. Data transfer must be done by spi_sync_locked
  * and spi_async_locked calls when the SPI bus lock is held.
  *
- * It returns zero on success, else a negative error code.
+ * Return: always zero.
  */
 int spi_bus_lock(struct spi_master *master)
 {
@@ -2469,7 +2490,7 @@ EXPORT_SYMBOL_GPL(spi_bus_lock);
  * This call releases an SPI bus lock previously obtained by an spi_bus_lock
  * call.
  *
- * It returns zero on success, else a negative error code.
+ * Return: always zero.
  */
 int spi_bus_unlock(struct spi_master *master)
 {
@@ -2504,6 +2525,8 @@ static u8	*buf;
  * portable code should never use this for more than 32 bytes.
  * Performance-sensitive or bulk transfer code should instead use
  * spi_{async,sync}() calls with dma-safe buffers.
+ *
+ * Return: zero on success, else a negative error code.
  */
 int spi_write_then_read(struct spi_device *spi,
 		const void *txbuf, unsigned n_tx,
-- 
2.6.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
