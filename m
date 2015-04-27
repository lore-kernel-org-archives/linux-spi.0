From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/3] spidev: Add DT binding example.
Date: Mon, 27 Apr 2015 12:25:39 +0100
Message-ID: <20150427112539.GR22845@sirena.org.uk>
References: <20150426103257.GJ22845@sirena.org.uk>
 <CAOMqctR235uF+7kNGsLEGfrrAOQAYmw0pWgk6t8fZHNT7XsRuw@mail.gmail.com>
 <20150426110144.GK22845@sirena.org.uk>
 <553CCABA.3090504@redhat.com>
 <12F80B18-7418-430E-94F7-5A20C133BA9A@martin.sperl.org>
 <CAOMqctR8MZ_r6HHEBWhgxpUsTaV=M7DfmnJ_VxTqjWu4KMBSwA@mail.gmail.com>
 <20150426125113.GF5627@lukather>
 <CAOMqctRbYoNG2c-5atBP3QvMKbEhOrAgxzK1QskA5k2TgHraFQ@mail.gmail.com>
 <20150427093618.GL22845@sirena.org.uk>
 <553E099C.4070208@redhat.com>
Reply-To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="VtpJd9mrbM613+PJ"
Cc: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>,
	linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
	Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-doc <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-sunxi+bncBDQ2L75W5QGBBUFZ7CUQKGQEHZZ3VXI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <553E099C.4070208-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
List-Id: linux-spi.vger.kernel.org

--VtpJd9mrbM613+PJ
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Mon, Apr 27, 2015 at 12:04:12PM +0200, Hans de Goede wrote:

> Have you seen my mail about the raspberry pi use-case? Using dt-overlays
> simply is not an acceptable answer there. There are legitimate use-cases
> for a "generic spi bus" concept with the bus only being accessible via
> spidev.

> Blocking this use-case because you do not believe it is a valid use-case
> is not going to help, this will just lead to the custom distros these
> boards are shipping doing some ugly hack, which is not what we want
> IMHO.

I don't think you've fully considered your use case here.  As I said in
my reply to your earlier e-mail I think what you're looking for here is
something like better UI around overlays.  Registering a SPI bus without
knowing what's connected to it doesn't allow generic maker style usage
of the board, it's just as likely to hinder a user as help them.  For
example, if someone wants to use the SPI pins for another function such
as GPIO they'll have to handle that (and may have problems with pin
conflicts causing electrical issues if they do load up the DT with
spidev in it).  If someone has a SPI device they want to bind an in
kernel driver to they'll have to handle that, if they want to use a GPIO
to provide an additional chip select they'll have to handle that too.

Note that the discussion here isn't about userspace drivers, it's about
how the hardware is described.
--VtpJd9mrbM613+PJ--
