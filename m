From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 7/12] neo1973: JBT6K74 LCM control
	interface driver
Date: Wed, 19 Dec 2007 13:16:44 -0800
Message-ID: <200712191316.45435.david-b@pacbell.net>
References: <20071218110800.GN29882@prithivi.gnumonks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: Harald Welte <laforge-4Bgg8jF3iZdg9hUCZPvPmw@public.gmane.org>,
	linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20071218110800.GN29882-jI4mzJ+yNOMOwssVsN95jSCwEArCW2h5@public.gmane.org>
Content-Disposition: inline
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

Since this is a LCD controller, it should be living in the
drivers/video directory somewhere.   Maybe in "backlight"
and depending on LCD_CLASS_DEVICE like the LTV350QV code.
(Which is not dissimilar to this LCM driver, although that
Samsung panel is much simpler.)


On Tuesday 18 December 2007, Harald Welte wrote:
> =

> +struct jbt_info {
> +	enum jbt_state state, last_state;
> +	u_int16_t tx_buf[8];
> +	struct spi_device *spi_dev;
> +	u_int16_t reg_cache[0xEE];

You don't have a lock protecting one thread from clobbering
tx_buf while another thread is using it.  And that's very
possible, even just through the sysfs attributes.


> +};
> +
> +#define JBT_COMMAND	0x000
> +#define JBT_DATA	0x100
> +
> +static int jbt_reg_write_nodata(struct jbt_info *jbt, u_int8_t reg)
> +{
> +	int rc;
> +
> +	jbt->tx_buf[0] =3D JBT_COMMAND | reg;
> +
> +	rc =3D spi_write(jbt->spi_dev, (u_int8_t *)jbt->tx_buf,
> +		       1*sizeof(u_int16_t));

I prefer the "u16" style not the "uint16_t" style, but that's
neither here nor there ... except that spi_write() is specified
to take a "const u8 *" not a "u_int8_t *".  =


This *looks* like a byteswap bug:  you're sending the data
in native endianness, but the slave is expecting it in one
particular byte order.  The saving grace is that you're
actually using nine-bit I/O words here, and the interface is
specified to ensure the native endianness is converted as
needed on the way out.

In short:  please add a comment there, saying that these
write operations all work with nine-bit native-endian data
that's transformed (to big-endian) on the way out the wire.

(The first time I looked at an LCD control module using SPI,
only the first/command data used nine-bit words, and the rest
of the data -- for pixel data, not control data -- used
eight bit ones.  This idiom was surprising to me in two
different ways!)


> +=A0=A0=A0=A0=A0=A0=A0if (rc =3D=3D 0)
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0jbt->reg_cache[reg] =3D 0;
> +
> +=A0=A0=A0=A0=A0=A0=A0return rc;
> +}

OK, so the return code for these write methods is either
zero for success, or a negative errno value.


