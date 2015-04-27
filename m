From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/3] spidev: Add DT binding example.
Date: Mon, 27 Apr 2015 16:27:05 +0100
Message-ID: <20150427152705.GU22845@sirena.org.uk>
References: <20150426110144.GK22845@sirena.org.uk>
 <553CCABA.3090504@redhat.com>
 <12F80B18-7418-430E-94F7-5A20C133BA9A@martin.sperl.org>
 <CAOMqctR8MZ_r6HHEBWhgxpUsTaV=M7DfmnJ_VxTqjWu4KMBSwA@mail.gmail.com>
 <20150426125113.GF5627@lukather>
 <CAOMqctRbYoNG2c-5atBP3QvMKbEhOrAgxzK1QskA5k2TgHraFQ@mail.gmail.com>
 <20150427093618.GL22845@sirena.org.uk>
 <553E099C.4070208@redhat.com>
 <20150427112539.GR22845@sirena.org.uk>
 <553E4447.6080202@martin.sperl.org>
Reply-To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4N6yfb5C0fB00J+0"
Cc: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>,
	Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
	Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-doc <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Return-path: <linux-sunxi+bncBDQ2L75W5QGBBXNK7GUQKGQEXJCZFNY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <553E4447.6080202-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
List-Id: linux-spi.vger.kernel.org

--4N6yfb5C0fB00J+0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Mon, Apr 27, 2015 at 04:14:31PM +0200, Martin Sperl wrote:
> On 2015-04-27 13:25, Mark Brown wrote:

> >I don't think you've fully considered your use case here.  As I said in
> >my reply to your earlier e-mail I think what you're looking for here is
> >something like better UI around overlays.  Registering a SPI bus without
> >knowing what's connected to it doesn't allow generic maker style usage
> >of the board, it's just as likely to hinder a user as help them.  For

> So you see that spi is disabled by default - the pins are
> free to use for anything.

> The firmware then integrates the overrrides into the device-tree
> before loading the kernel.

> So to enable spi in general you add the following to /boot/config.txt:
> dtparam=spi=on

> That gives you spi plus two "generic" spidev devices.

OK, so that is just a default overlay which is abusing the fact that we
will bind to spidev without a DT compatible and when the binding is
undocumented (which also applies to other devices and buses sadly).

Unfortunately nobody ever mentioned this upstream and the feedback
upstream that listing spidev in a DT is a bad idea has been ignored.
The whole reason we're doing this in the first place is that we got sick
of telling people that using spidev in DTs like this was a bad idea.

> If you want to include a mcp2515 you add also the following:
> dtoverlay=mcp2515-can0-overlay
> and that loads also the overlay for the mcp2515 can module.

And this is just a user specified overlay which is completely fine
already.

> So coming from this perspective I believe that there is some
> concern in the raspberry pi community, because the description
> they provide is now specific to the HW and their intent and so
> the loud "croaking" of spidev will irritate people even when
> they have done everything the best they can.

It does sound like the people maintianing the u-boot fork for the Pi
need to talk to both u-boot upstream (nothing here is specific to the
Pi that I can see) and the kernel community a bit more.  I'd be a bit
worried that they may be relying on other things that just happen to
work without being intentional (and are therefore more vulnerable to
issues) and it's a bit depressing to see things like this stuck in a
fork where only a limited community can make use of them.

> The only thing that could possibly be better would be that
> the user would define the "real" name of the device in the
> device tree and spidev would bind to it if there is no driver
> available (but that would require this "fallback" binding by
> spidev in case of no driver).

Yes, that is exactly the solution I'd suggest - change the UI to provide
a DT compatible to be used for the new device.  That would also have the
benefit of meaning that users who have connected some device that does
have a driver that works with a simple binding wouldn't need to write an
overlay which seems like it should be useful.
--4N6yfb5C0fB00J+0--
