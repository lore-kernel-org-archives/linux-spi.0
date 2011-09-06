From: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V3 1/5] i2c: Add irq_gpio field to struct i2c_client,
 i2c_board_info.
Date: Tue, 6 Sep 2011 15:57:08 -0700
Message-ID: <20110906225708.GA28957@kroah.com>
References: <1314914676-28397-1-git-send-email-swarren@nvidia.com>
 <20110902085620.4ad918c4@endymion.delvare>
 <4E609F9C.5020403@cam.ac.uk>
 <20110902112435.69c9e8f7@endymion.delvare>
 <74CDBE0F657A3D45AFBB94109FB122FF04B327A628@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>,
	Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>,
	Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>,
	"devel-gWbeCf7V1WCQmaza687I9mD2FQJk+8+b@public.gmane.org" <devel-gWbeCf7V1WCQmaza687I9mD2FQJk+8+b@public.gmane.org>,
	Andrew Chew <AChew-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>,
	"linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
	"linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>,
	"spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	"linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
To: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF04B327A628-C7FfzLzN0UxDw2glCA4ptUEOCMrvLtNR@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Fri, Sep 02, 2011 at 11:24:04AM -0700, Stephen Warren wrote:
> Jean Delvare wrote at Friday, September 02, 2011 3:25 AM:
> > Hi Jonathan,
> > 
> > On Fri, 02 Sep 2011 10:19:24 +0100, Jonathan Cameron wrote:
> > > On 09/02/11 07:56, Jean Delvare wrote:
> > > > Stephen,
> > > >
> > > > Can you please fix your e-mail client / system / whatever so that your
> > > > patch series are no longer sent duplicated?
> > > >
> > > > On Thu,  1 Sep 2011 16:04:27 -0600, Stephen Warren wrote:
> > > >> Some devices use a single pin as both an IRQ and a GPIO. In that case,
> > > >> irq_gpio is the GPIO ID for that pin. Not all drivers use this feature.
> > > >> Where they do, and the use of this feature is optional, and the system
> > > >> wishes to disable this feature, this field must be explicitly set to a
> > > >> defined invalid GPIO ID, such as -1.
> > > >>
> > > >> Signed-off-by: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> > > >> ---
> > > >> v3: Also add the field to i2c_board_info, and copy the field from
> > > >>     i2c_board_info to i2c_client upon instantiation
> > > >
> > > > I don't get the idea. The i2c core doesn't make any use of the field,
> > > > and that field will only be used by a few drivers amongst the 420+
> > > > i2c drivers in the tree. This looks like a waste of memory. What's wrong
> > > > with including the new field in the private platform or arch data
> > > > structure for drivers which need it?
> > >
> > > Why not make it platform data for now and 'if' it becomes way more common
> > > (probably won't) we can always propose adding as a general field at a later
> > > date.
> > 
> > Yes, this sounds like a much more reasonable approach.
> 
> BTW, if that's the direction that's decided, just take the first version
> of the patchset I posted, plus Jonathan Cameron's subsequent patch to
> modify ak8975 to accept GPIO ID through platform data.

I don't know which patchset that would be, can you please just resend
what you want applied so that I know I get the correct one?

thanks,

greg k-h
