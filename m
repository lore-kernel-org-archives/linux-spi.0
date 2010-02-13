From: Jonathan Cameron <kernel@jic23.retrosnub.co.uk>
Subject: Re: [spi-devel-general] SPI-ADC
Date: Sat, 13 Feb 2010 16:51:58 +0000
Message-ID: <4B76D8AE.7040102@jic23.retrosnub.co.uk>
References: <dc6d3181002122148v6451ebffka164de288738485d@mail.gmail.com> <63386a3d1002130548y7c839072y85097a9bcdf66cad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: arjun rath <rath.arjun@gmail.com>,
	spi-devel-general@lists.sourceforge.net,
	linux kernel <linux-kernel@vger.kernel.org>
To: Linus Walleij <linus.ml.walleij@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <63386a3d1002130548y7c839072y85097a9bcdf66cad@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Arjun and Linus,
>=20
>> can anybody share how to start a spi based ADC linux driver.I am hav=
ing a
>> MAXIM 1242 ADC chip.
>=20
> The =E1=B8=B1ernel does not contain any generic ADC subsystem abstrac=
tion (I
> think it would be good if it did), instead most drivers using ADC hav=
e
> their ADC portions stored inside a driver for something else, e.g.
> drivers/hwmon for ADCs used in temperature monitoring, or
> drivers/power for ADCs used in monitoring of currents and voltages
> for power supplies/batteries.
That's not entirely true.  These are covered by the IIO subsystem which
is admittedly currently in staging as some elements still need cleaning=
 up.

As a quick summary of IIO.  Except for a few bits of management code, b=
asic
drivers look pretty much like hwmon.  An example in tree is the tsl2563=
 driver
(under drivers/staging/iio/light) though that one is moving out to ALS =
when
Amit has a chance to sort out the relevant patch.

=46or more advanced drivers (only add support if you have a use as it i=
s a fair
bit more complex) we have support for hardware and software ring buffer=
s, an
events interface which is more or less the equivalent of input without =
cross
device aggregation.

ADC drivers are under drivers/staging/iio/adc.

I think in mainline we still only have a max1363 driver which covers a =
lot
of the i2c maxim parts (more to add after testing).  There are a couple
more iio using adc drivers in a blackfin tree at:

http://blackfin.uclinux.org/gf/project/linux-kernel/scmsvn/
(Note these are very much under development!)  Though from a quick look
all of them are i2c based.  For an spi equivalent, take a look at
drivers/staging/iio/accel/ where we have the kxsd9 driver (which is ano=
ther
simple example of an IIO driver) + lis3l02dq and sca3000 which are on t=
he
heavy side (probably not a good place to start).=20

=46or a general list of devices people are working on, or at least have=
 and
intend to work on, take a look at:

https://sourceforge.net/apps/mediawiki/iioutils/index.php?title=3DDevic=
e_List

Just for reference, the big up coming change in IIO is a new userspace =
ABI
to clean things up before we get too many drivers using the somewhat me=
ssy
old version.

It will still be a little while before we have cleaned up the more cont=
roversial
issues in the core (none of which touch on the simpler drivers) but wit=
h a
steady increase in active developers things are speeding up.

So in conclusion, if your use of the driver doesn't fall neatly under h=
wmon
or elsewhere, and you don't mind writing for a subsystem which isn't en=
tirely
polished and may change, then IIO might be what you are looking for.

Currently all discussions take place on LKML, but we are working on a m=
ore
focused alternative list which I'll announce once it is sorted out.

Just taking a quick and dirty look at the datasheet for the MAX1242:

* You might have fun getting the required conversion delay before a rea=
d.
 (Chip select must be enabled for 7.5 microsecs before the clock starts=
)

* Otherwise it is a nice simple chip with no actual control of anything=
=2E

Perhaps you can supply some information on your application to guide
an continuation of this discussion?

Thanks,



Jonathan Cameron
>=20
> This is a bit bad for driving a generic ADC like this using spidev an=
d,
> even if it was to be accessed from userspace only, having it under
> drivers/spi is rather counterintuitive, what happens when the next AD=
C
> using I2C turns up? drivers/i2c/chips?
>=20
> I would suggest creating subsystem drivers/adc if you have time and
> energy, other ideas?
>=20
> Linus Walleij
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
