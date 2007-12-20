From: Harald Welte <laforge-4Bgg8jF3iZdg9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 7/12] neo1973: JBT6K74 LCM
	control	interface driver
Date: Thu, 20 Dec 2007 16:06:59 +0100
Message-ID: <20071220150659.GP29882@prithivi.gnumonks.org>
References: <20071218110800.GN29882@prithivi.gnumonks.org>
	<200712191316.45435.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200712191316.45435.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi David,

thanks again for your review.

On Wed, Dec 19, 2007 at 01:16:44PM -0800, David Brownell wrote:
> Since this is a LCD controller, it should be living in the
> drivers/video directory somewhere.   =


Ok, no problem.

> Maybe in "backlight" and depending on LCD_CLASS_DEVICE like the
> LTV350QV code.  (Which is not dissimilar to this LCM driver, although
> that Samsung panel is much simpler.)

Well, the jbt6k74 driver does many things. But backlight switching is
not part of it :) the backlight is completely independent and machine
dependent.

> On Tuesday 18 December 2007, Harald Welte wrote:
> > =

> > +struct jbt_info {
> > +	enum jbt_state state, last_state;
> > +	u_int16_t tx_buf[8];
> > +	struct spi_device *spi_dev;
> > +	u_int16_t reg_cache[0xEE];
> =

> You don't have a lock protecting one thread from clobbering
> tx_buf while another thread is using it.  And that's very
> possible, even just through the sysfs attributes.

ok, introduced a mutex for protection.

> > +#define JBT_COMMAND	0x000
> > +#define JBT_DATA	0x100
> > +
> > +static int jbt_reg_write_nodata(struct jbt_info *jbt, u_int8_t reg)
> > +{
> > +	int rc;
> > +
> > +	jbt->tx_buf[0] =3D JBT_COMMAND | reg;
> > +
> > +	rc =3D spi_write(jbt->spi_dev, (u_int8_t *)jbt->tx_buf,
> > +		       1*sizeof(u_int16_t));
> =

> I prefer the "u16" style not the "uint16_t" style, but that's
> neither here nor there ... except that spi_write() is specified
> to take a "const u8 *" not a "u_int8_t *".  =


ok, will modify accordingly.

> This *looks* like a byteswap bug:  you're sending the data
> in native endianness, but the slave is expecting it in one
> particular byte order.  The saving grace is that you're
> actually using nine-bit I/O words here, and the interface is
> specified to ensure the native endianness is converted as
> needed on the way out.
> =

> In short:  please add a comment there, saying that these
> write operations all work with nine-bit native-endian data
> that's transformed (to big-endian) on the way out the wire.

ok, will do so.

> > +=A0=A0=A0=A0=A0=A0=A0if (rc =3D=3D 0)
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0jbt->reg_cache[reg] =3D 0;
> > +
> > +=A0=A0=A0=A0=A0=A0=A0return rc;
> > +}
> =

> OK, so the return code for these write methods is either
> zero for success, or a negative errno value.
> =

> =

> > +static int jbt_init_regs(struct jbt_info *jbt, int qvga)
> > +{
> > +	int rc;
> > +
> > +	dev_dbg(&jbt->spi_dev->dev, "entering %cVGA mode\n", qvga ? 'Q' : ' '=
);
> > +
> > +	rc =3D jbt_reg_write(jbt, JBT_REG_DISPLAY_MODE1, 0x01);
> > +	rc |=3D jbt_reg_write(jbt, JBT_REG_DISPLAY_MODE2, 0x00);
> > +	rc |=3D jbt_reg_write(jbt, JBT_REG_RGB_FORMAT, 0x60);
> =

> I understand why that convention is used -- too many errors to
> check for individually, for starters -- but it's not used right
> in this file.
> =

> =

> > +	...
> > +
> > +	return rc;
> =

> ... why not "return rc ? -EIO : 0" or something, so that
> the standard "int means negative errno else zero for success"
> convention is followed?  Here and elsewhere.  (Some routines
> return the real errno on some paths, and an invalid one on
> other paths...)
> =

> Masking together a whole bunch of fault codes doesn't generate
> a useful errno value!

I agree. changes are incorporated now.

> > +static ssize_t state_write(struct device *dev, struct device_attribute=
 *attr,
> > +			   const char *buf, size_t count)
> > +{
> > +	struct jbt_info *jbt =3D dev_get_drvdata(dev);
> > +	int i;
> > +
> > +	for (i =3D 0; i < ARRAY_SIZE(jbt_state_names); i++) {
> > +		if (!strncmp(buf, jbt_state_names[i],
> > +			     strlen(jbt_state_names[i]))) {
> > +			jbt6k74_enter_state(jbt, i);
> =

> You're ignoring the return code here.  I'd save it, and just
> return it (one that's fixed to return a real errno on all paths!)
> instead of continuing after errors.

ok.

> > +static ssize_t gamma_read(struct device *dev, struct device_attribute =
*attr,
> > +			  char *buf)
> > +{
> > +	return strlcpy(buf, "N/A\n", PAGE_SIZE);
> =

> Ugly ... why aren't you returning the jbt->reg_cache values
> that you saved?  Or just make these attributes write-only.

indeed, that's a good question.  I guess the reg_cache was only added
after this code.

> > +	/* since we don't have MISO connected, we can't do detection */
> =

> If the chip doesn't have a data output line, say so.

Yes, there is no data output line.  So it's not platform specific

> > +	dev_set_drvdata(&spi->dev, jbt);
> > +
> > +	spi->mode =3D SPI_CPOL | SPI_CPHA;
> > +	spi->bits_per_word =3D 9;
> > +
> > +	rc =3D spi_setup(spi);
> > +	if (rc < 0) {
> > +		dev_err(&spi->dev,
> > +			"error during spi_setup of jbt6k74 driver\n");
> > +		dev_set_drvdata(&spi->dev, NULL);
> > +		kfree(jbt);
> =

> Me, I'd rather do the spi_setup() before the kmalloc, so that
> cleanup here is easier.  But this is OK too.
> =

> =

> > +		return rc;
> > +	}
> > +
> > +	rc =3D jbt6k74_enter_state(jbt, JBT_STATE_NORMAL);
> > +	if (rc < 0)
> > +		dev_warn(&spi->dev, "cannot enter NORMAL state\n");
> > +
> > +	jbt6k74_display_onoff(jbt, 1);
> > +
> > +	rc =3D sysfs_create_group(&spi->dev.kobj, &jbt_attr_group);
> > +	if (rc) {
> > +		dev_set_drvdata(&spi->dev, NULL);
> =

> But leave the display on, and in "normal" state??
> =

> The normal policy is that failed probes shouldn't
> cause significant state changes.  If you intend
> to adopt a different policy, please add a comment
> saying why.

ok.

> > +	sysfs_remove_group(&spi->dev.kobj, &jbt_attr_group);
> =

> As above:  this probably shouldn't leave a user-visible
> state change.  (Display on, and in "normal" state.)

well, this is arguable.  For something as fundamental as a driver
associated with the single user-visible output device (in normal
operation), I think it is better to keep the device in a
functional, powered-up state.  Yes, why would somebody unload the
module.  But then, it's module usage count likely is zero.  so let's
rmmod -> display off according to your philosophy.

I've added a comment indicating this rationale.

> > +	struct jbt_info *jbt =3D dev_get_drvdata(&spi->dev);
> > +
> > +	switch (state.event) {
> > +	case PM_EVENT_SUSPEND:
> > +	case 3:
> =

> Gaak, no "case 3".  Bad!  Evil!

sorry. I don't remember from which example I've stolen that magic
number... removed it now.

> > +	default:
> > +		return -1;
> =

> Why return "-EPERM" rather than "0"?  Are you trying to
> prevent use of this driver on systems that support hibernation?
> =


nope. I just didn't know what other cases there were, and since none of
them are implemented, I thought it's better to refuse them than to claim
we support something that was never tested.

I'm now following the suggestion of pm.h, i.e. treat all cases like
SUSPEND.  Do you agree this sounds like the right thing to do?

> > +static int jbt_resume(struct spi_device *spi)
> > +{
> > +	struct jbt_info *jbt =3D dev_get_drvdata(&spi->dev);
> > +
> > +	jbt6k74_enter_state(jbt, jbt->last_state);
> > +	jbt6k74_display_onoff(jbt, 1);
> =

> I suspect that if the last state isn't DEEP_STANDBY this
> should do nothing.  =


Erm, you mean if the last state _is_ DEEP_STANDBY or SLEEP, it should do
nothing?  Thansk anyway for pointing it out, there definitely was a bug.

> Remember that during hibernation, this can be called multiple times.

And how would this be a problem? Sorry, I don't get it :/

> > +module_init(jbt_init);
> > +module_exit(jbt_exit);
> =

> As with EXPORT_SYMBOL() I'd like to see those snugged up against the
> function being used as a module init/exit function...

will do, thought all kernel code that I've been involed so far (mostly
networking related) used the style that I had in the first patch.

Here is the updated version for your review:

*************************

This driver adds support for the SPI-based control interface of the LCM (LCD
Panel) found on the FIC GTA01 hardware.  =


The specific panel in this hardware is a TPO TD028TTEC1, but the driver sho=
uld
be able to drive any other diplay based on the JBT6K74-AS controller ASIC.

Signed-off-by: Harald Welte <laforge-4Bgg8jF3iZdg9hUCZPvPmw@public.gmane.org>

---

Index: linux-2.6/drivers/video/display/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.orig/drivers/video/display/Kconfig
+++ linux-2.6/drivers/video/display/Kconfig
@@ -21,4 +21,15 @@
 comment "Display hardware drivers"
 	depends on DISPLAY_SUPPORT
 =

+config DISPLAY_JBT6K74
+	tristate "TPO JBT6K74-AS TFT display ASIC control interface"
+	depends on SPI_MASTER && SYSFS
+	help
+	  SPI driver for the control interface of TFT panels containing
+	  the TPO JBT6K74-AS controller ASIC, such as the TPO TD028TTEC1
+	  TFT diplay module used in the FIC/OpenMoko Neo1973 GSM phones.
+
+	  The control interface is required for display operation, as it
+	  controls power management, display timing and gamma calibration.
+
 endmenu
Index: linux-2.6/drivers/video/display/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.orig/drivers/video/display/Makefile
+++ linux-2.6/drivers/video/display/Makefile
@@ -3,4 +3,5 @@
 display-objs				:=3D display-sysfs.o
 =

 obj-$(CONFIG_DISPLAY_SUPPORT)		+=3D display.o
+obj-$(CONFIG_DISPLAY_JBT6K74)		+=3D jbt6k74.o
 =

Index: linux-2.6/drivers/video/display/jbt6k74.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ linux-2.6/drivers/video/display/jbt6k74.c
@@ -0,0 +1,673 @@
+/* Linux kernel driver for the tpo JBT6K74-AS LCM ASIC
+ *
+ * Copyright (C) 2006-2007 by OpenMoko, Inc.
+ * Author: Harald Welte <laforge-4Bgg8jF3iZdg9hUCZPvPmw@public.gmane.org>,
+ * 	   Stefan Schmidt <stefan-4Bgg8jF3iZdg9hUCZPvPmw@public.gmane.org>
+ * All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
+ * MA 02111-1307 USA
+ *
+ */
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <linux/delay.h>
+
+#include <linux/spi/spi.h>
+
+enum jbt_register {
+	JBT_REG_SLEEP_IN		=3D 0x10,
+	JBT_REG_SLEEP_OUT		=3D 0x11,
+
+	JBT_REG_DISPLAY_OFF		=3D 0x28,
+	JBT_REG_DISPLAY_ON		=3D 0x29,
+
+	JBT_REG_RGB_FORMAT		=3D 0x3a,
+	JBT_REG_QUAD_RATE		=3D 0x3b,
+
+	JBT_REG_POWER_ON_OFF		=3D 0xb0,
+	JBT_REG_BOOSTER_OP		=3D 0xb1,
+	JBT_REG_BOOSTER_MODE		=3D 0xb2,
+	JBT_REG_BOOSTER_FREQ		=3D 0xb3,
+	JBT_REG_OPAMP_SYSCLK		=3D 0xb4,
+	JBT_REG_VSC_VOLTAGE		=3D 0xb5,
+	JBT_REG_VCOM_VOLTAGE		=3D 0xb6,
+	JBT_REG_EXT_DISPL		=3D 0xb7,
+	JBT_REG_OUTPUT_CONTROL		=3D 0xb8,
+	JBT_REG_DCCLK_DCEV		=3D 0xb9,
+	JBT_REG_DISPLAY_MODE1		=3D 0xba,
+	JBT_REG_DISPLAY_MODE2		=3D 0xbb,
+	JBT_REG_DISPLAY_MODE		=3D 0xbc,
+	JBT_REG_ASW_SLEW		=3D 0xbd,
+	JBT_REG_DUMMY_DISPLAY		=3D 0xbe,
+	JBT_REG_DRIVE_SYSTEM		=3D 0xbf,
+
+	JBT_REG_SLEEP_OUT_FR_A		=3D 0xc0,
+	JBT_REG_SLEEP_OUT_FR_B		=3D 0xc1,
+	JBT_REG_SLEEP_OUT_FR_C		=3D 0xc2,
+	JBT_REG_SLEEP_IN_LCCNT_D	=3D 0xc3,
+	JBT_REG_SLEEP_IN_LCCNT_E	=3D 0xc4,
+	JBT_REG_SLEEP_IN_LCCNT_F	=3D 0xc5,
+	JBT_REG_SLEEP_IN_LCCNT_G	=3D 0xc6,
+
+	JBT_REG_GAMMA1_FINE_1		=3D 0xc7,
+	JBT_REG_GAMMA1_FINE_2		=3D 0xc8,
+	JBT_REG_GAMMA1_INCLINATION	=3D 0xc9,
+	JBT_REG_GAMMA1_BLUE_OFFSET	=3D 0xca,
+
+	/* VGA */
+	JBT_REG_BLANK_CONTROL		=3D 0xcf,
+	JBT_REG_BLANK_TH_TV		=3D 0xd0,
+	JBT_REG_CKV_ON_OFF		=3D 0xd1,
+	JBT_REG_CKV_1_2			=3D 0xd2,
+	JBT_REG_OEV_TIMING		=3D 0xd3,
+	JBT_REG_ASW_TIMING_1		=3D 0xd4,
+	JBT_REG_ASW_TIMING_2		=3D 0xd5,
+
+	/* QVGA */
+	JBT_REG_BLANK_CONTROL_QVGA	=3D 0xd6,
+	JBT_REG_BLANK_TH_TV_QVGA	=3D 0xd7,
+	JBT_REG_CKV_ON_OFF_QVGA		=3D 0xd8,
+	JBT_REG_CKV_1_2_QVGA		=3D 0xd9,
+	JBT_REG_OEV_TIMING_QVGA		=3D 0xde,
+	JBT_REG_ASW_TIMING_1_QVGA	=3D 0xdf,
+	JBT_REG_ASW_TIMING_2_QVGA	=3D 0xe0,
+
+
+	JBT_REG_HCLOCK_VGA		=3D 0xec,
+	JBT_REG_HCLOCK_QVGA		=3D 0xed,
+
+};
+
+enum jbt_state {
+	JBT_STATE_DEEP_STANDBY,
+	JBT_STATE_SLEEP,
+	JBT_STATE_NORMAL,
+	JBT_STATE_QVGA_NORMAL,
+};
+
+static const char *jbt_state_names[] =3D {
+	[JBT_STATE_DEEP_STANDBY]	=3D "deep-standby",
+	[JBT_STATE_SLEEP]		=3D "sleep",
+	[JBT_STATE_NORMAL]		=3D "normal",
+	[JBT_STATE_QVGA_NORMAL]		=3D "qvga-normal",
+};
+
+struct jbt_info {
+	enum jbt_state state, last_state;
+	struct spi_device *spi_dev;
+	struct mutex lock;		/* protects tx_buf and reg_cache */
+	u16 tx_buf[8];
+	u16 reg_cache[0xEE];
+};
+
+#define JBT_COMMAND	0x000
+#define JBT_DATA	0x100
+
+static int jbt_reg_write_nodata(struct jbt_info *jbt, u8 reg)
+{
+	int rc;
+
+	mutex_lock(&jbt->lock);
+
+	jbt->tx_buf[0] =3D JBT_COMMAND | reg;
+	rc =3D spi_write(jbt->spi_dev, (u8 *)jbt->tx_buf,
+		       1*sizeof(u16));
+	if (rc =3D=3D 0)
+		jbt->reg_cache[reg] =3D 0;
+
+	mutex_unlock(&jbt->lock);
+
+	return rc;
+}
+
+
+static int jbt_reg_write(struct jbt_info *jbt, u8 reg, u8 data)
+{
+	int rc;
+
+	mutex_lock(&jbt->lock);
+
+	jbt->tx_buf[0] =3D JBT_COMMAND | reg;
+	jbt->tx_buf[1] =3D JBT_DATA | data;
+	rc =3D spi_write(jbt->spi_dev, (u8 *)jbt->tx_buf,
+		       2*sizeof(u16));
+	if (rc =3D=3D 0)
+		jbt->reg_cache[reg] =3D data;
+	=

+	mutex_unlock(&jbt->lock);
+
+	return rc;
+}
+
+static int jbt_reg_write16(struct jbt_info *jbt, u8 reg, u16 data)
+{
+	int rc;
+
+	mutex_lock(&jbt->lock);
+
+	jbt->tx_buf[0] =3D JBT_COMMAND | reg;
+	jbt->tx_buf[1] =3D JBT_DATA | (data >> 8);
+	jbt->tx_buf[2] =3D JBT_DATA | (data & 0xff);
+
+	rc =3D spi_write(jbt->spi_dev, (u8 *)jbt->tx_buf,
+		       3*sizeof(u16));
+	if (rc =3D=3D 0)
+		jbt->reg_cache[reg] =3D data;
+
+	mutex_unlock(&jbt->lock);
+
+	return rc;
+}
+
+static int jbt_init_regs(struct jbt_info *jbt, int qvga)
+{
+	int rc;
+
+	dev_dbg(&jbt->spi_dev->dev, "entering %cVGA mode\n", qvga ? 'Q' : ' ');
+
+	rc =3D jbt_reg_write(jbt, JBT_REG_DISPLAY_MODE1, 0x01);
+	rc |=3D jbt_reg_write(jbt, JBT_REG_DISPLAY_MODE2, 0x00);
+	rc |=3D jbt_reg_write(jbt, JBT_REG_RGB_FORMAT, 0x60);
+	rc |=3D jbt_reg_write(jbt, JBT_REG_DRIVE_SYSTEM, 0x10);
+	rc |=3D jbt_reg_write(jbt, JBT_REG_BOOSTER_OP, 0x56);
+	rc |=3D jbt_reg_write(jbt, JBT_REG_BOOSTER_MODE, 0x33);
+	rc |=3D jbt_reg_write(jbt, JBT_REG_BOOSTER_FREQ, 0x11);
+	rc |=3D jbt_reg_write(jbt, JBT_REG_OPAMP_SYSCLK, 0x02);
+	rc |=3D jbt_reg_write(jbt, JBT_REG_VSC_VOLTAGE, 0x2b);
+	rc |=3D jbt_reg_write(jbt, JBT_REG_VCOM_VOLTAGE, 0x40);
+	rc |=3D jbt_reg_write(jbt, JBT_REG_EXT_DISPL, 0x03);
+	rc |=3D jbt_reg_write(jbt, JBT_REG_DCCLK_DCEV, 0x04);
+	rc |=3D jbt_reg_write(jbt, JBT_REG_ASW_SLEW, 0x02);
+	rc |=3D jbt_reg_write(jbt, JBT_REG_DUMMY_DISPLAY, 0x00);
+
+	rc |=3D jbt_reg_write(jbt, JBT_REG_SLEEP_OUT_FR_A, 0x11);
+	rc |=3D jbt_reg_write(jbt, JBT_REG_SLEEP_OUT_FR_B, 0x11);
+	rc |=3D jbt_reg_write(jbt, JBT_REG_SLEEP_OUT_FR_C, 0x11);
+	rc |=3D jbt_reg_write16(jbt, JBT_REG_SLEEP_IN_LCCNT_D, 0x2040);
+	rc |=3D jbt_reg_write16(jbt, JBT_REG_SLEEP_IN_LCCNT_E, 0x60c0);
+	rc |=3D jbt_reg_write16(jbt, JBT_REG_SLEEP_IN_LCCNT_F, 0x1020);
+	rc |=3D jbt_reg_write16(jbt, JBT_REG_SLEEP_IN_LCCNT_G, 0x60c0);
+
+	rc |=3D jbt_reg_write16(jbt, JBT_REG_GAMMA1_FINE_1, 0x5533);
+	rc |=3D jbt_reg_write(jbt, JBT_REG_GAMMA1_FINE_2, 0x00);
+	rc |=3D jbt_reg_write(jbt, JBT_REG_GAMMA1_INCLINATION, 0x00);
+	rc |=3D jbt_reg_write(jbt, JBT_REG_GAMMA1_BLUE_OFFSET, 0x00);
+
+	if (!qvga) {
+		rc |=3D jbt_reg_write16(jbt, JBT_REG_HCLOCK_VGA, 0x1f0);
+		rc |=3D jbt_reg_write(jbt, JBT_REG_BLANK_CONTROL, 0x02);
+		rc |=3D jbt_reg_write16(jbt, JBT_REG_BLANK_TH_TV, 0x0804);
+
+		rc |=3D jbt_reg_write(jbt, JBT_REG_CKV_ON_OFF, 0x01);
+		rc |=3D jbt_reg_write16(jbt, JBT_REG_CKV_1_2, 0x0000);
+
+		rc |=3D jbt_reg_write16(jbt, JBT_REG_OEV_TIMING, 0x0d0e);
+		rc |=3D jbt_reg_write16(jbt, JBT_REG_ASW_TIMING_1, 0x11a4);
+		rc |=3D jbt_reg_write(jbt, JBT_REG_ASW_TIMING_2, 0x0e);
+	} else {
+		rc |=3D jbt_reg_write16(jbt, JBT_REG_HCLOCK_QVGA, 0x00ff);
+		rc |=3D jbt_reg_write(jbt, JBT_REG_BLANK_CONTROL_QVGA, 0x02);
+		rc |=3D jbt_reg_write16(jbt, JBT_REG_BLANK_TH_TV_QVGA, 0x0804);
+
+		rc |=3D jbt_reg_write(jbt, JBT_REG_CKV_ON_OFF_QVGA, 0x01);
+		rc |=3D jbt_reg_write16(jbt, JBT_REG_CKV_1_2_QVGA, 0x0008);
+
+		rc |=3D jbt_reg_write16(jbt, JBT_REG_OEV_TIMING_QVGA, 0x050a);
+		rc |=3D jbt_reg_write16(jbt, JBT_REG_ASW_TIMING_1_QVGA, 0x0a19);
+		rc |=3D jbt_reg_write(jbt, JBT_REG_ASW_TIMING_2_QVGA, 0x0a);
+	}
+
+	return rc ? -EIO : 0;
+}
+
+static int standby_to_sleep(struct jbt_info *jbt)
+{
+	int rc;
+
+	/* three times command zero */
+	rc =3D jbt_reg_write_nodata(jbt, 0x00);
+	mdelay(1);
+	rc |=3D jbt_reg_write_nodata(jbt, 0x00);
+	mdelay(1);
+	rc |=3D jbt_reg_write_nodata(jbt, 0x00);
+	mdelay(1);
+
+	/* deep standby out */
+	rc |=3D jbt_reg_write(jbt, JBT_REG_POWER_ON_OFF, 0x17);
+
+	return rc ? -EIO : 0;
+}
+
+static int sleep_to_normal(struct jbt_info *jbt)
+{
+	int rc;
+
+	/* RGB I/F on, RAM wirte off, QVGA through, SIGCON enable */
+	rc =3D jbt_reg_write(jbt, JBT_REG_DISPLAY_MODE, 0x80);
+
+	/* Quad mode off */
+	rc |=3D jbt_reg_write(jbt, JBT_REG_QUAD_RATE, 0x00);
+
+	/* AVDD on, XVDD on */
+	rc |=3D jbt_reg_write(jbt, JBT_REG_POWER_ON_OFF, 0x16);
+
+	/* Output control */
+	rc |=3D jbt_reg_write16(jbt, JBT_REG_OUTPUT_CONTROL, 0xfff9);
+
+	/* Sleep mode off */
+	rc |=3D jbt_reg_write_nodata(jbt, JBT_REG_SLEEP_OUT);
+
+	/* initialize register set */
+	rc |=3D jbt_init_regs(jbt, 0);
+
+	return rc ? -EIO : 0;
+}
+
+static int sleep_to_qvga_normal(struct jbt_info *jbt)
+{
+	int rc;
+
+	/* RGB I/F on, RAM wirte off, QVGA through, SIGCON enable */
+	rc =3D jbt_reg_write(jbt, JBT_REG_DISPLAY_MODE, 0x81);
+
+	/* Quad mode on */
+	rc |=3D jbt_reg_write(jbt, JBT_REG_QUAD_RATE, 0x22);
+
+	/* AVDD on, XVDD on */
+	rc |=3D jbt_reg_write(jbt, JBT_REG_POWER_ON_OFF, 0x16);
+
+	/* Output control */
+	rc |=3D jbt_reg_write16(jbt, JBT_REG_OUTPUT_CONTROL, 0xfff9);
+
+	/* Sleep mode off */
+	rc |=3D jbt_reg_write_nodata(jbt, JBT_REG_SLEEP_OUT);
+
+	/* initialize register set for qvga*/
+	rc |=3D jbt_init_regs(jbt, 1);
+
+	return rc ? -EIO : 0;
+}
+
+static int normal_to_sleep(struct jbt_info *jbt)
+{
+	int rc;
+
+	rc =3D jbt_reg_write_nodata(jbt, JBT_REG_DISPLAY_OFF);
+	rc |=3D jbt_reg_write16(jbt, JBT_REG_OUTPUT_CONTROL, 0x8002);
+	rc |=3D jbt_reg_write_nodata(jbt, JBT_REG_SLEEP_IN);
+
+	return rc ? -EIO : 0;
+}
+
+static int sleep_to_standby(struct jbt_info *jbt)
+{
+	return jbt_reg_write(jbt, JBT_REG_POWER_ON_OFF, 0x00);
+}
+
+/* frontend function */
+int jbt6k74_enter_state(struct jbt_info *jbt, enum jbt_state new_state)
+{
+	int rc =3D -EINVAL;
+
+	dev_dbg(&jbt->spi_dev->dev, "entering (old_state=3D%u, "
+		"new_state=3D%u)\n", jbt->state, new_state);
+
+	switch (jbt->state) {
+	case JBT_STATE_DEEP_STANDBY:
+		switch (new_state) {
+		case JBT_STATE_DEEP_STANDBY:
+			rc =3D 0;
+			break;
+		case JBT_STATE_SLEEP:
+			rc =3D standby_to_sleep(jbt);
+			break;
+		case JBT_STATE_NORMAL:
+			/* first transition into sleep */
+			rc =3D standby_to_sleep(jbt);
+			/* then transition into normal */
+			rc |=3D sleep_to_normal(jbt);
+			break;
+		case JBT_STATE_QVGA_NORMAL:
+			/* first transition into sleep */
+			rc =3D standby_to_sleep(jbt);
+			/* then transition into normal */
+			rc |=3D sleep_to_qvga_normal(jbt);
+			break;
+		}
+		break;
+	case JBT_STATE_SLEEP:
+		switch (new_state) {
+		case JBT_STATE_SLEEP:
+			rc =3D 0;
+			break;
+		case JBT_STATE_DEEP_STANDBY:
+			rc =3D sleep_to_standby(jbt);
+			break;
+		case JBT_STATE_NORMAL:
+			rc =3D sleep_to_normal(jbt);
+			break;
+		case JBT_STATE_QVGA_NORMAL:
+			rc =3D sleep_to_qvga_normal(jbt);
+			break;
+		}
+		break;
+	case JBT_STATE_NORMAL:
+		switch (new_state) {
+		case JBT_STATE_NORMAL:
+			rc =3D 0;
+			break;
+		case JBT_STATE_DEEP_STANDBY:
+			/* first transition into sleep */
+			rc =3D normal_to_sleep(jbt);
+			/* then transition into deep standby */
+			rc |=3D sleep_to_standby(jbt);
+			break;
+		case JBT_STATE_SLEEP:
+			rc =3D normal_to_sleep(jbt);
+			break;
+		case JBT_STATE_QVGA_NORMAL:
+			/* first transition into sleep */
+			rc =3D normal_to_sleep(jbt);
+			/* second transition into deep standby */
+			rc |=3D sleep_to_standby(jbt);
+			/* third transition into sleep */
+			rc |=3D standby_to_sleep(jbt);
+			/* fourth transition into normal */
+			rc |=3D sleep_to_qvga_normal(jbt);
+			break;
+		}
+		break;
+	case JBT_STATE_QVGA_NORMAL:
+		switch (new_state) {
+		case JBT_STATE_QVGA_NORMAL:
+			rc =3D 0;
+			break;
+		case JBT_STATE_DEEP_STANDBY:
+			/* first transition into sleep */
+			rc =3D normal_to_sleep(jbt);
+			/* then transition into deep standby */
+			rc |=3D sleep_to_standby(jbt);
+			break;
+		case JBT_STATE_SLEEP:
+			rc =3D normal_to_sleep(jbt);
+			break;
+		case JBT_STATE_NORMAL:
+			/* first transition into sleep */
+			rc =3D normal_to_sleep(jbt);
+			/* second transition into deep standby */
+			rc |=3D sleep_to_standby(jbt);
+			/* third transition into sleep */
+			rc |=3D standby_to_sleep(jbt);
+			/* fourth transition into normal */
+			rc |=3D sleep_to_normal(jbt);
+			break;
+		}
+		break;
+	}
+	if (rc =3D=3D 0)
+		jbt->state =3D new_state;
+
+	return rc;
+}
+EXPORT_SYMBOL_GPL(jbt6k74_enter_state);
+
+int jbt6k74_display_onoff(struct jbt_info *jbt, int on)
+{
+	if (on)
+		return jbt_reg_write_nodata(jbt, JBT_REG_DISPLAY_ON);
+	else
+		return jbt_reg_write_nodata(jbt, JBT_REG_DISPLAY_OFF);
+}
+EXPORT_SYMBOL_GPL(jbt6k74_display_onoff);
+
+static ssize_t state_read(struct device *dev, struct device_attribute *att=
r,
+			  char *buf)
+{
+	struct jbt_info *jbt =3D dev_get_drvdata(dev);
+
+	if (jbt->state >=3D ARRAY_SIZE(jbt_state_names))
+		return -EIO;
+
+	return sprintf(buf, "%s\n", jbt_state_names[jbt->state]);
+}
+
+static ssize_t state_write(struct device *dev, struct device_attribute *at=
tr,
+			   const char *buf, size_t count)
+{
+	struct jbt_info *jbt =3D dev_get_drvdata(dev);
+	int i, rc;
+
+	for (i =3D 0; i < ARRAY_SIZE(jbt_state_names); i++) {
+		if (!strncmp(buf, jbt_state_names[i],
+			     strlen(jbt_state_names[i]))) {
+			rc =3D jbt6k74_enter_state(jbt, i);
+			if (rc)
+				return rc;
+			switch (i) {
+			case JBT_STATE_NORMAL:
+			case JBT_STATE_QVGA_NORMAL:
+				/* Enable display again after deep-standby */
+				rc =3D jbt6k74_display_onoff(jbt, 1);
+				if (rc)
+					return rc;
+				break;
+			default:
+				break;
+			}
+			return count;
+		}
+	}
+
+	return -EINVAL;
+}
+
+static DEVICE_ATTR(state, 0644, state_read, state_write);
+
+static int reg_by_string(const char *name)
+{
+	if (!strcmp(name, "gamma_fine1"))
+		return JBT_REG_GAMMA1_FINE_1;
+	else if (!strcmp(name, "gamma_fine2"))
+		return JBT_REG_GAMMA1_FINE_2;
+	else if (!strcmp(name, "gamma_inclination"))
+		return JBT_REG_GAMMA1_INCLINATION;
+	else
+		return JBT_REG_GAMMA1_BLUE_OFFSET;
+}
+
+static ssize_t gamma_read(struct device *dev, struct device_attribute *att=
r,
+			  char *buf)
+{
+	struct jbt_info *jbt =3D dev_get_drvdata(dev);
+	int reg =3D reg_by_string(attr->attr.name);
+	u16 val;
+
+	mutex_lock(&jbt->lock);
+	val =3D jbt->reg_cache[reg];
+	mutex_unlock(&jbt->lock);
+
+	return sprintf(buf, "0x%04x\n", val);
+}
+
+static ssize_t gamma_write(struct device *dev, struct device_attribute *at=
tr,
+			   const char *buf, size_t count)
+{
+	struct jbt_info *jbt =3D dev_get_drvdata(dev);
+	int reg =3D reg_by_string(attr->attr.name);
+	unsigned long val =3D simple_strtoul(buf, NULL, 10);
+
+	jbt_reg_write(jbt, reg, val & 0xff);
+
+	return count;
+}
+
+static DEVICE_ATTR(gamma_fine1, 0644, gamma_read, gamma_write);
+static DEVICE_ATTR(gamma_fine2, 0644, gamma_read, gamma_write);
+static DEVICE_ATTR(gamma_inclination, 0644, gamma_read, gamma_write);
+static DEVICE_ATTR(gamma_blue_offset, 0644, gamma_read, gamma_write);
+
+static struct attribute *jbt_sysfs_entries[] =3D {
+	&dev_attr_state.attr,
+	&dev_attr_gamma_fine1.attr,
+	&dev_attr_gamma_fine2.attr,
+	&dev_attr_gamma_inclination.attr,
+	&dev_attr_gamma_blue_offset.attr,
+	NULL,
+};
+
+static struct attribute_group jbt_attr_group =3D {
+	.name	=3D NULL,
+	.attrs	=3D jbt_sysfs_entries,
+};
+
+/* linux device model infrastructure */
+
+static int __devinit jbt_probe(struct spi_device *spi)
+{
+	int rc;
+	struct jbt_info *jbt;
+
+	/* the controller doesn't have a MISO pin; we can't do detection */
+
+	spi->mode =3D SPI_CPOL | SPI_CPHA;
+	spi->bits_per_word =3D 9;
+
+	rc =3D spi_setup(spi);
+	if (rc < 0) {
+		dev_err(&spi->dev,
+			"error during spi_setup of jbt6k74 driver\n");
+		return rc;
+	}
+
+	jbt =3D kzalloc(sizeof(*jbt), GFP_KERNEL);
+	if (!jbt)
+		return -ENOMEM;
+
+	jbt->spi_dev =3D spi;
+	jbt->state =3D JBT_STATE_DEEP_STANDBY;
+
+	dev_set_drvdata(&spi->dev, jbt);
+
+	rc =3D jbt6k74_enter_state(jbt, JBT_STATE_NORMAL);
+	if (rc < 0) {
+		dev_err(&spi->dev, "cannot enter NORMAL state\n");
+		goto err_free_drvdata;
+	}
+
+	rc =3D jbt6k74_display_onoff(jbt, 1);
+	if (rc < 0) {
+		dev_err(&spi->dev, "cannot switch display on\n");
+		goto err_standby;
+	}
+
+	rc =3D sysfs_create_group(&spi->dev.kobj, &jbt_attr_group);
+	if (rc < 0) {
+		dev_err(&spi->dev, "cannot create sysfs group\n");
+		goto err_off;
+	}
+
+	return 0;
+
+err_off:
+	jbt6k74_display_onoff(jbt, 0);
+err_standby:
+	jbt6k74_enter_state(jbt, JBT_STATE_DEEP_STANDBY);
+err_free_drvdata:
+	dev_set_drvdata(&spi->dev, NULL);
+	kfree(jbt);
+
+	return rc;
+}
+
+static int __devexit jbt_remove(struct spi_device *spi)
+{
+	struct jbt_info *jbt =3D dev_get_drvdata(&spi->dev);
+
+	/* We don't want to switch off the display in case the user
+	 * accidentially onloads the module (whose use count normally is 0) */
+
+	sysfs_remove_group(&spi->dev.kobj, &jbt_attr_group);
+	dev_set_drvdata(&spi->dev, NULL);
+	kfree(jbt);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int jbt_suspend(struct spi_device *spi, pm_message_t state)
+{
+	struct jbt_info *jbt =3D dev_get_drvdata(&spi->dev);
+
+	/* Save mode for resume */
+	jbt->last_state =3D jbt->state;
+	jbt6k74_enter_state(jbt, JBT_STATE_DEEP_STANDBY);
+
+	return 0;
+}
+
+static int jbt_resume(struct spi_device *spi)
+{
+	struct jbt_info *jbt =3D dev_get_drvdata(&spi->dev);
+
+	jbt6k74_enter_state(jbt, jbt->last_state);
+
+	switch (jbt->last_state) {
+	case JBT_STATE_NORMAL:
+	case JBT_STATE_QVGA_NORMAL:
+		jbt6k74_display_onoff(jbt, 1);
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+#else
+#define jbt_suspend	NULL
+#define jbt_resume	NULL
+#endif
+
+static struct spi_driver jbt6k74_driver =3D {
+	.driver =3D {
+		.name	=3D "jbt6k74",
+		.owner	=3D THIS_MODULE,
+	},
+
+	.probe	 =3D jbt_probe,
+	.remove	 =3D __devexit_p(jbt_remove),
+	.suspend =3D jbt_suspend,
+	.resume	 =3D jbt_resume,
+};
+
+static int __init jbt_init(void)
+{
+	return spi_register_driver(&jbt6k74_driver);
+}
+
+static void __exit jbt_exit(void)
+{
+	spi_unregister_driver(&jbt6k74_driver);
+}
+
+MODULE_DESCRIPTION("SPI driver for tpo JBT6K74-AS LCM control interface");
+MODULE_AUTHOR("Harald Welte <laforge-4Bgg8jF3iZdg9hUCZPvPmw@public.gmane.org>");
+MODULE_LICENSE("GPL");
+
+module_init(jbt_init);
+module_exit(jbt_exit);
Index: linux-2.6/arch/arm/mach-s3c2410/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.orig/arch/arm/mach-s3c2410/Kconfig
+++ linux-2.6/arch/arm/mach-s3c2410/Kconfig
@@ -107,6 +107,7 @@
 config MACH_QT2410
 	bool "QT2410"
 	select CPU_S3C2410
+	select DISPLAY_JBT6K74
 	help
 	   Say Y here if you are using the Armzone QT2410
 =

-- =

- Harald Welte <laforge-4Bgg8jF3iZdg9hUCZPvPmw@public.gmane.org>          	        http://openmoko.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
Software for the world's first truly open Free Software mobile phone

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
