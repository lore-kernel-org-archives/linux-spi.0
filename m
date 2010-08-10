From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH v2 3/6] mtd: m25p80: add support to
	parse the SPI flash's partitions
Date: Tue, 10 Aug 2010 12:27:11 -0600
Message-ID: <AANLkTi=EpjPC8Hf6dM1att8Mjg5vmfQxs2=4aUTYTrUL@mail.gmail.com>
References: <AANLkTik9cy+at2n28U+Mut4RD6_cJ9uRZzjf+H86d-rp@mail.gmail.com>
	<796604.30863.qm@web180307.mail.gq1.yahoo.com>
	<AANLkTi=FGf9gbWDkO4qs01Z+qkip+Zm11=Jc4wHu3G8b@mail.gmail.com>
	<OF0D24DC16.E1FE65D2-ONC125777B.002E544A-C125777B.002EA7C2@transmode.se>
	<AANLkTinYYTj+dR6ckPoShHKZTUmENEA1O-DYP9mjnWrs@mail.gmail.com>
	<OFF5EA512A.075E51C6-ONC125777B.005D9750-C125777B.005F8CAF@transmode.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: kumar.gala-KZfg59tc24xl57MIdRCFDg@public.gmane.org, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>,
	linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	"linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org Mingkai Hu" <Mingkai.hu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
To: Joakim Tjernlund <joakim.tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <OFF5EA512A.075E51C6-ONC125777B.005D9750-C125777B.005F8CAF-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tue, Aug 10, 2010 at 11:23 AM, Joakim Tjernlund
<joakim.tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org> wrote:
> glikely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org wrote on 2010/08/10 16:56:42:
>>
>> On Tue, Aug 10, 2010 at 2:29 AM, Joakim Tjernlund
>> <joakim.tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org> wrote:
>> >> On Tue, Aug 10, 2010 at 1:14 AM, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>=
 wrote:
>> >> >
>> >> >
>> >> > --- On Mon, 8/9/10, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> wrote:
>> >> >
>> >> >
>> >> >> > + =A0 =A0 =A0 nr_parts =3D
>> >> >> of_mtd_parse_partitions(&spi->dev, np, &parts);
>> >> >
>> >> > Let's keep OF-specific logic out of drivers like
>> >> > this one ... =A0intended to work without OF.
>> >> >
>> >> > NAK on adding dependencies like OF to drivers
>> >> > and other infrastructure that starts generic.
>> >
>> > Agreed.
>> >
>> >>
>> >> The OF hooks compile to no-ops when CONFIG_OF is disabled. =A0I've be=
en
>> >> very careful about that.
>> >
>> > OF should not be in the drivers, one should be able use some other met=
hod
>> > than OF.
>>
>> If a device is described in the device tree, then the code has to live
>> *somewhere* to translate the data from the device tree into a form the
>> driver can use. =A0If not the driver, then where should that code live?
>>
>> If it is in the machine support code, then that requires foreknowledge
>> about all the device specific data that needs to be translated out of
>> the device tree at device registration time, which also means that the
>> translation code cannot be a module and it nullifies some of the
>> advantages of the device tree. =A0Not to mention the fact that it is
>> just plain ugly! =A0:-)
>>
>> Some of it can go into the infrastructure code, but only for parsing
>> common properties like irqs, address ranges, and some common bindings
>> like registering spi and i2c bus child nodes as devices. =A0(This
>> *particular* case may fall into this category if add_mtd_device() was
>> able to call the OF partition parsing hook if a device node pointer
>> was present; which does make a certain amount of sense, but I defer to
>> dwmw2 in this case). =A0However, device-specific properties cannot be
>> parsed in the infrastructure code because the infrastructure has no
>> knowledge of device specific bits.
>
> I am no expert at this at all, but I can give you an example what I don't
> want. Look at spi_mpc8xxx.c, earlier it was possible to define your own
> CS functions and register them from board code. After OF:ication one can
> not and the current OF methods aren't expressive enough to do what I need.
> The spi subsystem has a general framework for dealing with SPI devices
> and I think OF should be built on top of the native methods, at the
> very least not disable those methods like spi_mpc8xxx.c does.

You're right and it's a problem.  There wasn't a good way to handle
this when powerpc first moved over to use OF.  I think we've got a
good solution now.  See the use of a bus notifier in
arch/powerpc/platforms/512x/pdm360ng.c in Linus' current tree.  Most
of the time that won't be needed, but when a platform specific
callback is required, this seems to be a clean solution.

g.

---------------------------------------------------------------------------=
---
This SF.net email is sponsored by =


Make an app they can't live without
Enter the BlackBerry Developer Challenge
http://p.sf.net/sfu/RIM-dev2dev =
