From: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: re: spi: spidev: Don't mangle max_speed_hz in underlying spi device
Date: Tue, 11 Nov 2014 15:42:51 +0300
Message-ID: <20141111124251.GA15219@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hello Mark Brown,

This is a semi-automatic email about new static checker warnings.

The patch c4f5669ff40e: "spi: spidev: Don't mangle max_speed_hz i
underlying spi device" from Nov 8, 2014, leads to the following
Smatch complaint:

drivers/spi/spidev.c:581 spidev_release()
	 warn: variable dereferenced before check 'spidev->spi' (see line 577)

drivers/spi/spidev.c
   576
   577			spidev->speed_hz = spidev->spi->max_speed_hz;
                                           ^^^^^^^^^^^^^
New unchecked dereference.

   578
   579			/* ... after we unbound from the underlying device? */
   580			spin_lock_irq(&spidev->spi_lock);
   581			dofree = (spidev->spi == NULL);
                                  ^^^^^^^^^^^^^^^^^^^
Old code assumes ->spi can be NULL.

   582			spin_unlock_irq(&spidev->spi_lock);
   583

regards,
dan carpenter
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
