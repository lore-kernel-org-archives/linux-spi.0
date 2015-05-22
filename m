From: Cao Minh Hiep <cm-hiep@jinso.co.jp>
Subject: [PATCH 0/2 v3] spi: Re-do correctly function name and return value
Date: Fri, 22 May 2015 18:59:35 +0900
Message-ID: <1432288777-7229-1-git-send-email-cm-hiep@jinso.co.jp>
Cc: kuninori.morimoto.gx@renesas.com, yoshihiro.shimoda.uh@renesas.com,
	ryusuke.sakato.bx@renesas.com, linux-sh@vger.kernel.org
To: broonie@kernel.org, geert+renesas@glider.be,
	linux-spi@vger.kernel.org
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Hiep Cao Minh <cm-hiep@jinso.co.jp>

Hi Mark-san,

I added "Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>" in two patches.
Please consider the following patches for the Rcar-Gen2.

Best Regards,
Cao Minh Hiep.

Hiep Cao Minh (2):
  spi: modify the name of "qspi_trigger_transfer_out_int" function
  spi: Re-do the returning value of qspi_transfer_out_in

 drivers/spi/spi-rspi.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

-- 
1.9.1

