From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 16/17] spi/topcliff-pch: Delete an error message for a failed
 memory allocation in pch_spi_set_tx()
Date: Fri, 13 Jan 2017 18:27:23 +0100
Message-ID: <b72c78dc-32b2-0f8f-8d3d-575ce4bff02f@users.sourceforge.net>
References: <1413e173-dbac-7a6e-09cb-2287300a335e@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>
To: linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <1413e173-dbac-7a6e-09cb-2287300a335e@users.sourceforge.net>
Sender: kernel-janitors-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 13 Jan 2017 17:00:08 +0100

Omit an extra message for a memory allocation failure in this function.

Link: http://events.linuxfoundation.org/sites/events/files/slides/LCJ16-Refactor_Strings-WSang_0.pdf
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/spi/spi-topcliff-pch.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-topcliff-pch.c b/drivers/spi/spi-topcliff-pch.c
index d36d42653087..97fd1ea9826b 100644
--- a/drivers/spi/spi-topcliff-pch.c
+++ b/drivers/spi/spi-topcliff-pch.c
@@ -590,7 +590,6 @@ static void pch_spi_set_tx(struct pch_spi_data *data, int *bpw)
 
 	if (!data->pkt_rx_buff) {
 		/* flush queue and set status of all transfers to -ENOMEM */
-		dev_err(&data->master->dev, "%s :kzalloc failed\n", __func__);
 		list_for_each_entry_safe(pmsg, tmp, data->queue.next, queue) {
 			pmsg->status = -ENOMEM;
 
-- 
2.11.0

