From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] SPI: make falcon-spi bool
Date: Tue, 10 Jan 2017 12:26:35 +0000
Message-ID: <20170110122635.nuznniwxxk74r73w@sirena.org.uk>
References: <20170103170427.26120-1-hauke@hauke-m.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xk5mokjo3ktwbcyg"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hauke.mehrtens-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org,
        thomas.langer-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, john-Pj+rj9U5foFAfugRpC6u6w@public.gmane.org
To: Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170103170427.26120-1-hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--xk5mokjo3ktwbcyg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 03, 2017 at 06:04:27PM +0100, Hauke Mehrtens wrote:
> Falcon spi accesses some ebu functions which are not exported and can
> not be accessed when build as module. Make this module bool instead.

Please use subject lines matching the style for the subsystem.  This
makes it easier for people to identify relevant patches.

--xk5mokjo3ktwbcyg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlh00voACgkQJNaLcl1U
h9DcIgf9H7eB3ida/pfjYGSz+cqBE+S1P7NQfW9coHCqLUrmObAIqZrFYOqRJxGO
LRESHglkGwlDCsKVeo4y6HmyvPfB9uC87Jge7wEWDiKgzEIeM0BP/ghEbyIbIfPL
Fjx2QHdKH5gUHsnyzTOYzZQ1pz1ycK5YYMeZnZ3N6BiiqnT25R38tHVvdp60kbuL
NbsKKTE/T0VmfnU0hAGXnd/GP0JqMcJTCZ6MUOD1Si4gfwMKOX3LgadquyRmhd16
0AfLN7GiqHvCFJnEguz2EjrXZsaU+9KFXb8aHDvXENGx9yefcBoDwG57nv7CwdHf
zbSvB6yy8uc+X+w8OhmypIk+s7DpNA==
=e+yA
-----END PGP SIGNATURE-----

--xk5mokjo3ktwbcyg--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
