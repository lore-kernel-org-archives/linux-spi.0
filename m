From: Lubomir Rintel <lkundrak-NGH9Lh4a5iE@public.gmane.org>
Subject: [PATCH] spi: pxa2xx: Avoid touching SSCR0_SSE on MMP2
Date: Sat, 18 Jan 2020 10:40:31 +0100
Message-ID: <20200118094031.327373-1-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Cc: Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
        Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
        linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lubomir Rintel <lkundrak-NGH9Lh4a5iE@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

A read from a Winbond W25Q32FV SPI NOR memory chip on my MMP2 returns
wrong data.

It seems like SSE doesn't do the right thing on MMP2 at all. After
enabling the SPI port back again, the FIFO reads return garbage. Things
can be brought back to order by telling the PMU to reset the block.

Here's a good transaction with said chip:

  # busybox devmem 0xd4035000 32 0x00001987 # SSCR0
  # echo 0 >/sys/class/gpio/gpio46/value    # (assert CS)
  # busybox devmem 0xd4035010 32 0x0000009f # SSDR (read ID command)
  # busybox devmem 0xd4035010 32 0x00000000 # SSDR
  # busybox devmem 0xd4035010 32 0x00000000 # SSDR
  # busybox devmem 0xd4035010 32 0x00000000 # SSDR
  # busybox devmem 0xd4035010 32 0x00000000 # SSDR
  # busybox devmem 0xd4035010 32 0x00000000 # SSDR
  # busybox devmem 0xd4035010 32 0x00000000 # SSDR
  # busybox devmem 0xd4035010               # SSDR
  0x000000ff
  # busybox devmem 0xd4035010               # SSDR
  0x000000ef                                # Correct response
  # busybox devmem 0xd4035010               # SSDR
  0x00000040
  # busybox devmem 0xd4035010               # SSDR
  0x00000016
  # busybox devmem 0xd4035010               # SSDR
  0x00000000
  # busybox devmem 0xd4035010               # SSDR
  0x00000000
  # busybox devmem 0xd4035010               # SSDR
  0x00000000
  # echo 1 >/sys/class/gpio/gpio46/value # (deassert CS)
  #

Flipping off an on SSE, then running another transaction:

  # busybox devmem 0xd4035000 32 0x00001907 # SSCR0, SSE off
  # busybox devmem 0xd4035000 32 0x00001987 # SSCR0, SSE on
  # echo 0 >/sys/class/gpio/gpio46/value    # (assert CS)
  # busybox devmem 0xd4035010 32 0x0000009f # SSDR (read ID command)
  # busybox devmem 0xd4035010 32 0x00000000 # SSDR
  # busybox devmem 0xd4035010 32 0x00000000 # SSDR
  # busybox devmem 0xd4035010 32 0x00000000 # SSDR
  # busybox devmem 0xd4035010 32 0x00000000 # SSDR
  # busybox devmem 0xd4035010 32 0x00000000 # SSDR
  # busybox devmem 0xd4035010 32 0x00000000 # SSDR
  # busybox devmem 0xd4035010               # SSDR
  0x000000ff
  # busybox devmem 0xd4035010               # SSDR
  0x000000ff                                # Garbage!
  # busybox devmem 0xd4035010               # SSDR
  0x000000ff                                # Oh no
  # busybox devmem 0xd4035010               # SSDR
  0x000000ff
  # busybox devmem 0xd4035010               # SSDR
  0x000000ff
  # busybox devmem 0xd4035010               # SSDR
  0x000000ff
  # busybox devmem 0xd4035010               # SSDR
  0x000000ff
  # echo 1 >/sys/class/gpio/gpio46/value # (deassert CS)
  #

Sometimes the response is not just ones, but something that looks like
bits of a response from a previous transaction.

I can't see a fix other than not touching the SSE altogether after the
device is first brought up.

Signed-off-by: Lubomir Rintel <lkundrak-NGH9Lh4a5iE@public.gmane.org>
---
 drivers/spi/spi-pxa2xx.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 9071333ebdd86..df1b30b2c2745 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -461,6 +461,16 @@ int pxa2xx_spi_flush(struct driver_data *drv_data)
 	return limit;
 }
