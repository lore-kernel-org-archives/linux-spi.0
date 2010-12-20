From: Marc Reilly <marc-DtE7ei5U7Kg0n/F98K4Iww@public.gmane.org>
Subject: Re: [PATCHv3 1/4] mc13xxx-core: Consolidate common code to prepare for separate i2c and spi
Date: Mon, 20 Dec 2010 21:00:29 +1100
Message-ID: <201012202100.29212.marc@cpdesign.com.au>
References: <1292817055-17715-1-git-send-email-marc@cpdesign.com.au> <1292817055-17715-2-git-send-email-marc@cpdesign.com.au> <20101220083120.GP1940@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Uwe =?iso-8859-1?q?Kleine-K=F6nig?="
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20101220083120.GP1940-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Uwe,

Thanks again for your comments, and your patience :)

On Monday, December 20, 2010 07:31:20 pm Uwe Kleine-K=F6nig wrote:
> On Mon, Dec 20, 2010 at 02:50:52PM +1100, Marc Reilly wrote:
> > This patch moves common mc13xxx definitions to the header file in
> > preparation for separate i2c and spi driver modules.
> > spi specific functions are also removed.
> >=20
> > Changes to the mc13xxx struct are:
> > removing the redundant irq member,
> > adding driver read/write function ptrs,
> > adding ictype
>=20
> This list isn't complete, but see below.

Do you mean the list above is incomplete? I should have said "Changes t=
o the=20
struct _include_".=20
I'm ignorant of "patch summary etiquette" (or what people otherwise lik=
e to=20
see) but I had just assumed that the patch comments were more like a=20
highlights reel - the real info is in the patch itself.

Or did you just mean that your list of critiques is incomplete? :)

>=20
> I don't like that after this patch the driver isn't functional, becau=
se
> you removed the spi functionality which breaks bisection.

OK. I should introduce things more slowly, like adding the read/write f=
unction=20
ptrs and splitting out the common code. Then move the spi code, then ad=
d the=20
i2c driver... =20

