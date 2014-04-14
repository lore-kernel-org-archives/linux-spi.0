From: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/5] spi : sirf: some chip-select, DMA and checkpatch fixes
Date: Mon, 14 Apr 2014 14:29:56 +0800
Message-ID: <1397457001-5266-1-git-send-email-21cnbao@gmail.com>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, workgroup.linux-kQvG35nSl+M@public.gmane.org,
	Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>

this patchset fixes some IO transferring issues and fixes checkpatch issues.

Qipan Li (5):
  spi: sirf: correct TXFIFO empty interrupt status bit
  spi: sirf: set SPI controller in RISC IO chipselect mode
  spi: sirf: make GPIO chipselect function work well
  spi: sirf: fix line over 80 characters style issue
  spi: sirf: fix spi full-duplex DMA transferring issue

 drivers/spi/spi-sirf.c |   74 +++++++++++++++++++++++++++++++++--------------
 1 files changed, 52 insertions(+), 22 deletions(-)

-- 
1.7.5.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
