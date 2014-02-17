From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [PATCH] spi: core: Fix Oops in spi_pump_messages error path
Date: Mon, 17 Feb 2014 18:20:37 +0100
Message-ID: <1392657637-5297-1-git-send-email-maxime.ripard@free-electrons.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	kevin.z.m.zh@gmail.com, sunny@allwinnertech.com,
	shuge@allwinnertech.com, zhuzhenhua@allwinnertech.com,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	stable@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

When the generic implementation of the transfer_one_message callback was called
by the spi_pump_messages function, if that transfer was to fail, the
spi_finalize_current_message was called twice, once in
spi_transfer_one_message, and one in spi_pump_messages.

This was causing a null pointer dereference in the second call, because the
first one set the ->cur_msg field to NULL.

Since the SPI framework expect the transfer_one_message callback to call
spi_finalize_current_message, we can remove it from spi_pump_messages, together
with any dereference of the ->cur_msg pointer.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: stable@vger.kernel.org
---
 drivers/spi/spi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 23756b0..39f12be 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -756,8 +756,6 @@ static void spi_pump_messages(struct kthread_work *work)
 	if (ret) {
 		dev_err(&master->dev,
 			"failed to transfer one message from queue: %d\n", ret);
-		master->cur_msg->status = ret;
-		spi_finalize_current_message(master);
 		return;
 	}
 }
-- 
1.8.4.2
