From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: omap-100k: Fix memory leak
Date: Sat, 29 Mar 2014 10:01:28 +0000
Message-ID: <20140329100128.GB21628@sirena.org.uk>
References: <1396076617.1937.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="St7VIuEGZ6dlpu13"
Cc: Fabrice Crohas <fcrohas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1396076617.1937.1.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--St7VIuEGZ6dlpu13
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Mar 29, 2014 at 03:03:37PM +0800, Axel Lin wrote:
> The memory allocated for cs is not freed anywhere.
> Convert to use devm_kzalloc to fix the memory leak.

Applied, thanks.

--St7VIuEGZ6dlpu13
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTNpn1AAoJELSic+t+oim9fugP/156jEehrSAHTNaQClDpfcEe
F+ds14wpH/oZ2X5OVH6lY8I+bvD4/9aYkcoj0LcL0Uniculr8kKOuadI9fNkulOi
YVt1a5OSWmyMvrf9fXSo3/5qpViI4l4a26trqIaZdwW5iKQsPzMnBCBHOYA587eQ
gWwq3EcHZC+tNWzoebP3OQgK5F0zwGWUDeqr8IHplfMY16Dz8+K/nOn11ux2fjl8
zFPVVgWciBQFIUx67kRFO5GniptSzItk8iJQ75wesNaI+BoKMQ6fqN4GR7Y6wj+x
DX3IHbDTfUCmP2ZzCz0+A/emRVRMuwMJy2M2uWCwc5P+ubtZ36PwtZoR1YVp8Q9x
6r9uoJ9TY5Gx4FoauGfoEt6lN2A80txH7GFiDwFeuTgWvOIbuX1x+xXR4cm8qxbE
NyADgOO+Gw33yq65+61kLBu22EP8DH5M7YwyI3Qg6sav3CLQhUJKamY84hYAMxXH
kTWO30VgfZ2yNYCdypcaz/YZiAnqPTNL0RSe+X4ZPfeWFKJrnR/7S2cO4y+LiYFV
c/VYkkfcgl19GHy7kk7uscSxh35bpnFYp97ArMf9cttmu6PQBxoGOBSYzlx+9rwD
SIY5pTjIqaGjlYk7UVc3HaDHHh+30O3uMxug/UlYhhBOc6Jrtlh5tLF7XXwTXS1S
ni3Kb6fFwKgJFEZJsWdR
=x1NA
-----END PGP SIGNATURE-----

--St7VIuEGZ6dlpu13--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
