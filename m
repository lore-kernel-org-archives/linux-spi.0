From: Hu Mingkai-B21284 <B21284-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH v2 3/6] mtd: m25p80: add support to
	parse the SPI flash's partitions
Date: Thu, 2 Sep 2010 16:46:28 +0800
Message-ID: <73839B4A0818E747864426270AC332C30561B6DC@zmy16exm20.fsl.freescale.net>
References: <AANLkTik9cy+at2n28U+Mut4RD6_cJ9uRZzjf+H86d-rp@mail.gmail.com>
	<796604.30863.qm@web180307.mail.gq1.yahoo.com>
	<AANLkTi=FGf9gbWDkO4qs01Z+qkip+Zm11=Jc4wHu3G8b@mail.gmail.com>
	<OF0D24DC16.E1FE65D2-ONC125777B.002E544A-C125777B.002EA7C2@transmode.se>
	<AANLkTinYYTj+dR6ckPoShHKZTUmENEA1O-DYP9mjnWrs@mail.gmail.com>
	<OFF5EA512A.075E51C6-ONC125777B.005D9750-C125777B.005F8CAF@transmode.se>
	<AANLkTi=EpjPC8Hf6dM1att8Mjg5vmfQxs2=4aUTYTrUL@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Gala Kumar-B11780 <B11780-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: "Grant Likely" <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
	"Joakim Tjernlund" <joakim.tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Class: urn:content-classes:message
In-Reply-To: <AANLkTi=EpjPC8Hf6dM1att8Mjg5vmfQxs2=4aUTYTrUL-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org



> -----Original Message-----
> From: glikely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org [mailto:glikely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org] On Behalf Of Gra=
nt
> Likely
> Sent: Wednesday, August 11, 2010 2:27 AM
> To: Joakim Tjernlund
> Cc: David Brownell; David Woodhouse; Gala Kumar-B11780; linux-
> mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org; Hu Mingkai-B21284; spi-devel-
> general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: Re: [spi-devel-general] [PATCH v2 3/6] mtd: m25p80: add support =
to
> parse the SPI flash's partitions
> =

> On Tue, Aug 10, 2010 at 11:23 AM, Joakim Tjernlund
> <joakim.tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org> wrote:
> > glikely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org wrote on 2010/08/10 16:56:42:
> >>
> >> On Tue, Aug 10, 2010 at 2:29 AM, Joakim Tjernlund
> >> <joakim.tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org> wrote:
> >> >> On Tue, Aug 10, 2010 at 1:14 AM, David Brownell <david-b-yBeKhBN/0LBNg+MwTxZMZA@public.gmane.org=
t>
> wrote:
> >> >> >
> >> >> >
> >> >> > --- On Mon, 8/9/10, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> wrot=
e:
> >> >> >
> >> >> >
> >> >> >> > + =A0 =A0 =A0 nr_parts =3D
> >> >> >> of_mtd_parse_partitions(&spi->dev, np, &parts);
> >> >> >
> >> >> > Let's keep OF-specific logic out of drivers like this one ...
> >> >> > intended to work without OF.
> >> >> >
> >> >> > NAK on adding dependencies like OF to drivers and other
> >> >> > infrastructure that starts generic.
> >> >
> >> > Agreed.
> >> >
> >> >>
> >> >> The OF hooks compile to no-ops when CONFIG_OF is disabled. =A0I've
> >> >> been very careful about that.
> >> >
> >> > OF should not be in the drivers, one should be able use some other
> >> > method than OF.
> >>
> >> If a device is described in the device tree, then the code has to
> >> live
> >> *somewhere* to translate the data from the device tree into a form
> >> the driver can use. =A0If not the driver, then where should that code =
live?
> >>
> >> If it is in the machine support code, then that requires
> >> foreknowledge about all the device specific data that needs to be
> >> translated out of the device tree at device registration time, which
> >> also means that the translation code cannot be a module and it
> >> nullifies some of the advantages of the device tree. =A0Not to mention
> >> the fact that it is just plain ugly! =A0:-)
> >>
> >> Some of it can go into the infrastructure code, but only for parsing
> >> common properties like irqs, address ranges, and some common bindings
> >> like registering spi and i2c bus child nodes as devices. =A0(This
> >> *particular* case may fall into this category if add_mtd_device() was
> >> able to call the OF partition parsing hook if a device node pointer
> >> was present; which does make a certain amount of sense, but I defer
> >> to
> >> dwmw2 in this case). =A0However, device-specific properties cannot be
> >> parsed in the infrastructure code because the infrastructure has no
> >> knowledge of device specific bits.
> >
> > I am no expert at this at all, but I can give you an example what I
> > don't want. Look at spi_mpc8xxx.c, earlier it was possible to define
> > your own CS functions and register them from board code. After
> > OF:ication one can not and the current OF methods aren't expressive eno=
ugh to
> do what I need.
> > The spi subsystem has a general framework for dealing with SPI devices
> > and I think OF should be built on top of the native methods, at the
> > very least not disable those methods like spi_mpc8xxx.c does.
> =

> You're right and it's a problem.  There wasn't a good way to handle this =
when
> powerpc first moved over to use OF.  I think we've got a good solution no=
w.  See
> the use of a bus notifier in arch/powerpc/platforms/512x/pdm360ng.c in Li=
nus'
> current tree.  Most of the time that won't be needed, but when a platform
> specific callback is required, this seems to be a clean solution.
> =


Thanks for your valuable suggestion, but where should I put the bus_registe=
r_notifier?
On the drivers/mtd/devices/m25p80.c or drivers/spi/spi.c? I think it should=
 add in the =

flash driver m25p80.c, but it looks like the notifier function will be call=
ed many times.
How does it happen?

Here is my demo code patch:
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -753,6 +753,34 @@ static const struct spi_device_id *__devinit jedec_pro=
be(struct spi_device *spi)
 }

+static int m25p80_notifier_call(struct notifier_block *nb,
+                                       unsigned long event, void *__dev)
+{
+       printk("%s %d event =3D 0x%x:\n", __func__, __LINE__, event);
+       switch (event) {
+       case BUS_NOTIFY_ADD_DEVICE:
+               printk("BUS_NOTIFY_ADD_DEVICE\n");
+               break;
+       case BUS_NOTIFY_DEL_DEVICE:
+               printk("BUS_NOTIFY_DEL_DEVICE\n");
+               break;
+       case BUS_NOTIFY_BOUND_DRIVER:
+               printk("BUS_NOTIFY_BOUND_DRIVER\n");
+               break;
+       case BUS_NOTIFY_UNBIND_DRIVER:
+               printk("BUS_NOTIFY_UNBIND_DRIVER\n");
+               break;
+       case BUS_NOTIFY_UNBOUND_DRIVER:
+               printk("BUS_NOTIFY_UNBOUND_DRIVER\n");
+               break;
+       }
+       return NOTIFY_DONE;
+}
+
+static struct notifier_block m25p80_nb =3D {
+       .notifier_call =3D m25p80_notifier_call,
+};
+
 /*
  * board specific setup should have ensured the SPI clock used here
  * matches what the READ command supports, at least until this driver
@@ -766,6 +794,8 @@ static int __devinit m25p_probe(struct spi_device *spi)
        struct flash_info               *info;
        unsigned                        i;

+       bus_register_notifier(&spi_bus_type, &m25p80_nb);
+


Thanks,
Mingkai


---------------------------------------------------------------------------=
---
This SF.net Dev2Dev email is sponsored by:

Show off your parallel programming skills.
Enter the Intel(R) Threading Challenge 2010.
http://p.sf.net/sfu/intel-thread-sfd
