From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: [PATCH] spi: fix race freeing dummy_tx/rx before it is unmapped
Date: Sun, 10 May 2015 07:50:45 +0000
Message-ID: <1431244245-2880-1-git-send-email-kernel@martin.sperl.org>
References: <20150508221309.GK2761@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
To: =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf-L59+Z2yzLopAfugRpC6u6w@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150508221309.GK2761-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

=46rom: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

=46ix a race (with some kernel configurations) where a queued
master->pump_messages runs and frees dummy_tx/rx before
spi_unmap_msg is running (or is finished).

This results in the following messages:
  BUG: Bad page state in process
  page:db7ba030 count:0 mapcount:0 mapping:  (null) index:0x0
  flags: 0x200(arch_1)
  page dumped because: PAGE_FLAGS_CHECK_AT_PREP flag set
  ...

Reported-by: Noralf Tr=C3=B8nnes <noralf-L59+Z2yzLopAfugRpC6u6w@public.gmane.org>
Suggested-by: Noralf Tr=C3=B8nnes <noralf-L59+Z2yzLopAfugRpC6u6w@public.gmane.org>
Tested-by: Noralf Tr=C3=B8nnes <noralf-L59+Z2yzLopAfugRpC6u6w@public.gmane.org>

Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
---
 drivers/spi/spi.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

Note that I am not 100% sure if the spinlock is really needed to read
cur_msg, but as it was there I left it as is and just moved the
scheduling and assignments down after sg_unmap and unprepare_message.

Noralf also sugested removing the first locking and my testing shows
that I was unable to trigger any issues with locking removed for the
assignemnt of mesg but there still may be a possibilty...

Also note that if you leave cur_message =3D NULL assignement on top, th=
en
there is another race were other drivers submitting spi_messages and th=
us
triggering spi_pump while we still are cleaning up the old message.
This is because pump_message stops if it finds cur_message to be still
asigned.

Tested with the following devices on the same bus and all active:
* 2x mcp2515
* 1x enc28j60
* 1x fb_st7735r

Communication on reporting/testing by Noralf can get reviewed at:
https://github.com/raspberrypi/linux/issues/959#issuecomment-100391599 =
and
https://github.com/msperl/spi-bcm2835/issues/13#issuecomment-87210385

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 50910d8..d35c1a1 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -988,9 +988,6 @@ void spi_finalize_current_message(struct spi_master=
 *master)
=20
 	spin_lock_irqsave(&master->queue_lock, flags);
 	mesg =3D master->cur_msg;
-	master->cur_msg =3D NULL;
-
-	queue_kthread_work(&master->kworker, &master->pump_messages);
 	spin_unlock_irqrestore(&master->queue_lock, flags);
=20
 	spi_unmap_msg(master, mesg);
@@ -1003,9 +1000,13 @@ void spi_finalize_current_message(struct spi_mas=
ter *master)
 		}
 	}
=20
-	trace_spi_message_done(mesg);
-
+	spin_lock_irqsave(&master->queue_lock, flags);
+	master->cur_msg =3D NULL;
 	master->cur_msg_prepared =3D false;
+	queue_kthread_work(&master->kworker, &master->pump_messages);
+	spin_unlock_irqrestore(&master->queue_lock, flags);
+
+	trace_spi_message_done(mesg);
=20
 	mesg->state =3D NULL;
 	if (mesg->complete)
--=20
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
