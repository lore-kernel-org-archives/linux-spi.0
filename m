From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: core: added spi_resource management" to the spi tree
Date: Tue, 09 Feb 2016 19:43:15 +0000
Message-ID: <E1aTEBv-0003KR-51@debutante>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: 
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: core: added spi_resource management

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

>From d780c3711d9df9bacd56b71cf23443b895a331ca Mon Sep 17 00:00:00 2001
From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Date: Mon, 14 Dec 2015 15:20:18 +0000
Subject: [PATCH] spi: core: added spi_resource management

SPI resource management framework used while processing a spi_message
via the spi-core.

The basic idea is taken from devres, but as the allocation may happen
fairly frequently, some provisioning (in the form of an unused spi_device
pointer argument to spi_res_alloc) has been made so that at a later stage
we may implement reuse objects allocated earlier avoiding the repeated
allocation by keeping a cache of objects that we can reuse.

This framework can get used for:
* rewriting spi_messages
  * to fullfill alignment requirements of the spi_master HW
  * to fullfill transfer length requirements
    (e.g: transfers need to be less than 64k)
  * consolidate spi_messages with multiple transfers into a single transfer
  when the total transfer length is below a threshold.
* reimplement spi_unmap_buf without explicitly needing to check if it has
  been mapped

Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi.c       | 91 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/spi/spi.h | 36 +++++++++++++++++++
 2 files changed, 127 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 47eff8012a77..894ed0357dd7 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1024,6 +1024,8 @@ out:
 	if (msg->status && master->handle_err)
 		master->handle_err(master, msg);
 
+	spi_res_release(master, msg);
+
 	spi_finalize_current_message(master);
 
 	return ret;
@@ -2013,6 +2015,95 @@ struct spi_master *spi_busnum_to_master(u16 bus_num)
 }
 EXPORT_SYMBOL_GPL(spi_busnum_to_master);
 
+/*-------------------------------------------------------------------------*/
+
+/* Core methods for SPI resource management */
+
+/**
+ * spi_res_alloc - allocate a spi resource that is life-cycle managed
+ *                 during the processing of a spi_message while using
+ *                 spi_transfer_one
+ * @spi:     the spi device for which we allocate memory
+ * @release: the release code to execute for this resource
+ * @size:    size to alloc and return
+ * @gfp:     GFP allocation flags
+ *
+ * Return: the pointer to the allocated data
+ *
+ * This may get enhanced in the future to allocate from a memory pool
+ * of the @spi_device or @spi_master to avoid repeated allocations.
+ */
+void *spi_res_alloc(struct spi_device *spi,
+		    spi_res_release_t release,
+		    size_t size, gfp_t gfp)
+{
+	struct spi_res *sres;
+
+	sres = kzalloc(sizeof(*sres) + size, gfp);
+	if (!sres)
+		return NULL;
+
+	INIT_LIST_HEAD(&sres->entry);
+	sres->release = release;
+
+	return sres->data;
+}
+EXPORT_SYMBOL_GPL(spi_res_alloc);
+
+/**
+ * spi_res_free - free an spi resource
+ * @res: pointer to the custom data of a resource
+ *
+ */
+void spi_res_free(void *res)
+{
+	struct spi_res *sres = container_of(res, struct spi_res, data);
+
+	if (!res)
+		return;
+
+	WARN_ON(!list_empty(&sres->entry));
+	kfree(sres);
+}
+EXPORT_SYMBOL_GPL(spi_res_free);
+
+/**
+ * spi_res_add - add a spi_res to the spi_message
+ * @message: the spi message
+ * @res:     the spi_resource
+ */
+void spi_res_add(struct spi_message *message, void *res)
+{
+	struct spi_res *sres = container_of(res, struct spi_res, data);
+
+	WARN_ON(!list_empty(&sres->entry));
+	list_add_tail(&sres->entry, &message->resources);
+}
+EXPORT_SYMBOL_GPL(spi_res_add);
+
+/**
+ * spi_res_release - release all spi resources for this message
+ * @master:  the @spi_master
+ * @message: the @spi_message
+ */
+void spi_res_release(struct spi_master *master,
+		     struct spi_message *message)
+{
+	struct spi_res *res;
+
+	while (!list_empty(&message->resources)) {
+		res = list_last_entry(&message->resources,
+				      struct spi_res, entry);
+
+		if (res->release)
+			res->release(master, message, res->data);
+
+		list_del(&res->entry);
+
+		kfree(res);
+	}
+}
+EXPORT_SYMBOL_GPL(spi_res_release);
 
 /*-------------------------------------------------------------------------*/
 
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 53be3a4c60cb..38204b584dc5 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -582,6 +582,37 @@ extern void spi_unregister_master(struct spi_master *master);
 
 extern struct spi_master *spi_busnum_to_master(u16 busnum);
 
+/*
+ * SPI resource management while processing a SPI message
+ */
+
+/**
+ * struct spi_res - spi resource management structure
+ * @entry:   list entry
+ * @release: release code called prior to freeing this resource
+ * @data:    extra data allocated for the specific use-case
+ *
+ * this is based on ideas from devres, but focused on life-cycle
+ * management during spi_message processing
+ */
+typedef void (*spi_res_release_t)(struct spi_master *master,
+				  struct spi_message *msg,
+				  void *res);
+struct spi_res {
+	struct list_head        entry;
+	spi_res_release_t       release;
+	unsigned long long      data[]; /* guarantee ull alignment */
+};
+
+extern void *spi_res_alloc(struct spi_device *spi,
+			   spi_res_release_t release,
+			   size_t size, gfp_t gfp);
+extern void spi_res_add(struct spi_message *message, void *res);
+extern void spi_res_free(void *res);
+
+extern void spi_res_release(struct spi_master *master,
+			    struct spi_message *message);
+
 /*---------------------------------------------------------------------------*/
 
 /*
@@ -720,6 +751,7 @@ struct spi_transfer {
  * @status: zero for success, else negative errno
  * @queue: for use by whichever driver currently owns the message
  * @state: for use by whichever driver currently owns the message
+ * @resources: for resource management when the spi message is processed
  *
  * A @spi_message is used to execute an atomic sequence of data transfers,
  * each represented by a struct spi_transfer.  The sequence is "atomic"
@@ -766,11 +798,15 @@ struct spi_message {
 	 */
 	struct list_head	queue;
 	void			*state;
+
+	/* list of spi_res reources when the spi message is processed */
+	struct list_head        resources;
 };
 
 static inline void spi_message_init_no_memset(struct spi_message *m)
 {
 	INIT_LIST_HEAD(&m->transfers);
+	INIT_LIST_HEAD(&m->resources);
 }
 
 static inline void spi_message_init(struct spi_message *m)
-- 
2.7.0.rc3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
