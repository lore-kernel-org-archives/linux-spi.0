From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC][PATCH v2 0/3] slower spi-gpio
Date: Thu, 9 Dec 2010 20:38:31 -0800 (PST)
Message-ID: <795969.76999.qm@web180308.mail.gq1.yahoo.com>
References: <cover.1291925752.git.bengardiner@nanometrics.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org, Michael Buesch <mb@bu3sch.de>
To: spi-devel-general@lists.sourceforge.net,
	Grant Likely <grant.likely@secretlab.ca>,
	David Brownell <dbrownell@users.sourceforge.net>,
	Ben Gardiner <bengardiner@nanometrics.ca>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1291925752.git.bengardiner@nanometrics.ca>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org



--- On Thu, 12/9/10, Ben Gardiner <bengardiner@nanometrics.ca> wrote:


> This a continuation of the previous
> RFC [1]; we

You know, the spi-gpio code was written so it
would not need Kconfiguration, and I'd like
to see that continued.

Surely the minimal configuration you'd need
could be wrapped up in #defineslike the
actual GPIO numbers are wrapped up in.

Heck, nothing outside your patches needs your
:slow it way the heck down" option, so there's
no point to exposing it  via Kconfig;
such stuff is routinely embedded in C code.


 are interested in running a
> bitbanged SPI bus with a limited rate of transfer,

Would it make more sense to have a separate
slowed-down veresion of the driver, maybe just
custom defs for our hardware plus the current
driver body, as explained in the driver code
(last time I looked at it, anyway).

It bothers me to think of cluttering the
current driver with slowdowns

Or just have the "be slow" options private to
the driver instance, like "which GPIOs" is??

