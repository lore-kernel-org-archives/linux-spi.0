From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RESEND PATCH 1/2] spi: rockchip: Convert to late and early
 system PM callbacks
Date: Fri, 13 Oct 2017 19:37:50 +0100
Message-ID: <20171013183750.piabs7m3dnpabnkm@sirena.co.uk>
References: <20171013104138.3216-1-jeffy.chen@rock-chips.com>
 <20171013104138.3216-2-jeffy.chen@rock-chips.com>
 <CAD=FV=X6pkaY3t=ceh3QEUws+_gqRGMN9zveW0fXR1noF1T6ew@mail.gmail.com>
 <20171013155120.GA137489@google.com>
 <20171013164235.thgqha7sl5tdptwv@sirena.co.uk>
 <59E103B0.8060705@rock-chips.com>
 <20171013183006.k6pzcr5tcwsxxtmp@dtor-ws>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nvlrob4ycjbsshux"
Cc: jeffy <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>,
        Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
        Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
        "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
        <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171013183006.k6pzcr5tcwsxxtmp@dtor-ws>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--nvlrob4ycjbsshux
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 13, 2017 at 11:30:06AM -0700, Dmitry Torokhov wrote:
> On Sat, Oct 14, 2017 at 02:19:28AM +0800, jeffy wrote:

> > > Yeah, it's the same stuff as we get with initcall ordering.  This sort
> > > of thing does happen with things like PMICs which tend to have hardware
> > > that the system wants to manipulate in the IRQs off part of suspend.
> > > Ideally the dependency annotation stuff would figure things out though
> > > I'm not sure what the status of that is.

> I'd say non-existent for resources such as regulators, pwms, clocks,
> etc. I do not think many places call device_link_add()... I think adding
> this to devm_* APIs might be easiest to get the ball going as they
> naturally have consumer device and can easily figure out the supplier
> side.

Hrm, are things in a state where we're supposed to be doing that?  I've
not seen anyone even trying which is a bit odd, I'd thought there was
some core work still ongoing (and it wasn't clear to me if we were going
to try to do things like use DT/ACPI cross references to figure this
stuff out).

--nvlrob4ycjbsshux
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlnhB/4ACgkQJNaLcl1U
h9AL4gf/TPauvBLJA1KlEwk+1G5Fmtq+YD9yujRnt01kMKvCwglVFmrLuAdk5Pgp
rgw6I60AChk82u6Kny0diLtrgCsctMU8Js0Cs1SysxmC5uwIsWEOHiyFBJ9SoKuQ
exN+/RAOcCtYc9TYys+qxA4Ys3H9FhyB18gVYYgix/22IZ0u+IKJWnrvXpPfB7Rd
H1Xlykbq57wTOhw3Ox7nmbqkHX2S4N68KK8VxREobN18GmFKATQe7RRI/ep4uig7
eIF793oFR9B6OCIYk8Z8s1ZKB/P8GXECPHvXFb3IoiZqdfzQnSDtkDeEbSNmXtcq
LlAhn7s342MEyO5fS5QrQY+3pHK1jw==
=CrhW
-----END PGP SIGNATURE-----

--nvlrob4ycjbsshux--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
