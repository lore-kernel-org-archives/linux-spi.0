From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [butterfly_attach] WARNING: CPU: 0 PID: 198 at fs/sysfs/dir.c:31
 sysfs_warn_dup+0x71/0x97
Date: Wed, 8 Nov 2017 11:17:50 +0000
Message-ID: <20171108111750.lpr7vuhf37znxmsn@sirena.co.uk>
References: <20171107102450.lgaujtc7f3dftvvb@wfg-t540p.sh.intel.com>
 <CA+55aFyxgvzPWiQgRjg1n-MNQe5O6xU0MtKQ9cq1OppJ-2sEXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yzmztfvod4bnww6r"
Cc: Fengguang Wu <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CA+55aFyxgvzPWiQgRjg1n-MNQe5O6xU0MtKQ9cq1OppJ-2sEXQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--yzmztfvod4bnww6r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 07, 2017 at 08:49:46AM -0800, Linus Torvalds wrote:
> On Tue, Nov 7, 2017 at 2:24 AM, Fengguang Wu <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wro=
te:

> > FYI this happens in v4.14-rc8 -- it's not necessarily a new bug.

> Yeah, very doubtful. Nobody has touched that spi-butterfly driver in
> about two years.

Indeed.  I'm not super convinced anyone who actually has the hardware
has touched the driver since David Brownell was maintaining SPI, all the
changes since then seem pretty mechanical.

> > [   13.141240] sysfs: cannot create duplicate filename '/devices/pnp0/0=
0:04/spi_master/spi42'
> > [   13.142495] ------------[ cut here ]------------

> I'm not sure why that driver even gets initialized under qemu. I'm
> assuming it just tries to attach to any parport.

Yes, if there's any mechanism for constraining what it attaches to it's
in the parport subsysetm.  This simply provides an attach method which
the parport subsystem looks like it calls on any parport in the system.
I'm a little confused about how it ends up getting registered multiple
times but that looks like it should be something in paport (I noticed
some stuff about allowing multiple devices on one port).

> Mark, should it have a stricter check perhaps? Or should this driver
> perhaps simply not be loaded by the zeroday robot?

Loading parallel port client drivers (or other semi-enumerable drivers)
seems like a recipe for trouble.  In this case there's never been any
code there that attempts to work out if there's actually a butterfy
device on the parport, just a REVISIT comment in the code which isn't
much help.  Looking at the docs for the driver it's intended to control
an AVR32 microcontroller reference board running some custom program
(with instructions on how to make the cable!) so I don't hold out much
hope.

I'm tempted to just remove the driver though I fear it might have some
actual users for industrial processes still. =20

--yzmztfvod4bnww6r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAloC594ACgkQJNaLcl1U
h9B67wf+K+1DaSiUPM2e2qFWbq0Q8XAK8R/VkEQ2G0uXfAGI6DMG49clqJxVEbuP
YGzvzC70DfoypOIidBQLkPuoqrFA4zLkh3ouUSyr2reEMgNN25vR1+aw9U1sRUrG
q38JanlmyT29+V5QlDmrKQ2RgGjkfL4dkifSYMVwpLeBoKgc8SyTS15Q0HEnoQjM
rzMoAiMWXobKQGMImIK18KzaxRBz0IW2IcHtpwx93+oXwS3wevclckhCpXPvKn/q
EtRYjPn1JeDVbP9h91TF7HjqcSaUGkOLWA+AEAzl6p6tZqsmDk+HQl1nKI9Q8bo+
KgRl1h1e6acxjGAXLcR8n5VPGie12g==
=tZ6N
-----END PGP SIGNATURE-----

--yzmztfvod4bnww6r--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
