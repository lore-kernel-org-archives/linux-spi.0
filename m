From: Nobuteru Hayashi <hayashi.nbb-MBed0sS7vigTBYAz+LHnZg@public.gmane.org>
Subject: [PATCH 0/3] fix infinite loops and worker task hang up
Date: Fri, 18 Mar 2016 11:35:21 +0000
Message-ID: <59EFBE2126ED0E4AA25DF57320AFF129051FE3A9@BPXM14GP.gisp.nec.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Language: ja-JP
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hello,

Fix infinite loops on fsl_espi_cpu_irq().
 - spin forever on SPIE_RXCNT
 - infinite loops on while (tmp--)

Fix worker task hang up that is caused by waiting transaction
completion forever on wait_for_completion().

Best regards,
Nobu

Nobuteru Hayashi (3):
  spi/fsl-espi: Don't spin forever on SPIE_RXCNT
  spi/fsl-espi: avoid infinite loops on fsl_espi_cpu_irq()
  spi/fsl-espi: Don't wait transaction completion forever

 drivers/spi/spi-fsl-espi.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

-- 
1.9.1
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
