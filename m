From: Marc Reilly <marc@cpdesign.com.au>
Subject: Re: mc13xxx-core, support for i2c, V4
Date: Tue, 22 Feb 2011 14:23:45 +1100
Message-ID: <201102221423.45932.marc@cpdesign.com.au>
References: <1294119299-18352-1-git-send-email-marc@cpdesign.com.au>
	<201102122111.30525.marc@cpdesign.com.au>
	<20110221163347.GG10686@sortiz-mobl>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_BxyYNpMDv+rlOKk"
Cc: Grant Likely <grant.likely@secretlab.ca>,
	spi-devel-general@lists.sourceforge.net,
	linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	u.kleine-koenig@pengutronix.de
To: Samuel Ortiz <sameo@linux.intel.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20110221163347.GG10686@sortiz-mobl>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

--Boundary-00=_BxyYNpMDv+rlOKk
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Hi Samuel,


> > > {Grant wrote}
> > > This series looks okay to me.  Since this is audio drivers, I expect
> > > that it would best be taken via the ASoC tree?  Have you sent it to
> > > Mark Brown and the ALSA list for review?
> > > 
> > > g.
> > 
> > Actually only the mc13873 has audio support. I think these IC's really
> > fit better under the MFD tree, but silly me didn't add Samuel Ortiz (MFD
> > maintainer) to this series... so included him now.
> > 
> > Samuel, are you the most appropriate to take this series in and would you
> > like me to resend these patches to you? The thread archive is at [1].
> 
> Yes, I would be the one taking those patches. Please resend the patch set
> to me, and I'll have a look. 

I don't have the original patch files available to resend the normal way, but 
attached are the 4 patch files off of patchwork [1]. Apologies if they are not 
what is required/inconvenient for you.

> Has Uwe commented on them yet ?
Uwe was very helpful in the first three versions of this series, but didn't 
have anything to say about V4.


Cheers
Marc

[1] https://patchwork.kernel.org/patch/449541/


--Boundary-00=_BxyYNpMDv+rlOKk
Content-Type: text/x-patch;
  charset="UTF-8";
  name="v4-1-4-mc13xxx-core-Prepare-for-separate-spi-and-i2c-backends..patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="v4-1-4-mc13xxx-core-Prepare-for-separate-spi-and-i2c-backends..patch"

=46rom patchwork Tue Jan  4 05:34:56 2011
Content-Type: text/plain; charset=3D"utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [v4,1/4] mc13xxx-core: Prepare for separate spi and i2c backends.
Date: Tue, 04 Jan 2011 05:34:56 -0000
=46rom: Marc Reilly <marc@cpdesign.com.au>
X-Patchwork-Id: 449541
Message-Id: <1294119299-18352-2-git-send-email-marc@cpdesign.com.au>
To: linux-arm-kernel@lists.infradead.org, u.kleine-koenig@pengutronix.de
Cc: spi-devel-general@lists.sourceforge.net, linux-i2c@vger.kernel.org,
 Marc Reilly <marc@cpdesign.com.au>

This patch abstracts the bus specific operations from the driver core.
Read and write handlers are introduced and generic initialization is
consolidated into mc13xxx_comon_init. The irq member is removed because
it is unused.

Signed-off-by: Marc Reilly <marc@cpdesign.com.au>

=2D--
drivers/mfd/mc13xxx-core.c  |  158 +++++++++++++++++++++++++---------------=
=2D-
 include/linux/mfd/mc13xxx.h |    5 ++
 2 files changed, 99 insertions(+), 64 deletions(-)

diff --git a/drivers/mfd/mc13xxx-core.c b/drivers/mfd/mc13xxx-core.c
index a2ac2ed..d1f1d7b 100644
=2D-- a/drivers/mfd/mc13xxx-core.c
+++ b/drivers/mfd/mc13xxx-core.c
@@ -19,10 +19,22 @@
 #include <linux/mfd/core.h>
 #include <linux/mfd/mc13xxx.h>
