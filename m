From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: Clean up probe and remove functions
Date: Sun, 16 Feb 2014 08:40:31 +0800
Message-ID: <20140216004031.GQ4451@sirena.org.uk>
References: <20140213152841.390de00f@endymion.delvare>
 <20140214150341.GC4451@sirena.org.uk>
 <1392402129.4365.51.camel@chaos.site>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hkJ/XfKuQcNFcQvU"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
To: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1392402129.4365.51.camel-H7Kp9ZFCxt/N0uC3ymp8PA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--hkJ/XfKuQcNFcQvU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 14, 2014 at 07:22:09PM +0100, Jean Delvare wrote:

> I don't disagree. The rationale for the change is that I simply reverted
> to how the code was before 33cf00e5, assuming that the introduction of
> spi as a local variable was caused by it being used more than once. If
> you believe this was a good change on its own and would prefer to keep
> it that way, I could send a patch replacing this one and only changing
> &spi->dev to dev. Let me know.

I do have a small preference for it but I don't care enough to suggest
you actually send that patch - if it annoyed me enough I'd just fix it
myself.

--hkJ/XfKuQcNFcQvU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTAAj8AAoJELSic+t+oim9MDEP/1frJvX72geU5UadN4vvelKt
znoFHsZ9X7mGVzivAJWzerIUxPsUGelsR/5LK7ilR1/mP81oG0NRj4e0uQCGA+tK
8uvBF2ADQ1A6I+hKs9YP3YjmfKq6ey4SoMiX/qBfHeJJJ/MSaJHymI5gH22Av5mD
+MB52O96X7wCjRkpdJ5nn5srbw1WTY6S9uDSC7WyiYy4kmAIUaC3cgCg7tgQ8cSx
jgADCzvquLjNFliPdsWt392vUOWJQ698wLYETDC0oyBj/iOFOWJNnp0FfPfoKUSl
nsiomlnSd3+BrojBtLLBYHkMpV+Z9eed74Nsu16M+lLMjC5lARBouJyPZhduWsFp
yZ5tBUbTHdaTiDbzDLZ/LYS0Om8iboMqEYnHg71eeYQUeC9nctbMRUuTg+oOrNEZ
rsfkYIRYYgaV0xB0y3gbklZP6jTcueCcmn3zQObfXGwUGDrZwQpP8ZBYlBfGUlrv
ZtxX/eErXMukknXN5O8akqgL/y4GJ6nPXYhRru4U/7gSwdW9gfAe3Z7Q3SB5wwdC
WoWitMjmKzdc6rOFLlIHUjzy9EXuNWa/okxFnqg8KVw4hII8NraSQiZbQ5Eyh/oB
rYXx0OeJb/zV1lqkI5mTH7+7BRRSH8WOzhyd1oVkAkHuzuPG1RlHTe0MkgKLrxsX
YgCiZ7ae9OkG0jxWDeGN
=lXzD
-----END PGP SIGNATURE-----

--hkJ/XfKuQcNFcQvU--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
