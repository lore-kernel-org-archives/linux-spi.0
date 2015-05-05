From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: add statistics gathering and reporting methods
Date: Tue, 5 May 2015 16:02:46 +0100
Message-ID: <20150505150246.GG22845@sirena.org.uk>
References: <1430741564-2849-1-git-send-email-kernel@martin.sperl.org>
 <1430741564-2849-2-git-send-email-kernel@martin.sperl.org>
 <20150504134226.GY15510@sirena.org.uk>
 <9A0ADDBC-5D5A-428F-B434-9CCB97505DCB@martin.sperl.org>
 <20150505142008.2087baac@north>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SSlfERZsBlnM8Nke"
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jakub =?utf-8?B?S2ljacWEc2tp?= <moorray3-5tc4TXWwyLM@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150505142008.2087baac@north>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--SSlfERZsBlnM8Nke
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 05, 2015 at 02:20:08PM +0200, Jakub Kici=C5=84ski wrote:
> On Mon, 4 May 2015 16:25:01 +0200, Martin Sperl wrote:

> > that makes it much more complicated to add things per spi_master
> > implementation (which was my original idea: have a framework that expos=
es
> > the distinct transfer modes of the spi-bcm2835 driver (polling, interru=
pt
> > and dma driven) and also to get some stats on how often we run into tho=
se
> > =E2=80=9Ccorner=E2=80=9D cases - that is also why I want to gather the =
histogram
> > statistics, as it may make it easier to understand the use cases of peo=
ple
> > who complain about =E2=80=9Cperformance=E2=80=9D in case they share tho=
se infos=E2=80=A6

> You can also consider adding few strategically placed tracepoints. =20
> It saves the amount of kernel code necessary and is generally more
> flexible.

We already have a bunch of tracepoints in there (probably sufficiently
detailed for what's here) but they solve a different problem to
statistics - while you can extract statistics at least as far back as
the tracepoints go but it's slightly cumbersome and for longer term
tests the buffer will roll round at some point and it's a bit more work
for people to set them up.

If we can gather a few statistics without too much overhead I don't see
a huge problem with doing both.

--SSlfERZsBlnM8Nke
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVSNuVAAoJECTWi3JdVIfQOj8H/jSOprLg7R1SM9yjAWCSI3BE
FDdq0TB/tzWwmhQqZicDjvkH0eB6WZGQyH+u9PqsucPLJCmqmRtvIGmU9ktXyGsY
O7duvOCOeNJbHKvpT2QIrbdQ0TXZh9Hi8fVW7RFggyQmjW8dwk3AWMuIEVoYlIlW
foobOZ0YMijgsHvEQjDWF83t4DIxtzqdgMbntPk3OWSkj8raR6PgRst7puXiLuMj
XPmb7sOhkVgjVk2wKYlwKJLyJniVCTOPINYElHmQBanabZmy2tsM3BPSLEN4f2Na
UQLI+YfCki2VCG6JeUAJ4hVl8Y6NYkED/X6wjPeeRaK2qmqVU82VtY5ZuMOZqpQ=
=84s2
-----END PGP SIGNATURE-----

--SSlfERZsBlnM8Nke--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
