From: Jiada Wang <jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH linux-next v1 0/2] improve imx spi performance
Date: Wed, 8 Feb 2017 15:20:26 +0900
Message-ID: <20170208062028.22313-1-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        <fixed-term.Oleksij.Rempel-V5te9oGctAVWk0Htik3J/w@public.gmane.org>, <jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
To: <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

previously burst length (BURST_LENGTH) is always set to equal
to bits_per_word, causes a 10us gap between each word in transfer,
which significantly affects performance.

This patch set uses 32 bits tranfser to simulate lowers bits transfer,
and by set burst length to maximum possible value to reduce number of gaps
in both PIO & DMA transfers.

* This patch set is against linux-next tree

Jiada Wang (2):
  spi: imx: dynamic burst length adjust for PIO mode
  spi: imx: dynamic burst length adjust for DMA mode

 drivers/spi/spi-imx.c | 293 +++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 267 insertions(+), 26 deletions(-)

-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
