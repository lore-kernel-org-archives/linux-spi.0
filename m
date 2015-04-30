From: Cao Minh Hiep <cm-hiep-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>
Subject: [PATCH 0/1 v2] spi: Re-do the returning value of rspi_dma_check_then_transfer
Date: Thu, 30 Apr 2015 11:12:11 +0900
Message-ID: <1430359932-13245-1-git-send-email-cm-hiep@jinso.co.jp>
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org,
	ryusuke.sakato.bx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Hiep Cao Minh <cm-hiep-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>

Hi Mark
Hi Geert

This is version 2 of spi-Re-do-the-returning-value-of-rspi_dma_check_then_transfer patch.
I have tested it at linux Upstream Linux-4.0.0-10713-g6e24fd1 on Lager and Koelsch.
To reduce indentation and complexity of code, drop "ret" then function 
rspi_dma_check_then_transfer should be returning rspi_dma_transfer directly
after checking error.
Please consider the following patch for the Rcar-Gen2.

Hiep Cao Minh (1):
  spi: Re-do the returning value of rspi_dma_check_then_transfer

 drivers/spi/spi-rspi.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
