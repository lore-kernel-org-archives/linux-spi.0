From: David Daney <ddaney.cavm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/3] of: Add prefix parameter to of_modalias_node().
Date: Fri, 11 May 2012 15:05:21 -0700
Message-ID: <1336773923-17866-2-git-send-email-ddaney.cavm@gmail.com>
References: <1336773923-17866-1-git-send-email-ddaney.cavm@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org,
	Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
	David Daney <david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>,
	Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Liam Girdwood <lrg-l0cyMroinI0@public.gmane.org>,
	Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org,
	Timur Tabi <timur-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
To: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org,
	Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
	Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1336773923-17866-1-git-send-email-ddaney.cavm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: David Daney <david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>

When generating MODALIASes, it is convenient to add things like "spi:"
or "i2c:" to the front of the strings.  This allows the standard
modprobe to find the right driver when automatically populating bus
children from the device tree structure.

Add a prefix parameter, and adjust callers.  For
of_register_spi_devices() use the "spi:" prefix.

Signed-off-by: David Daney <david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
Cc: Liam Girdwood <lrg-l0cyMroinI0@public.gmane.org>
Cc: Timur Tabi <timur-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>
Cc: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
---
 drivers/of/base.c            |   22 ++++++++++++++++------
 drivers/of/of_i2c.c          |    2 +-
 drivers/of/of_spi.c          |    2 +-
 include/linux/of.h           |    3 ++-
 sound/soc/fsl/mpc8610_hpcd.c |    2 +-
 sound/soc/fsl/p1022_ds.c     |    2 +-
 6 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 5806449..f05a520 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -575,26 +575,36 @@ EXPORT_SYMBOL(of_find_matching_node);
 /**
  * of_modalias_node - Lookup appropriate modalias for a device node
  * @node:	pointer to a device tree node
+ * @prefix:	prefix to be added to the compatible property, may be NULL
  * @modalias:	Pointer to buffer that modalias value will be copied into
  * @len:	Length of modalias value
  *
- * Based on the value of the compatible property, this routine will attempt
- * to choose an appropriate modalias value for a particular device tree node.
- * It does this by stripping the manufacturer prefix (as delimited by a ',')
- * from the first entry in the compatible list property.
+ * Based on the value of the compatible property, this routine will
+ * attempt to choose an appropriate modalias value for a particular
+ * device tree node.  It does this by stripping the manufacturer
+ * prefix (as delimited by a ',') from the first entry in the
+ * compatible list property, and appending it to the prefix.
  *
  * This routine returns 0 on success, <0 on failure.
  */
-int of_modalias_node(struct device_node *node, char *modalias, int len)
+int of_modalias_node(struct device_node *node, const char *prefix,
+		     char *modalias, int len)
 {
 	const char *compatible, *p;
 	int cplen;
 
+	if (len < 1)
+		return -EINVAL;
+
 	compatible = of_get_property(node, "compatible", &cplen);
 	if (!compatible || strlen(compatible) > cplen)
 		return -ENODEV;
 	p = strchr(compatible, ',');
-	strlcpy(modalias, p ? p + 1 : compatible, len);
+	if (prefix)
+		strlcpy(modalias, prefix, len);
+	else
+		modalias[0] = 0;
+	strlcat(modalias, p ? p + 1 : compatible, len);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(of_modalias_node);
diff --git a/drivers/of/of_i2c.c b/drivers/of/of_i2c.c
index f37fbeb..23b05ee 100644
--- a/drivers/of/of_i2c.c
+++ b/drivers/of/of_i2c.c
@@ -37,7 +37,7 @@ void of_i2c_register_devices(struct i2c_adapter *adap)
 
 		dev_dbg(&adap->dev, "of_i2c: register %s\n", node->full_name);
 
-		if (of_modalias_node(node, info.type, sizeof(info.type)) < 0) {
+		if (of_modalias_node(node, NULL, info.type, sizeof(info.type)) < 0) {
 			dev_err(&adap->dev, "of_i2c: modalias failure on %s\n",
 				node->full_name);
 			continue;
diff --git a/drivers/of/of_spi.c b/drivers/of/of_spi.c
index 6dbc074..c329c6d 100644
--- a/drivers/of/of_spi.c
+++ b/drivers/of/of_spi.c
@@ -42,7 +42,7 @@ void of_register_spi_devices(struct spi_master *master)
 		}
 
 		/* Select device driver */
-		if (of_modalias_node(nc, spi->modalias,
+		if (of_modalias_node(nc, SPI_MODULE_PREFIX, spi->modalias,
 				     sizeof(spi->modalias)) < 0) {
 			dev_err(&master->dev, "cannot find modalias for %s\n",
 				nc->full_name);
diff --git a/include/linux/of.h b/include/linux/of.h
index fa7fb1d..ee34d76 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -233,7 +233,8 @@ extern int of_n_addr_cells(struct device_node *np);
 extern int of_n_size_cells(struct device_node *np);
 extern const struct of_device_id *of_match_node(
 	const struct of_device_id *matches, const struct device_node *node);
-extern int of_modalias_node(struct device_node *node, char *modalias, int len);
+extern int of_modalias_node(struct device_node *node,
+			    const char *prefix, char *modalias, int len);
 extern struct device_node *of_parse_phandle(struct device_node *np,
 					    const char *phandle_name,
 					    int index);
diff --git a/sound/soc/fsl/mpc8610_hpcd.c b/sound/soc/fsl/mpc8610_hpcd.c
index 3fea5a1..1fa0682 100644
--- a/sound/soc/fsl/mpc8610_hpcd.c
+++ b/sound/soc/fsl/mpc8610_hpcd.c
@@ -254,7 +254,7 @@ static int codec_node_dev_name(struct device_node *np, char *buf, size_t len)
 	char temp[DAI_NAME_SIZE];
 	struct i2c_client *i2c;
 
-	of_modalias_node(np, temp, DAI_NAME_SIZE);
+	of_modalias_node(np, NULL, temp, DAI_NAME_SIZE);
 
 	iprop = of_get_property(np, "reg", NULL);
 	if (!iprop)
diff --git a/sound/soc/fsl/p1022_ds.c b/sound/soc/fsl/p1022_ds.c
index 982a1c9..3ea51ec 100644
--- a/sound/soc/fsl/p1022_ds.c
+++ b/sound/soc/fsl/p1022_ds.c
@@ -257,7 +257,7 @@ static int codec_node_dev_name(struct device_node *np, char *buf, size_t len)
 	char temp[DAI_NAME_SIZE];
 	struct i2c_client *i2c;
 
-	of_modalias_node(np, temp, DAI_NAME_SIZE);
+	of_modalias_node(np, NULL, temp, DAI_NAME_SIZE);
 
 	iprop = of_get_property(np, "reg", NULL);
 	if (!iprop)
-- 
1.7.2.3


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
