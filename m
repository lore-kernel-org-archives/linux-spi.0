From: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v4 0/2] spi: atmel: add support to FIFOs and the internal chip-select
Date: Tue, 16 Jun 2015 12:09:29 +0200
Message-ID: <cover.1434448837.git.cyrille.pitchen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	<devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	<pawel.moll-5wv7dgnIgG8@public.gmane.org>, <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	<ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
To: <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	<linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

ChangeLog

v4:
- remove the chip-select patch from the series as it has already been applied
- reword the commit message of the DT bindings patch to better explain why we
  use a new DT property, "atmel,fifo-size" instead of relying on the VERSION
  register or the "compatible" string.
- reword the commit message of the actual FIFO patch to better explain what
  are the MULTIPLE and SINGLE data modes and how to use them properly.
- add Acked-by: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>

v3:
- replace "Alternative Command Mode" by "Chip Select Active After Transfer" in
  the DT bindings documentation. The "Alternative Command Mode" is a feature of
  the I2C controller.
- rename somes "size" variables to "num_data" to ease the distinction between
  the number of bytes and the number of data to transfer.

v2:
- read the Status Register to clear its RX FIFO Threshold Flag (RXFTHF) before
  writing into the IER to enable the RXFTHF interrupt.
- remove the reset of the FIFO Mode Register (FMR) at the end of transfers
  because setting the RX FIFO Threshold to 0 also sets the RXFTHF bit in SR.
- add a 3rd patch in the series to update the documentation of DT bindings.

v1:
This series of patches add support to features introduced by the Atmel sama5d2x
SoC

Cyrille Pitchen (2):
  spi: atmel: update DT bindings documentation
  spi: atmel: add support to FIFOs

 .../devicetree/bindings/spi/spi_atmel.txt          |   8 +-
 drivers/spi/spi-atmel.c                            | 255 ++++++++++++++++++++-
 2 files changed, 252 insertions(+), 11 deletions(-)

-- 
1.8.2.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
