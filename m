From: =?UTF-8?q?Jan=20Kundr=C3=A1t?= <jan.kundrat@cesnet.cz>
Subject: [PATCH 4/4] pinctrl: mcp23s08: spi: Fix duplicate pinctrl debugfs
 entries
Date: Fri, 26 Jan 2018 16:06:37 +0100
Message-ID: <e3a251cf48ad518ce4205cfdf2e866e6b3bb76f8.1516997103.git.jan.kundrat@cesnet.cz>
References: <cover.1516997103.git.jan.kundrat@cesnet.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: linux-spi@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Phil Reid <preid@electromag.com.au>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To: linux-gpio@vger.kernel.org
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <cover.1516997103.git.jan.kundrat@cesnet.cz>
Sender: linux-gpio-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This is a bit more involved because the pinctrl core so far always
assumed that one device (with a unique dev_name) only contains a single
pinctrl thing. This is not true for the mcp23s08 driver for chips
connected over SPI. They have a "logical address" which means that
several chips can share one physical CS signal.

A downside of this patch are some possibly ugly names for the debugfs
entries, such as "spi1.1-mcp23xxx-pinctrl.2", etc.

Signed-off-by: Jan Kundrát <jan.kundrat@cesnet.cz>
---
 drivers/pinctrl/core.c             | 18 ++++++++++++++++--
 drivers/pinctrl/pinctrl-mcp23s08.c |  9 ++++++++-
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index 4c8d5b23e4d0..dc7a77f2f9fe 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -1856,9 +1856,23 @@ static struct dentry *debugfs_root;
 static void pinctrl_init_device_debugfs(struct pinctrl_dev *pctldev)
 {
 	struct dentry *device_root;
+	const char *debugfs_name;
+
+	if (pctldev->desc->name &&
+			strcmp(dev_name(pctldev->dev), pctldev->desc->name)) {
+		debugfs_name = devm_kasprintf(pctldev->dev, GFP_KERNEL,
+				"%s-%s", dev_name(pctldev->dev),
+				pctldev->desc->name);
+		if (!debugfs_name) {
+			pr_warn("failed to determine debugfs dir name for %s\n",
+				dev_name(pctldev->dev));
+			return;
+		}
+	} else {
+		debugfs_name = dev_name(pctldev->dev);
+	}
 
-	device_root = debugfs_create_dir(dev_name(pctldev->dev),
-					 debugfs_root);
+	device_root = debugfs_create_dir(debugfs_name, debugfs_root);
 	pctldev->device_root = device_root;
 
 	if (IS_ERR(device_root) || !device_root) {
diff --git a/drivers/pinctrl/pinctrl-mcp23s08.c b/drivers/pinctrl/pinctrl-mcp23s08.c
index c76c9d4b26c9..1f3971d02084 100644
--- a/drivers/pinctrl/pinctrl-mcp23s08.c
+++ b/drivers/pinctrl/pinctrl-mcp23s08.c
@@ -954,7 +954,14 @@ static int mcp23s08_probe_one(struct mcp23s08 *mcp, struct device *dev,
 			goto fail;
 	}
 
-	mcp->pinctrl_desc.name = "mcp23xxx-pinctrl";
+	if (one_regmap_config) {
+		mcp->pinctrl_desc.name = devm_kasprintf(dev, GFP_KERNEL,
+				"mcp23xxx-pinctrl.%d", raw_chip_address);
+		if (!mcp->pinctrl_desc.name)
+			return -ENOMEM;
+	} else {
+		mcp->pinctrl_desc.name = "mcp23xxx-pinctrl";
+	}
 	mcp->pinctrl_desc.pctlops = &mcp_pinctrl_ops;
 	mcp->pinctrl_desc.confops = &mcp_pinconf_ops;
 	mcp->pinctrl_desc.npins = mcp->chip.ngpio;
-- 
2.14.3


