From: Andrey Smirnov <andrew.smirnov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [RFC, PATCH] spi, spidev: Add support for long SPI transfers
Date: Mon, 24 Nov 2014 09:50:23 -0800
Message-ID: <1416851423-1902-2-git-send-email-andrew.smirnov@gmail.com>
References: <1416851423-1902-1-git-send-email-andrew.smirnov@gmail.com>
Cc: andrew.smirnov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, yurovsky-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1416851423-1902-1-git-send-email-andrew.smirnov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

SPI controllers found on modern SoCs have rather large SPI FIFOs and
allow for uninterrupted SPI transaction that are more then 256 bytes
long. This commit adds necessary plumbing for such SPI transfers.

Signed-off-by: Andrey Smirnov <andrew.smirnov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spidev.c            | 7 ++++++-
 include/linux/spi/spi.h         | 4 ++--
 include/uapi/linux/spi/spidev.h | 2 +-
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index d7c6e36..45d8905 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -265,7 +265,12 @@ static int spidev_message(struct spidev_data *spidev,
 		buf += k_tmp->len;
 
 		k_tmp->cs_change = !!u_tmp->cs_change;
-		k_tmp->bits_per_word = u_tmp->bits_per_word;
+
+		if (!u_tmp->bits_per_word && u_tmp->bits_per_burst)
+			k_tmp->bits_per_word = u_tmp->bits_per_burst;
+		else
+			k_tmp->bits_per_word = u_tmp->bits_per_word;
+
 		k_tmp->delay_usecs = u_tmp->delay_usecs;
 		k_tmp->speed_hz = u_tmp->speed_hz;
 #ifdef VERBOSE
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 4203c66..a0c34c1 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -75,7 +75,7 @@ struct spi_device {
 	struct spi_master	*master;
 	u32			max_speed_hz;
 	u8			chip_select;
-	u8			bits_per_word;
+	u32			bits_per_word;
 	u16			mode;
 #define	SPI_CPHA	0x01			/* clock phase */
 #define	SPI_CPOL	0x02			/* clock polarity */
@@ -586,7 +586,7 @@ struct spi_transfer {
 #define	SPI_NBITS_SINGLE	0x01 /* 1bit transfer */
 #define	SPI_NBITS_DUAL		0x02 /* 2bits transfer */
 #define	SPI_NBITS_QUAD		0x04 /* 4bits transfer */
-	u8		bits_per_word;
+	u32		bits_per_word;
 	u16		delay_usecs;
 	u32		speed_hz;
 
diff --git a/include/uapi/linux/spi/spidev.h b/include/uapi/linux/spi/spidev.h
index 52d9ed0..b70f3d4 100644
--- a/include/uapi/linux/spi/spidev.h
+++ b/include/uapi/linux/spi/spidev.h
@@ -92,7 +92,7 @@ struct spi_ioc_transfer {
 	__u16		delay_usecs;
 	__u8		bits_per_word;
 	__u8		cs_change;
-	__u32		pad;
+	__u32		bits_per_burst;
 
 	/* If the contents of 'struct spi_ioc_transfer' ever change
 	 * incompatibly, then the ioctl number (currently 0) must change;
-- 
1.9.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
