From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH v7] spi: sun4i: Allow transfers larger than FIFO size
Date: Wed, 26 Oct 2016 10:55:28 +0200
Message-ID: <20161026085528.vjjypbfmfbhvileb@lukather>
References: <1477465231-17704-1-git-send-email-mr.nuke.me@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="r2ndqqqu2w33zcqa"
Cc: broonie@kernel.org, wens@csie.org, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
To: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1477465231-17704-1-git-send-email-mr.nuke.me@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--r2ndqqqu2w33zcqa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 26, 2016 at 12:00:30AM -0700, Alexandru Gagniuc wrote:
> This is the seventh attempt to get this patch in. I was prompted to look
> into this again as someone recently remarked:
>=20
> " cool, to bad spi does not work properly on allwinner..."
>=20
> Two and a half years ago,  we were told this will all be handled with DMA.
> A year or so ago, we were told this will all be handled with DMA.
> A week or so ago, we were told this will all be handled with DMA.
>=20
> See the pattern?
> When DMA finally takes over, this fallback path is not mutually exclusive.

I definitely agree, and we had this patch in the CHIP kernel for quite
some time, working like a charm.

I was planning to respin it in the next few days, glad to see you took
care of it :)

Mark, any comments on this? For the record, it already has my Acked-by.

Thanks,
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--r2ndqqqu2w33zcqa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYEG98AAoJEBx+YmzsjxAg0BoP/2mpKmhuQqgMt6IqcM6aAyu/
JFaco/hMkHm+dw+sFFUw+gtq+HUGqAL8KmVgtkzrJo9uYcaQJEPzEhKXfUQP/n5U
VlJjXH0TWSuIqBrd5YvMhNXEFuMjWnO9q2i/aFyFcXsvj5RJw1852zK1w2hJmasX
Gkz24Pqd5mWpMHjScledTLDSkYhLAa0XWRuCwJCE92jgmoFR+2wGd0eKfUobvBCn
4s6qowpAEro2pXuwYfokzlBgYBodMzEAMD0vtlVk3Q0fWcp7h6XvDCw4A3uuK0Gx
epMaIQYljhoQtg70fkMDAW7QMOASFR8OPdlDE4DamHc/iBNuxns9IzNSH9DYf+1J
MbWxKTPw5pFtb5Tm0GN+S88vMRvHx9vimzSZriGgDygxL1PDGXdVS0UUIWHeGUqY
7tzhJ1NJEQWz/ZIGeAbGN6jDEgeUOfClkGL8Wt9BdwsWNtzRb8pONhhrUU8KJYQI
p7f51kYEDFOoMQZi742Syugbhh7aabwLcnfIUKMLBOMx7/ZTGEwmFhi1M13ZIAmZ
cYs2y/zGv4lp7hUnffk80FDdwwTO1lY8VcOrL3YG0DkO9Uw6YAvu8VvrL/cwUr3I
UiOKeMIqRYJuPyOSUj6zZMEfYgL/c5itbYgTIeNOubLSb/iq0luSHYyqetTgoAO9
mUZz42WA5CqUtXLflzbt
=IimF
-----END PGP SIGNATURE-----

--r2ndqqqu2w33zcqa--
