From: Christian Hartmann <cornogle-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: Fwd: [alsa-devel] Fwd: [PATCH 1/1] SPI : spi-pxa2xx : fix spi init of
 WM510205 codec via ACPI (resend)
Date: Fri, 28 Aug 2015 11:50:54 +0200
Message-ID: <CAKor6TfW4reRz3m-xkCr_ZUfHQkfqT3q+S7JCpO-9F+k1QW38g@mail.gmail.com>
References: <20150821074310.GM30005@lahna.fi.intel.com>
	<CAKor6TeJp4ti6_QVCEpz0x7c2NwvUiS5wq_=_WDjM3B7T4=1Yg@mail.gmail.com>
	<20150824085140.GA5647@ck-lbox>
	<CAKor6TcRWgn-Z+Va0JKCBqxVA9HBSLMR_vh-z8MSBZebn9kDVg@mail.gmail.com>
	<20150825062157.GB27431@sirena.org.uk>
	<CAKor6Tf_8J4DVrVRShw2ked-zJzmP6G1P1i=vTcbzWX-J1H6dQ@mail.gmail.com>
	<CAKor6TfpWuhTG6dfARdHmXEb+bLpm5Q6Z-A0g60VPD2fCWHbOg@mail.gmail.com>
	<20150826100155.GA1513@lahna.fi.intel.com>
	<CAKor6TeH32hd0QUCPowzrjp54iJjGKiJ8jVT994y2O29dfk=QA@mail.gmail.com>
	<20150827115914.GF28428@lahna.fi.intel.com>
	<20150827145614.GC5313@sirena.org.uk>
	<CAKor6Tf8kB0WPXLTBFmCzUJkMVEDu-xTEyw0-_NZvBdFSyQSFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org,
	Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Pierre-Louis Bossart <pierre-louis.bossart-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
	Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
	dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org
To: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAKor6Tf8kB0WPXLTBFmCzUJkMVEDu-xTEyw0-_NZvBdFSyQSFA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi,

this is a resend with all recipients in cc now


---------- Forwarded message ----------
From: Christian Hartmann <cornogle-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Date: 2015-08-28 9:41 GMT+02:00
Subject: Re: [alsa-devel] Fwd: [PATCH 1/1] SPI : spi-pxa2xx : fix spi
init of WM510205 codec via ACPI (resend)
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>


hi Mark et al.,



2015-08-27 16:56 GMT+02:00 Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>:
> I can't see how that would work, the interrupt output isn't a GPIO.

yes I think also that this is the GPIO pin number.
I am not familiar with the interrupt handling, have again to look (in
other drivers or similar), to understand how things should work, never
done that before.

I have added three dev_info() into spi-pxa2xx pxa2xx_spi_probe() to
found out more whats wrong with the slave/master:

commit 4b6ff73610deef478e53b958a02617f024bbef22
Author: Christian Hartmann <cornogle-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Date:   Thu Aug 27 14:51:48 2015 +0200

    spi/spi-pxa2xx.c : added three new dev_infos, which prints irq,
bus_num and num_chipselect

    Signed-off-by: Christian Hartmann <cornogle-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 6d795a5..cf02094 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1389,6 +1389,9 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
        master->unprepare_transfer_hardware = pxa2xx_spi_unprepare_transfer;
        master->auto_runtime_pm = true;

+       dev_info(&pdev->dev, "bus_num = %d\n",master->bus_num);
+       dev_info(&pdev->dev, "num_chipselect = %d\n",master->num_chipselect);
+
        drv_data->ssp_type = ssp->type;
        drv_data->null_dma_buf = (u32 *)PTR_ALIGN(&drv_data[1], DMA_ALIGNMENT);

@@ -1423,6 +1426,8 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)

        }

+       dev_info(&pdev->dev, "IRQ %d\n", ssp->irq);
+
        /* Setup DMA if requested */
        drv_data->tx_channel = -1;
        drv_data->rx_channel = -1;


 and thats what I got:

[    6.182903] pxa2xx-spi 80860F0E:00: bus_num = -1
[    6.182909] pxa2xx-spi 80860F0E:00: num_chipselect = 2
[    6.182928] pxa2xx-spi 80860F0E:00: IRQ 194
[    6.183049] pxa2xx-spi 80860F0E:00: no DMA channels available, using PIO
[    6.183111] pxa2xx-spi 80860F0E:00: registered master spi32766 (dynamic)
[    6.192761] spi spi-WM510205:00: 8333333 Hz actual, PIO
.... the rest of the dmesg is currently the same....


Q:  this thread is about the patch for the pxa2xx-spi where the
num_chipselect was raised by one to so that the slave connects here at
all. otherwise the cs1 >= max will be hit.
Do you think the bus_number is ok ?
And shouldn't it be set the cs1=0 and num_chipselect=1  ??

The DSDT has wrongly SPI=1 as chipselect,  either the firmware (DSDT)
must be updated or a correct patch enables the spi master/slave init
here.

I hope or expect that when the spi slave will be init correctly, that
the device would also work.
The ACPI stuff is already done here, and I am running out of time.

In the last resort I have to give up or have to do that at night :)

cheers
chris
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
