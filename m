From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH RFT] spi: ep93xx: Convert to let spi core handle checking
 transfer speed
Date: Fri, 14 Feb 2014 20:24:21 +0000
Message-ID: <20140214202421.GK4451@sirena.org.uk>
References: <1391874746.24507.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EMQjp+MvU6EBGjHc"
Cc: Mika Westerberg <mika.westerberg-X3B1VOXEql0@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1391874746.24507.1.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--EMQjp+MvU6EBGjHc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Feb 08, 2014 at 11:52:26PM +0800, Axel Lin wrote:
> By setting master->max_speed_hz and master->min_speed_hz, spi core will handle
> checking transfer speed. So we can remove the same checking in this driver.

Applied, thanks.

--EMQjp+MvU6EBGjHc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS/ntyAAoJELSic+t+oim9Jz4P/293ZVNu7f3/8jHeVA2u6uHf
lPSSamcFkNbtwggfb7VMUIeMPQgSKYxCviC+40K4V5DtT+kQFo10P4fw7Xdsx5W6
zg+NP3g+uXcST1Hb6r0Jl6HgCmasgAbAgfO9RtiKoLS5mSTdcH5a24SZKCoO0aMj
Lu/HiYKIXhnbdGpp5ZJY1CmuxH1PZzTL7a+f0VJHyGcAy7EFM1GmmfvMlILaUx4b
vTQd7IRGikeJlKbTF/D8n6d4EWR6LRTQUD/U8yXRSnusqHcDohdl9ftmnbbx2Rft
s5cMgKuqQILthXnN6PRJ9ZPstHgwDASp/sOh+Z+++ea5SACyZyGBeoHHXuBZ8BE1
zCj2LDyDWLCx1WZMbYEgQOJDDdBTLQU+jnVUe2gNG8bj2ZwQE7qEi1h3TJuAhw7x
EpGKIhMYmv6JM/loFBkKpyRkCgJR7REl8Y/fnE9uN3drVQ4/E1x9ZVAwjV6SCz6q
fkRQ5Be0Tkvq7A9VAWQ7MA2ft6s4zIiQ6XL0MzUhL2ZliYVgn58ALQydlQDfTUXY
XH5bSmth5B6yUtRIX3dG/KLDq0TMBSu7Uj45dc9BLGMuaqVnkEyjfO4DCBYWPVfp
7wOVz9ZLQfnBd/mRbRncT/473FRemWdubDOXGdH69xUetgRuVIuaFaCdZkqmzXTN
kqwoALuB285Li5CJDZIn
=eFdB
-----END PGP SIGNATURE-----

--EMQjp+MvU6EBGjHc--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
