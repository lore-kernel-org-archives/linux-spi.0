From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/4] spi: fsl-espi: eliminate linearization into intermediate
 buffer
Date: Fri, 25 Nov 2016 23:58:33 +0100
Message-ID: <a787765f-9d18-c062-60ef-21a72bc27e49@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Currently all transfers are copied into an intermediate buffer first,
and then written to the hardware from this buffer.

This patch set implements direct transfers between transfer buffers
and hardware, and it allows to get rid of the 64k intermediate buffer.

Heiner Kallweit (4):
  spi: fsl-espi: determine need for byte swap only once
  spi: fsl-espi: eliminate need for linearization when writing to hardware
  spi: fsl-espi: eliminate need for linearization when reading from hardware
  spi: fsl-espi: remove unused linearization code

 drivers/spi/spi-fsl-espi.c | 240 +++++++++++++++++++++++++--------------------
 1 file changed, 132 insertions(+), 108 deletions(-)

-- 
2.10.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
