From: Cao Minh Hiep <cm-hiep@jinso.co.jp>
Subject: [PATCH 0/3 v2] spi: Re-do correctly function name and 'ret' return value
Date: Tue, 28 Apr 2015 14:55:48 +0900
Message-ID: <1430200551-20708-1-git-send-email-cm-hiep@jinso.co.jp>
Cc: broonie@kernel.org, linux-spi@vger.kernel.org,
	kuninori.morimoto.gx@renesas.com, yoshihiro.shimoda.uh@renesas.com,
	ryusuke.sakato.bx@renesas.com, linux-sh@vger.kernel.org
To: geert+renesas@glider.be
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Hiep Cao Minh <cm-hiep@jinso.co.jp>

Hi Mark
Hi Geert

I have splitted the patch that I sent you last week in 3 separate patches.
To re-do correctly function name and returning value.
qspi_trigger_transfer_out_int function should be qspi_trigger_transfer_out_in
without "t". 
To reduce indentation and complex of code, drop "ret" then function 
rspi_dma_check_then_transfer should be returned rspi_dma_transfer directly
after checking error.
And It just returns the value of qspi_trigger_transfer_out_in() in qspi_transfer_out_in().
These patches has been tested at linux Upstream v4.0.0-10712-g27cf3a1 on Lager.
Please consider the following patches for the Rcar-Gen2.

Hiep Cao Minh (3):
  spi: Re-do the returning value of rspi_dma_check_then_transfer
  spi: modify the name of qspi_trigger_transfer_out_int function
  spi: Re-do the returning value of qspi_transfer_out_in

 drivers/spi/spi-rspi.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

-- 
1.9.1