>=20
> > Signed-off-by: Marc Reilly <marc-DtE7ei5U7Kg0n/F98K4Iww@public.gmane.org>
> > ---
> >=20
> >  drivers/mfd/mc13xxx-core.c  |  207
> >  +++++++----------------------------------- include/linux/mfd/mc13x=
xx.h
> >  |   77 +++++++++++-----
> >  2 files changed, 87 insertions(+), 197 deletions(-)
> >=20
> > diff --git a/drivers/mfd/mc13xxx-core.c b/drivers/mfd/mc13xxx-core.=
c
> > index a2ac2ed..3367a40 100644
> > --- a/drivers/mfd/mc13xxx-core.c
> > +++ b/drivers/mfd/mc13xxx-core.c
> > @@ -9,24 +9,14 @@
> >=20
> >   * the terms of the GNU General Public License version 2 as publis=
hed by
> >   the * Free Software Foundation.
> >   */
> >=20
> > -
>=20
> (hmm.  I think there is no style guide for that, but I know people wh=
o
> think that this nl should be there.  So IMHO don't touch this.)

=46ollow over from the first time around. I don't notice it because I d=
on't=20
really care - but I understand why people might.=20
And because I don't care, it can go back in without further hassle :)

>=20
> >  #include <linux/slab.h>
> >  #include <linux/module.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/mutex.h>
> >  #include <linux/interrupt.h>
> >=20
> > -#include <linux/spi/spi.h>
> >=20
> >  #include <linux/mfd/core.h>
> >  #include <linux/mfd/mc13xxx.h>
> >=20
> > -struct mc13xxx {
> > -	struct spi_device *spidev;
> > -	struct mutex lock;
> > -	int irq;
> > -
> > -	irq_handler_t irqhandler[MC13XXX_NUM_IRQ];
> > -	void *irqdata[MC13XXX_NUM_IRQ];
> > -};
> >=20
> >  struct mc13783 {
> > =20
> >  	struct mc13xxx mc13xxx;
> >=20
> > @@ -150,99 +140,53 @@ EXPORT_SYMBOL(mc13783_to_mc13xxx);
> >=20
> >  void mc13xxx_lock(struct mc13xxx *mc13xxx)
> >  {
> > =20
> >  	if (!mutex_trylock(&mc13xxx->lock)) {
> >=20
> > -		dev_dbg(&mc13xxx->spidev->dev, "wait for %s from %pf\n",
> > +		dev_dbg(mc13xxx->dev, "wait for %s from %pf\n",
> >=20
> >  				__func__, __builtin_return_address(0));
> >  	=09
> >  		mutex_lock(&mc13xxx->lock);
> >  =09
> >  	}
> >=20
> > -	dev_dbg(&mc13xxx->spidev->dev, "%s from %pf\n",
> > +	dev_dbg(mc13xxx->dev, "%s from %pf\n",
> >=20
> >  			__func__, __builtin_return_address(0));
> > =20
> >  }
> >  EXPORT_SYMBOL(mc13xxx_lock);
> > =20
> >  void mc13xxx_unlock(struct mc13xxx *mc13xxx)
> >  {
> >=20
> > -	dev_dbg(&mc13xxx->spidev->dev, "%s from %pf\n",
> > +	dev_dbg(mc13xxx->dev, "%s from %pf\n",
> >=20
> >  			__func__, __builtin_return_address(0));
> >  =09
> >  	mutex_unlock(&mc13xxx->lock);
> > =20
> >  }
> >  EXPORT_SYMBOL(mc13xxx_unlock);
> >=20
> > -#define MC13XXX_REGOFFSET_SHIFT 25
> >=20
> >  int mc13xxx_reg_read(struct mc13xxx *mc13xxx, unsigned int offset,=
 u32
> >  *val) {
> >=20
> > -	struct spi_transfer t;
> > -	struct spi_message m;
> >=20
> >  	int ret;
> >=20
> > -
> >=20
> >  	BUG_ON(!mutex_is_locked(&mc13xxx->lock));
> >  =09
> >  	if (offset > MC13XXX_NUMREGS)
> >  =09
> >  		return -EINVAL;
> >=20
> > -	*val =3D offset << MC13XXX_REGOFFSET_SHIFT;
> > -
> > -	memset(&t, 0, sizeof(t));
> > -
> > -	t.tx_buf =3D val;
> > -	t.rx_buf =3D val;
> > -	t.len =3D sizeof(u32);
> > -
> > -	spi_message_init(&m);
> > -	spi_message_add_tail(&t, &m);
> > -
> > -	ret =3D spi_sync(mc13xxx->spidev, &m);
> > -
> > -	/* error in message.status implies error return from spi_sync */
> > -	BUG_ON(!ret && m.status);
> > +	ret =3D mc13xxx->read_dev(mc13xxx, offset, val);
> > +	dev_vdbg(mc13xxx->dev, "[0x%02x] -> 0x%06x\n", offset, *val);
> >=20
> > -	if (ret)
> > -		return ret;
> > -
> > -	*val &=3D 0xffffff;
> > -
> > -	dev_vdbg(&mc13xxx->spidev->dev, "[0x%02x] -> 0x%06x\n", offset, *=
val);
> > -
> > -	return 0;
> > +	return ret;
> >=20
> >  }
> >  EXPORT_SYMBOL(mc13xxx_reg_read);
> >=20
> > +
>=20
> no please
(whoops x2)

>=20
> >  int mc13xxx_reg_write(struct mc13xxx *mc13xxx, unsigned int offset=
, u32
> >  val) {
> >=20
> > -	u32 buf;
> > -	struct spi_transfer t;
> > -	struct spi_message m;
> > -	int ret;
> > -
> >=20
> >  	BUG_ON(!mutex_is_locked(&mc13xxx->lock));
> >=20
> > -
> > -	dev_vdbg(&mc13xxx->spidev->dev, "[0x%02x] <- 0x%06x\n", offset, v=
al);
> > +	dev_vdbg(mc13xxx->dev, "[0x%02x] <- 0x%06x\n", offset, val);
> >=20
> >  	if (offset > MC13XXX_NUMREGS || val > 0xffffff)
> >  =09
> >  		return -EINVAL;
> >=20
> > -	buf =3D 1 << 31 | offset << MC13XXX_REGOFFSET_SHIFT | val;
> > -
> > -	memset(&t, 0, sizeof(t));
> > -
> > -	t.tx_buf =3D &buf;
> > -	t.rx_buf =3D &buf;
> > -	t.len =3D sizeof(u32);
> > -
> > -	spi_message_init(&m);
> > -	spi_message_add_tail(&t, &m);
> > -
> > -	ret =3D spi_sync(mc13xxx->spidev, &m);
> > -
> > -	BUG_ON(!ret && m.status);
> > -
> > -	if (ret)
> > -		return ret;
> > -
> > -	return 0;
> > +	return mc13xxx->write_dev(mc13xxx, offset, val);
> >=20
> >  }
> >  EXPORT_SYMBOL(mc13xxx_reg_write);
> >=20
> > +
>=20
> no please
>=20
> >  int mc13xxx_reg_rmw(struct mc13xxx *mc13xxx, unsigned int offset,
> > =20
> >  		u32 mask, u32 val)
> > =20
> >  {
> >=20
> > @@ -445,7 +389,7 @@ static int mc13xxx_irq_handle(struct mc13xxx
> > *mc13xxx,
> >=20
> >  			if (handled =3D=3D IRQ_HANDLED)
> >  		=09
> >  				num_handled++;
> >  	=09
> >  		} else {
> >=20
> > -			dev_err(&mc13xxx->spidev->dev,
> > +			dev_err(mc13xxx->dev,
> >=20
> >  					"BUG: irq %u but no handler\n",
> >  					baseirq + irq);
> >=20
> > @@ -481,11 +425,6 @@ static irqreturn_t mc13xxx_irq_thread(int irq,=
 void
> > *data)
> >=20
> >  	return IRQ_RETVAL(handled);
> > =20
> >  }
> >=20
> > -enum mc13xxx_id {
> > -	MC13XXX_ID_MC13783,
> > -	MC13XXX_ID_MC13892,
> > -	MC13XXX_ID_INVALID,
> > -};
> >=20
> >  const char *mc13xxx_chipname[] =3D {
> > =20
> >  	[MC13XXX_ID_MC13783] =3D "mc13783",
> >=20
> > @@ -493,13 +432,16 @@ const char *mc13xxx_chipname[] =3D {
> >=20
> >  };
> > =20
> >  #define maskval(reg, mask)	(((reg) & (mask)) >> __ffs(mask))
> >=20
> > -static int mc13xxx_identify(struct mc13xxx *mc13xxx, enum mc13xxx_=
id
> > *id) +static int mc13xxx_identify(struct mc13xxx *mc13xxx)
> >=20
> >  {
> > =20
> >  	u32 icid;
> >  	u32 revision;
> >=20
> > -	const char *name;
> >=20
> >  	int ret;
> >=20
> > +	/* Get the generation ID from register 46, as apparently some old=
er
>=20
> /* should be on a seperate line

Sorry. You asked me to read the coding style docs for precisely this. I=
 did,=20
but then I saw it done this way in several other files and inadvertentl=
y=20
copied that.

>=20
> > +	 * ic revisions only have this info at this location. Newer ICs s=
eem to
> > +	 * have both.
> > +	 */
> >=20
> >  	ret =3D mc13xxx_reg_read(mc13xxx, 46, &icid);
> >  	if (ret)
> >  =09
> >  		return ret;
> >=20
> > @@ -508,26 +450,22 @@ static int mc13xxx_identify(struct mc13xxx
> > *mc13xxx, enum mc13xxx_id *id)
> >=20
> >  	switch (icid) {
> >=20
> >  	case 2:
> > -		*id =3D MC13XXX_ID_MC13783;
> > -		name =3D "mc13783";
> > +		mc13xxx->ictype =3D MC13XXX_ID_MC13783;
> >=20
> >  		break;
> >  =09
> >  	case 7:
> > -		*id =3D MC13XXX_ID_MC13892;
> > -		name =3D "mc13892";
> > +		mc13xxx->ictype =3D MC13XXX_ID_MC13892;
> >=20
> >  		break;
> >  =09
> >  	default:
> > -		*id =3D MC13XXX_ID_INVALID;
> > +		mc13xxx->ictype =3D MC13XXX_ID_INVALID;
> >=20
> >  		break;
> >  =09
> >  	}
> >=20
> > -	if (*id =3D=3D MC13XXX_ID_MC13783 || *id =3D=3D MC13XXX_ID_MC1389=
2) {
> > +	if (mc13xxx->ictype =3D=3D MC13XXX_ID_MC13783 ||
> > +			mc13xxx->ictype =3D=3D MC13XXX_ID_MC13892) {
> >=20
> >  		ret =3D mc13xxx_reg_read(mc13xxx, MC13XXX_REVISION, &revision);
> >=20
> > -		if (ret)
> > -			return ret;
> > -
> > -		dev_info(&mc13xxx->spidev->dev, "%s: rev: %d.%d, "
> > +		dev_info(mc13xxx->dev, "%s: rev: %d.%d, "
> >=20
> >  				"fin: %d, fab: %d, icid: %d/%d\n",
> >=20
> > -				mc13xxx_chipname[*id],
> > +				mc13xxx_chipname[mc13xxx->ictype],
> >=20
> >  				maskval(revision, MC13XXX_REVISION_REVFULL),
> >  				maskval(revision, MC13XXX_REVISION_REVMETAL),
> >  				maskval(revision, MC13XXX_REVISION_FIN),
> >=20
> > @@ -536,26 +474,12 @@ static int mc13xxx_identify(struct mc13xxx
> > *mc13xxx, enum mc13xxx_id *id)
> >=20
> >  				maskval(revision, MC13XXX_REVISION_ICIDCODE));
> >  =09
> >  	}
> >=20
> > -	if (*id !=3D MC13XXX_ID_INVALID) {
> > -		const struct spi_device_id *devid =3D
> > -			spi_get_device_id(mc13xxx->spidev);
> > -		if (!devid || devid->driver_data !=3D *id)
> > -			dev_warn(&mc13xxx->spidev->dev, "device id doesn't "
> > -					"match auto detection!\n");
> > -	}
> > -
> > -	return 0;
> > +	return (mc13xxx->ictype =3D=3D MC13XXX_ID_INVALID) ? -ENODEV : 0;
> >=20
> >  }
> > =20
> >  static const char *mc13xxx_get_chipname(struct mc13xxx *mc13xxx)
> >  {
> >=20
> > -	const struct spi_device_id *devid =3D
> > -		spi_get_device_id(mc13xxx->spidev);
> > -
> > -	if (!devid)
> > -		return NULL;
> > -
> > -	return mc13xxx_chipname[devid->driver_data];
> > +	return mc13xxx_chipname[mc13xxx->ictype];
> >=20
> >  }
> > =20
> >  #include <linux/mfd/mc13783.h>
> >=20
> > @@ -563,7 +487,7 @@ static const char *mc13xxx_get_chipname(struct
> > mc13xxx *mc13xxx)
> >=20
> >  int mc13xxx_get_flags(struct mc13xxx *mc13xxx)
> >  {
> > =20
> >  	struct mc13xxx_platform_data *pdata =3D
> >=20
> > -		dev_get_platdata(&mc13xxx->spidev->dev);
> > +		dev_get_platdata(mc13xxx->dev);
> >=20
> >  	return pdata->flags;
> > =20
> >  }
> >=20
> > @@ -601,7 +525,7 @@ int mc13783_adc_do_conversion(struct mc13783
> > *mc13783, unsigned int mode,
> >=20
> >  	};
> >  	init_completion(&adcdone_data.done);
> >=20
> > -	dev_dbg(&mc13xxx->spidev->dev, "%s\n", __func__);
> > +	dev_dbg(mc13xxx->dev, "%s\n", __func__);
> >=20
> >  	mc13xxx_lock(mc13xxx);
> >=20
> > @@ -643,7 +567,7 @@ int mc13783_adc_do_conversion(struct mc13783
> > *mc13783, unsigned int mode,
> >=20
> >  		return -EINVAL;
> >  =09
> >  	}
> >=20
> > -	dev_dbg(&mc13783->mc13xxx.spidev->dev, "%s: request irq\n", __fun=
c__);
> > +	dev_dbg(mc13783->mc13xxx.dev, "%s: request irq\n", __func__);
> >=20
> >  	mc13xxx_irq_request(mc13xxx, MC13783_IRQ_ADCDONE,
> >  =09
> >  			mc13783_handler_adcdone, __func__, &adcdone_data);
> >  =09
> >  	mc13xxx_irq_ack(mc13xxx, MC13783_IRQ_ADCDONE);
> >=20
> > @@ -701,7 +625,7 @@ static int mc13xxx_add_subdevice_pdata(struct m=
c13xxx
> > *mc13xxx,
> >=20
> >  	if (!cell.name)
> >  =09
> >  		return -ENOMEM;
> >=20
> > -	return mfd_add_devices(&mc13xxx->spidev->dev, -1, &cell, 1, NULL,=
 0);
> > +	return mfd_add_devices(mc13xxx->dev, -1, &cell, 1, NULL, 0);
> >=20
> >  }
> > =20
> >  static int mc13xxx_add_subdevice(struct mc13xxx *mc13xxx, const ch=
ar
> >  *format)
> >=20
> > @@ -709,29 +633,16 @@ static int mc13xxx_add_subdevice(struct mc13x=
xx
> > *mc13xxx, const char *format)
> >=20
> >  	return mc13xxx_add_subdevice_pdata(mc13xxx, format, NULL, 0);
> > =20
> >  }
> >=20
> > -static int mc13xxx_probe(struct spi_device *spi)
> > +int mc13xxx_common_init(struct mc13xxx *mc13xxx,
> > +			struct mc13xxx_platform_data *pdata, int irq)
> >=20
> >  {
> >=20
> > -	struct mc13xxx *mc13xxx;
> > -	struct mc13xxx_platform_data *pdata =3D dev_get_platdata(&spi->de=
v);
> > -	enum mc13xxx_id id;
> >=20
> >  	int ret;
> >=20
> > -	mc13xxx =3D kzalloc(sizeof(*mc13xxx), GFP_KERNEL);
> > -	if (!mc13xxx)
> > -		return -ENOMEM;
> > -
> > -	dev_set_drvdata(&spi->dev, mc13xxx);
> > -	spi->mode =3D SPI_MODE_0 | SPI_CS_HIGH;
> > -	spi->bits_per_word =3D 32;
> > -	spi_setup(spi);
> > -
> > -	mc13xxx->spidev =3D spi;
> > -
> >=20
> >  	mutex_init(&mc13xxx->lock);
> >  	mc13xxx_lock(mc13xxx);
> >=20
> > -	ret =3D mc13xxx_identify(mc13xxx, &id);
> > -	if (ret || id =3D=3D MC13XXX_ID_INVALID)
> > +	ret =3D mc13xxx_identify(mc13xxx);
> > +	if (ret)
> >=20
> >  		goto err_revision;
> >  =09
> >  	/* mask all irqs */
> >=20
> > @@ -743,14 +654,13 @@ static int mc13xxx_probe(struct spi_device *s=
pi)
> >=20
> >  	if (ret)
> >  =09
> >  		goto err_mask;
> >=20
> > -	ret =3D request_threaded_irq(spi->irq, NULL, mc13xxx_irq_thread,
> > +	ret =3D request_threaded_irq(irq, NULL, mc13xxx_irq_thread,
> >=20
> >  			IRQF_ONESHOT | IRQF_TRIGGER_HIGH, "mc13xxx", mc13xxx);
> >  =09
> >  	if (ret) {
> > =20
> >  err_mask:
> > =20
> >  err_revision:
> >  		mutex_unlock(&mc13xxx->lock);
> >=20
> > -		dev_set_drvdata(&spi->dev, NULL);
> >=20
> >  		kfree(mc13xxx);
> >  		return ret;
> >  =09
> >  	}
> >=20
> > @@ -786,54 +696,7 @@ err_revision:
> >  	return 0;
> > =20
> >  }
> >=20
> > -
> > -static int __devexit mc13xxx_remove(struct spi_device *spi)
> > -{
> > -	struct mc13xxx *mc13xxx =3D dev_get_drvdata(&spi->dev);
> > -
> > -	free_irq(mc13xxx->spidev->irq, mc13xxx);
> > -
> > -	mfd_remove_devices(&spi->dev);
> > -
> > -	kfree(mc13xxx);
> > -
> > -	return 0;
> > -}
> > -
> > -static const struct spi_device_id mc13xxx_device_id[] =3D {
> > -	{
> > -		.name =3D "mc13783",
> > -		.driver_data =3D MC13XXX_ID_MC13783,
> > -	}, {
> > -		.name =3D "mc13892",
> > -		.driver_data =3D MC13XXX_ID_MC13892,
> > -	}, {
> > -		/* sentinel */
> > -	}
> > -};
> > -
> > -static struct spi_driver mc13xxx_driver =3D {
> > -	.id_table =3D mc13xxx_device_id,
> > -	.driver =3D {
> > -		.name =3D "mc13xxx",
> > -		.bus =3D &spi_bus_type,
> > -		.owner =3D THIS_MODULE,
> > -	},
> > -	.probe =3D mc13xxx_probe,
> > -	.remove =3D __devexit_p(mc13xxx_remove),
> > -};
> > -
> > -static int __init mc13xxx_init(void)
> > -{
> > -	return spi_register_driver(&mc13xxx_driver);
> > -}
> > -subsys_initcall(mc13xxx_init);
> > -
> > -static void __exit mc13xxx_exit(void)
> > -{
> > -	spi_unregister_driver(&mc13xxx_driver);
> > -}
> > -module_exit(mc13xxx_exit);
> > +EXPORT_SYMBOL_GPL(mc13xxx_common_init);
> >=20
> >  MODULE_DESCRIPTION("Core driver for Freescale MC13XXX PMIC");
> >  MODULE_AUTHOR("Uwe Kleine-Koenig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>"=
);
> >=20
> > diff --git a/include/linux/mfd/mc13xxx.h b/include/linux/mfd/mc13xx=
x.h
> > index a1d391b..d7c18d7 100644
> > --- a/include/linux/mfd/mc13xxx.h
> > +++ b/include/linux/mfd/mc13xxx.h
> > @@ -11,7 +11,53 @@
> >=20
> >  #include <linux/interrupt.h>
> >=20
> > -struct mc13xxx;
> > +#define MC13XXX_IRQ_ADCDONE	0
> > +#define MC13XXX_IRQ_ADCBISDONE	1
> > +#define MC13XXX_IRQ_TS		2
> > +#define MC13XXX_IRQ_CHGDET	6
> > +#define MC13XXX_IRQ_CHGREV	8
> > +#define MC13XXX_IRQ_CHGSHORT	9
> > +#define MC13XXX_IRQ_CCCV	10
> > +#define MC13XXX_IRQ_CHGCURR	11
> > +#define MC13XXX_IRQ_BPON	12
> > +#define MC13XXX_IRQ_LOBATL	13
> > +#define MC13XXX_IRQ_LOBATH	14
> > +#define MC13XXX_IRQ_1HZ		24
> > +#define MC13XXX_IRQ_TODA	25
> > +#define MC13XXX_IRQ_SYSRST	30
> > +#define MC13XXX_IRQ_RTCRST	31
> > +#define MC13XXX_IRQ_PC		32
> > +#define MC13XXX_IRQ_WARM	33
> > +#define MC13XXX_IRQ_MEMHLD	34
> > +#define MC13XXX_IRQ_THWARNL	36
> > +#define MC13XXX_IRQ_THWARNH	37
> > +#define MC13XXX_IRQ_CLK		38
> > +
> > +#define MC13XXX_NUM_IRQ		46
> > +
> > +
> > +enum mc13xxx_id {
> > +	MC13XXX_ID_MC13783,
> > +	MC13XXX_ID_MC13892,
> > +	MC13XXX_ID_INVALID,
> > +};
> > +
> > +struct mc13xxx {
> > +	union {
> > +		struct spi_device *spidev;
> > +		struct i2c_client *i2cclient;
> > +	};
>=20
> I'd do this in a later patch.  IMHO the first patch should only shuff=
le
> code around without changing any behaviour.

OK. I think i understand.

>=20
> > +	struct device *dev;
> > +	enum mc13xxx_id ictype;
> > +
> > +	struct mutex lock;
> > +
> > +	int (*read_dev)(struct mc13xxx *, unsigned int, u32 *);
> > +	int (*write_dev)(struct mc13xxx *, unsigned int, u32);
> > +
> > +	irq_handler_t irqhandler[MC13XXX_NUM_IRQ];
> > +	void *irqdata[MC13XXX_NUM_IRQ];
> > +};
> >=20
> >  void mc13xxx_lock(struct mc13xxx *mc13xxx);
> >  void mc13xxx_unlock(struct mc13xxx *mc13xxx);
> >=20
> > @@ -21,6 +67,11 @@ int mc13xxx_reg_write(struct mc13xxx *mc13xxx,
> > unsigned int offset, u32 val);
> >=20
> >  int mc13xxx_reg_rmw(struct mc13xxx *mc13xxx, unsigned int offset,
> > =20
> >  		u32 mask, u32 val);
> >=20
> > +struct mc13xxx_platform_data;
> > +
> > +int mc13xxx_common_init(struct mc13xxx *mc13xxx,
> > +			struct mc13xxx_platform_data *pdata, int irq);
> > +
> >=20
> >  int mc13xxx_get_flags(struct mc13xxx *mc13xxx);
> > =20
> >  int mc13xxx_irq_request(struct mc13xxx *mc13xxx, int irq,
> >=20
> > @@ -37,30 +88,6 @@ int mc13xxx_irq_ack(struct mc13xxx *mc13xxx, int=
 irq);
> >=20
> >  int mc13xxx_get_flags(struct mc13xxx *mc13xxx);
> >=20
> > -#define MC13XXX_IRQ_ADCDONE	0
> > -#define MC13XXX_IRQ_ADCBISDONE	1
> > -#define MC13XXX_IRQ_TS		2
> > -#define MC13XXX_IRQ_CHGDET	6
> > -#define MC13XXX_IRQ_CHGREV	8
> > -#define MC13XXX_IRQ_CHGSHORT	9
> > -#define MC13XXX_IRQ_CCCV	10
> > -#define MC13XXX_IRQ_CHGCURR	11
> > -#define MC13XXX_IRQ_BPON	12
> > -#define MC13XXX_IRQ_LOBATL	13
> > -#define MC13XXX_IRQ_LOBATH	14
> > -#define MC13XXX_IRQ_1HZ		24
> > -#define MC13XXX_IRQ_TODA	25
> > -#define MC13XXX_IRQ_SYSRST	30
> > -#define MC13XXX_IRQ_RTCRST	31
> > -#define MC13XXX_IRQ_PC		32
> > -#define MC13XXX_IRQ_WARM	33
> > -#define MC13XXX_IRQ_MEMHLD	34
> > -#define MC13XXX_IRQ_THWARNL	36
> > -#define MC13XXX_IRQ_THWARNH	37
> > -#define MC13XXX_IRQ_CLK		38
> > -
> > -#define MC13XXX_NUM_IRQ		46
> > -
>=20
> why don't you keep these at their original place?

The MC13XXX_NUM_IRQ is needed for the irqhandler and irqdata arrays in =
the=20
mc13xxx struct. Agree, the actual IRQ defines should have stayed where =
they=20
were.


>=20
> Uwe

Thanks again,

Cheers
Marc
