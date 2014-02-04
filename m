From: SeongJae Park <sj38.park-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] spi: fix pointer-integer size mismatch warning
Date: Tue,  4 Feb 2014 15:58:09 +0900
Message-ID: <1391497089-6831-1-git-send-email-sj38.park@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	SeongJae Park <sj38.park-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

=46ix the pointer-integer size mismatch warning below:
	drivers/spi/spi-gpio.c: In function =E2=80=98spi_gpio_setup=E2=80=99:
	drivers/spi/spi-gpio.c:252:8: warning: cast from pointer to integer of
			different size [-Wpointer-to-int-cast]
	   cs =3D (unsigned int) spi->controller_data;
	        ^

Signed-off-by: SeongJae Park <sj38.park-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-gpio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-gpio.c b/drivers/spi/spi-gpio.c
index cfc9fb3..406bbd7 100644
--- a/drivers/spi/spi-gpio.c
+++ b/drivers/spi/spi-gpio.c
@@ -249,7 +249,7 @@ static int spi_gpio_setup(struct spi_device *spi)
 		/*
 		 * ... otherwise, take it from spi->controller_data
 		 */
-		cs =3D (unsigned int) spi->controller_data;
+		cs =3D (unsigned int)(uintptr_t) spi->controller_data;
 	}
=20
 	if (!spi->controller_state) {
--=20
1.8.3.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
