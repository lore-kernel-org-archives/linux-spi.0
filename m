From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v1 0/2] spi: fsl-dspi: better approximation for baudrate
Date: Mon, 6 Apr 2015 17:49:01 +0100
Message-ID: <20150406164901.GN6023@sirena.org.uk>
References: <1427965907-28125-1-git-send-email-andy.shevchenko@gmail.com>
 <551ED2F6.8020701@datasoft.com>
 <CAHp75Vfa9b0s6rXMbUERbbGRowGp4bidKH1UZ4a8HAx23oSrLw@mail.gmail.com>
 <551F17B1.3010109@datasoft.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Tb77rFjxeKqknTuc"
Cc: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Aaron Brice <aaron.brice-vSOi0k5x9wFWk0Htik3J/w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <551F17B1.3010109-vSOi0k5x9wFWk0Htik3J/w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--Tb77rFjxeKqknTuc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 03, 2015 at 03:44:01PM -0700, Aaron Brice wrote:

> You're probably right that the extra Hz are "unlikely" to break
> anything.  I think they're also unlikely to improve anything noticeably,
> what systems do you have where the transfer speed of a SPI device is the
> bottleneck?  In my case [1], I'm 1000% more concerned about reliability
> than throughput for the SPI devices.

Reads from flash devices, anything doing firmware downloads...  there's
probably other examples but those are the ones that spring to mind off
the top of my head.

> > Can you test on real hardware? I'm pretty sure it's quite hard to find
> > something that will not work.

> Shouldn't the burden be on you to prove that setting the frequency 8%
> higher than the max frequency is safe on all hardware?

8% seems like a huge error especially if that's 8% over, I can't see that
being OK for things operating at or near spec.  Note also that it's
common to see constraints that the SPI clock be strictly less than some
other clock.

--Tb77rFjxeKqknTuc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVIrj8AAoJECTWi3JdVIfQNkMH/RG93uSdpj1KF9+OQabmJp6a
8Dc1uS4q7n3EVQTbVrvAmQ+jIMkBT2LgSYaC2ZFDyAhUQO6nHTsNQMUsM1vtH6DO
8qlzv8o1fhlOMkTBl2qoDyLVs9Ts9ktnkM3vDFfmvXXtJjuKTfzPpoO7rkWJCmD/
T+6TNfm5WmhLnAI5YqLXnkNAi3foDFcuiA4nBjYeDIDVjTROl/H+kORYoohWAS+o
MpCx6JUHtdS5KhqcSatRmNjn6d+N4DXdBczqZ0rEIcbBo7B154RFzFlMlSy1QluB
82Q8V3elaGtx72wgDXAnirJYQhVvLYPoWy72y/v5ieO73qF3B4hA855EeU+FxDI=
=j6jq
-----END PGP SIGNATURE-----

--Tb77rFjxeKqknTuc--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
