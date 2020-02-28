From: John Garry <john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH RFC 0/3] spi/HiSilicon v3xx: Support dual and quad mode through DMI quirks
Date: Fri, 28 Feb 2020 23:18:48 +0800
Message-ID: <1582903131-160033-1-git-send-email-john.garry@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, <linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>,
        John Garry <john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
To: <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

As discussed during the original HiSilicon v3xx SPI driver upstreaming,
currently there is no method for the ACPI SPI Serial Bus Connection
Resource Descriptor to define the data buswidth [0], [1].

So we can look to get the ACPI spec updated for this, and I have
submitted a proposal for a new feature here:
https://bugzilla.tianocore.org/show_bug.cgi?id=2557

However I am not sure how successful that will be.

In the meantime, as an alternate approach, this RFC proposes to allow the
SPI controller driver override the device buswidth. In this example,
the driver uses DMI quirks to discover the host machine and set the 
buswidth override accordingly when the machine is known to support
dual or quad mode of operation.

I also have included a fix for dual and quad modes in the driver.

Comments welcome. thanks.

[0] https://lore.kernel.org/linux-mtd/20200109212842.GK3702-GFdadSzt00ze9xe1eoZjHA@public.gmane.org/
[1] https://uefi.org/sites/default/files/resources/ACPI_6_3_final_Jan30.pdf, 
     19.6.126

John Garry (3):
  spi: Allow SPI controller override device buswidth
  spi: HiSilicon v3xx: Properly set CMD_CONFIG for Dual/Quad modes
  spi: HiSilicon v3xx: Use DMI quirk to set controller buswidth override
    bits

 drivers/spi/spi-hisi-sfc-v3xx.c | 99 ++++++++++++++++++++++++++++++++-
 drivers/spi/spi.c               |  4 +-
 include/linux/spi/spi.h         |  3 +
 3 files changed, 104 insertions(+), 2 deletions(-)

-- 
2.17.1
