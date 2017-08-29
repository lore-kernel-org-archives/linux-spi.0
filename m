From: =?iso-8859-1?Q?H=E4nel-Baas=2C_Alexander?=
        <alexander.haenel-baas-2YRSn766l8rddJNmlsFzeA@public.gmane.org>
Subject: SPI_IOC_WR_MAX_SPEED_HZ was overwitten?
Date: Tue, 29 Aug 2017 14:13:22 +0000
Message-ID: <9BA84827B30CBE4996725F98F7DC91236563EEE4@SMExchange01.siebmeyer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
To: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Language: de-DE
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi

> Is it possible that the ioctl SPI_IOC_WR_MODE call can 
> overwrite the previous ioctl SPI_IOC_WR_MAX_SPEED_HZ speed setting?

Yes it is. Please take a look in spidev.c Line 488. 
In the spidev_ioctl() function at the SPI_IOC_WR_MAX_SPEED_HZ case the
spi->max_speed_hz value was always overwritten with the old "save" value
regardless if the spi_setup call was successful or not.

--Snip--  
else
	dev_dbg(&spi->dev, "%d Hz (max)\n", tmp);
spi->max_speed_hz = save;
}
break;
--snip--

Every following ioctl call will restore the wrong speed value.
 
Here is my patch to correct this:
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -480,11 +480,10 @@
 
 			spi->max_speed_hz = tmp;
 			retval = spi_setup(spi);
-			if (retval >= 0)
-				spidev->speed_hz = tmp;
+			if (retval < 0)
+				spidev->speed_hz = save;
 			else
 				dev_dbg(&spi->dev, "%d Hz (max)\n", tmp);
-			spi->max_speed_hz = save;
 		}
 		break;

Can anybody review this please?

With this patch  my program works fine with the spidev and the tool flashrom also.

Best regards,
Alexander

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
