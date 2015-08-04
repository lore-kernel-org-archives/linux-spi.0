From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Additional SPI-master parameters per SPI-Device in device-tree
Date: Tue, 04 Aug 2015 08:39:20 +0200
Message-ID: <55C05E18.600@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi!

How could we implement additional per spi-device parameters that
are interesting to the spi-master.

Examples for the spi-bcm2835 master for example could be:
* set minimum transfer size for dma to something else but the default
    (of 96 bytes - setting for something high would disable it)
* change polling transfer limits (i.e disable it)

Implementing these on a spi-master level is easy during probe.

So I wonder if the following approach would be acceptable
to implement device-tree parsing on the device for master
specific parameters:

int bcm2835_spi_setup(struct spi_device *spi)
{
   struct bcm2835_spi_dev *cs = spi->controller_state;
   if (!cs) {
     cs = devm_kzalloc(&spi->dev, sizeof(struct bcm2835_spi_dev), 0);
     if (!cs)
         return -ENOMEM;
     spi->controller_state = cs;

     /* parse device-tree and assign to controller_state */
     cs->polling_limit = master_bs->polling_limit;
     of_property_read_u32(nc, "spi-bcm2835-polling-limit", 
&cs->polling_limit);
     cs->dma_limit = master_bs->dma_limit;
     of_property_read_u32(nc, "spi-bcm2835-dma-limit", &cs->polling_limit);
   }
   ...
   return 0;
}

Or would it be better if we included an additional master method
that would get called from spi_add_device to do this kind of setup?
say:
   int add_device(struct spi_master *master, struct spi_device *spi);
(possibly also one called when removing the device)

Thanks,
                 Martin

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