> +static int jbt_init_regs(struct jbt_info *jbt, int qvga)
> +{
> +	int rc;
> +
> +	dev_dbg(&jbt->spi_dev->dev, "entering %cVGA mode\n", qvga ? 'Q' : ' ');
> +
> +	rc =3D jbt_reg_write(jbt, JBT_REG_DISPLAY_MODE1, 0x01);
> +	rc |=3D jbt_reg_write(jbt, JBT_REG_DISPLAY_MODE2, 0x00);
> +	rc |=3D jbt_reg_write(jbt, JBT_REG_RGB_FORMAT, 0x60);

I understand why that convention is used -- too many errors to
check for individually, for starters -- but it's not used right
in this file.


> +	...
> +
> +	return rc;

... why not "return rc ? -EIO : 0" or something, so that
the standard "int means negative errno else zero for success"
convention is followed?  Here and elsewhere.  (Some routines
return the real errno on some paths, and an invalid one on
other paths...)

Masking together a whole bunch of fault codes doesn't generate
a useful errno value!


> +static ssize_t state_write(struct device *dev, struct device_attribute *=
attr,
> +			   const char *buf, size_t count)
> +{
> +	struct jbt_info *jbt =3D dev_get_drvdata(dev);
> +	int i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(jbt_state_names); i++) {
> +		if (!strncmp(buf, jbt_state_names[i],
> +			     strlen(jbt_state_names[i]))) {
> +			jbt6k74_enter_state(jbt, i);

You're ignoring the return code here.  I'd save it, and just
return it (one that's fixed to return a real errno on all paths!)
instead of continuing after errors.


> +static ssize_t gamma_read(struct device *dev, struct device_attribute *a=
ttr,
> +			  char *buf)
> +{
> +	return strlcpy(buf, "N/A\n", PAGE_SIZE);

Ugly ... why aren't you returning the jbt->reg_cache values
that you saved?  Or just make these attributes write-only.


> +static int __devinit jbt_probe(struct spi_device *spi)
> +{
> +	int rc;
> +	struct jbt_info *jbt;
> +
> +	jbt =3D kzalloc(sizeof(*jbt), GFP_KERNEL);
> +	if (!jbt)
> +		return -ENOMEM;
> +
> +	jbt->spi_dev =3D spi;
> +	jbt->state =3D JBT_STATE_DEEP_STANDBY;
> +
> +	/* since we don't have MISO connected, we can't do detection */

If the chip doesn't have a data output line, say so.

Otherwise this is more of a board-specific issue, and
the comment should be more like "if we knew that this
board connects MISO, we could do detection".  When
someone adds a board with MISO connected, they could
provide and use a platform_data hook to get that kind
of board-specific config data into the driver.


> +
> +	dev_set_drvdata(&spi->dev, jbt);
> +
> +	spi->mode =3D SPI_CPOL | SPI_CPHA;
> +	spi->bits_per_word =3D 9;
> +
> +	rc =3D spi_setup(spi);
> +	if (rc < 0) {
> +		dev_err(&spi->dev,
> +			"error during spi_setup of jbt6k74 driver\n");
> +		dev_set_drvdata(&spi->dev, NULL);
> +		kfree(jbt);

Me, I'd rather do the spi_setup() before the kmalloc, so that
cleanup here is easier.  But this is OK too.


> +		return rc;
> +	}
> +
> +	rc =3D jbt6k74_enter_state(jbt, JBT_STATE_NORMAL);
> +	if (rc < 0)
> +		dev_warn(&spi->dev, "cannot enter NORMAL state\n");
> +
> +	jbt6k74_display_onoff(jbt, 1);
> +
> +	rc =3D sysfs_create_group(&spi->dev.kobj, &jbt_attr_group);
> +	if (rc) {
> +		dev_set_drvdata(&spi->dev, NULL);

But leave the display on, and in "normal" state??

The normal policy is that failed probes shouldn't
cause significant state changes.  If you intend
to adopt a different policy, please add a comment
saying why.


> +		kfree(jbt);
> +		return rc;
> +	}
> +
> +	return 0;
> +}
> +
> +static int __devexit jbt_remove(struct spi_device *spi)
> +{
> +	struct jbt_info *jbt =3D dev_get_drvdata(&spi->dev);
> +
> +	sysfs_remove_group(&spi->dev.kobj, &jbt_attr_group);

As above:  this probably shouldn't leave a user-visible
state change.  (Display on, and in "normal" state.)


> +	kfree(jbt);
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_PM
> +static int jbt_suspend(struct spi_device *spi, pm_message_t state)
> +{
> +	struct jbt_info *jbt =3D dev_get_drvdata(&spi->dev);
> +
> +	switch (state.event) {
> +	case PM_EVENT_SUSPEND:
> +	case 3:

Gaak, no "case 3".  Bad!  Evil!

> +		/* Save mode for resume */
> +		jbt->last_state =3D jbt->state;
> +		jbt6k74_enter_state(jbt, JBT_STATE_DEEP_STANDBY);
> +		return 0;
> +	default:
> +		return -1;

Why return "-EPERM" rather than "0"?  Are you trying to
prevent use of this driver on systems that support hibernation?


> +	}
> +}
> +
> +static int jbt_resume(struct spi_device *spi)
> +{
> +	struct jbt_info *jbt =3D dev_get_drvdata(&spi->dev);
> +
> +	jbt6k74_enter_state(jbt, jbt->last_state);
> +	jbt6k74_display_onoff(jbt, 1);

I suspect that if the last state isn't DEEP_STANDBY this
should do nothing.  Remember that during hibernation, this
can be called multiple times.

> +
> +	return 0;
> +}
> +#else
> +#define jbt_suspend	NULL
> +#define jbt_resume	NULL
> +#endif
> +
> +static struct spi_driver jbt6k74_driver =3D {
> +	.driver =3D {
> +		.name	=3D "jbt6k74",
> +		.owner	=3D THIS_MODULE,
> +	},
> +
> +	.probe	 =3D jbt_probe,
> +	.remove	 =3D __devexit_p(jbt_remove),
> +	.suspend =3D jbt_suspend,
> +	.resume	 =3D jbt_resume,
> +};
> +
> +static int __init jbt_init(void)
> +{
> +	return spi_register_driver(&jbt6k74_driver);
> +}
> +
> +static void __exit jbt_exit(void)
> +{
> +	spi_unregister_driver(&jbt6k74_driver);
> +}
> +
> +MODULE_DESCRIPTION("SPI driver for tpo JBT6K74-AS LCM control interface"=
);
> +MODULE_AUTHOR("Harald Welte <laforge-4Bgg8jF3iZdg9hUCZPvPmw@public.gmane.org>");
> +MODULE_LICENSE("GPL");
> +
> +module_init(jbt_init);
> +module_exit(jbt_exit);

As with EXPORT_SYMBOL() I'd like to see those snugged up against the
function being used as a module init/exit function...

-------------------------------------------------------------------------
SF.Net email is sponsored by:
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services
for just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
