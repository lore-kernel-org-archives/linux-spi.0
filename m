From: =?UTF-8?q?Rapha=C3=ABl=20Poggi?= <poggi.raph@gmail.com>
Subject: =?UTF-8?q?=5BPATCH=5D=20spi=3A=20atmel=3A=20fix=20typo=20in=20dev=5Ferr?=
Date: Tue, 20 May 2014 09:41:51 +0200
Message-ID: <1400571711-13137-1-git-send-email-poggi.raph@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	=?UTF-8?q?Rapha=C3=ABl=20Poggi?= <poggi.raph@gmail.com>
To: nicolas.ferre@atmel.com
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

=46ix typo in dev_err.

Signed-off-by: Rapha=C3=ABl Poggi <poggi.raph@gmail.com>
---
 drivers/spi/spi-atmel.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 079e6b1..7a1788b 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -1122,7 +1122,7 @@ static int atmel_spi_one_transfer(struct spi_mast=
er *master,
 		atmel_spi_lock(as);
 		if (WARN_ON(ret =3D=3D 0)) {
 			dev_err(&spi->dev,
-				"spi trasfer timeout, err %d\n", ret);
+				"spi transfer timeout, err %d\n", ret);
 			as->done_status =3D -EIO;
 		} else {
 			ret =3D 0;
--=20
1.7.9.5
