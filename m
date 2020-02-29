From: Oleksandr Suvorov <oleksandr.suvorov-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 1/2] spi: spidev: fix a debug message value
Date: Sat, 29 Feb 2020 18:18:40 +0200
Message-ID: <20200229161841.89144-2-oleksandr.suvorov@toradex.com>
References: <20200229161841.89144-1-oleksandr.suvorov@toradex.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Cc: Oleksandr Suvorov <oleksandr.suvorov-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>,
        Oleksandr Suvorov <cryosay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Marcel Ziswiler <marcel.ziswiler-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>,
        Igor Opaniuk <igor.opaniuk-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>,
        Philippe Schenker <philippe.schenker-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200229161841.89144-1-oleksandr.suvorov-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The debug message in spidev_message() can show wrong xfer speed.
It happens if the initial (came from DT) and set with ioctl call spidev
speeds are different (spidev->speed_hz != spi->max_speed_hz) and one
sends a message with ioctl call and the field of speed is uninitialized
(u_tmp->speed_hz == 0).

In this case the kernel shows the spi->max_speed_hz value instead of
correct spidev->speed_hz.
...
set the max speed with an ioctl call:
[ 1227.702714] spidev spi0.0: setup mode 0, 32 bits/w, 20000000 Hz max --> 0
(real speed sets to 20000000Hz)
send a message with an ioctl call:
[ 1227.731801] spidev spi0.0:   xfer len 4096 tx 32bits 0 usec 10000000Hz
(debug message shows 10000000Hz that is the original max speed of this
spidev came from DT)
...

Fix the data source for the debug message.

Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
---

 drivers/spi/spidev.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 2ab6e782f14c..c97e853dbf5c 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -275,14 +275,14 @@ static int spidev_message(struct spidev_data *spidev,
 #ifdef VERBOSE
 		dev_dbg(&spidev->spi->dev,
 			"  xfer len %u %s%s%s%dbits %u usec %u usec %uHz\n",
-			u_tmp->len,
-			u_tmp->rx_buf ? "rx " : "",
-			u_tmp->tx_buf ? "tx " : "",
-			u_tmp->cs_change ? "cs " : "",
-			u_tmp->bits_per_word ? : spidev->spi->bits_per_word,
-			u_tmp->delay_usecs,
-			u_tmp->word_delay_usecs,
-			u_tmp->speed_hz ? : spidev->spi->max_speed_hz);
+			k_tmp->len,
+			k_tmp->rx_buf ? "rx " : "",
+			k_tmp->tx_buf ? "tx " : "",
+			k_tmp->cs_change ? "cs " : "",
+			k_tmp->bits_per_word ? : spidev->spi->bits_per_word,
+			k_tmp->delay.value,
+			k_tmp->word_delay.value,
+			k_tmp->speed_hz ? : spidev->spi->max_speed_hz);
 #endif
 		spi_message_add_tail(k_tmp, &msg);
 	}
-- 
2.24.1
