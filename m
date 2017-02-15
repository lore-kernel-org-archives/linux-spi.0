From: DongCV <cv-dong-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>
Subject: [PATCH 0/2 v4] spi: rspi: Fixes bogus received byte and replaces "n" by "len"
Date: Wed, 15 Feb 2017 19:50:50 +0900
Message-ID: <1487155852-12102-1-git-send-email-cv-dong@jinso.co.jp>
Cc: kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org,
        ryusuke.sakato.bx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        nv-dung-HEF513clHfp3+QwDJ9on6Q@public.gmane.org, h-inayoshi-HEF513clHfp3+QwDJ9on6Q@public.gmane.org, cm-hiep-HEF513clHfp3+QwDJ9on6Q@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mark,
Cc: Geert, Sergei

Thanks for your comments and advices.

I separated my patch into two patches as you've shown me.
These patches fix: 3be09bec42a800d4 "spi: rspi: supports 32bytes 
buffer for DUAL and QUAD". One of them is to fix bogus received byte 
into qspi_transfer_in(), and other is to replace "n" by "len" bytes of 
data in qspi_transfer_in()and qspi_transfer_out().
These patches were tested at v4.10-rc8 on Renesas Gen2 Lager board.

Please consider these patches to Renesas Rcar family.
Thank you.
Jinso/Dong.

DongCV (2):
  spi: rspi: Fixes bogus received byte in qspi_transfer_in()
  spi: rspi: Replaces "n" by "len" in qspi_transfer_in() and
    qspi_transfer_out()

 drivers/spi/spi-rspi.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
