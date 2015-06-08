From: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 0/3] spi: atmel: add support to FIFOs and the internal chip-select
Date: Mon, 8 Jun 2015 18:07:41 +0200
Message-ID: <cover.1433779081.git.cyrille.pitchen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	<devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	<pawel.moll-5wv7dgnIgG8@public.gmane.org>, <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	<ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
To: <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

ChangeLog

v2:
- read the Status Register to clear its RX FIFO Threshold Flag (RXFTHF) before
  writing into the IER to enable the RXFTHF interrupt.
- remove the reset of the FIFO Mode Register (FMR) at the end of transfers
  because setting the RX FIFO Threshold to 0 also sets the RXFTHF bit in SR.
- add a 3rd patch in the series to update the documentation of DT bindings.

v1:
This series of patches add support to features introduced by the Atmel sama5d2x
SoC

Cyrille Pitchen (3):
  spi: atmel: add support for the internal chip-select of the spi
    controller
  spi: atmel: update DT bindings documentation
  spi: atmel: add support to FIFOs

 .../devicetree/bindings/spi/spi_atmel.txt          |   8 +-
 drivers/spi/spi-atmel.c                            | 276 +++++++++++++++++++--
 2 files changed, 264 insertions(+), 20 deletions(-)

-- 
1.8.2.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
