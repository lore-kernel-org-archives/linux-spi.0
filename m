From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH v2] spi: Fix device unregistration when unregistering the
	bus master
Date: Fri, 16 Dec 2011 17:52:04 +0100
Message-ID: <201112161752.05318.laurent.pinchart@ideasonboard.com>
References: <CACRpkda685p+fe_P5Ww=4Qtup6qmCe_oqiwTqN+KAaAktPNKFw@mail.gmail.com>
	<1323648906-24863-1-git-send-email-laurent.pinchart@ideasonboard.com>
	<20111213234520.GA24922@ponder.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20111213234520.GA24922-e0URQFbLeQY2iJbIjFUEsiwD8/FfD2ys@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Grant,

On Wednesday 14 December 2011 00:45:20 Grant Likely wrote:
> On Mon, Dec 12, 2011 at 01:15:06AM +0100, Laurent Pinchart wrote:
> > Device are added as children of the bus master's parent device, but
> > spi_unregister_master() looks for devices to unregister in the bus
> > master's children. This results in the child devices not being
> > unregistered.
> > 
> > Fix this by registering devices as direct children of the bus master.
> > 
> > Signed-off-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
> > ---
> > 
> >  drivers/spi/spi.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> > 
> > diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> > index 2e13a14..b423fe9 100644
> > --- a/drivers/spi/spi.c
> > +++ b/drivers/spi/spi.c
> > @@ -318,7 +318,7 @@ struct spi_device *spi_alloc_device(struct spi_master
> > *master)
> > 
> >  	}
> >  	
> >  	spi->master = master;
> > 
> > -	spi->dev.parent = dev;
> > +	spi->dev.parent = &master->dev;
> > 
> >  	spi->dev.bus = &spi_bus_type;
> >  	spi->dev.release = spidev_release;
> >  	device_initialize(&spi->dev);
> 
> Yes, I agree and I think this is the correct fix.  However, I'd like
> to make sure it behaves correctly.  Can you test and confirm that
> with this patch in place and an spi_device in use (bound to a driver)
> that the kernel will either refuse to unbind the driver, or correctly
> release the spi_driver from the spi_device?

$ ls -l /sys/bus/spi/devices/spi0.0/
lrwxrwxrwx    1 root     root            0 Jan  1 01:23 driver -> 
../../../../../../bus/spi/drivers/m25p80
-r--r--r--    1 root     root         4096 Jan  1 01:23 modalias
drwxr-xr-x    4 root     root            0 Jan  1 01:23 mtd
drwxr-xr-x    2 root     root            0 Jan  1 01:23 power
lrwxrwxrwx    1 root     root            0 Jan  1 01:23 subsystem -> 
../../../../../../bus/spi
-rw-r--r--    1 root     root         4096 Jan  1 01:23 uevent

$ ls -l /dev/mtd1*
crw-rw----    1 root     root      90,   2 Jan  1 01:23 /dev/mtd1
crw-rw----    1 root     root      90,   3 Jan  1 01:23 /dev/mtd1ro

$ echo spi0.0 > /sys/bus/spi/drivers/m25p80/unbind

$ ls -l /sys/bus/spi/devices/spi0.0/
-r--r--r--    1 root     root         4096 Jan  1 01:23 modalias
drwxr-xr-x    2 root     root            0 Jan  1 01:23 power
lrwxrwxrwx    1 root     root            0 Jan  1 01:23 subsystem -> 
../../../../../../bus/spi
-rw-r--r--    1 root     root         4096 Jan  1 01:23 uevent

$ ls -l /dev/mtd1*
ls: /dev/mtd1*: No such file or directory

Is that what you were asking for ?

-- 
Regards,

Laurent Pinchart

------------------------------------------------------------------------------
Learn Windows Azure Live!  Tuesday, Dec 13, 2011
Microsoft is holding a special Learn Windows Azure training event for 
developers. It will provide a great way to learn Windows Azure and what it 
provides. You can attend the event by watching it streamed LIVE online.  
Learn more at http://p.sf.net/sfu/ms-windowsazure
