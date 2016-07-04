From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v1 0/4] spi: pxa2xx-pci: Enable on Intel Merrifield
Date: Mon,  4 Jul 2016 12:44:23 +0300
Message-ID: <1467625467-103785-1-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The series refactors a bit PCI glue driver in order to add support for SPI
controllers found on Intel Merrifield SoC.

Andy Shevchenko (4):
  spi: pxa2xx-pci: Do a specific setup in a separate function
  spi: pxa2xx-pci: Enable SPI on Intel Merrifield
  spi: pxa2xx-pci: Remove unused code
  spi: pxa2xx-pci: Sort header block alphabetically

 drivers/spi/spi-pxa2xx-pci.c | 122 ++++++++++++++++++++++++++++---------------
 1 file changed, 79 insertions(+), 43 deletions(-)

-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
