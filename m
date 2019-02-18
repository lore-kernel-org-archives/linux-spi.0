From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [RFC 2/4] driver: platform: Provide helper for safer
	setting of driver_override
Date: Mon, 18 Feb 2019 11:15:58 +0100
Message-ID: <1550484960-2392-3-git-send-email-krzk@kernel.org>
References: <1550484960-2392-1-git-send-email-krzk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Russell King <linux@armlinux.org.uk>, Mark Brown <broonie@kernel.org>,
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Tomasz Figa <tomasz.figa@gmail.com>, Chanwoo Choi <cw00.choi@samsung.com>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Kukjin Kim <kgene@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Andy Gross <andy.gross@linaro.org>,
 David Brown <david.brown@linaro.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 alsa-devel@alsa-project.org
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1550484960-2392-1-git-send-email-krzk@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
List-Id: linux-spi.vger.kernel.org

The core platform driver expects that driver_override is an dynamically
allocated memory so later it can kfree() it.

However such assumption is not documented and there are already users
setting it to a const memory.  This leads to kfree() of const memory
during device release (e.g. in error paths or during unbind):

    kernel BUG at ../mm/slub.c:3960!
    Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM
    ...
    (kfree) from [<c058da50>] (platform_device_release+0x88/0xb4)
    (platform_device_release) from [<c0585be0>] (device_release+0x2c/0x90)
    (device_release) from [<c0a69050>] (kobject_put+0xec/0x20c)
    (kobject_put) from [<c0f2f120>] (exynos5_clk_probe+0x154/0x18c)
    (exynos5_clk_probe) from [<c058de70>] (platform_drv_probe+0x6c/0xa4)
    (platform_drv_probe) from [<c058b7ac>] (really_probe+0x280/0x414)
    (really_probe) from [<c058baf4>] (driver_probe_device+0x78/0x1c4)
    (driver_probe_device) from [<c0589854>] (bus_for_each_drv+0x74/0xb8)
    (bus_for_each_drv) from [<c058b48c>] (__device_attach+0xd4/0x16c)
    (__device_attach) from [<c058a638>] (bus_probe_device+0x88/0x90)
    (bus_probe_device) from [<c05871fc>] (device_add+0x3dc/0x62c)
    (device_add) from [<c075ff10>] (of_platform_device_create_pdata+0x94/0xbc)
    (of_platform_device_create_pdata) from [<c07600ec>] (of_platform_bus_create+0x1a8/0x4fc)
    (of_platform_bus_create) from [<c0760150>] (of_platform_bus_create+0x20c/0x4fc)
    (of_platform_bus_create) from [<c07605f0>] (of_platform_populate+0x84/0x118)
    (of_platform_populate) from [<c0f3c964>] (of_platform_default_populate_init+0xa0/0xb8)
    (of_platform_default_populate_init) from [<c01031f8>] (do_one_initcall+0x8c/0x404)
    (do_one_initcall) from [<c0f012c0>] (kernel_init_freeable+0x3d0/0x4d8)
    (kernel_init_freeable) from [<c0a7def0>] (kernel_init+0x8/0x114)
    (kernel_init) from [<c01010b4>] (ret_from_fork+0x14/0x20)

Provide a helper which clearly documents the usage of driver_override.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/base/platform.c         | 63 ++++++++++++++++++++++++++++-------------
 include/linux/platform_device.h |  9 +++++-
 2 files changed, 51 insertions(+), 21 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 0d3611cd1b3b..1458903a33c8 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -730,6 +730,45 @@ int __init_or_module __platform_driver_probe(struct platform_driver *drv,
 }
 EXPORT_SYMBOL_GPL(__platform_driver_probe);
 
+/*
+ * platform_set_driver_override() - Helper to set or clear driver override.
+ * @pdev: platform device
+ * @override: Driver name to force a match, pass empty string to clear it
+ *
+ * Returns: 0 on success or a negative error code on failure.
+ */
+int platform_set_driver_override(struct platform_device *pdev,
+				 const char *override)
+{
+	struct device *dev = &pdev->dev;
+	char *driver_override, *old, *cp;
+
+	if (!pdev || !override)
+		return -EINVAL;
+
+	driver_override = kstrndup(override, strlen(override), GFP_KERNEL);
+	if (!driver_override)
+		return -ENOMEM;
+
+	cp = strchr(driver_override, '\n');
+	if (cp)
+		*cp = '\0';
+
+	device_lock(dev);
+	old = pdev->driver_override;
+	if (strlen(driver_override)) {
+		pdev->driver_override = driver_override;
+	} else {
+		kfree(driver_override);
+		pdev->driver_override = NULL;
+	}
+	device_unlock(dev);
+
+	kfree(old);
+
+	return 0;
+}
+
 /**
  * __platform_create_bundle - register driver and create corresponding device
  * @driver: platform driver structure
@@ -879,31 +918,15 @@ static ssize_t driver_override_store(struct device *dev,
 				     const char *buf, size_t count)
 {
 	struct platform_device *pdev = to_platform_device(dev);
-	char *driver_override, *old, *cp;
+	int ret;
 
 	/* We need to keep extra room for a newline */
 	if (count >= (PAGE_SIZE - 1))
 		return -EINVAL;
 
-	driver_override = kstrndup(buf, count, GFP_KERNEL);
-	if (!driver_override)
-		return -ENOMEM;
-
-	cp = strchr(driver_override, '\n');
-	if (cp)
-		*cp = '\0';
-
-	device_lock(dev);
-	old = pdev->driver_override;
-	if (strlen(driver_override)) {
-		pdev->driver_override = driver_override;
-	} else {
-		kfree(driver_override);
-		pdev->driver_override = NULL;
-	}
-	device_unlock(dev);
-
-	kfree(old);
+	ret = platform_set_driver_override(pdev, buf);
+	if (ret)
+		return ret;
 
 	return count;
 }
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index c7c081dc6034..1dd06fed3306 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -29,7 +29,11 @@ struct platform_device {
 	struct resource	*resource;
 
 	const struct platform_device_id	*id_entry;
-	char *driver_override; /* Driver name to force a match */
+	/*
+	 * Driver name to force a match, use
+	 * platform_set_driver_override() to set or clear it.
+	 */
+	char *driver_override;
 
 	/* MFD cell pointer */
 	struct mfd_cell *mfd_cell;
@@ -220,6 +224,9 @@ static inline void platform_set_drvdata(struct platform_device *pdev,
 	dev_set_drvdata(&pdev->dev, data);
 }
 
+int platform_set_driver_override(struct platform_device *pdev,
+				 const char *override);
+
 /* module_platform_driver() - Helper macro for drivers that don't do
  * anything special in module init/exit.  This eliminates a lot of
  * boilerplate.  Each module may only use this macro once, and
-- 
2.7.4