=20
+static void pxa2xx_spi_off(struct driver_data *drv_data)
+{
+	/* On MMP, disabling SSE seems to corrupt the rx fifo */
+	if (drv_data->ssp_type =3D=3D MMP2_SSP)
+		return;
+
+	pxa2xx_spi_write(drv_data, SSCR0,
+			 pxa2xx_spi_read(drv_data, SSCR0) & ~SSCR0_SSE);
+}
+
 static int null_writer(struct driver_data *drv_data)
 {
 	u8 n_bytes =3D drv_data->n_bytes;
@@ -587,8 +597,7 @@ static void int_error_stop(struct driver_data *drv_da=
ta, const char* msg)
 	if (!pxa25x_ssp_comp(drv_data))
 		pxa2xx_spi_write(drv_data, SSTO, 0);
 	pxa2xx_spi_flush(drv_data);
-	pxa2xx_spi_write(drv_data, SSCR0,
-			 pxa2xx_spi_read(drv_data, SSCR0) & ~SSCR0_SSE);
+	pxa2xx_spi_off(drv_data);
=20
 	dev_err(&drv_data->pdev->dev, "%s\n", msg);
=20
@@ -686,8 +695,7 @@ static irqreturn_t interrupt_transfer(struct driver_d=
ata *drv_data)
=20
 static void handle_bad_msg(struct driver_data *drv_data)
 {
-	pxa2xx_spi_write(drv_data, SSCR0,
-			 pxa2xx_spi_read(drv_data, SSCR0) & ~SSCR0_SSE);
+	pxa2xx_spi_off(drv_data);
 	pxa2xx_spi_write(drv_data, SSCR1,
 			 pxa2xx_spi_read(drv_data, SSCR1) & ~drv_data->int_cr1);
 	if (!pxa25x_ssp_comp(drv_data))
@@ -1062,7 +1070,8 @@ static int pxa2xx_spi_transfer_one(struct spi_contr=
oller *controller,
 	    || (pxa2xx_spi_read(drv_data, SSCR1) & change_mask)
 	    !=3D (cr1 & change_mask)) {
 		/* stop the SSP, and update the other bits */
-		pxa2xx_spi_write(drv_data, SSCR0, cr0 & ~SSCR0_SSE);
+		if (drv_data->ssp_type !=3D MMP2_SSP)
+			pxa2xx_spi_write(drv_data, SSCR0, cr0 & ~SSCR0_SSE);
 		if (!pxa25x_ssp_comp(drv_data))
 			pxa2xx_spi_write(drv_data, SSTO, chip->timeout);
 		/* first set CR1 without interrupt and service enables */
@@ -1118,8 +1127,7 @@ static int pxa2xx_spi_slave_abort(struct spi_contro=
ller *controller)
 	if (!pxa25x_ssp_comp(drv_data))
 		pxa2xx_spi_write(drv_data, SSTO, 0);
 	pxa2xx_spi_flush(drv_data);
-	pxa2xx_spi_write(drv_data, SSCR0,
-			 pxa2xx_spi_read(drv_data, SSCR0) & ~SSCR0_SSE);
+	pxa2xx_spi_off(drv_data);
=20
 	dev_dbg(&drv_data->pdev->dev, "transfer aborted\n");
=20
@@ -1135,8 +1143,7 @@ static void pxa2xx_spi_handle_err(struct spi_contro=
ller *controller,
 	struct driver_data *drv_data =3D spi_controller_get_devdata(controller)=
;
=20
 	/* Disable the SSP */
-	pxa2xx_spi_write(drv_data, SSCR0,
-			 pxa2xx_spi_read(drv_data, SSCR0) & ~SSCR0_SSE);
+	pxa2xx_spi_off(drv_data);
 	/* Clear and disable interrupts and service requests */
 	write_SSSR_CS(drv_data, drv_data->clear_sr);
 	pxa2xx_spi_write(drv_data, SSCR1,
@@ -1161,8 +1168,7 @@ static int pxa2xx_spi_unprepare_transfer(struct spi=
_controller *controller)
 	struct driver_data *drv_data =3D spi_controller_get_devdata(controller)=
;
=20
 	/* Disable the SSP now */
-	pxa2xx_spi_write(drv_data, SSCR0,
-			 pxa2xx_spi_read(drv_data, SSCR0) & ~SSCR0_SSE);
+	pxa2xx_spi_off(drv_data);
=20
 	return 0;
 }
--=20
2.24.1
