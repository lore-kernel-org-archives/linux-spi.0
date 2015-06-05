From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCHv2 1/3] spi: pxa2xx: Differentiate Intel LPSS types
Date: Fri, 5 Jun 2015 11:40:55 +0100
Message-ID: <20150605104055.GT14071@sirena.org.uk>
References: <1433426112-19021-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="y9n12KajPNdV/7DP"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1433426112-19021-1-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--y9n12KajPNdV/7DP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 04, 2015 at 04:55:10PM +0300, Jarkko Nikula wrote:
> Intel LPSS SPI properties differ between between platforms. Now private
> registers offset 0x400 or 0x800 is autodetected but there is need to
> support also other offset and handle a few other differences.

Applied all, thanks.

--y9n12KajPNdV/7DP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEbBAEBCAAGBQJVcXy2AAoJECTWi3JdVIfQ4+QH91kPMBJfDlocIFiVQpTqpkN4
AlpoBD2qq7wA/aywrKo3CtBUrEQGe93u5zO3eWXQRw5d5SS7MEzXaGGmPQfwBqTx
FUzofiA6qvkSxjv9nxIlHiEHlB75T8wjfzV/pTyWaQD7UtsB+zH/3gka8yxp6LzL
oM4t77pN14qBIRioNLisnFRykLOoUmP/NCbRmnUtpS1j2s5nMcA+Bl3Zt9IDl+1E
/pgqjaRcBJduivB7kBagDNouytnp3Z24/Q/ArSeYRitSu5woY9HksQoSzebMbFgp
docMzIONhinx74tqLVJOX0zTnDxyD1PTM+3PBU+/QmgwXenk/H2SHE1NorpsPw==
=+uo+
-----END PGP SIGNATURE-----

--y9n12KajPNdV/7DP--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