=20
+enum mc13xxx_id {
+	MC13XXX_ID_MC13783,
+	MC13XXX_ID_MC13892,
+	MC13XXX_ID_INVALID,
+};
+
 struct mc13xxx {
 	struct spi_device *spidev;
+
+	struct device *dev;
+	enum mc13xxx_id ictype;
+
 	struct mutex lock;
=2D	int irq;
+
+	int (*read_dev)(struct mc13xxx *, unsigned int, u32 *);
+	int (*write_dev)(struct mc13xxx *, unsigned int, u32);
=20
 	irq_handler_t irqhandler[MC13XXX_NUM_IRQ];
 	void *irqdata[MC13XXX_NUM_IRQ];
@@ -150,36 +162,32 @@ EXPORT_SYMBOL(mc13783_to_mc13xxx);
 void mc13xxx_lock(struct mc13xxx *mc13xxx)
 {
 	if (!mutex_trylock(&mc13xxx->lock)) {
=2D		dev_dbg(&mc13xxx->spidev->dev, "wait for %s from %pf\n",
+		dev_dbg(mc13xxx->dev, "wait for %s from %pf\n",
 				__func__, __builtin_return_address(0));
=20
 		mutex_lock(&mc13xxx->lock);
 	}
=2D	dev_dbg(&mc13xxx->spidev->dev, "%s from %pf\n",
+	dev_dbg(mc13xxx->dev, "%s from %pf\n",
 			__func__, __builtin_return_address(0));
 }
 EXPORT_SYMBOL(mc13xxx_lock);
=20
 void mc13xxx_unlock(struct mc13xxx *mc13xxx)
 {
=2D	dev_dbg(&mc13xxx->spidev->dev, "%s from %pf\n",
+	dev_dbg(mc13xxx->dev, "%s from %pf\n",
 			__func__, __builtin_return_address(0));
 	mutex_unlock(&mc13xxx->lock);
 }
 EXPORT_SYMBOL(mc13xxx_unlock);
=20
 #define MC13XXX_REGOFFSET_SHIFT 25
=2Dint mc13xxx_reg_read(struct mc13xxx *mc13xxx, unsigned int offset, u32 *=
val)
+static int mc13xxx_spi_reg_read(struct mc13xxx *mc13xxx,
+				unsigned int offset, u32 *val)
 {
 	struct spi_transfer t;
 	struct spi_message m;
 	int ret;
=20
=2D	BUG_ON(!mutex_is_locked(&mc13xxx->lock));
=2D
=2D	if (offset > MC13XXX_NUMREGS)
=2D		return -EINVAL;
=2D
 	*val =3D offset << MC13XXX_REGOFFSET_SHIFT;
=20
 	memset(&t, 0, sizeof(t));
@@ -201,26 +209,33 @@ int mc13xxx_reg_read(struct mc13xxx *mc13xxx, unsigne=
d int offset, u32 *val)
=20
 	*val &=3D 0xffffff;
=20
=2D	dev_vdbg(&mc13xxx->spidev->dev, "[0x%02x] -> 0x%06x\n", offset, *val);
=2D
 	return 0;
 }
=2DEXPORT_SYMBOL(mc13xxx_reg_read);
=20
=2Dint mc13xxx_reg_write(struct mc13xxx *mc13xxx, unsigned int offset, u32 =
val)
+int mc13xxx_reg_read(struct mc13xxx *mc13xxx, unsigned int offset, u32 *va=
l)
 {
=2D	u32 buf;
=2D	struct spi_transfer t;
=2D	struct spi_message m;
 	int ret;
=20
 	BUG_ON(!mutex_is_locked(&mc13xxx->lock));
=20
=2D	dev_vdbg(&mc13xxx->spidev->dev, "[0x%02x] <- 0x%06x\n", offset, val);
=2D
=2D	if (offset > MC13XXX_NUMREGS || val > 0xffffff)
+	if (offset > MC13XXX_NUMREGS)
 		return -EINVAL;
=20
+	ret =3D mc13xxx->read_dev(mc13xxx, offset, val);
+	dev_vdbg(mc13xxx->dev, "[0x%02x] -> 0x%06x\n", offset, *val);
+
+	return ret;
+}
+EXPORT_SYMBOL(mc13xxx_reg_read);
+
+static int mc13xxx_spi_reg_write(struct mc13xxx *mc13xxx, unsigned int off=
set,
+		u32 val)
+{
+	u32 buf;
+	struct spi_transfer t;
+	struct spi_message m;
+	int ret;
+
 	buf =3D 1 << 31 | offset << MC13XXX_REGOFFSET_SHIFT | val;
=20
 	memset(&t, 0, sizeof(t));
@@ -241,6 +256,18 @@ int mc13xxx_reg_write(struct mc13xxx *mc13xxx, unsigne=
d int offset, u32 val)
=20
 	return 0;
 }
+
+int mc13xxx_reg_write(struct mc13xxx *mc13xxx, unsigned int offset, u32 va=
l)
+{
+	BUG_ON(!mutex_is_locked(&mc13xxx->lock));
+
+	dev_vdbg(mc13xxx->dev, "[0x%02x] <- 0x%06x\n", offset, val);
+
+	if (offset > MC13XXX_NUMREGS || val > 0xffffff)
+		return -EINVAL;
+
+	return mc13xxx->write_dev(mc13xxx, offset, val);
+}
 EXPORT_SYMBOL(mc13xxx_reg_write);
=20
 int mc13xxx_reg_rmw(struct mc13xxx *mc13xxx, unsigned int offset,
@@ -445,7 +472,7 @@ static int mc13xxx_irq_handle(struct mc13xxx *mc13xxx,
 			if (handled =3D=3D IRQ_HANDLED)
 				num_handled++;
 		} else {
=2D			dev_err(&mc13xxx->spidev->dev,
+			dev_err(mc13xxx->dev,
 					"BUG: irq %u but no handler\n",
 					baseirq + irq);
=20
@@ -481,25 +508,23 @@ static irqreturn_t mc13xxx_irq_thread(int irq, void *=
data)
 	return IRQ_RETVAL(handled);
 }
=20
=2Denum mc13xxx_id {
=2D	MC13XXX_ID_MC13783,
=2D	MC13XXX_ID_MC13892,
=2D	MC13XXX_ID_INVALID,
=2D};
=2D
 const char *mc13xxx_chipname[] =3D {
 	[MC13XXX_ID_MC13783] =3D "mc13783",
 	[MC13XXX_ID_MC13892] =3D "mc13892",
 };
=20
 #define maskval(reg, mask)	(((reg) & (mask)) >> __ffs(mask))
=2Dstatic int mc13xxx_identify(struct mc13xxx *mc13xxx, enum mc13xxx_id *id)
+static int mc13xxx_identify(struct mc13xxx *mc13xxx)
 {
 	u32 icid;
 	u32 revision;
=2D	const char *name;
 	int ret;
=20
+	/*
+	 * Get the generation ID from register 46, as apparently some older
+	 * IC revisions only have this info at this location. Newer ICs seem to
+	 * have both.
+	 */
 	ret =3D mc13xxx_reg_read(mc13xxx, 46, &icid);
 	if (ret)
 		return ret;
@@ -508,26 +533,23 @@ static int mc13xxx_identify(struct mc13xxx *mc13xxx, =
enum mc13xxx_id *id)
=20
 	switch (icid) {
 	case 2:
=2D		*id =3D MC13XXX_ID_MC13783;
=2D		name =3D "mc13783";
+		mc13xxx->ictype =3D MC13XXX_ID_MC13783;
 		break;
 	case 7:
=2D		*id =3D MC13XXX_ID_MC13892;
=2D		name =3D "mc13892";
+		mc13xxx->ictype =3D MC13XXX_ID_MC13892;
 		break;
 	default:
=2D		*id =3D MC13XXX_ID_INVALID;
+		mc13xxx->ictype =3D MC13XXX_ID_INVALID;
 		break;
 	}
=20
=2D	if (*id =3D=3D MC13XXX_ID_MC13783 || *id =3D=3D MC13XXX_ID_MC13892) {
+	if (mc13xxx->ictype =3D=3D MC13XXX_ID_MC13783 ||
+			mc13xxx->ictype =3D=3D MC13XXX_ID_MC13892) {
 		ret =3D mc13xxx_reg_read(mc13xxx, MC13XXX_REVISION, &revision);
=2D		if (ret)
=2D			return ret;
=20
=2D		dev_info(&mc13xxx->spidev->dev, "%s: rev: %d.%d, "
+		dev_info(mc13xxx->dev, "%s: rev: %d.%d, "
 				"fin: %d, fab: %d, icid: %d/%d\n",
=2D				mc13xxx_chipname[*id],
+				mc13xxx_chipname[mc13xxx->ictype],
 				maskval(revision, MC13XXX_REVISION_REVFULL),
 				maskval(revision, MC13XXX_REVISION_REVMETAL),
 				maskval(revision, MC13XXX_REVISION_FIN),
@@ -536,26 +558,12 @@ static int mc13xxx_identify(struct mc13xxx *mc13xxx, =
enum mc13xxx_id *id)
 				maskval(revision, MC13XXX_REVISION_ICIDCODE));
 	}
=20
=2D	if (*id !=3D MC13XXX_ID_INVALID) {
=2D		const struct spi_device_id *devid =3D
=2D			spi_get_device_id(mc13xxx->spidev);
=2D		if (!devid || devid->driver_data !=3D *id)
=2D			dev_warn(&mc13xxx->spidev->dev, "device id doesn't "
=2D					"match auto detection!\n");
=2D	}
=2D
=2D	return 0;
+	return (mc13xxx->ictype =3D=3D MC13XXX_ID_INVALID) ? -ENODEV : 0;
 }
=20
 static const char *mc13xxx_get_chipname(struct mc13xxx *mc13xxx)
 {
=2D	const struct spi_device_id *devid =3D
=2D		spi_get_device_id(mc13xxx->spidev);
=2D
=2D	if (!devid)
=2D		return NULL;
=2D
=2D	return mc13xxx_chipname[devid->driver_data];
+	return mc13xxx_chipname[mc13xxx->ictype];
 }
=20
 #include <linux/mfd/mc13783.h>
@@ -563,7 +571,7 @@ static const char *mc13xxx_get_chipname(struct mc13xxx =
*mc13xxx)
 int mc13xxx_get_flags(struct mc13xxx *mc13xxx)
 {
 	struct mc13xxx_platform_data *pdata =3D
=2D		dev_get_platdata(&mc13xxx->spidev->dev);
+		dev_get_platdata(mc13xxx->dev);
=20
 	return pdata->flags;
 }
@@ -601,7 +609,7 @@ int mc13783_adc_do_conversion(struct mc13783 *mc13783, =
unsigned int mode,
 	};
 	init_completion(&adcdone_data.done);
=20
=2D	dev_dbg(&mc13xxx->spidev->dev, "%s\n", __func__);
+	dev_dbg(mc13xxx->dev, "%s\n", __func__);
=20
 	mc13xxx_lock(mc13xxx);
=20
@@ -643,7 +651,7 @@ int mc13783_adc_do_conversion(struct mc13783 *mc13783, =
unsigned int mode,
 		return -EINVAL;
 	}
=20
=2D	dev_dbg(&mc13783->mc13xxx.spidev->dev, "%s: request irq\n", __func__);
+	dev_dbg(mc13783->mc13xxx.dev, "%s: request irq\n", __func__);
 	mc13xxx_irq_request(mc13xxx, MC13783_IRQ_ADCDONE,
 			mc13783_handler_adcdone, __func__, &adcdone_data);
 	mc13xxx_irq_ack(mc13xxx, MC13783_IRQ_ADCDONE);
@@ -701,7 +709,7 @@ static int mc13xxx_add_subdevice_pdata(struct mc13xxx *=
mc13xxx,
 	if (!cell.name)
 		return -ENOMEM;
=20
=2D	return mfd_add_devices(&mc13xxx->spidev->dev, -1, &cell, 1, NULL, 0);
+	return mfd_add_devices(mc13xxx->dev, -1, &cell, 1, NULL, 0);
 }
=20
 static int mc13xxx_add_subdevice(struct mc13xxx *mc13xxx, const char *form=
at)
@@ -713,7 +721,6 @@ static int mc13xxx_probe(struct spi_device *spi)
 {
 	struct mc13xxx *mc13xxx;
 	struct mc13xxx_platform_data *pdata =3D dev_get_platdata(&spi->dev);
=2D	enum mc13xxx_id id;
 	int ret;
=20
 	mc13xxx =3D kzalloc(sizeof(*mc13xxx), GFP_KERNEL);
@@ -725,13 +732,36 @@ static int mc13xxx_probe(struct spi_device *spi)
 	spi->bits_per_word =3D 32;
 	spi_setup(spi);
=20
+	mc13xxx->dev =3D &spi->dev;
 	mc13xxx->spidev =3D spi;
+	mc13xxx->read_dev =3D mc13xxx_spi_reg_read;
+	mc13xxx->write_dev =3D mc13xxx_spi_reg_write;
+
+	ret =3D mc13xxx_common_init(mc13xxx, pdata, spi->irq);
+
+	if (ret) {
+		dev_set_drvdata(&spi->dev, NULL);
+	} else {
+		const struct spi_device_id *devid =3D
+			spi_get_device_id(mc13xxx->spidev);
+		if (!devid || devid->driver_data !=3D mc13xxx->ictype)
+			dev_warn(mc13xxx->dev,
+				"device id doesn't match auto detection!\n");
+	}
+
+	return ret;
+}
+
+int mc13xxx_common_init(struct mc13xxx *mc13xxx,
+		struct mc13xxx_platform_data *pdata, int irq)
+{
+	int ret;
=20
 	mutex_init(&mc13xxx->lock);
 	mc13xxx_lock(mc13xxx);
=20
=2D	ret =3D mc13xxx_identify(mc13xxx, &id);
=2D	if (ret || id =3D=3D MC13XXX_ID_INVALID)
+	ret =3D mc13xxx_identify(mc13xxx);
+	if (ret)
 		goto err_revision;
=20
 	/* mask all irqs */
@@ -743,14 +773,13 @@ static int mc13xxx_probe(struct spi_device *spi)
 	if (ret)
 		goto err_mask;
=20
=2D	ret =3D request_threaded_irq(spi->irq, NULL, mc13xxx_irq_thread,
+	ret =3D request_threaded_irq(irq, NULL, mc13xxx_irq_thread,
 			IRQF_ONESHOT | IRQF_TRIGGER_HIGH, "mc13xxx", mc13xxx);
=20
 	if (ret) {
 err_mask:
 err_revision:
 		mutex_unlock(&mc13xxx->lock);
=2D		dev_set_drvdata(&spi->dev, NULL);
 		kfree(mc13xxx);
 		return ret;
 	}
@@ -786,6 +815,7 @@ err_revision:
=20
 	return 0;
 }
+EXPORT_SYMBOL_GPL(mc13xxx_common_init);
=20
 static int __devexit mc13xxx_remove(struct spi_device *spi)
 {
diff --git a/include/linux/mfd/mc13xxx.h b/include/linux/mfd/mc13xxx.h
index a1d391b..f5d277d 100644
=2D-- a/include/linux/mfd/mc13xxx.h
+++ b/include/linux/mfd/mc13xxx.h
@@ -21,6 +21,11 @@ int mc13xxx_reg_write(struct mc13xxx *mc13xxx, unsigned =
int offset, u32 val);
 int mc13xxx_reg_rmw(struct mc13xxx *mc13xxx, unsigned int offset,
 		u32 mask, u32 val);
=20
+struct mc13xxx_platform_data;
+
+int mc13xxx_common_init(struct mc13xxx *mc13xxx,
+		struct mc13xxx_platform_data *pdata, int irq);
+
 int mc13xxx_get_flags(struct mc13xxx *mc13xxx);
=20
 int mc13xxx_irq_request(struct mc13xxx *mc13xxx, int irq,

--Boundary-00=_BxyYNpMDv+rlOKk
Content-Type: text/x-patch;
  charset="UTF-8";
  name="v4-2-4-mc13xxx-core-Kconfig-Config-menu-driven-by-specific-IC-type.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="v4-2-4-mc13xxx-core-Kconfig-Config-menu-driven-by-specific-IC-type.patch"

=46rom patchwork Tue Jan  4 05:34:57 2011
Content-Type: text/plain; charset=3D"utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [v4,
 2/4] mc13xxx-core: Kconfig: Config menu driven by specific IC type
Date: Tue, 04 Jan 2011 05:34:57 -0000
=46rom: Marc Reilly <marc@cpdesign.com.au>
X-Patchwork-Id: 449531
Message-Id: <1294119299-18352-3-git-send-email-marc@cpdesign.com.au>
To: linux-arm-kernel@lists.infradead.org, u.kleine-koenig@pengutronix.de
Cc: spi-devel-general@lists.sourceforge.net, linux-i2c@vger.kernel.org,
 Marc Reilly <marc@cpdesign.com.au>

This patch makes config items for the mc13892 and mc13783 distinct and
splits introduces a separate config item for spi interface support in
preparation for a separate i2c and spi backend.

The mc13xxx generic core is therefore selected by the spi (or i2c) item:
having it the other way around doesn't work for other drivers that will
need to distinguish between mc13783 and mc13892 (at build time).

Signed-off-by: Marc Reilly <marc@cpdesign.com.au>

=2D--
drivers/mfd/Kconfig |   34 +++++++++++++++++++++++++---------
 1 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 3a1493b..9ce1d42 100644
=2D-- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -425,20 +425,36 @@ config MFD_PCF50633
 	  so that function-specific drivers can bind to them.
=20
 config MFD_MC13783
=2D	tristate
=2D
=2Dconfig MFD_MC13XXX
=2D	tristate "Support Freescale MC13783 and MC13892"
 	depends on SPI_MASTER
=2D	select MFD_CORE
=2D	select MFD_MC13783
+	select MFD_MC13XXX_SPI
+	tristate "Support for Freescale MC13783 PMIC"
 	help
=2D	  Support for the Freescale (Atlas) PMIC and audio CODECs
=2D	  MC13783 and MC13892.
=2D	  This driver provides common support for accessing  the device,
+	  Support for the Freescale MC13783 PMIC and audio CODEC.
+	  This driver provides common support for accessing the device,
 	  additional drivers must be enabled in order to use the
 	  functionality of the device.
=20
+config MFD_MC13892
+	depends on SPI_MASTER || I2C
+	select MFD_MC13XXX
+	tristate "Support for Freescale MC13892 PMIC"
+	help
+	  Enable support for the Freescale MC13892 PMIC.
+	  As the MC13892 can connect by either I2C or SPI bus, you will
+	  also need to select which of these you would like to support.
+	  Additional drivers must be enabled in order to use the
+	  functionality of the device.
+
+config MFD_MC13XXX
+	tristate
+	depends on SPI_MASTER || I2C
+	select MFD_CORE
+
+config MFD_MC13XXX_SPI
+	tristate "Support Freescale MC13783 and MC13892 via SPI interface"
+	select MFD_MC13XXX
+	depends on SPI_MASTER && (MFD_MC13783 || MFD_MC13892)
+
 config PCF50633_ADC
 	tristate "Support for NXP PCF50633 ADC"
 	depends on MFD_PCF50633

--Boundary-00=_BxyYNpMDv+rlOKk
Content-Type: text/x-patch;
  charset="UTF-8";
  name="v4-3-4-mc13xxx-core-Move-spi-specific-code-into-separate-module..patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="v4-3-4-mc13xxx-core-Move-spi-specific-code-into-separate-module..patch"

=46rom patchwork Tue Jan  4 05:34:58 2011
Content-Type: text/plain; charset=3D"utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [v4,3/4] mc13xxx-core: Move spi specific code into separate module.
Date: Tue, 04 Jan 2011 05:34:58 -0000
=46rom: Marc Reilly <marc@cpdesign.com.au>
X-Patchwork-Id: 449561
Message-Id: <1294119299-18352-4-git-send-email-marc@cpdesign.com.au>
To: linux-arm-kernel@lists.infradead.org, u.kleine-koenig@pengutronix.de
Cc: spi-devel-general@lists.sourceforge.net, linux-i2c@vger.kernel.org,
 Marc Reilly <marc@cpdesign.com.au>

This patch moves all spi specific code into a new module. The mc13xxx
struct moves to the include file by necessity.

Signed-off-by: Marc Reilly <marc@cpdesign.com.au>

=2D--
drivers/mfd/Makefile        |    1 +
 drivers/mfd/mc13xxx-core.c  |  166 ---------------------------------------=
=2D--
 drivers/mfd/mc13xxx-spi.c   |  168 +++++++++++++++++++++++++++++++++++++++=
++++
 include/linux/mfd/mc13xxx.h |   21 ++++++
 4 files changed, 190 insertions(+), 166 deletions(-)
 create mode 100644 drivers/mfd/mc13xxx-spi.c

diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index f54b365..492e881 100644
=2D-- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -42,6 +42,7 @@ obj-$(CONFIG_TWL4030_CODEC)	+=3D twl4030-codec.o
 obj-$(CONFIG_TWL6030_PWM)	+=3D twl6030-pwm.o
=20
 obj-$(CONFIG_MFD_MC13XXX)	+=3D mc13xxx-core.o
+obj-$(CONFIG_MFD_MC13XXX_SPI)	+=3D mc13xxx-spi.o
=20
 obj-$(CONFIG_MFD_CORE)		+=3D mfd-core.o
=20
diff --git a/drivers/mfd/mc13xxx-core.c b/drivers/mfd/mc13xxx-core.c
index d1f1d7b..3201041 100644
=2D-- a/drivers/mfd/mc13xxx-core.c
+++ b/drivers/mfd/mc13xxx-core.c
@@ -15,31 +15,9 @@
 #include <linux/platform_device.h>
 #include <linux/mutex.h>
 #include <linux/interrupt.h>
=2D#include <linux/spi/spi.h>
 #include <linux/mfd/core.h>
 #include <linux/mfd/mc13xxx.h>
=20
=2Denum mc13xxx_id {
=2D	MC13XXX_ID_MC13783,
=2D	MC13XXX_ID_MC13892,
=2D	MC13XXX_ID_INVALID,
=2D};
=2D
=2Dstruct mc13xxx {
=2D	struct spi_device *spidev;
=2D
=2D	struct device *dev;
=2D	enum mc13xxx_id ictype;
=2D
=2D	struct mutex lock;
=2D
=2D	int (*read_dev)(struct mc13xxx *, unsigned int, u32 *);
=2D	int (*write_dev)(struct mc13xxx *, unsigned int, u32);
=2D
=2D	irq_handler_t irqhandler[MC13XXX_NUM_IRQ];
=2D	void *irqdata[MC13XXX_NUM_IRQ];
=2D};
=2D
 struct mc13783 {
 	struct mc13xxx mc13xxx;
=20
@@ -180,38 +158,6 @@ void mc13xxx_unlock(struct mc13xxx *mc13xxx)
 }
 EXPORT_SYMBOL(mc13xxx_unlock);
=20
=2D#define MC13XXX_REGOFFSET_SHIFT 25
=2Dstatic int mc13xxx_spi_reg_read(struct mc13xxx *mc13xxx,
=2D				unsigned int offset, u32 *val)
=2D{
=2D	struct spi_transfer t;
=2D	struct spi_message m;
=2D	int ret;
=2D
=2D	*val =3D offset << MC13XXX_REGOFFSET_SHIFT;
=2D
=2D	memset(&t, 0, sizeof(t));
=2D
=2D	t.tx_buf =3D val;
=2D	t.rx_buf =3D val;
=2D	t.len =3D sizeof(u32);
=2D
=2D	spi_message_init(&m);
=2D	spi_message_add_tail(&t, &m);
=2D
=2D	ret =3D spi_sync(mc13xxx->spidev, &m);
=2D
=2D	/* error in message.status implies error return from spi_sync */
=2D	BUG_ON(!ret && m.status);
=2D
=2D	if (ret)
=2D		return ret;
=2D
=2D	*val &=3D 0xffffff;
=2D
=2D	return 0;
=2D}
=2D
 int mc13xxx_reg_read(struct mc13xxx *mc13xxx, unsigned int offset, u32 *va=
l)
 {
 	int ret;
@@ -228,35 +174,6 @@ int mc13xxx_reg_read(struct mc13xxx *mc13xxx, unsigned=
 int offset, u32 *val)
 }
 EXPORT_SYMBOL(mc13xxx_reg_read);
=20
=2Dstatic int mc13xxx_spi_reg_write(struct mc13xxx *mc13xxx, unsigned int o=
ffset,
=2D		u32 val)
=2D{
=2D	u32 buf;
=2D	struct spi_transfer t;
=2D	struct spi_message m;
=2D	int ret;
=2D
=2D	buf =3D 1 << 31 | offset << MC13XXX_REGOFFSET_SHIFT | val;
=2D
=2D	memset(&t, 0, sizeof(t));
=2D
=2D	t.tx_buf =3D &buf;
=2D	t.rx_buf =3D &buf;
=2D	t.len =3D sizeof(u32);
=2D
=2D	spi_message_init(&m);
=2D	spi_message_add_tail(&t, &m);
=2D
=2D	ret =3D spi_sync(mc13xxx->spidev, &m);
=2D
=2D	BUG_ON(!ret && m.status);
=2D
=2D	if (ret)
=2D		return ret;
=2D
=2D	return 0;
=2D}
=2D
 int mc13xxx_reg_write(struct mc13xxx *mc13xxx, unsigned int offset, u32 va=
l)
 {
 	BUG_ON(!mutex_is_locked(&mc13xxx->lock));
@@ -717,41 +634,6 @@ static int mc13xxx_add_subdevice(struct mc13xxx *mc13x=
xx, const char *format)
 	return mc13xxx_add_subdevice_pdata(mc13xxx, format, NULL, 0);
 }
=20
=2Dstatic int mc13xxx_probe(struct spi_device *spi)
=2D{
=2D	struct mc13xxx *mc13xxx;
=2D	struct mc13xxx_platform_data *pdata =3D dev_get_platdata(&spi->dev);
=2D	int ret;
=2D
=2D	mc13xxx =3D kzalloc(sizeof(*mc13xxx), GFP_KERNEL);
=2D	if (!mc13xxx)
=2D		return -ENOMEM;
=2D
=2D	dev_set_drvdata(&spi->dev, mc13xxx);
=2D	spi->mode =3D SPI_MODE_0 | SPI_CS_HIGH;
=2D	spi->bits_per_word =3D 32;
=2D	spi_setup(spi);
=2D
=2D	mc13xxx->dev =3D &spi->dev;
=2D	mc13xxx->spidev =3D spi;
=2D	mc13xxx->read_dev =3D mc13xxx_spi_reg_read;
=2D	mc13xxx->write_dev =3D mc13xxx_spi_reg_write;
=2D
=2D	ret =3D mc13xxx_common_init(mc13xxx, pdata, spi->irq);
=2D
=2D	if (ret) {
=2D		dev_set_drvdata(&spi->dev, NULL);
=2D	} else {
=2D		const struct spi_device_id *devid =3D
=2D			spi_get_device_id(mc13xxx->spidev);
=2D		if (!devid || devid->driver_data !=3D mc13xxx->ictype)
=2D			dev_warn(mc13xxx->dev,
=2D				"device id doesn't match auto detection!\n");
=2D	}
=2D
=2D	return ret;
=2D}
=2D
 int mc13xxx_common_init(struct mc13xxx *mc13xxx,
 		struct mc13xxx_platform_data *pdata, int irq)
 {
@@ -817,54 +699,6 @@ err_revision:
 }
 EXPORT_SYMBOL_GPL(mc13xxx_common_init);
=20
=2Dstatic int __devexit mc13xxx_remove(struct spi_device *spi)
=2D{
=2D	struct mc13xxx *mc13xxx =3D dev_get_drvdata(&spi->dev);
=2D
=2D	free_irq(mc13xxx->spidev->irq, mc13xxx);
=2D
=2D	mfd_remove_devices(&spi->dev);
=2D
=2D	kfree(mc13xxx);
=2D
=2D	return 0;
=2D}
=2D
=2Dstatic const struct spi_device_id mc13xxx_device_id[] =3D {
=2D	{
=2D		.name =3D "mc13783",
=2D		.driver_data =3D MC13XXX_ID_MC13783,
=2D	}, {
=2D		.name =3D "mc13892",
=2D		.driver_data =3D MC13XXX_ID_MC13892,
=2D	}, {
=2D		/* sentinel */
=2D	}
=2D};
=2D
=2Dstatic struct spi_driver mc13xxx_driver =3D {
=2D	.id_table =3D mc13xxx_device_id,
=2D	.driver =3D {
=2D		.name =3D "mc13xxx",
=2D		.bus =3D &spi_bus_type,
=2D		.owner =3D THIS_MODULE,
=2D	},
=2D	.probe =3D mc13xxx_probe,
=2D	.remove =3D __devexit_p(mc13xxx_remove),
=2D};
=2D
=2Dstatic int __init mc13xxx_init(void)
=2D{
=2D	return spi_register_driver(&mc13xxx_driver);
=2D}
=2Dsubsys_initcall(mc13xxx_init);
=2D
=2Dstatic void __exit mc13xxx_exit(void)
=2D{
=2D	spi_unregister_driver(&mc13xxx_driver);
=2D}
=2Dmodule_exit(mc13xxx_exit);
=2D
 MODULE_DESCRIPTION("Core driver for Freescale MC13XXX PMIC");
 MODULE_AUTHOR("Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/mfd/mc13xxx-spi.c b/drivers/mfd/mc13xxx-spi.c
new file mode 100644
index 0000000..d8ffff7
=2D-- /dev/null
+++ b/drivers/mfd/mc13xxx-spi.c
@@ -0,0 +1,168 @@
+/*
+ * Copyright 2009-2010 Pengutronix
+ * Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
+ *
+ * loosely based on an earlier driver that has
+ * Copyright 2009 Pengutronix, Sascha Hauer <s.hauer@pengutronix.de>
+ *
+ * This program is free software; you can redistribute it and/or modify it=
 under
+ * the terms of the GNU General Public License version 2 as published by t=
he
+ * Free Software Foundation.
+ */
+
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/mutex.h>
+#include <linux/interrupt.h>
+#include <linux/spi/spi.h>
+#include <linux/mfd/core.h>
+#include <linux/mfd/mc13xxx.h>
+
+#define MC13XXX_REGOFFSET_SHIFT 25
+static int mc13xxx_spi_reg_read(struct mc13xxx *mc13xxx,
+				unsigned int offset, u32 *val)
+{
+	struct spi_transfer t;
+	struct spi_message m;
+	int ret;
+
+	*val =3D offset << MC13XXX_REGOFFSET_SHIFT;
+
+	memset(&t, 0, sizeof(t));
+
+	t.tx_buf =3D val;
+	t.rx_buf =3D val;
+	t.len =3D sizeof(u32);
+
+	spi_message_init(&m);
+	spi_message_add_tail(&t, &m);
+
+	ret =3D spi_sync(mc13xxx->spidev, &m);
+
+	/* error in message.status implies error return from spi_sync */
+	BUG_ON(!ret && m.status);
+
+	if (ret)
+		return ret;
+
+	*val &=3D 0xffffff;
+
+	return 0;
+}
+
+static int mc13xxx_spi_reg_write(struct mc13xxx *mc13xxx, unsigned int off=
set,
+		u32 val)
+{
+	u32 buf;
+	struct spi_transfer t;
+	struct spi_message m;
+	int ret;
+
+	buf =3D 1 << 31 | offset << MC13XXX_REGOFFSET_SHIFT | val;
+
+	memset(&t, 0, sizeof(t));
+
+	t.tx_buf =3D &buf;
+	t.rx_buf =3D &buf;
+	t.len =3D sizeof(u32);
+
+	spi_message_init(&m);
+	spi_message_add_tail(&t, &m);
+
+	ret =3D spi_sync(mc13xxx->spidev, &m);
+
+	BUG_ON(!ret && m.status);
+
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int mc13xxx_spi_probe(struct spi_device *spi)
+{
+	struct mc13xxx *mc13xxx;
+	struct mc13xxx_platform_data *pdata =3D dev_get_platdata(&spi->dev);
+	int ret;
+
+	mc13xxx =3D kzalloc(sizeof(*mc13xxx), GFP_KERNEL);
+	if (!mc13xxx)
+		return -ENOMEM;
+
+	dev_set_drvdata(&spi->dev, mc13xxx);
+	spi->mode =3D SPI_MODE_0 | SPI_CS_HIGH;
+	spi->bits_per_word =3D 32;
+	spi_setup(spi);
+
+	mc13xxx->dev =3D &spi->dev;
+	mc13xxx->spidev =3D spi;
+	mc13xxx->read_dev =3D mc13xxx_spi_reg_read;
+	mc13xxx->write_dev =3D mc13xxx_spi_reg_write;
+
+	ret =3D mc13xxx_common_init(mc13xxx, pdata, spi->irq);
+
+	if (ret) {
+		dev_set_drvdata(&spi->dev, NULL);
+	} else {
+		const struct spi_device_id *devid =3D
+			spi_get_device_id(mc13xxx->spidev);
+		if (!devid || devid->driver_data !=3D mc13xxx->ictype)
+			dev_warn(mc13xxx->dev,
+				"device id doesn't match auto detection!\n");
+	}
+
+	return ret;
+}
+
+static int __devexit mc13xxx_spi_remove(struct spi_device *spi)
+{
+	struct mc13xxx *mc13xxx =3D dev_get_drvdata(&spi->dev);
+
+	free_irq(mc13xxx->spidev->irq, mc13xxx);
+
+	mfd_remove_devices(&spi->dev);
+
+	kfree(mc13xxx);
+
+	return 0;
+}
+
+static const struct spi_device_id mc13xxx_device_id[] =3D {
+	{
+		.name =3D "mc13783",
+		.driver_data =3D MC13XXX_ID_MC13783,
+	}, {
+		.name =3D "mc13892",
+		.driver_data =3D MC13XXX_ID_MC13892,
+	}, {
+		/* sentinel */
+	}
+};
+
+static struct spi_driver mc13xxx_spi_driver =3D {
+	.id_table =3D mc13xxx_device_id,
+	.driver =3D {
+		.name =3D "mc13xxx",
+		.bus =3D &spi_bus_type,
+		.owner =3D THIS_MODULE,
+	},
+	.probe =3D mc13xxx_spi_probe,
+	.remove =3D __devexit_p(mc13xxx_spi_remove),
+};
+
+static int __init mc13xxx_spi_init(void)
+{
+	return spi_register_driver(&mc13xxx_spi_driver);
+}
+subsys_initcall(mc13xxx_spi_init);
+
+static void __exit mc13xxx_spi_exit(void)
+{
+	spi_unregister_driver(&mc13xxx_spi_driver);
+}
+module_exit(mc13xxx_spi_exit);
+
+MODULE_DESCRIPTION("Core driver for Freescale MC13XXX PMIC");
+MODULE_AUTHOR("Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/mfd/mc13xxx.h b/include/linux/mfd/mc13xxx.h
index f5d277d..ab7deb3 100644
=2D-- a/include/linux/mfd/mc13xxx.h
+++ b/include/linux/mfd/mc13xxx.h
@@ -66,6 +66,27 @@ int mc13xxx_get_flags(struct mc13xxx *mc13xxx);
=20
 #define MC13XXX_NUM_IRQ		46
=20
+enum mc13xxx_id {
+	MC13XXX_ID_MC13783,
+	MC13XXX_ID_MC13892,
+	MC13XXX_ID_INVALID,
+};
+
+struct mc13xxx {
+	struct spi_device *spidev;
+
+	struct device *dev;
+	enum mc13xxx_id ictype;
+
+	struct mutex lock;
+
+	int (*read_dev)(struct mc13xxx *, unsigned int, u32 *);
+	int (*write_dev)(struct mc13xxx *, unsigned int, u32);
+
+	irq_handler_t irqhandler[MC13XXX_NUM_IRQ];
+	void *irqdata[MC13XXX_NUM_IRQ];
+};
+
 struct regulator_init_data;
=20
 struct mc13xxx_regulator_init_data {

--Boundary-00=_BxyYNpMDv+rlOKk
Content-Type: text/x-patch;
  charset="UTF-8";
  name="v4-4-4-mc13xxx-core-Add-i2c-driver.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="v4-4-4-mc13xxx-core-Add-i2c-driver.patch"

=46rom patchwork Tue Jan  4 05:34:59 2011
Content-Type: text/plain; charset=3D"utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [v4,4/4] mc13xxx-core: Add i2c driver
Date: Tue, 04 Jan 2011 05:34:59 -0000
=46rom: Marc Reilly <marc@cpdesign.com.au>
X-Patchwork-Id: 449551
Message-Id: <1294119299-18352-5-git-send-email-marc@cpdesign.com.au>
To: linux-arm-kernel@lists.infradead.org, u.kleine-koenig@pengutronix.de
Cc: spi-devel-general@lists.sourceforge.net, linux-i2c@vger.kernel.org,
 Marc Reilly <marc@cpdesign.com.au>

Signed-off-by: Marc Reilly <marc@cpdesign.com.au>

=2D--
drivers/mfd/Kconfig         |    5 ++
 drivers/mfd/Makefile        |    1 +
 drivers/mfd/mc13xxx-i2c.c   |  115 +++++++++++++++++++++++++++++++++++++++=
++++
 include/linux/mfd/mc13xxx.h |    5 ++-
 4 files changed, 125 insertions(+), 1 deletions(-)
 create mode 100644 drivers/mfd/mc13xxx-i2c.c

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 9ce1d42..fbbbdaa 100644
=2D-- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -455,6 +455,11 @@ config MFD_MC13XXX_SPI
 	select MFD_MC13XXX
 	depends on SPI_MASTER && (MFD_MC13783 || MFD_MC13892)
=20
+config MFD_MC13XXX_I2C
+	tristate "Support Freescale MC13892 via I2C interface"
+	select MFD_MC13XXX
+	depends on I2C && MFD_MC13892
+
 config PCF50633_ADC
 	tristate "Support for NXP PCF50633 ADC"
 	depends on MFD_PCF50633
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 492e881..b7d774f 100644
=2D-- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -43,6 +43,7 @@ obj-$(CONFIG_TWL6030_PWM)	+=3D twl6030-pwm.o
=20
 obj-$(CONFIG_MFD_MC13XXX)	+=3D mc13xxx-core.o
 obj-$(CONFIG_MFD_MC13XXX_SPI)	+=3D mc13xxx-spi.o
+obj-$(CONFIG_MFD_MC13XXX_I2C)	+=3D mc13xxx-i2c.o
=20
 obj-$(CONFIG_MFD_CORE)		+=3D mfd-core.o
=20
diff --git a/drivers/mfd/mc13xxx-i2c.c b/drivers/mfd/mc13xxx-i2c.c
new file mode 100644
index 0000000..b3f2f2b
=2D-- /dev/null
+++ b/drivers/mfd/mc13xxx-i2c.c
@@ -0,0 +1,115 @@
+/*
+ * Copyright 2009-2010 Creative Product Design
+ * Marc Reilly marc@cpdesign.com.au
+ *
+ * This program is free software; you can redistribute it and/or modify it=
 under
+ * the terms of the GNU General Public License version 2 as published by t=
he
+ * Free Software Foundation.
+ */
+
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/mutex.h>
+#include <linux/mfd/core.h>
+#include <linux/mfd/mc13xxx.h>
+#include <linux/i2c.h>
+
+static int mc13xxx_i2c_reg_read(struct mc13xxx *mc13xxx, unsigned int offs=
et,
+		u32 *val)
+{
+	int ret;
+	unsigned char buf[3] =3D {0, 0, 0};
+
+	ret =3D i2c_smbus_read_i2c_block_data(mc13xxx->i2cclient,
+			offset, 3, buf);
+	*val =3D buf[0] << 16 | buf[1] << 8 | buf[2];
+
+	return ret =3D=3D 3 ? 0 : ret;
+}
+
+static int mc13xxx_i2c_reg_write(struct mc13xxx *mc13xxx, unsigned int off=
set,
+		u32 val)
+{
+	int ret;
+	unsigned char buf[3];
+
+	buf[0] =3D (val >> 16) & 0xff;
+	buf[1] =3D (val >> 8) & 0xff;
+	buf[2] =3D val & 0xff;
+
+	ret =3D i2c_smbus_write_i2c_block_data(mc13xxx->i2cclient,
+			offset, 3, buf);
+
+	return ret;
+}
+
+static int mc13xxx_i2c_probe(struct i2c_client *client,
+		const struct i2c_device_id *id)
+{
+	struct mc13xxx *mc13xxx;
+	struct mc13xxx_platform_data *pdata =3D dev_get_platdata(&client->dev);
+	int ret;
+
+	mc13xxx =3D kzalloc(sizeof(*mc13xxx), GFP_KERNEL);
+	if (!mc13xxx)
+		return -ENOMEM;
+
+	dev_set_drvdata(&client->dev, mc13xxx);
+	mc13xxx->dev =3D &client->dev;
+	mc13xxx->i2cclient =3D client;
+	mc13xxx->read_dev =3D mc13xxx_i2c_reg_read;
+	mc13xxx->write_dev =3D mc13xxx_i2c_reg_write;
+
+	ret =3D mc13xxx_common_init(mc13xxx, pdata, client->irq);
+
+	if (ret =3D=3D 0 && (id->driver_data !=3D mc13xxx->ictype))
+		dev_warn(mc13xxx->dev,
+				"device id doesn't match auto detection!\n");
+
+	return ret;
+}
+
+static int __devexit mc13xxx_i2c_remove(struct i2c_client *client)
+{
+	struct mc13xxx *mc13xxx =3D dev_get_drvdata(&client->dev);
+
+	free_irq(client->irq, mc13xxx);
+
+	mfd_remove_devices(&client->dev);
+
+	kfree(mc13xxx);
+
+	return 0;
+}
+
+static const struct i2c_device_id mc13xxx_i2c_idtable[] =3D {
+	{"mc13892", MC13XXX_ID_MC13892},
+	{ }
+};
+
+static struct i2c_driver mc13xxx_i2c_driver =3D {
+	.driver =3D {
+		.owner =3D THIS_MODULE,
+		.name =3D "mc13xxx-i2c"
+	},
+	.id_table =3D mc13xxx_i2c_idtable,
+	.probe =3D mc13xxx_i2c_probe,
+	.remove =3D __devexit_p(mc13xxx_i2c_remove),
+};
+
+static int __init mc13xxx_i2c_init(void)
+{
+	return i2c_add_driver(&mc13xxx_i2c_driver);
+}
+subsys_initcall(mc13xxx_i2c_init);
+
+static void __exit mc13xxx_i2c_exit(void)
+{
+	i2c_del_driver(&mc13xxx_i2c_driver);
+}
+module_exit(mc13xxx_i2c_exit);
+
+MODULE_DESCRIPTION("i2c driver for Freescale MC13XXX PMIC");
+MODULE_AUTHOR("Marc Reilly <marc@cpdesign.com.au");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/mfd/mc13xxx.h b/include/linux/mfd/mc13xxx.h
index ab7deb3..c5ab08b 100644
=2D-- a/include/linux/mfd/mc13xxx.h
+++ b/include/linux/mfd/mc13xxx.h
@@ -73,7 +73,10 @@ enum mc13xxx_id {
 };
=20
 struct mc13xxx {
=2D	struct spi_device *spidev;
+	union {
+		struct spi_device *spidev;
+		struct i2c_client *i2cclient;
+	};
=20
 	struct device *dev;
 	enum mc13xxx_id ictype;

--Boundary-00=_BxyYNpMDv+rlOKk
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--Boundary-00=_BxyYNpMDv+rlOKk--
