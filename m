From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] spi: Always check complete callback before calling it
Date: Wed, 02 Apr 2014 22:21:04 +0800
Message-ID: <1396448464.8891.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Hou Zhiqiang <b48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>,
	Gerhard Sittig <gsi-ynQEQJNshbs@public.gmane.org>,
	Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>,
	Atsushi Nemoto <anemo-7JcRY8pycbNHfZP73Gtkiw@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Since commit 1e25cd4729bd "spi: Do not require a completion", this checking is
required to prevent NULL pointer dereference.

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-fsl-espi.c    | 3 ++-
 drivers/spi/spi-fsl-spi.c     | 3 ++-
 drivers/spi/spi-mpc512x-psc.c | 3 ++-
 drivers/spi/spi-mpc52xx-psc.c | 3 ++-
 drivers/spi/spi-mpc52xx.c     | 6 ++++--
 drivers/spi/spi-sh.c          | 6 ++++--
 drivers/spi/spi-txx9.c        | 3 ++-
 7 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index 6fb2b75..e767f58 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -441,7 +441,8 @@ static void fsl_espi_do_one_msg(struct spi_message *m)
 
 	m->actual_length = espi_trans.actual_length;
 	m->status = espi_trans.status;
-	m->complete(m->context);
+	if (m->complete)
+		m->complete(m->context);
 }
 
 static int fsl_espi_setup(struct spi_device *spi)
diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
index f35488e..b3e7775 100644
--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -408,7 +408,8 @@ static void fsl_spi_do_one_msg(struct spi_message *m)
 	}
 
 	m->status = status;
-	m->complete(m->context);
+	if (m->complete)
+		m->complete(m->context);
 
 	if (status || !cs_change) {
 		ndelay(nsecs);
diff --git a/drivers/spi/spi-mpc512x-psc.c b/drivers/spi/spi-mpc512x-psc.c
index 3822eef..577d23a 100644
--- a/drivers/spi/spi-mpc512x-psc.c
+++ b/drivers/spi/spi-mpc512x-psc.c
@@ -300,7 +300,8 @@ static int mpc512x_psc_spi_msg_xfer(struct spi_master *master,
 	}
 
 	m->status = status;
-	m->complete(m->context);
+	if (m->complete)
+		m->complete(m->context);
 
 	if (status || !cs_change)
 		mpc512x_psc_spi_deactivate_cs(spi);
diff --git a/drivers/spi/spi-mpc52xx-psc.c b/drivers/spi/spi-mpc52xx-psc.c
index 3d18d93..de532aa 100644
--- a/drivers/spi/spi-mpc52xx-psc.c
+++ b/drivers/spi/spi-mpc52xx-psc.c
@@ -247,7 +247,8 @@ static void mpc52xx_psc_spi_work(struct work_struct *work)
 		}
 
 		m->status = status;
-		m->complete(m->context);
+		if (m->complete)
+			m->complete(m->context);
 
 		if (status || !cs_change)
 			mpc52xx_psc_spi_deactivate_cs(spi);
diff --git a/drivers/spi/spi-mpc52xx.c b/drivers/spi/spi-mpc52xx.c
index aac2a5d..b07db4b 100644
--- a/drivers/spi/spi-mpc52xx.c
+++ b/drivers/spi/spi-mpc52xx.c
@@ -234,7 +234,8 @@ static int mpc52xx_spi_fsmstate_transfer(int irq, struct mpc52xx_spi *ms,
 		dev_err(&ms->master->dev, "mode fault\n");
 		mpc52xx_spi_chipsel(ms, 0);
 		ms->message->status = -EIO;
-		ms->message->complete(ms->message->context);
+		if (ms->message->complete)
+			ms->message->complete(ms->message->context);
 		ms->state = mpc52xx_spi_fsmstate_idle;
 		return FSM_CONTINUE;
 	}
@@ -288,7 +289,8 @@ mpc52xx_spi_fsmstate_wait(int irq, struct mpc52xx_spi *ms, u8 status, u8 data)
 		ms->msg_count++;
 		mpc52xx_spi_chipsel(ms, 0);
 		ms->message->status = 0;
-		ms->message->complete(ms->message->context);
+		if (ms->message->complete)
+			ms->message->complete(ms->message->context);
 		ms->state = mpc52xx_spi_fsmstate_idle;
 		return FSM_CONTINUE;
 	}
diff --git a/drivers/spi/spi-sh.c b/drivers/spi/spi-sh.c
index f6f2c70..03edf5e 100644
--- a/drivers/spi/spi-sh.c
+++ b/drivers/spi/spi-sh.c
@@ -322,7 +322,8 @@ static void spi_sh_work(struct work_struct *work)
 		spin_lock_irqsave(&ss->lock, flags);
 
 		mesg->status = 0;
-		mesg->complete(mesg->context);
+		if (mesg->complete)
+			mesg->complete(mesg->context);
 	}
 
 	clear_fifo(ss);
@@ -340,7 +341,8 @@ static void spi_sh_work(struct work_struct *work)
 
  error:
 	mesg->status = ret;
-	mesg->complete(mesg->context);
+	if (mesg->complete)
+		mesg->complete(mesg->context);
 
 	spi_sh_clear_bit(ss, SPI_SH_SSA | SPI_SH_SSDB | SPI_SH_SSD,
 			 SPI_SH_CR1);
diff --git a/drivers/spi/spi-txx9.c b/drivers/spi/spi-txx9.c
index 820b499..5f183ba 100644
--- a/drivers/spi/spi-txx9.c
+++ b/drivers/spi/spi-txx9.c
@@ -262,7 +262,8 @@ static void txx9spi_work_one(struct txx9spi *c, struct spi_message *m)
 
 exit:
 	m->status = status;
-	m->complete(m->context);
+	if (m->complete)
+		m->complete(m->context);
 
 	/* normally deactivate chipselect ... unless no error and
 	 * cs_change has hinted that the next message will probably
-- 
1.8.3.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
