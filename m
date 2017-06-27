From: Varadarajan Narayanan <varada-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH v4 00/14] spi: qup: Fixes and add support for >64k transfers
Date: Tue, 27 Jun 2017 15:15:17 +0530
Message-ID: <1498556731-13087-1-git-send-email-varada@codeaurora.org>
Cc: Varadarajan Narayanan <varada-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org,
        andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, david.brown-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

v4:
	Discard patch #15, 'spi: qup: support for qup v1 dma'.
	This depends on ADM driver, which is not upstreamed yet.

v3:
	Fix git bisect-ability issues in
		spi: qup: Add completion structures for DMA
		spi: qup: Add completion timeout
		spi: qup: Place the QUP in run mode before DMA
		spi: qup: Fix transaction done signaling

v2:
	Incorporate feedback from Andy Gross, Sricharan, Stanimir Varbanov

	Modified the QUP-v1 dma completion sequence to QUP-v2 as per feedback.

	Removed code that used controller->xfer to identify extra interrupts,
	since with the fixes done to handle i/o completion we don't see
	extra interrupts.

v1:
	This series fixes some existing issues in the code for both
	interrupt and dma mode. Patches 1 - 11 are the fixes.
	Random failures/timeout are observed without these fixes.
	Also, the current driver does not support block transfers > 64K
	and the driver quietly fails. Patches 12 - 18 add support for this
	in both interrupt and dma mode.

	The entire series has been tested on ipq4019 with
	SPI-NOR flash for block sizes > 64k.

Varadarajan Narayanan (14):
  spi: qup: Enable chip select support
  spi: qup: Setup DMA mode correctly
  spi: qup: Add completion structures for DMA
  spi: qup: Add completion timeout
  spi: qup: Place the QUP in run mode before DMA
  spi: qup: Fix error handling in spi_qup_prep_sg
  spi: qup: Fix transaction done signaling
  spi: qup: Do block sized read/write in block mode
  spi: qup: refactor spi_qup_io_config into two functions
  spi: qup: call io_config in mode specific function
  spi: qup: allow block mode to generate multiple transactions
  spi: qup: refactor spi_qup_prep_sg
  spi: qup: allow multiple DMA transactions per spi xfer
  spi: qup: Ensure done detection

 drivers/spi/spi-qup.c | 597 ++++++++++++++++++++++++++++++++++----------------
 1 file changed, 408 insertions(+), 189 deletions(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
