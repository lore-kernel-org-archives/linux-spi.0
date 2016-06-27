From: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>
Subject: [RFC] [PATCH v2 1/3] scatterlist: Add support to clone scatterlist
Date: Mon, 27 Jun 2016 09:54:07 -0500
Message-ID: <1467039249-7816-2-git-send-email-fcooper@ti.com>
References: <1467039249-7816-1-git-send-email-fcooper@ti.com>
Cc: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>
To: david.s.gordon-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, axboe-b10kYP2dOMg@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org,
	ming.l-Vzezgt5dB6uUEJcrhfAQsw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org,
	peter.ujfalusi-l0cyMroinI0@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1467039249-7816-1-git-send-email-fcooper-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Occasionally there are times you need to tweak a chained S/G list while
maintaining the original list. This function will duplicate the passed
in chained S/G list and return a pointer to the cloned copy.

The function also supports passing in a length that can be equal or less
than the original chained S/G list length. Reducing the length can result
in less entries of the chained S/G list being created.

Signed-off-by: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>
---
 include/linux/scatterlist.h |   2 +
 lib/scatterlist.c           | 103 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 105 insertions(+)

diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
index cb3c8fe..9a109da 100644
--- a/include/linux/scatterlist.h
+++ b/include/linux/scatterlist.h
@@ -247,6 +247,8 @@ struct scatterlist *sg_next(struct scatterlist *);
 struct scatterlist *sg_last(struct scatterlist *s, unsigned int);
 void sg_init_table(struct scatterlist *, unsigned int);
 void sg_init_one(struct scatterlist *, const void *, unsigned int);
+struct sg_table *sg_table_clone(struct sg_table *orig_table, u64 len,
+				gfp_t gfp_mask);
 int sg_split(struct scatterlist *in, const int in_mapped_nents,
 	     const off_t skip, const int nb_splits,
 	     const size_t *split_sizes,
diff --git a/lib/scatterlist.c b/lib/scatterlist.c
index 004fc70..b15f648 100644
--- a/lib/scatterlist.c
+++ b/lib/scatterlist.c
@@ -180,6 +180,109 @@ static struct scatterlist *sg_kmalloc(unsigned int nents, gfp_t gfp_mask)
 		return kmalloc(nents * sizeof(struct scatterlist), gfp_mask);
 }
 
+/*
+ * sg_clone -	Duplicate an existing chained sgl
+ * @orig_sgl:	Original sg list to be duplicated
+ * @len:	Total length of sg while taking chaining into account
+ * @gfp_mask:	GFP allocation mask
+ *
+ * Description:
+ *   Clone a chained sgl. This cloned copy may be modified in some ways while
+ *   keeping the original sgl in tact. Also allow the cloned copy to have
+ *   a smaller length than the original which may reduce the sgl total
+ *   sg entries.
+ *
+ * Returns:
+ *   Pointer to new kmalloced sg list, ERR_PTR() on error
+ *
+ */
+static struct scatterlist *sg_clone(struct scatterlist *orig_sgl, u64 len,
+				    gfp_t gfp_mask)
+{
+	unsigned int		nents;
+	bool			last_entry;
+	struct scatterlist	*sgl, *head;
+
+	nents = sg_nents_for_len(orig_sgl, len);
+
+	if (nents < 0)
+		return ERR_PTR(-EINVAL);
+
+	head = sg_kmalloc(nents, gfp_mask);
+
+	if (!head)
+		return ERR_PTR(-ENOMEM);
+
+	sgl = head;
+
+	sg_init_table(sgl, nents);
+
+	for (; sgl; orig_sgl = sg_next(orig_sgl), sgl = sg_next(sgl)) {
+
+		last_entry = sg_is_last(sgl);
+		*sgl = *orig_sgl;
+
+		/*
+		 * If page_link is pointing to a chained sgl then set it to
+		 * zero since we already compensated for chained sgl. If
+		 * page_link is pointing to a page then clear bits 1 and 0.
+		 */
+		if (sg_is_chain(orig_sgl))
+			sgl->page_link = 0x0;
+		else
+			sgl->page_link &= ~0x03;
+
+		if (last_entry) {
+			sg_dma_len(sgl) = len;
+			/* Set bit 1 to indicate end of sgl */
+			sgl->page_link |= 0x02;
+		} else {
+			len -= sg_dma_len(sgl);
+		}
+	}
+
+	return head;
+}
+
+/*
+ * sg_table_clone - Duplicate an existing sg_table including chained sgl
+ * @orig_table:     Original sg_table to be duplicated
+ * @len:            Total length of sg while taking chaining into account
+ * @gfp_mask:       GFP allocation mask
+ *
+ * Description:
+ *   Clone a sg_table along with chained sgl. This cloned copy may be
+ *   modified in some ways while keeping the original table and sgl in tact.
+ *   Also allow the cloned sgl copy to have a smaller length than the original
+ *   which may reduce the sgl total sg entries.
+ *
+ * Returns:
+ *   Pointer to new kmalloced sg_table, ERR_PTR() on error
+ *
+ */
+struct sg_table *sg_table_clone(struct sg_table *orig_table, u64 len,
+				gfp_t gfp_mask)
+{
+	struct sg_table	*table;
+
+	table = kmalloc(sizeof(struct sg_table), gfp_mask);
+
+	if (!table)
+		return ERR_PTR(-ENOMEM);
+
+	table->sgl = sg_clone(orig_table->sgl, len, gfp_mask);
+
+	if (IS_ERR(table->sgl)) {
+		kfree(table);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	table->nents = table->orig_nents = sg_nents(table->sgl);
+
+	return table;
+}
+EXPORT_SYMBOL(sg_table_clone);
+
 static void sg_kfree(struct scatterlist *sg, unsigned int nents)
 {
 	if (nents == SG_MAX_SINGLE_ALLOC) {
-- 
2.7.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
