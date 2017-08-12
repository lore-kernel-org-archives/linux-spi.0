From: Vikram N <vicky773-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] spi: spidev: add exclusive bus access lock via ioctls
Date: Sat, 12 Aug 2017 17:24:03 +0530
Message-ID: <1502538843-3283-1-git-send-email-vicky773@gmail.com>
Cc: Vikram N <vicky773-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

There are use-cases wherein one or more applications wants to communicate
with the same spi slave chip and they wish to have exclusive bus access.
May to serialize their command,response patterns.
This can be realized in two ways,
 - Identify different applications using same spi channel and implement
   synchronization mechanisms to get exclusive bus access
 - Provide some mechanism through spidev driver to get exclusive spi bus
   access like via ioctls

This patch implements the second approach which eliminates the need for
implementing complex IPC mechanisms in the applications which shares the
spi bus. This becomes even harder if we don't have access to the source
code of the application which is using the spi channel.

Signed-off-by: Vikram N <vicky773-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spidev.c            |   14 +++++++++++++-
 include/uapi/linux/spi/spidev.h |    4 +++-
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index cda1071..d14a8c1 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -85,6 +85,7 @@ struct spidev_data {
 	u8			*tx_buffer;
 	u8			*rx_buffer;
 	u32			speed_hz;
+	bool			bus_locked;
 };
 
 static LIST_HEAD(device_list);
@@ -109,7 +110,8 @@ struct spidev_data {
 	if (spi == NULL)
 		status = -ESHUTDOWN;
 	else
-		status = spi_sync(spi, message);
+		status = spidev->bus_locked ? spi_sync_locked(spi, message) :
+				spi_sync(spi, message);
 
 	if (status == 0)
 		status = message->actual_length;
@@ -462,6 +464,16 @@ static int spidev_message(struct spidev_data *spidev,
 		}
 		break;
 
+	case SPI_IOC_BUS_LOCK:
+		spi_bus_lock(spi->master);
+		spidev->bus_locked = true;
+		break;
+
+	case SPI_IOC_BUS_UNLOCK:
+		spi_bus_unlock(spi->master);
+		spidev->bus_locked = false;
+		break;
+
 	default:
 		/* segmented and/or full-duplex I/O request */
 		/* Check message and copy into scratch area */
diff --git a/include/uapi/linux/spi/spidev.h b/include/uapi/linux/spi/spidev.h
index dd5f21e..1f776fe 100644
--- a/include/uapi/linux/spi/spidev.h
+++ b/include/uapi/linux/spi/spidev.h
@@ -136,6 +136,8 @@ struct spi_ioc_transfer {
 #define SPI_IOC_RD_MODE32		_IOR(SPI_IOC_MAGIC, 5, __u32)
 #define SPI_IOC_WR_MODE32		_IOW(SPI_IOC_MAGIC, 5, __u32)
 
-
+/* Exclusive bus access lock */
+#define SPI_IOC_BUS_LOCK		_IO(SPI_IOC_MAGIC, 6)
+#define SPI_IOC_BUS_UNLOCK		_IO(SPI_IOC_MAGIC, 7)
 
 #endif /* SPIDEV_H */
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
