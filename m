From: Franklin S Cooper Jr <fcooper@ti.com>
Subject: [RFC] [PATCH 1/3] lib/scatterlist: Add support to clone sg_table
Date: Fri, 17 Jun 2016 17:45:11 -0500
Message-ID: <1466203513-4771-2-git-send-email-fcooper@ti.com>
References: <1466203513-4771-1-git-send-email-fcooper@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Franklin S Cooper Jr <fcooper@ti.com>
To: <broonie@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-spi@vger.kernel.org>, <david.s.gordon@intel.com>,
	<akpm@linux-foundation.org>, <nsekhar@ti.com>, <vigneshr@ti.com>,
	<peter.ujfalusi@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466203513-4771-1-git-send-email-fcooper@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Occasionally there are times you need to tweak a S/G table while
maintaining the original table. This function will duplicate the passed
in S/G table along with its chained sgl and return a pointer to the cloned
copy.

The function also supports passing in a length that can be equal or less
than the original chained S/G list length. This can reduce the length of
the chained S/G list.

Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
---
 include/linux/scatterlist.h |  2 +
 lib/scatterlist.c           | 93 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 95 insertions(+)

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
index 004fc70..15a0142 100644
--- a/lib/scatterlist.c
+++ b/lib/scatterlist.c
@@ -180,6 +180,99 @@ static struct scatterlist *sg_kmalloc(unsigned int nents, gfp_t gfp_mask)
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
+	unsigned long		page_link;
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
+		page_link = sgl->page_link;
+
+		*sgl = *orig_sgl;
+
+		sgl->page_link = page_link;
+
+		if (sg_is_last(sgl))
+			sg_dma_len(sgl) = len;
+		else
+			len -= sg_dma_len(sgl);
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
+	table = kmalloc(sizeof(struct sg_table),gfp_mask);
+
+	if (!table)
+		return ERR_PTR(-ENOMEM);
+
+	table->sgl = sg_clone(orig_table->sgl,len,gfp_mask);
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
1.9.1
