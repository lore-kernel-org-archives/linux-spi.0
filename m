From: <jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH linux-next v2 0/1] improve imx spi performance
Date: Mon, 1 May 2017 03:31:43 -0700
Message-ID: <1493634704-3545-1-git-send-email-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Jiada Wang <jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
To: <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Jiada Wang <jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>

previously burst length (BURST_LENGTH) is always set to equal
to bits_per_word, causes a 10us gap between each word in transfer,
which significantly affects performance.

This patch set uses 32 bits tranfser to simulate lowers bits transfer,
and by set burst length to maximum possible value to reduce number of gaps
in PIO transfers.

Jiada Wang (1):
  spi: imx: dynamic burst length adjust for PIO mode

Changes from v2:
  used cpu_to_* functions, to ensure this patch works for both
  little & big endian kernel.
  other minor fix.

 drivers/spi/spi-imx.c | 157 +++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 149 insertions(+), 8 deletions(-)

-- 
2.7.4


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