(I notice you didn't even check the GPIOs to see
if they are sleeping calls (e.g. over I2C), which
would have been preferable to a static always-slow
Kconfig option.  (But not to an always-slow object
vs the current default always-fast model.

I still need to be able to get multi-megabit
SPI clock rates out of the standard spi-gpio
code base.  (When I've had to use spi-gpio it
has never been a performance issue; the code
was written to facilitate inner bitbang loops
of about half a dozen instructions (ARM).

These recent patches look to be de-tuning badly,
or at least optimizing for slowness not speed,
which seems the wrong default.

- Dave


> including the delay between
> CS assertion and the beginning of data transfer. We also
> would like to do this=20
> with the GPIOs on an IO expander.
>=20
> The following three changes have been identified so far as
> being required to=20
> achieve this. spidelay() must be implemented, the delay
> specified in
> controller_state should be honoured when a transfer begins
> and finally the=20
> _cansleep gpio set functions should be used so that GPIOs
> on an expander can
> be used.=20
>=20
> This is alot of compile-time functionality switching
> though. I wonder if this
> kind of patching of spi-gpio would be acceptable or not;
> given the recent
> events in polled gpio-keys I feel that maybe a new
> 'spi-gpio-limited' driver=20
> might be preferred.
>=20
> [1] http://article.gmane.org/gmane.linux.kernel/1065748
>=20
> Ben Gardiner (3):
> =A0 [RFC] spi-gpio: implement spidelay() for platforms
> that configure
> =A0 =A0 SLOWER_SPI_GPIO
> =A0 [RFC] spi_bitbang : get nsecs delay from cs during
> transfer
> =A0 [RFC] spi-gpio: use _cansleep when
> CONFIG_SLOWER_SPI_GPIO is defined
>=20
>  drivers/spi/Kconfig=A0 =A0
> =A0=A0=A0|=A0=A0=A017 +++++++++++++++++
>  drivers/spi/spi_bitbang.c |=A0=A0=A015
> +++++++++------
>  drivers/spi/spi_gpio.c=A0 =A0 |=A0=A0=A018
> +++++++++++++++---
>  3 files changed, 41 insertions(+), 9 deletions(-)
>=20
> ---
>=20
> Changes since v1:
>  * rebased to=A0 2.6.37-rc5
>  * introduced patch 2/3 and 3/3
>=20
> This time around I tested the changes by registering a
> spi-gpio bus intance
> on the user DIP switches of the da850evm baseboard which
> are connected to a=20
> pca953x-compatible I2C gpio expander. Then I did a few=20
> 'echo hello > /dev/spidev0.0' commands and checked the
> behaviour of the bus
> on a scope. I was unable to test the speed of this bus
> without the patchset
> this time since using the GPIOs on the expander requires
> patch 3/3. I found=20
> that the SCLK speed was roughly 300Hz where 500Hz was
> requested.
>=20
> Here is a snip of the board-setup code that registers the
> spi-gpio bus:
>=20
> static struct spi_gpio_platform_data bb_spi_gpio_pdata =3D {
> =A0=A0=A0 .sck=A0=A0=A0
> =A0=A0=A0 =3D -1 /* assigned at runtime */,
> =A0=A0=A0 .mosi=A0=A0=A0
> =A0=A0=A0 =3D -1 /* assigned at runtime */,
> =A0=A0=A0 .miso=A0=A0=A0
> =A0=A0=A0 =3D -1 /* assigned at runtime */,
> =A0=A0=A0 .num_chipselect =3D 1,
> };
>=20
> static struct platform_device bb_spi_gpio =3D {
> =A0=A0=A0 .name=A0=A0=A0
> =A0=A0=A0 =3D "spi_gpio",
> =A0=A0=A0 .id=A0=A0=A0 =A0=A0=A0
> =3D 0,
> =A0=A0=A0 .dev=A0=A0=A0
> =A0=A0=A0 =3D {
> =A0=A0=A0 =A0=A0=A0
> .platform_data=A0=A0=A0 =3D &bb_spi_gpio_pdata,
> =A0=A0=A0 },
> };
>=20
> static struct spi_board_info bb_spi_devices[] =3D {
> =A0=A0=A0 {
> =A0=A0=A0 =A0=A0=A0
> .modalias=A0=A0=A0 =3D "spidev",
> =A0=A0=A0 =A0=A0=A0
> .max_speed_hz=A0=A0=A0 =3D 500,
> =A0=A0=A0 =A0=A0=A0
> .bus_num=A0=A0=A0 =3D 0,
> =A0=A0=A0 =A0=A0=A0
> .chip_select=A0=A0=A0 =3D 0,
> =A0=A0=A0 =A0=A0=A0
> .mode=A0=A0=A0 =A0=A0=A0 =3D SPI_MODE_0,
> =A0=A0=A0 =A0=A0=A0 .controller_data =3D
> (void *) -1 /* assigned at runtime */,
> =A0=A0=A0 },
> };
>=20
> static int bb_spi_gpio_init(unsigned gpio)
> {
> =A0=A0=A0 int ret;
>=20
> =A0=A0=A0 bb_spi_gpio_pdata.sck =3D gpio +
> DA850_EVM_BB_EXP_USER_SW1;
> =A0=A0=A0 bb_spi_gpio_pdata.mosi =3D gpio +
> DA850_EVM_BB_EXP_USER_SW2;
> =A0=A0=A0 bb_spi_gpio_pdata.miso =3D -1 /* nothing
> connected ATM */;
>=20
> =A0=A0=A0 bb_spi_devices[0].controller_data =3D
> (void *) gpio +
> =A0=A0=A0 =A0=A0=A0 =A0=A0=A0
> =A0=A0=A0 =A0=A0=A0 =A0=A0=A0
> DA850_EVM_BB_EXP_USER_SW3;
>=20
> =A0=A0=A0 ret =3D
> spi_register_board_info(bb_spi_devices,
> =A0=A0=A0 =A0=A0=A0 =A0=A0=A0
> =A0=A0=A0 =A0=A0=A0
> ARRAY_SIZE(bb_spi_devices));
> =A0=A0=A0 if (ret) {
> =A0=A0=A0 =A0=A0=A0 pr_warning("could not
> register spi devices");
> =A0=A0=A0 =A0=A0=A0 goto
> spi_gpio_fail_devices;
> =A0=A0=A0 }
>=20
> =A0=A0=A0 ret =3D
> platform_device_register(&bb_spi_gpio);
> =A0=A0=A0 if (ret) {
> =A0=A0=A0 =A0=A0=A0 pr_warning("could not
> register spi-gpio driver instance");

> =A0=A0=A0 =A0=A0=A0 goto
> spi_gpio_fail_bus;
> =A0=A0=A0 }
>=20
> =A0=A0=A0 return 0;
> spi_gpio_fail_bus:
> =A0=A0=A0 /* no unregister board info function
> available*/
> spi_gpio_fail_devices:
> =A0=A0=A0 return ret;
> }
>=20
> static int da850_evm_bb_expander_setup(struct i2c_client
> *client,
> =A0=A0=A0 =A0=A0=A0 =A0=A0=A0
> =A0=A0=A0 =A0=A0=A0 =A0=A0=A0
> unsigned gpio, unsigned ngpio,
> =A0=A0=A0 =A0=A0=A0 =A0=A0=A0
> =A0=A0=A0 =A0=A0=A0 =A0=A0=A0
> void *c)
> {
> =A0=A0=A0 int ret;
>=20
> =A0=A0=A0 /*
> =A0=A0=A0=A0=A0* Register the switches and
> pushbutton on the baseboard as a gpio-keys
> =A0=A0=A0=A0=A0* device.
> =A0=A0=A0=A0=A0*/
> =A0=A0=A0 da850_evm_bb_keys_init(gpio);
> =A0=A0=A0 ret =3D
> platform_device_register(&da850_evm_bb_keys_device);
> =A0=A0=A0 if (ret) {
> =A0=A0=A0 =A0=A0=A0 pr_warning("Could not
> register baseboard GPIO expander keys");
> =A0=A0=A0 =A0=A0=A0 goto
> io_exp_setup_sw_fail;
> =A0=A0=A0 }
>=20
> =A0=A0=A0 da850_evm_bb_leds_init(gpio);
> =A0=A0=A0 ret =3D
> platform_device_register(&da850_evm_bb_leds_device);
> =A0=A0=A0 if (ret) {
> =A0=A0=A0 =A0=A0=A0 pr_warning("Could not
> register baseboard GPIO expander LEDS");
> =A0=A0=A0 =A0=A0=A0 goto
> io_exp_setup_leds_fail;
> =A0=A0=A0 }
>=20
> =A0=A0=A0 ret =3D bb_spi_gpio_init(gpio);
> =A0=A0=A0 if (ret) {
> =A0=A0=A0 =A0=A0=A0 pr_warning("Could not
> register spi-gpio bus");
> =A0=A0=A0 =A0=A0=A0 goto
> io_exp_setup_spi_fail;
> =A0=A0=A0 }
>=20
> =A0=A0=A0 return 0;
>=20
> io_exp_setup_spi_fail:
> =A0=A0=A0
> platform_device_unregister(&da850_evm_bb_leds_device);
> io_exp_setup_leds_fail:
> =A0=A0=A0
> platform_device_unregister(&da850_evm_bb_keys_device);
> io_exp_setup_sw_fail:
> =A0=A0=A0 return ret;
> }
>=20
