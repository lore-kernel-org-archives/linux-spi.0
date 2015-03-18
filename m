From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH] spi: trigger trace event for message-done before mesg->complete
Date: Wed, 18 Mar 2015 11:27:28 +0100
Message-ID: <1426674448-8246-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

With spidev the mesg->complete callback points to spidev_complete.
Calling this unblocks spidev_sync and so spidev_sync_write finishes. As
the struct spi_message just read is a local variable in
spidev_sync_write and recording the trace event accesses this message
the recording is better done first. The same can happen for
spidev_sync_read.

This fixes an oops observed on a 3.14-rt system with spidev activity
after

	echo 1 > /sys/kernel/debug/tracing/events/spi/enable

=2E

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
 drivers/spi/spi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 6d3b9b76c80b..df577518b770 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -994,13 +994,14 @@ void spi_finalize_current_message(struct spi_mast=
er *master)
 				"failed to unprepare message: %d\n", ret);
 		}
 	}
+
+	trace_spi_message_done(mesg);
+
 	master->cur_msg_prepared =3D false;
=20
 	mesg->state =3D NULL;
 	if (mesg->complete)
 		mesg->complete(mesg->context);
-
-	trace_spi_message_done(mesg);
 }
 EXPORT_SYMBOL_GPL(spi_finalize_current_message);
=20
--=20
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
