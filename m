From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 1/3] spi_topcliff_pch: support new device ML7213
Date: Fri, 21 Jan 2011 11:48:52 -0700
Message-ID: <20110121184852.GA18603@angua.secretlab.ca>
References: <1293449027-3219-1-git-send-email-tomoya-linux@dsn.okisemi.com>
	<20101229064937.GC8172@angua.secretlab.ca>
	<280596192AA74D208C2C5F6389DBE8C1@hacdom.okisemi.com>
	<20110105163835.GD17272@angua.secretlab.ca>
	<46862922F48B45F781832619CF3F4B79@hacdom.okisemi.com>
	<topcliff-split@mdm.bga.com>
	<84FF3503839A46E0B9919DF000DDE5C5@hacdom.okisemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: 'David Brownell' <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, "'Wang,
	Qi'" <qi.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	"'linux-kernel-u79uwXL29TaiAVqoAR/hOA49XUYAGyU/@public.gmane.org@intel.com'"@angua.secretlab.ca,
	yong.y.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, 'Milton Miller' <miltonm-ogEGBHC/i9Y@public.gmane.org>,
	Toshiharu Okada <toshiharu-linux-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org>,
	kok.howg.ewe-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	joel.clark-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
To: Tomoya MORINAGA <tomoya-linux-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <84FF3503839A46E0B9919DF000DDE5C5-c0cKtqp5df7I9507bXv2FdBPR1lH4CV8@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tue, Jan 11, 2011 at 06:38:35PM +0900, Tomoya MORINAGA wrote:
> Hi Grant,
> 
> On Friday, January 07, 2011 6:22 PM, Milton Miller wrote:
> > follow mfd_add_devices into drivers/mfd/mfd-core.c
> I have also seen mfd-core.c.
> However, I couldn't clear my question.
> 
> Q1. It seems platform_device is not used in your example. Does need "platform_device" ?
> Q2. How detect pch_spi channel dynamically ?
> 
> I want to catch your saying correctly.
> Could you give me more information ?

Let me try a different explanation.  The pch_spi driver implements a
pci_driver, and currently that pci_driver implements a single
spi_master child device as a child of the pci_bus.  The structure in
/sys/devices is probably something like this:

/sys/devices/.../0000:00:1a.0 (pci_dev bound to driver 'pch_spi_pcidev')
  |
  +--spi0.0  (spi_device 0 on spi_master 0)
  |
  \--spi0.1  (spi_device 1 on spi_master 0)

You want to modify the driver so that it can have more than one
spi_master attached to the device.  Your patch attempts to do so by
maintaining an array of spi_master devices that are children of the
pci_dev, so that the structure looks like this:


/sys/devices/.../0000:00:1a.0 (pci_dev bound to driver 'pch_spi_pcidev')
  |
  +--spi0.0  (spi_device 0 on spi_master 0)
  |
  +--spi0.1  (spi_device 1 on spi_master 0)
  |
  \--spi1.0  (spi_device 0 on spi_master 1)

Am I correct so far?

What I'm suggesting is that the code used to implement this structure
adds unnecessary complexity to the driver since each of the spi_master
instances are essentially completely independent, yet the driver has
to do extra work to know about the multiple instances.

Instead what you can do is to treat each spi bus as a child
platform_device of the pci_dev, and move the guts of the current
pch_spi_pcidev driver into a new platform_driver.  Then, instead of
driving the spi_master directly, the pch_spi_pcidev registers one or
more child platform_devices, one for each spi bus, so that the device
model looks something like this:

/sys/devices/.../0000:00:1a.0 (pci_dev bound to driver 'pch_spi_pcidev')
  |
  +--pch_spi.0
  |   |
  |   +--spi0.0  (spi_device 0 on spi_master 0)
  |   |
  |   \--spi0.1  (spi_device 1 on spi_master 0)
  |
  \--pch_spi.1
      |
      \--spi1.0  (spi_device 0 on spi_master 1)

where pch_spi.0 and pch_spi.1 are platform devices.  The
pch_spi_pcidev driver would allocated and register one or more
pch_spi.* platform_device children, each of which gets bound to a
pch_spi_platform_driver independently.  Doing it this way lets the
Linux driver model manage multiple instances instead of implementing
it by hand in your driver.

Make sense?

To do this, you need to move most of the driver code into a
platform_driver, and then modify your pci_driver so that it only
allocates and registers one or more platform_devices that will bind to
the driver.  It means you now have *two* driver structures.  One for
the pci_dev, and one for the platform_device children, and the pci_dev
acts as a container for the platform_devices.

The files in drivers/misc are an example of drivers that work in this
way.

g.


------------------------------------------------------------------------------
Special Offer-- Download ArcSight Logger for FREE (a $49 USD value)!
Finally, a world-class log management solution at an even better price-free!
Download using promo code Free_Logger_4_Dev2Dev. Offer expires 
February 28th, so secure your free ArcSight Logger TODAY! 
http://p.sf.net/sfu/arcsight-sfd2d
