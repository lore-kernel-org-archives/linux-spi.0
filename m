From: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 4/6] dt: add helper function to read u32 arrays
Date: Fri,  8 Jul 2011 16:27:32 +0800
Message-ID: <1310113654-25887-5-git-send-email-shawn.guo@linaro.org>
References: <1310113654-25887-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org,
	Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1310113654-25887-1-git-send-email-shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>

Rework of_property_read_u32 to read an array of values. Then
of_property_read_u32 becomes an inline with array size of 1.

Also make struct device_node ptr const.

Signed-off-by: Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
Cc: Thomas Abraham <thomas.abraham-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
---
 drivers/of/base.c  |   19 +++++++++++++------
 include/linux/of.h |   14 ++++++++++++--
 2 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 9f5293f..736cf5f 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -620,32 +620,39 @@ struct device_node *of_find_node_by_phandle(phandle handle)
 EXPORT_SYMBOL(of_find_node_by_phandle);
 
 /**
- * of_property_read_u32 - Find and read a 32 bit integer from a property
+ * of_property_read_u32_array - Find and read an array of 32 bit integers
+ * from a property.
+ *
  * @np:		device node from which the property value is to be read.
  * @propname:	name of the property to be searched.
  * @out_value:	pointer to return value, modified only if return value is 0.
  *
- * Search for a property in a device node and read a 32-bit value from
+ * Search for a property in a device node and read 32-bit value(s) from
  * it. Returns 0 on success, -EINVAL if the property does not exist,
  * -ENODATA if property does not have a value, and -EOVERFLOW if the
  * property data isn't large enough.
  *
  * The out_value is modified only if a valid u32 value can be decoded.
  */
-int of_property_read_u32(struct device_node *np, char *propname, u32 *out_value)
+int of_property_read_u32_array(const struct device_node *np, char *propname,
+			       u32 *out_values, size_t sz)
 {
 	struct property *prop = of_find_property(np, propname, NULL);
+	const __be32 *val;
 
 	if (!prop)
 		return -EINVAL;
 	if (!prop->value)
 		return -ENODATA;
-	if (sizeof(*out_value) > prop->length)
+	if ((sz * sizeof(*out_values)) > prop->length)
 		return -EOVERFLOW;
-	*out_value = be32_to_cpup(prop->value);
+
+	val = prop->value;
+	while (sz--)
+		*out_values++ = be32_to_cpup(val++);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(of_property_read_u32);
+EXPORT_SYMBOL_GPL(of_property_read_u32_array);
 
 /**
  * of_property_read_string - Find and read a string from a property
diff --git a/include/linux/of.h b/include/linux/of.h
index 69afeec..4761046 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -196,8 +196,18 @@ extern struct device_node *of_find_node_with_property(
 extern struct property *of_find_property(const struct device_node *np,
 					 const char *name,
 					 int *lenp);
-extern int of_property_read_u32(struct device_node *np, char *propname,
-					u32 *out_value);
+extern int of_property_read_u32_array(const struct device_node *np,
+				      char *propname,
+				      u32 *out_values,
+				      size_t sz);
+
+static inline int of_property_read_u32(const struct device_node *np,
+				       char *propname,
+				       u32 *out_value)
+{
+	return of_property_read_u32_array(np, propname, out_value, 1);
+}
+
 extern int of_property_read_string(struct device_node *np, char *propname,
 					const char **out_string);
 extern int of_device_is_compatible(const struct device_node *device,
-- 
1.7.4.1
