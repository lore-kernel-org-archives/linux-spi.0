From: <jiada_wang@mentor.com>
Subject: [PATCH linux-next v2 0/2] follow up fix patch for dynamic burst
Date: Tue, 23 May 2017 07:35:27 -0700
Message-ID: <1495550129-3489-1-git-send-email-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jiada Wang <jiada_wang@mentor.com>
To: <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Jiada Wang <jiada_wang@mentor.com>

v1:
only allow to use dynamic burst in PIO mode, to address the issue
reported by Fabio

v2:
add one more patch to avoid direct manipulation of tx_buf,
to address the issue reported by Sascha

Jiada Wang (2):
  spi: imx: only allow dynamic burst in PIO mode
  spi: imx: don't manipulate trasnfer buffer directly

 drivers/spi/spi-imx.c | 84 ++++++++++++++++++++++++---------------------------
 1 file changed, 39 insertions(+), 45 deletions(-)

-- 
2.7.4
