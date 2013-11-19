From: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
Subject: [PATCHv2 0/2] spi/qspi: Fix remove path and miscellaneous cleanup.
Date: Tue, 19 Nov 2013 18:37:14 +0530
Message-ID: <1384866436-11542-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
To: <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch series fix remove path and did a miscellaneous
cleanup in pm_runtime error check.

Tested on DRA7 board.

Reabsed on Mark Brown tree, branch: topic/qspi.

v1->v2:
- split the patches
- Document the bug fixed.

Sourav Poddar (2):
  spi/qspi: cleanup pm_runtime error check.
  spi/qspi: Fix qspi remove path.

 drivers/spi/spi-ti-qspi.c |   20 ++++++++++++++++++--
 1 files changed, 18 insertions(+), 2 deletions(-)

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
