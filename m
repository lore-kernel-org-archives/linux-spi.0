From: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: spi: OF module autoloading is still broken
Date: Mon, 16 Nov 2015 11:24:34 -0800
Message-ID: <20151116192434.GO8456@google.com>
References: <56104E88.3040807@gmail.com>
 <20151112185926.GC8456@google.com>
 <20151113194031.GI8456@google.com>
 <20151113221228.GT12392@sirena.org.uk>
 <20151113225113.GJ8456@google.com>
 <20151113231410.GV12392@sirena.org.uk>
 <20151113234857.GK8456@google.com>
 <564A101F.9090807@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <564A101F.9090807-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Javier,

On Mon, Nov 16, 2015 at 02:19:27PM -0300, Javier Martinez Canillas wrote:
> On 11/13/2015 08:48 PM, Brian Norris wrote:
> > On Fri, Nov 13, 2015 at 11:14:10PM +0000, Mark Brown wrote:
> >> On Fri, Nov 13, 2015 at 02:51:13PM -0800, Brian Norris wrote:

> Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt
> 
> And doesn't have a list of compatible strings. It points to a file in
> the Linux kernel source tree (drivers/mtd/devices/m25p80.c) which IMHO
> is wrong since the bindings should be OS agnostic. So instead, a list
> of the valid compatible strings (with both manufacturer and model)
> should be documented there.

Yep, that's a sore spot that I'm aware of. We had enough trouble sorting
out what "jedec,spi-nor" would be, and I never moved on to the point of
fixing up that comment. Will do that this week.

> The fact that having compatible = "garbage,valid-model" or "valid-model"
> worked was just a fortunate event due how the SPI core currently works.

I'd call that "unfortunate", and I agree with Mark. Implementation
matters more than documentation when talking about ABI.


> > No "nor-jedec" -- that was an intermediate name that got replaced
> > mid-release-cycle due to some late DT review comments.
> >
> 
> I think the comments in the m25p80 driver should be updated then since I
> had the same confusion when reading the spi_device_id table.

Oops, thanks for pointing that out. That's old garbage that should be
cleaned up. Will patch that soon.

> > But yes, I suppose adding "spi-nor" back to the spi_device_id table
> > fixes *one* of the immediate problems (i.e., 'compatible =
> > "jedec,spi-nor"'). That would cover Heiner's report. But it doesn't
> > solve:
> > 
> >   compatible = "vendor,shiny-new-device", "jedec,spi-nor"
> > 
> > I believe that the latter is sometimes the Right Way (TM) to do things
> > for device tree, so you have a fallback if auto-probing "jedec,spi-nor"
> > ever doesn't suffice.
> > 
> > (This came up in Heiner's original post: "In case of m25p80 this means
> > that "jedec,spi-nor" has to be the first "compatible" value. This
> > constraint might be too strict ..")
> >
> 
> I don't believe Heiner's statement is correct or maybe I misunderstood how
> module alias is reported for OF based platforms. But IIRC what happens is
> that the of_device_get_modalias() concatenates all the compatible strings
> that are present in the OF node.

Heiner was only talking about the existing SPI core code, which doesn't
use of_device_get_modalias().

> So in this particular example the reported modalias would be:
> 
> of:Nshiny-new-deviceT<NULL>Cvendor,shiny-new-deviceCjedec,spi-nor
> 
> and since the modaliases that will be stored in the module would be:
> 
> alias: of:N*T*Cjedec,spi-nor*
> 
> the latter will match the former since all compatible strings are in the
> reported modalias and the of_device_id .name was not set so is a wilcard.
> 
> If there is also a "vendor,shiny-new-device", then the aliases would be:
> 
> alias: of:N*T*Cvendor,shiny-new-device*
> alias: of:N*T*Cjedec,spi-nor*
> 
> so of:N*T*Cvendor,shiny-new-device* will also match
> of:Nshiny-new-deviceT<NULL>Cvendor,shiny-new-deviceCjedec,spi-nor
> 
> That covers the two use cases for valid compatible strings AFAICT and DT
> using invalid compatible strings should not be tried to be supported IMHO.

But it doesn't cover cases like this:

	compatible = "vendor,m25p80";

which today yield uevent/modalias:

	spi:m25p80

and will match with m25p80.c's spi_device_id table (and therefore will
autoload). Your patch will change this to:

	of:N*T*vendor,m25p80*

and unless I go and add "vendor,m25p80" to m25p80's of_match_table as
well, then this will NOT autoload. But, see how this can't be extended
to wildcard matches? So I think your patch requires a bit more thought
and care, or else you will break a lot more than you think.

> I will of course add a comment to my patch explaining what could break when
> the SPI core is modified to report a proper OF modalias

> but I don't think we
> should try to maintain FDTs that were not doing the right thing with regard
> to using wrong and undocumented compatible strings.

I don't think you have problems only with bad FDTs. I think you have a
problem with perfectly valid DTs.

Brian
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
