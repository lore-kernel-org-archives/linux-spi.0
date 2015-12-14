From: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Subject: Re: [PATCH] ACPI / scan: set status to 0 if _STA failed
Date: Tue, 15 Dec 2015 00:42:21 +0100
Message-ID: <5288517.rYC1Fmx4Ls@vostro.rjw.lan>
References: <564D3C75.60208@intel.com> <20151119101149.GZ1604@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Cc: ACPI Devel Mailing List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Bastien Nocera <bugzilla-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>,
	Stephen Just <stephenjust-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	"Chen, Yu C" <yu.c.chen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Aaron Lu <aaron.lu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151119101149.GZ1604-3PARRvDOhMZrdx17CPfAsdBPR1lH4CV8@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Thursday, November 19, 2015 12:11:49 PM Mika Westerberg wrote:
> On Thu, Nov 19, 2015 at 11:05:25AM +0800, Aaron Lu wrote:
> > Some ACPI node's _STA will touch operation region field, since the
> > evaluation of _STA in acpi_bus_type_and_status is very early, the
> > operation region handler is not ready yet. Instead of fail that function
> > and not creating the acpi_device node consequently, set status to 0 so
> > that later when the driver for that device is probing, it can find
> > the acpi_device node and proceed normally. And at that time, the
> > handler for the operation region is ready and its _STA evaluation will
> > succeed, its present status can be checked there.
> > 
> > Even there will be no driver using this node later, it doesn't seem
> > hurt to have one more acpi_device node created with status set to 0.
> > 
> > This happens on Microsoft Surface 3, where the SPI device node NTRG's
> > _STA touches GPIO fields and the SPI core driver will only enumerate SPI
> > devices from ACPI if the acpi_device node is 1: created; 2: _STA
> > indicates it's present.
> > 
> > Note that due to another problem in SPI driver, for NTRG to be actually
> > enumerated, some changes have to be made in the SPI layer, which is
> > addressed by Mika(not send out yet):
> > https://bugzilla.kernel.org/show_bug.cgi?id=104291#c23
> > 
> > Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=104291
> > Reported-by: Bastien Nocera <bugzilla-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>
> > Signed-off-by: Aaron Lu <aaron.lu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> 
> I don't know any better solution to this,
> 
> Reviewed-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

Applied, thanks!

Rafael

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
