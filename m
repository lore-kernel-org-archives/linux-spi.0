From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH/RFC] spi: core: Fix logic mismatch in spi_master.set_cs()
Date: Fri, 17 Jan 2014 18:03:04 +0000
Message-ID: <20140117180304.GB17314@sirena.org.uk>
References: <1389699411-29135-1-git-send-email-geert@linux-m68k.org>
 <20140114125242.GE15567@sirena.org.uk>
 <CAMuHMdVmSUh8yphZ4oPR=QYp5uMS9BXgPRVuwa19S9q7jWxxiQ@mail.gmail.com>
 <20140114134528.GG15567@sirena.org.uk>
 <CAMuHMdXEsNKRxYv8gh5sDzpg_QH2RmrjYhLhCZx0QCcRN+gdOg@mail.gmail.com>
 <20140114145002.GR15567@sirena.org.uk>
 <CAMuHMdVhmtA0ogEqu-jj8Kvii5CwV8qfHn+GzgQ9uFKzH7Ua6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sZvnRN25x3w09J/6"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdVhmtA0ogEqu-jj8Kvii5CwV8qfHn+GzgQ9uFKzH7Ua6w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--sZvnRN25x3w09J/6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 14, 2014 at 04:18:06PM +0100, Geert Uytterhoeven wrote:

>   2. Make the documentation match the code.
>       It seems this is what you prefer?

Yes.

--sZvnRN25x3w09J/6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS2XBVAAoJELSic+t+oim9rHgP/i1/nQxfZvBNbsL3JGNA4oqE
CCErqNWnEAQnunlwXvcVjkyppjlkdmILGpygpWPW//DQxFm+icVg+xMjl8xpqK0n
3vVTsI7CUfWO1lyYlNPlPGcduzfk32U1FrigKePVWpDHi03VPcTdmG4Vx1iux1e/
YONtZBLpyVDhCpIXvGrAz5sM9PREXUSn1Bc5N5Ry7onQHSwpLV0akSsFFg/ZL9kb
H2DZUnXrxM/pKMny3PA/5+dYvDBE8haYMbkLVOJuPByl82no3c26EH9Zi1jhjjSf
aUKouybx76QOC+H1/dWGNDiu5DMKY2EUaXkPlrknT/Xo6w+Wu00Q4q0SZUygJPt3
z2gfS0A4nRZ+tr/v+PE5nXzdm3Ci2LFSKXQGXlkNc5AaXxUgqTVVrRD9MA0FUy2f
2dnZz/MSsGYXHbSNdEeVXfBQPBu0R+/WK6uSSNP06wFjUsnOM6UR1nXMmMEpPBho
B8pE1g9YpELgli7mkUoAIkJpR1C6nrWdsDkkzbyx/n65/XK29Uzz5klrKYvoPwWg
bBLgenpIoYLBz4qFBPdg5H2UXbM6awW8KoV3xfCWBCm3P0sU7EiIGT3mfQkkx4Tp
U7rGee/P2O1NiiZNA3Qrv4LsWijFPFMIkJrudmZANmc4Rb6SXGoNNiXDfvQNQacr
op5/f+i2J5AkrAS0Id/h
=M5cx
-----END PGP SIGNATURE-----

--sZvnRN25x3w09J/6--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
