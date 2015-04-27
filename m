From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/3] spidev: Add DT binding example.
Date: Mon, 27 Apr 2015 18:59:57 +0100
Message-ID: <20150427175957.GV22845@sirena.org.uk>
References: <12F80B18-7418-430E-94F7-5A20C133BA9A@martin.sperl.org>
 <CAOMqctR8MZ_r6HHEBWhgxpUsTaV=M7DfmnJ_VxTqjWu4KMBSwA@mail.gmail.com>
 <20150426125113.GF5627@lukather>
 <CAOMqctRbYoNG2c-5atBP3QvMKbEhOrAgxzK1QskA5k2TgHraFQ@mail.gmail.com>
 <20150427093618.GL22845@sirena.org.uk>
 <553E099C.4070208@redhat.com>
 <20150427112539.GR22845@sirena.org.uk>
 <553E4447.6080202@martin.sperl.org>
 <20150427152705.GU22845@sirena.org.uk>
 <CD7C1C3B-80B5-4627-94A4-2B83AAEC1DDB@martin.sperl.org>
Reply-To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MZc9ndojYYCMh/B/"
Cc: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>,
	Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
	Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-doc <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Return-path: <linux-sunxi+bncBDQ2L75W5QGBBMXS7GUQKGQETQB6HNQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CD7C1C3B-80B5-4627-94A4-2B83AAEC1DDB-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
List-Id: linux-spi.vger.kernel.org

--MZc9ndojYYCMh/B/
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Mon, Apr 27, 2015 at 06:25:26PM +0200, Martin Sperl wrote:
> > On 27.04.2015, at 17:27, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> > OK, so that is just a default overlay which is abusing the fact that we
> > will bind to spidev without a DT compatible and when the binding is
> > undocumented (which also applies to other devices and buses sadly).

> > Unfortunately nobody ever mentioned this upstream and the feedback
> > upstream that listing spidev in a DT is a bad idea has been ignored.

> Maybe it should also have been documented as such in
> Documentation/spi/spidev or in Documentation/devicetree/bindings/spi/

It was documented in the DT bindings in that there was no documented
binding; people are in general expected to know that anything they're
using should be documented.  For the main spidev document I guess it's
something similar, though if you can think of something there by all
means send a patch.

> > The whole reason we're doing this in the first place is that we got sick
> > of telling people that using spidev in DTs like this was a bad idea.

> The only reference I found in my history of the spi-list is this email:

It mostly comes up in review of DT files for boards so won't be on the
SPI list.

> > It does sound like the people maintianing the u-boot fork for the Pi
> > need to talk to both u-boot upstream (nothing here is specific to the
> > Pi that I can see) and the kernel community a bit more.  I'd be a bit
> > worried that they may be relying on other things that just happen to
> > work without being intentional (and are therefore more vulnerable to
> > issues) and it's a bit depressing to see things like this stuck in a
> > fork where only a limited community can make use of them.

> Actually this functionality is not in u-boot, but in the firmware
> boot-loader itself, which can load the kernel (and the devicetree)
> without u-boot, but which can also load u-boot as an additional
> intermediate boot-stage.

Ugh, right.  The thing about talking to the kernel community does still
stand though.

> >> The only thing that could possibly be better would be that
> >> the user would define the "real" name of the device in the
> >> device tree and spidev would bind to it if there is no driver
> >> available (but that would require this "fallback" binding by
> >> spidev in case of no driver).

> > Yes, that is exactly the solution I'd suggest - change the UI to provide
> > a DT compatible to be used for the new device.  That would also have the
> > benefit of meaning that users who have connected some device that does
> > have a driver that works with a simple binding wouldn't need to write an
> > overlay which seems like it should be useful.

> Well then why did you just make the system complain loudly and bringing
> problems to people instead of solving it in a usable manner that does not
> require people to maintain an out of tree patch to work around that warning?

This is quite honestly the first time I've heard of this bootloader
interface that's been implemented for the Pi.  All the other users I've
been aware of have been writing DT files or overlays in tree and
therefore it's not a substantial effort (and indeed the misuse is
basically just people being lazy) - if you can use the shipped binaries
it's a very different tradeoff.

> We still have the one-line warning about using the depreciated 
> spi_master.transfer interface, but it is not such loud warning as this one.

Right, that is a purely in kernel interface visible only to people
directly working on implementing SPI controller drivers that isn't
especially open to misuse and therefore both less serious and more
likely to be noticed.

> I guess the time spent discussing this could have been better spent
> implementing that solution instead.

> All we need is a volunteer to get that implemented.

Yes.
--MZc9ndojYYCMh/B/--
