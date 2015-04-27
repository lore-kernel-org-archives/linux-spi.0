From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 2/3] spidev: Add DT binding example.
Date: Mon, 27 Apr 2015 12:05:37 +0200
Message-ID: <20150427100537.GQ5627@lukather>
References: <20150426110144.GK22845@sirena.org.uk>
 <553CCABA.3090504@redhat.com>
 <12F80B18-7418-430E-94F7-5A20C133BA9A@martin.sperl.org>
 <CAOMqctR8MZ_r6HHEBWhgxpUsTaV=M7DfmnJ_VxTqjWu4KMBSwA@mail.gmail.com>
 <20150426125113.GF5627@lukather>
 <CAOMqctRbYoNG2c-5atBP3QvMKbEhOrAgxzK1QskA5k2TgHraFQ@mail.gmail.com>
 <20150426143359.GI5627@lukather>
 <553CF8F2.6070204@redhat.com>
 <20150426154728.GK5627@lukather>
 <CAOMqctRQYsphKxaZXUae0KqAE5SnYZN5M3iPPGw_PKnnuh0W1Q@mail.gmail.com>
Reply-To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZqRzwd/9tauJXEMK"
Cc: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>,
	Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
	Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-doc <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRB6UV7CUQKGQEY6TUL7A-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAOMqctRQYsphKxaZXUae0KqAE5SnYZN5M3iPPGw_PKnnuh0W1Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
List-Id: linux-spi.vger.kernel.org

--ZqRzwd/9tauJXEMK
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Mon, Apr 27, 2015 at 08:51:12AM +0200, Michal Suchanek wrote:
> On 26 April 2015 at 17:47, Maxime Ripard
> <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
> > On Sun, Apr 26, 2015 at 04:40:50PM +0200, Hans de Goede wrote:
> >> Hi,
> >>
> >> I've a feeling everyone in this thread is ignoring the
> >> raspberry pi use-case. Where the board is specifically
> >> designed for educational purposes and used with lots of
> >> peripherals which are usually programmed from userspace
> >> using e.g. python bindings for i2c-dev or spidev, for
> >> such a setup we really want spidev to be loaded on the
> >> spibus by default and we really do not have a proper
> >> compatible for a child device.
> >
> > I'm not sure we're ignoring it, it just is the exact same use case
> > than the whole spidev use case: people want to write SPI userspace
> > drivers, the rpi really is not special here, except maybe for its user
> > space code base, but it really boils down to the same issue.
> >
> >> And no having to use per device devicetree overlays
> >> for this is not the answer, this needs to be really
> >> really easy. With pre device-tree kernels this just
> >> works, we should be able to match that ease of use
> >> with devicetree.
> >
> > We do agree on that. We repeatedly told that the DT was not a good
> > solution, overlays or not, and this is exactly one of the reasons.
> >
> 
> Ok, so how about skipping the bindings altogether.
> 
> Just instantiate a spidev for each SPI bus and each CS the SPI core
> knows of once spidev is loaded.

Which is exactly what my patch did but didn't seem like good enough
for you at the time...

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
--ZqRzwd/9tauJXEMK--
