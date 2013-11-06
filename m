From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: Depreciated spi_master.transfer and "prepared spi messages" for
 an optimized pipelined-SPI-DMA-driver
Date: Wed, 6 Nov 2013 23:26:05 +0000
Message-ID: <20131106232605.GC2674@sirena.org.uk>
References: <20131031001004.GW2493@sirena.org.uk>
 <18639D9A-630E-44F3-AA7A-ADFF5D5E8B56@sperl.org>
 <20131104184511.GR2493@sirena.org.uk>
 <5A55A832-5313-499C-A483-BF5A6649D69D@sperl.org>
 <20131106094854.GF11602@sirena.org.uk>
 <844EDAEA-3FDC-48D0-B59E-CECC0A83761E@sperl.org>
 <20131106113219.GJ11602@sirena.org.uk>
 <C6C68042-63A0-40FD-8363-B4553ECB4774@sperl.org>
 <20131106162410.GB2674@sirena.org.uk>
 <3B0EDE3F-3386-4879-8D89-2E4577860073@sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jy6Sn24JjFx/iggw"
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
To: Martin Sperl <martin-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3B0EDE3F-3386-4879-8D89-2E4577860073-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--jy6Sn24JjFx/iggw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 06, 2013 at 08:54:10PM +0100, Martin Sperl wrote:
> >> The above is an allowed sequence, that must work - otherwise we would=
=20
> >> break an existing API.

> > This would be broken anyway with existing drivers; if we want to support
> > that we need to take copies of both the messages and the transfers but
> > really that just looks crazy.

> The sequence shown is not broken - see that I have been using spi_sync=20
> not spi_async! (think also of people using this via SPIDEV, where you do
> not have such control as you would in kernel space)

Oh, if you're using spi_sync() it's fine but then what's the issue?  The
stack isn't going to remember anything about old messages when they're
resubmitted so why would there ever be any problem?  Even if there were
a problem I can't see how having the core manage things is going to be
an issue.

> Also see the scenario like this:
> * kalloc memory for message
> * add xfers to message
> * call spi_sync
> * kfree xfers
> * kfree message
> * kalloc memory for message
> ** here we may have a high likelihood of getting the same pointer again
> * add xfers to message
> * call spi_sync
> * kfree xfers
> * kfree message

> so we would need again a means to detect such changes.
> The pointers are the same, but the data may be different.

Why would anything even notice a problem?  Like I say by the time the
transfer is returned to the user the stack isn't going to remember
anything about it.

--jy6Sn24JjFx/iggw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSetAKAAoJELSic+t+oim9WaQP/3taiA/SecUHBii1ozGBINTD
4TYjY6fE6DKjU4LyT5G9eb60cbnIQ9Eo0oK4miTKnNXW6mMwSw4ctikz6bif0+Ax
sOiZIRyvVOIoOnhJlQ0cgzPP0mg9d90FLlGJCCe/vNJIlk3SghBRLV9EG7vF45z1
OQaxrT7hFMBRHpZb+gvWyd0cb+FUgbvKxPjc/iAeS1nyyWSpmML1QtN0j10DaTSJ
uueL/qynk1zbcVi2myhDuNz0/PBOxEvHvz78FtCZFgrpVMBRsyKpjM51wFHkHpaE
5pvY5ntFNVT3eCz3rRE6nwBFPgXUxvwjNMeIL2idjC8BMR/5Lj2M3egbRCNdfPfC
qmYC4+oGW2BawXIbVIgKu7vW5lqxQb4aIbNowKFh2j2ug2XC7IgqzIeuWulyIiGP
F0nJV/i3rE/FRbAPo4r1YqgUeO4qtOztmUeoqfJu7aV++l09YydQgdKeW4obocB3
ZPQdpBqxiXe8LJS5BPg0wrpYNuC3hNXnbK/hiQJ1UcT+U/0M1QsvFdl/thrNj9dc
cCxu0tk7uVtdcIbA1WCcmsImFYhKlM3sCQ5gGKdna/bBd3JiJpikV9WfRxww6vrB
rn9LsjQ0PUnOc8xiTNsrMr4jh56mzh8qGEALcDPeRKh6ENQpFy5aWL0Ze0ZfyCxI
fNl+OViw6i6T98USBkEz
=gOvR
-----END PGP SIGNATURE-----

--jy6Sn24JjFx/iggw--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
