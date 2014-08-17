From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: [PATCH 2/2] extcon: sm5502: EXTCON_SM5502 should depend on I2C
Date: Sun, 17 Aug 2014 12:08:58 +0200
Message-ID: <1408270138-29811-2-git-send-email-geert@linux-m68k.org>
References: <1408270138-29811-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>,
	MyungJoo Ham <myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1408270138-29811-1-git-send-email-geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

EXTCON_SM5502 selects REGMAP_I2C, but if I2C=3Dn:

drivers/base/regmap/regmap-i2c.c: In function =E2=80=98regmap_smbus_byt=
e_reg_read=E2=80=99:
drivers/base/regmap/regmap-i2c.c:28: error: implicit declaration of fun=
ction =E2=80=98i2c_smbus_read_byte_data=E2=80=99
drivers/base/regmap/regmap-i2c.c: In function =E2=80=98regmap_smbus_byt=
e_reg_write=E2=80=99:
drivers/base/regmap/regmap-i2c.c:46: error: implicit declaration of fun=
ction =E2=80=98i2c_smbus_write_byte_data=E2=80=99
drivers/base/regmap/regmap-i2c.c: In function =E2=80=98regmap_smbus_wor=
d_reg_read=E2=80=99:
drivers/base/regmap/regmap-i2c.c:64: error: implicit declaration of fun=
ction =E2=80=98i2c_smbus_read_word_data=E2=80=99
drivers/base/regmap/regmap-i2c.c: In function =E2=80=98regmap_smbus_wor=
d_reg_write=E2=80=99:
drivers/base/regmap/regmap-i2c.c:82: error: implicit declaration of fun=
ction =E2=80=98i2c_smbus_write_word_data=E2=80=99
drivers/base/regmap/regmap-i2c.c: In function =E2=80=98regmap_i2c_write=
=E2=80=99:
drivers/base/regmap/regmap-i2c.c:96: error: implicit declaration of fun=
ction =E2=80=98i2c_master_send=E2=80=99
drivers/base/regmap/regmap-i2c.c: In function =E2=80=98regmap_i2c_gathe=
r_write=E2=80=99:
drivers/base/regmap/regmap-i2c.c:117: error: implicit declaration of fu=
nction =E2=80=98i2c_check_functionality=E2=80=99
drivers/base/regmap/regmap-i2c.c:130: error: implicit declaration of fu=
nction =E2=80=98i2c_transfer=E2=80=99

Signed-off-by: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
---
 drivers/extcon/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/extcon/Kconfig b/drivers/extcon/Kconfig
index 6f2f4727de2c..764f3a113e0a 100644
--- a/drivers/extcon/Kconfig
+++ b/drivers/extcon/Kconfig
@@ -72,6 +72,7 @@ config EXTCON_PALMAS
=20
 config EXTCON_SM5502
 	tristate "SM5502 EXTCON support"
+	depends on I2C
 	select IRQ_DOMAIN
 	select REGMAP_I2C
 	select REGMAP_IRQ
--=20
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
