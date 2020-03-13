From: Akash Asthana <akashast-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH V2 1/8] interconnect: Add devm_of_icc_get() as exported API for users
Date: Fri, 13 Mar 2020 18:42:07 +0530
Message-ID: <1584105134-13583-2-git-send-email-akashast@codeaurora.org>
References: <1584105134-13583-1-git-send-email-akashast@codeaurora.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, swboyd-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org,
        mgautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org,
        dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, evgreen-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org,
        Akash Asthana <akashast-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
To: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, agross-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        mark.rutland-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1584105134-13583-1-git-send-email-akashast-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Users can use devm version of of_icc_get() to benefit from automatic
resource release.

Signed-off-by: Akash Asthana <akashast-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
---
 drivers/interconnect/core.c  | 25 +++++++++++++++++++++++++
 include/linux/interconnect.h |  7 +++++++
 2 files changed, 32 insertions(+)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 2c6515e..f5699ed 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -350,6 +350,31 @@ static struct icc_node *of_icc_get_from_provider(struct of_phandle_args *spec)
 	return node;
 }
 
+static void devm_icc_release(struct device *dev, void *res)
+{
+	icc_put(*(struct icc_path **)res);
+}
+
+struct icc_path *devm_of_icc_get(struct device *dev, const char *name)
+{
+	struct icc_path **ptr, *path;
+
+	ptr = devres_alloc(devm_icc_release, sizeof(**ptr), GFP_KERNEL);
+	if (!ptr)
+		return ERR_PTR(-ENOMEM);
+
+	path = of_icc_get(dev, name);
+	if (!IS_ERR(path)) {
+		*ptr = path;
+		devres_add(dev, ptr);
+	} else {
+		devres_free(ptr);
+	}
+
+	return path;
+}
+EXPORT_SYMBOL_GPL(devm_of_icc_get);
+
 /**
  * of_icc_get() - get a path handle from a DT node based on name
  * @dev: device pointer for the consumer device
diff --git a/include/linux/interconnect.h b/include/linux/interconnect.h
index d70a914..7706924 100644
--- a/include/linux/interconnect.h
+++ b/include/linux/interconnect.h
@@ -28,6 +28,7 @@ struct device;
 struct icc_path *icc_get(struct device *dev, const int src_id,
 			 const int dst_id);
 struct icc_path *of_icc_get(struct device *dev, const char *name);
+struct icc_path *devm_of_icc_get(struct device *dev, const char *name);
 void icc_put(struct icc_path *path);
 int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw);
 void icc_set_tag(struct icc_path *path, u32 tag);
@@ -46,6 +47,12 @@ static inline struct icc_path *of_icc_get(struct device *dev,
 	return NULL;
 }
 
+static inline struct icc_path *devm_of_icc_get(struct device *dev,
+						const char *name)
+{
+	return NULL;
+}
+
 static inline void icc_put(struct icc_path *path)
 {
 }
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project
