From: Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH 2/3] spi: Make of_find_spi_controller_by_node visible
Date: Fri, 12 Apr 2019 17:02:12 +1200
Message-ID: <20190412050213.17698-3-chris.packham@alliedtelesis.co.nz>
References: <20190412050213.17698-1-chris.packham@alliedtelesis.co.nz>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Cc: Hamish Martin <hamish.martin@alliedtelesis.co.nz>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
To: broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190412050213.17698-1-chris.packham@alliedtelesis.co.nz>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Drop the static and add of_find_spi_controller_by_node() to spi.h. Also
move it outside of the CONFIG_OF_DYNAMIC so it is available with just
CONFIG_OF.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 drivers/spi/spi.c       | 7 ++++---
 include/linux/spi/spi.h | 7 +++++++
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 93986f879b09..19929163a45b 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -3531,16 +3531,14 @@ struct spi_device *of_find_spi_device_by_node(str=
uct device_node *node)
 	return dev ? to_spi_device(dev) : NULL;
 }
 EXPORT_SYMBOL_GPL(of_find_spi_device_by_node);
-#endif /* IS_ENABLED(CONFIG_OF) */
=20
-#if IS_ENABLED(CONFIG_OF_DYNAMIC)
 static int __spi_of_controller_match(struct device *dev, const void *dat=
a)
 {
 	return dev->of_node =3D=3D data;
 }
=20
 /* the spi controllers are not using spi_bus, so we find it with another=
 way */
-static struct spi_controller *of_find_spi_controller_by_node(struct devi=
ce_node *node)
+struct spi_controller *of_find_spi_controller_by_node(struct device_node=
 *node)
 {
 	struct device *dev;
=20
@@ -3555,7 +3553,10 @@ static struct spi_controller *of_find_spi_controll=
er_by_node(struct device_node
 	/* reference got in class_find_device */
 	return container_of(dev, struct spi_controller, dev);
 }
+EXPORT_SYMBOL_GPL(of_find_spi_controller_by_node);
+#endif /* IS_ENABLED(CONFIG_OF) */
=20
+#if IS_ENABLED(CONFIG_OF_DYNAMIC)
 static int of_spi_notify(struct notifier_block *nb, unsigned long action=
,
 			 void *arg)
 {
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 662b336aa2e4..e763290767ea 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -1334,6 +1334,8 @@ spi_transfer_is_last(struct spi_controller *ctlr, s=
truct spi_transfer *xfer)
 extern struct spi_device *
 of_find_spi_device_by_node(struct device_node *node);
=20
+extern struct spi_controller *
+of_find_spi_controller_by_node(struct device_node *node);
 #else
=20
 static inline struct spi_device *
@@ -1342,6 +1344,11 @@ of_find_spi_device_by_node(struct device_node *nod=
e)
 	return NULL;
 }
=20
+static inline struct spi_controller *
+of_find_spi_controller_by_node(struct device_node *node)
+{
+	return NULL;
+}
 #endif /* IS_ENABLED(CONFIG_OF) */
=20
 /* Compatibility layer */
--=20
2.21.0
