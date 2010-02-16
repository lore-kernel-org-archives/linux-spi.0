From: Ernst Schwab <eschwab-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH 2/5] spi: spi_register_lock_bus and
	spi_unregister_lock_bus
Date: Tue, 16 Feb 2010 20:57:28 +0100
Message-ID: <20100216205728.86960a9e.eschwab@online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: yi.li-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org, vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Kumar Gala
	<galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, David Brownell
	<dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Ernst Schwab <eschwab-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>

Added code for spi_register_lock_bus. One driver can lock the bus, if the
SPI master supports bus locking, or there is only one chip select in use.
spi_add_device will refuse to add further SPI devices if the bus master
does not support bus locking and one driver requested it. 

Signed-off-by: Ernst Schwab <eschwab-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>
---
diff -upr a/drivers/spi/spi.c b/drivers/spi/spi.c
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -285,6 +285,18 @@ int spi_add_device(struct spi_device *sp
 		goto done;
 	}
 
+	/* If exclusive SPI bus access was granted to an SPI client, all
+	 * further spi_add_device calls are abandoned.
+	 */
+	if (spi->master->exclusive &&
+	    spi->chip_select!=spi->master->bus_lock_chip_select) {
+		dev_err(dev, "SPI bus is locked for exclusive use "
+			"by chipselect %d; chipselect %d cannot be used\n", 
+			spi->master->bus_lock_chip_select, spi->chip_select);
+		status = -EBUSY;
+		goto done;
+	}		
+
 	/* Drivers may modify this initial i/o setup, but will
 	 * normally rely on the device being setup.  Devices
 	 * using SPI_CS_HIGH can't coexist well otherwise...
@@ -524,6 +536,10 @@ int spi_register_master(struct spi_maste
 		dynamic = 1;
 	}
 
+	/* no device has registered the master for exclusive use yet */
+	master->bus_lock_chip_select = SPI_MASTER_BUS_UNLOCKED;
+	master->exclusive = 0;
+	
 	/* register the device, then userspace will see it.
 	 * registration fails if the bus ID is in use.
 	 */
@@ -783,6 +799,96 @@ int spi_unlock_bus(struct spi_device *sp
 }
 EXPORT_SYMBOL_GPL(spi_unlock_bus);
 
+/* REVISIT:
+ * Temporary solution: 
+ * Helper functions to check if exclusive access possible.
+ * If all masters support the spi_lock_bus callback, these can be removed.
+ */
+struct count_children {
+	unsigned	n;
+	struct bus_type	*bus;
+};
+
+static int maybe_count_child(struct device *dev, void *c)
+{
+	struct count_children *ccp = c;
+
+	if (dev->bus == ccp->bus) {
+		if (ccp->n)
+			return -EBUSY;
+		ccp->n++;
+	}
+	return 0;
+}
+
+static int spi_lock_bus_check (struct spi_device *spi) 
+{
+	int status;
+	
+	if (spi->master->num_chipselect > 1) {
+		struct count_children cc;
+
+		cc.n = 0;
+		cc.bus = spi->dev.bus;
+		status = device_for_each_child(spi->dev.parent, &cc,
+				maybe_count_child);
+		if (status < 0) {
+			return status;
+		}
+	}
+	return 0;
+}
+
+/**
+ * spi_register_lock_bus - register SPI device for use of spi_lock_bus
+ */
+int spi_register_lock_bus(struct spi_device *spi)
+{
+	if (spi->master->bus_lock_chip_select != SPI_MASTER_BUS_UNLOCKED) {
+		/* currently, only one device can use bus locking */
+		dev_err(&spi->dev, "only one SPI device can "
+				   "get exclusive SPI bus access\n");
+		return -EBUSY;
+	}
+
+	if (!spi->master->lock_bus) {
+		/* REVISIT:
+		 * If all masters support the spi_lock_bus entry, 
+		 * this can be removed.
+		 * A check for exclusive SPI bus use is done if the SPI master
+		 * does not support bus locking.
+		 */
+		if (spi_lock_bus_check(spi) < 0) {
+			return -EBUSY;
+		}
+		
+		/* lock out all future spi_add_device calls */
+		spi->master->exclusive = 1;
+		dev_warn(&spi->dev, "ENFORCING SPI bus stays unshared!\n");
+	}
+
+	/* Remember the chip_select for which the bus is locked. */
+	spi->master->bus_lock_chip_select = spi->chip_select;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(spi_register_lock_bus);
+
+/**
+ * spi_unregister_lock_bus - unregister SPI device for use of spi_lock_bus
+ */
+int spi_unregister_lock_bus(struct spi_device *spi)
+{
+	if (spi->master->bus_lock_chip_select != spi->chip_select) {
+		/* unregister without a matching register */
+		return -EINVAL;
+	}
+
+	spi->master->bus_lock_chip_select = SPI_MASTER_BUS_UNLOCKED;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(spi_unregister_lock_bus);
+
 /**
  * spi_sync - blocking/synchronous SPI data transfers
  * @spi: device with which data will be exchanged
diff -upr a/include/linux/spi/spi.h b/include/linux/spi/spi.h
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -263,6 +263,14 @@ struct spi_master {
 #define SPI_MASTER_NO_RX	BIT(1)		/* can't do buffer read */
 #define SPI_MASTER_NO_TX	BIT(2)		/* can't do buffer write */
 
+	/* chipselect of the (one) spi device that may lock the bus for 
+	 * exclusive use */
+	u8			bus_lock_chip_select;
+#define SPI_MASTER_BUS_UNLOCKED 0xFF		/* value to indicate unlocked */
+
+	/* enforce that the spi bus remains unshared */
+	u8			exclusive;
+				
 	/* Setup mode and clock, etc (spi driver may call many times).
 	 *
 	 * IMPORTANT:  this may be called when transfers to another
@@ -555,6 +563,10 @@ extern int spi_async(struct spi_device *
  */
 
 extern int spi_sync(struct spi_device *spi, struct spi_message *message);
+
+/* Functions to ensure exclusive access to the spi bus */
+extern int spi_register_lock_bus(struct spi_device *spi);
+extern int spi_unregister_lock_bus(struct spi_device *spi);
 extern int spi_lock_bus(struct spi_device *spi);
 extern int spi_unlock_bus(struct spi_device *spi);
 



------------------------------------------------------------------------------
SOLARIS 10 is the OS for Data Centers - provides features such as DTrace,
Predictive Self Healing and Award Winning ZFS. Get Solaris 10 NOW
http://p.sf.net/sfu/solaris-dev2dev
