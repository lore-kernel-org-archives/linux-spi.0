From: Cao Minh Hiep <cm-hiep@jinso.co.jp>
Subject: [PATCH 0/1] ARM: spi supports 32bytes buffer for DUAL and QUAD
Date: Fri,  4 Nov 2016 17:38:53 +0900
Message-ID: <1478248734-32044-1-git-send-email-cm-hiep@jinso.co.jp>
Cc: kuninori.morimoto.gx@renesas.com, yoshihiro.shimoda.uh@renesas.com,
        ryusuke.sakato.bx@renesas.com, linux-renesas-soc@vger.kernel.org,
        nv-dung@jinso.co.jp, h-inayoshi@jinso.co.jp
To: broonie@kernel.org, geert+renesas@glider.be,
        linux-spi@vger.kernel.org
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Hiep Cao Minh <cm-hiep@jinso.co.jp>

Hi,

This patch will improve the DUAL and QUAD's performance of SPI,
that supported for GEN2 r8a7790 SOC in PIO mode. 
It sends/receives each 32bytes of data instead of each byte data 
as current situation.

This patch was developed based on the Mainline v4.9-rc3 and have 
tested on the Lager board.

Please consider the following patches for the r8a7790 Soc.

Thank you!

Cao Minh Hiep

Hiep Cao Minh (1):
  ARM:spi supports 32bytes buffer for DUAL and QUAD

 drivers/spi/spi-rspi.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 49 insertions(+), 3 deletions(-)

-- 
1.9.1
