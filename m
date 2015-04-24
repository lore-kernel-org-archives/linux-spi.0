From: Cao Minh Hiep <cm-hiep-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>
Subject: [PATCH 0/1] spi: Re-do correctly function name and 'ret' return value
Date: Fri, 24 Apr 2015 15:40:55 +0900
Message-ID: <1429857656-8348-1-git-send-email-cm-hiep@jinso.co.jp>
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

This is patch to re-do correctly function name and 'ret' return value.
qspi_trigger_transfer_out_int function should be qspi_trigger_transfer_out_in
without "t". "ret" value in rspi_dma_check_then_transfer should be returned
insteeds of returning zero. It just returns qspi_trigger_transfer_out_in() value
in qspi_transfer_out_in().
This patch has been tested at linux Upstream v4.0.0-10712-g27cf3a1 on Lager.
Please consider the following patches for the Rcar-Gen2.

Best Regards,
Cao Minh Hiep

Hiep Cao Minh (1):
  spi: Re-do correctly function name and 'ret' return value

 drivers/spi/spi-rspi.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
