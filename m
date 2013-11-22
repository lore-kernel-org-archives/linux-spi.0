From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: core: invert success test in
 devm_spi_register_master
Date: Fri, 22 Nov 2013 00:07:55 +0000
Message-ID: <20131122000755.GG14725@sirena.org.uk>
References: <1385075475-25441-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vSsTm1kUtxIHoa7M"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1385075475-25441-1-git-send-email-swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--vSsTm1kUtxIHoa7M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2013 at 04:11:15PM -0700, Stephen Warren wrote:
> From: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>=20
> devres_add() should be called when the action to be undone succeeded,
> not when it failed. Fix the inverted test in devm_spi_register_master()
> which was doing the opposite.

Oh, my.  That's embarrassing.  Applied, thanks.

--vSsTm1kUtxIHoa7M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSjqBYAAoJELSic+t+oim9jEUP/1vVqrKj9/IpOf85vqVs/tD4
Euv9Bu86R7rEgvBNzOw7ze2NCT3eqsWGTjIewZHIT0HhEEXVkx7vDgAvVnkXuTRM
nV/yujuH5C5rRNrIcN3jrsANEicuUjDTpO3v7UVh9TaBjKmkVBRXO1nA97SuY3aV
dKa59LQ2JsfzrTC0DIVox+EC/Y0/jcxV8gO9W9n9ZfKSGeUWZiwA7Jo71BeQeJhG
/InVwGNGN3zOIehdfrK9xs4+aoj7W/JXqTk9yNagXnL7AA8RoRJWzkmwlivzfbRO
kdfCYhPP7gA4US5YBhDrI7rNwMyAKnOata856SRjD9lH3NOqBMY8pguc7JXrFO4L
oFnNwVChwDIsCinT+qfyXpSDTj21T0an2RUWDyh2MYhsicHmKAReAhMbdU53KmmQ
c1O4dhQDL4LMSVdZ6B8p6vIZP+FMxZialqGG7h4nGYBNJW4Zp5aJZHUfhR1cO+qi
7Q3psihqehuUpFt8K+KL1LQkwlaEEvIkrZsKQM8OFJ9NlrD5z7RIxzViniqLhPCA
zlbhnt/1yBswCK2ZdzZ3EVmeWyvHux1glQVVVuP/0qTqHR4YRvb/lFi0KhFKsOBf
Rgqm2i7bON614c5tJ+eMBITuZ+g4DLSS5xwwgaBAE2Omcs5JunxlLANryTwXBOwX
APBVzcubOkqzpWVp36zR
=d7V2
-----END PGP SIGNATURE-----

--vSsTm1kUtxIHoa7M--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
