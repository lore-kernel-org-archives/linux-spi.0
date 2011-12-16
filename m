From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH v2] spi: Fix device unregistration when unregistering the
	bus master
Date: Fri, 16 Dec 2011 09:59:20 -0700
Message-ID: <CACxGe6tYCNdfj7BeHt-801M01=3Lk4LVfR91z6Pyfiq+LqXiJA@mail.gmail.com>
References: <CACRpkda685p+fe_P5Ww=4Qtup6qmCe_oqiwTqN+KAaAktPNKFw@mail.gmail.com>
	<1323648906-24863-1-git-send-email-laurent.pinchart@ideasonboard.com>
	<20111213234520.GA24922@ponder.secretlab.ca>
	<201112161752.05318.laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <201112161752.05318.laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Fri, Dec 16, 2011 at 9:52 AM, Laurent Pinchart
<laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org> wrote:
> Hi Grant,
>
> On Wednesday 14 December 2011 00:45:20 Grant Likely wrote:
>> On Mon, Dec 12, 2011 at 01:15:06AM +0100, Laurent Pinchart wrote:
>> > Device are added as children of the bus master's parent device, but
>> > spi_unregister_master() looks for devices to unregister in the bus
>> > master's children. This results in the child devices not being
>> > unregistered.
>> >
>> > Fix this by registering devices as direct children of the bus master.
>> >
>> > Signed-off-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
>> > ---
>> >
>> > =A0drivers/spi/spi.c | =A0 =A02 +-
>> > =A01 files changed, 1 insertions(+), 1 deletions(-)
>> >
>> > diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
>> > index 2e13a14..b423fe9 100644
>> > --- a/drivers/spi/spi.c
>> > +++ b/drivers/spi/spi.c
>> > @@ -318,7 +318,7 @@ struct spi_device *spi_alloc_device(struct spi_mas=
ter
>> > *master)
>> >
>> > =A0 =A0 }
>> >
>> > =A0 =A0 spi->master =3D master;
>> >
>> > - =A0 spi->dev.parent =3D dev;
>> > + =A0 spi->dev.parent =3D &master->dev;
>> >
>> > =A0 =A0 spi->dev.bus =3D &spi_bus_type;
>> > =A0 =A0 spi->dev.release =3D spidev_release;
>> > =A0 =A0 device_initialize(&spi->dev);
>>
>> Yes, I agree and I think this is the correct fix. =A0However, I'd like
>> to make sure it behaves correctly. =A0Can you test and confirm that
>> with this patch in place and an spi_device in use (bound to a driver)
>> that the kernel will either refuse to unbind the driver, or correctly
>> release the spi_driver from the spi_device?
>
> $ ls -l /sys/bus/spi/devices/spi0.0/
> lrwxrwxrwx =A0 =A01 root =A0 =A0 root =A0 =A0 =A0 =A0 =A0 =A00 Jan =A01 0=
1:23 driver ->
> ../../../../../../bus/spi/drivers/m25p80
> -r--r--r-- =A0 =A01 root =A0 =A0 root =A0 =A0 =A0 =A0 4096 Jan =A01 01:23=
 modalias
> drwxr-xr-x =A0 =A04 root =A0 =A0 root =A0 =A0 =A0 =A0 =A0 =A00 Jan =A01 0=
1:23 mtd
> drwxr-xr-x =A0 =A02 root =A0 =A0 root =A0 =A0 =A0 =A0 =A0 =A00 Jan =A01 0=
1:23 power
> lrwxrwxrwx =A0 =A01 root =A0 =A0 root =A0 =A0 =A0 =A0 =A0 =A00 Jan =A01 0=
1:23 subsystem ->
> ../../../../../../bus/spi
> -rw-r--r-- =A0 =A01 root =A0 =A0 root =A0 =A0 =A0 =A0 4096 Jan =A01 01:23=
 uevent
>
> $ ls -l /dev/mtd1*
> crw-rw---- =A0 =A01 root =A0 =A0 root =A0 =A0 =A090, =A0 2 Jan =A01 01:23=
 /dev/mtd1
> crw-rw---- =A0 =A01 root =A0 =A0 root =A0 =A0 =A090, =A0 3 Jan =A01 01:23=
 /dev/mtd1ro
>
> $ echo spi0.0 > /sys/bus/spi/drivers/m25p80/unbind
>
> $ ls -l /sys/bus/spi/devices/spi0.0/
> -r--r--r-- =A0 =A01 root =A0 =A0 root =A0 =A0 =A0 =A0 4096 Jan =A01 01:23=
 modalias
> drwxr-xr-x =A0 =A02 root =A0 =A0 root =A0 =A0 =A0 =A0 =A0 =A00 Jan =A01 0=
1:23 power
> lrwxrwxrwx =A0 =A01 root =A0 =A0 root =A0 =A0 =A0 =A0 =A0 =A00 Jan =A01 0=
1:23 subsystem ->
> ../../../../../../bus/spi
> -rw-r--r-- =A0 =A01 root =A0 =A0 root =A0 =A0 =A0 =A0 4096 Jan =A01 01:23=
 uevent
>
> $ ls -l /dev/mtd1*
> ls: /dev/mtd1*: No such file or directory
>
> Is that what you were asking for ?

Not really, I was referring to having an spi_device in use, and then
attempting to unbind/remove the spi_master driver.

g.

---------------------------------------------------------------------------=
---
Learn Windows Azure Live!  Tuesday, Dec 13, 2011
Microsoft is holding a special Learn Windows Azure training event for =

developers. It will provide a great way to learn Windows Azure and what it =

provides. You can attend the event by watching it streamed LIVE online.  =

Learn more at http://p.sf.net/sfu/ms-windowsazure
