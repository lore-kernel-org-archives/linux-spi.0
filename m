From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/3] spidev: Add DT binding example.
Date: Sun, 3 May 2015 10:59:17 +0100
Message-ID: <20150503095917.GQ22845@sirena.org.uk>
References: <20150428141630.GR22845@sirena.org.uk>
 <CAOMqctTNSgycy7K=ZMK9aaZGyybDT61e0Y6Fwf1jtoMbSVoNQQ@mail.gmail.com>
 <20150428171738.GY22845@sirena.org.uk>
 <CAOMqctSEAd-WeBRLabvDugN04XaqY6Y1UyO9UPLaTW9ce7t_rQ@mail.gmail.com>
 <20150429174059.GQ22845@sirena.org.uk>
 <CAOMqctQmpYmD0J9=o6FVjJhXBc8b+oGd7cNh5aH_fmgE3vk5+A@mail.gmail.com>
 <20150429180659.GT22845@sirena.org.uk>
 <CAOMqctSMeWvG6YsCFn5=wxS2nCBbMiiCKUNJh8oFsH1VZY4H-w@mail.gmail.com>
 <20150430195829.GG22845@sirena.org.uk>
 <A92B1688-9A12-4462-BA02-AEEE197C0FF4@martin.sperl.org>
Reply-To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="KT7uikKvGtQSCm8w"
Cc: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	"Eric D." <eric.dillmann-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
	Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>,
	Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>,
	Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Return-path: <linux-sunxi+bncBDQ2L75W5QGBBBHDS6VAKGQEGMEBD5I-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <A92B1688-9A12-4462-BA02-AEEE197C0FF4-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
List-Id: linux-spi.vger.kernel.org

--KT7uikKvGtQSCm8w
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 03, 2015 at 11:01:05AM +0200, Martin Sperl wrote:

> What about implementing it like this:
> echo -n =E2=80=9Cspi32761.4=E2=80=9D > /sys/bus/spi/drivers/spidev/bind

> Would this be an acceptable solution?

> This is actually mentioned in Documentation/spi/spidev as a
> possible option for the future - quote:

> > (Sysfs also supports userspace driven binding/unbinding of drivers to
> > devices.  That mechanism might be supported here in the future.)

> Not sure why it does not work right now (but it works for =E2=80=9Creal=
=E2=80=9D
> device-drivers), but I guess it has to do with compatibility checks.

Hrm, yes - that should work.  I'd ask Greg, that's not something the bus
implements.

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.

--KT7uikKvGtQSCm8w
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVRfF0AAoJECTWi3JdVIfQZLAH/RXeuHBtVLz7dFeqK2MiqlKY
yNikjgUXkQu/kHNhNpWQE5NyUg92sqY4HwnENrBd+5KxW1rwWd5Kr0Ur1i7V0HIh
uTKyT6O/zIpaWqN1WtAVdtMuJiRfK8XsYp9hnOZIS2ZVSNDTkce8lj6VCCwqIVl2
Gtegr3rjtG+eMr3tezk+isjq90nPS1gdFGmZERUWFxCirtP7/IPUD/avFUaTCdSo
obCkVMDi5GQc/UtZXeRda0zqRLu5A+jFan7Zzw69IDiadU4baSk4Xa7ApuRBSsWv
x281iCzU+KcjsuZbStvYpRCzAWrQ1gJNnIjITC5+GAz6RGDEqmyFaVJcu+OM5Uc=
=RD8D
-----END PGP SIGNATURE-----

--KT7uikKvGtQSCm8w--
