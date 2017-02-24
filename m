From: Kamal Dasu <kdasu.kdev@gmail.com>
Subject: [PATCH v6 2/3] mtd: spi-nor: Add spi-nor flash device synchronization
 between flash states
Date: Fri, 24 Feb 2017 15:16:38 -0500
Message-ID: <1487967399-28967-3-git-send-email-kdasu.kdev@gmail.com>
References: <1487967399-28967-1-git-send-email-kdasu.kdev@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: bcm-kernel-feedback-list@broadcom.com, f.fainelli@gmail.com,
 linux-mtd@lists.infradead.org, Kamal Dasu <kdasu.kdev@gmail.com>
To: linux-spi@vger.kernel.org, cyrille.pitchen@atmel.com, marex@denx.de,
 broonie@kernel.org
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <1487967399-28967-1-git-send-email-kdasu.kdev@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

Added flash access synchronization methods spi_nor_get/release_device(). This
change allows spi-nor driver to maintain flash states in spi-nor stucture for
read, write, erase, lock, unlock nor ops. Only when the flash state is FL_READY
a new state is set and spi-nor flash op is initiated. The state change is done
with a spin_lock held and released as soon as the state is changed. Else the
current process for spi-nor transfer is queued till the flash is in FL_READY
state. This change allows us to add mtd layer synchronization when the mtd
resume suspend handlers are added.

Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 69 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/mtd/spi-nor.h   |  4 +++
 2 files changed, 73 insertions(+)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 8b71c11..5363807 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -89,6 +89,15 @@ struct flash_info {
 
 #define JEDEC_MFR(info)	((info)->id[0])
 
+/* map table for spi_nor op to flashchip state  */
+static int spi_nor_state[] = {
+	[SPI_NOR_OPS_READ]	= FL_READING,
+	[SPI_NOR_OPS_WRITE]	= FL_WRITING,
+	[SPI_NOR_OPS_ERASE]	= FL_ERASING,
+	[SPI_NOR_OPS_LOCK]	= FL_LOCKING,
+	[SPI_NOR_OPS_UNLOCK]	= FL_UNLOCKING,
+};
+
 static const struct flash_info *spi_nor_match_id(const char *name);
 
 /*
@@ -396,10 +405,64 @@ static int erase_chip(struct spi_nor *nor)
 	return nor->write_reg(nor, SPINOR_OP_CHIP_ERASE, NULL, 0);
 }
 
+/**
+ * spi_nor_get_device - [GENERIC] Get chip for selected access
+ * @param mtd		MTD device structure
+ * @param new_state	the state which is requested
+ *
+ * Get the nor flash device and lock it for exclusive access
+ */
+static int spi_nor_get_device(struct mtd_info *mtd, int new_state)
+{
+	struct spi_nor *nor = mtd_to_spi_nor(mtd);
+	DECLARE_WAITQUEUE(wait, current);
+
+	/*
+	 * Grab the lock and see if the device is available
+	 */
+	while (1) {
+		spin_lock(&nor->chip_lock);
+		if (nor->state == FL_READY) {
+			nor->state = new_state;
+			spin_unlock(&nor->chip_lock);
+			break;
+		}
+		if (new_state == FL_PM_SUSPENDED) {
+			spin_unlock(&nor->chip_lock);
+			return (nor->state == FL_PM_SUSPENDED) ? 0 : -EAGAIN;
+		}
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		add_wait_queue(&nor->wq, &wait);
+		spin_unlock(&nor->chip_lock);
+		schedule();
+		remove_wait_queue(&nor->wq, &wait);
+	}
+
+	return 0;
+}
+
+/**
+ * spi_nor_release_device - [GENERIC] release chip
+ * @mtd: MTD device structure
+ *
+ * Release nor flash chip lock and wake up anyone waiting on the device.
+ */
+static void spi_nor_release_device(struct mtd_info *mtd)
+{
+	struct spi_nor *nor = mtd_to_spi_nor(mtd);
+
+	/* Release the controller and the chip */
+	spin_lock(&nor->chip_lock);
+	nor->state = FL_READY;
+	wake_up(&nor->wq);
+	spin_unlock(&nor->chip_lock);
+}
+
 static int spi_nor_lock_and_prep(struct spi_nor *nor, enum spi_nor_ops ops)
 {
 	int ret = 0;
 
+	spi_nor_get_device(&nor->mtd, spi_nor_state[ops]);
 	mutex_lock(&nor->lock);
 
 	if (nor->prepare) {
@@ -407,6 +470,7 @@ static int spi_nor_lock_and_prep(struct spi_nor *nor, enum spi_nor_ops ops)
 		if (ret) {
 			dev_err(nor->dev, "failed in the preparation.\n");
 			mutex_unlock(&nor->lock);
+			spi_nor_release_device(&nor->mtd);
 			return ret;
 		}
 	}
@@ -418,6 +482,7 @@ static void spi_nor_unlock_and_unprep(struct spi_nor *nor, enum spi_nor_ops ops)
 	if (nor->unprepare)
 		nor->unprepare(nor, ops);
 	mutex_unlock(&nor->lock);
+	spi_nor_release_device(&nor->mtd);
 }
 
 /*
@@ -1743,6 +1808,10 @@ int spi_nor_scan(struct spi_nor *nor, const char *name, enum read_mode mode)
 			return ret;
 	}
 
+	nor->state = FL_READY;
+	init_waitqueue_head(&nor->wq);
+	spin_lock_init(&nor->chip_lock);
+
 	/*
 	 * call init function to send necessary spi-nor read/write config
 	 * commands to nor flash based on above nor settings
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index 29a8283..244d98d 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -13,6 +13,7 @@
 #include <linux/bitops.h>
 #include <linux/mtd/cfi.h>
 #include <linux/mtd/mtd.h>
+#include <linux/mtd/flashchip.h>
 
 /*
  * Manufacturer IDs
@@ -210,6 +211,9 @@ struct spi_nor {
 
 	void *priv;
 	const struct flash_info *info;
+	spinlock_t		chip_lock;
+	wait_queue_head_t	wq;
+	flstate_t		state;
 };
 
 static inline void spi_nor_set_flash_node(struct spi_nor *nor,
-- 
1.9.1


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
