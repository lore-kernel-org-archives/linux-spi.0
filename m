From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 1/2] spi: add transfer_status() callback
Date: Tue, 10 Jan 2017 12:37:29 +0000
Message-ID: <20170110123729.j6qa34b7ipm6ih33@sirena.org.uk>
References: <20170103172015.13052-1-hauke@hauke-m.de>
 <20170103172015.13052-2-hauke@hauke-m.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fkfbxuwrynszkvpr"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hauke.mehrtens-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org,
        thomas.langer-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, daniel.schwierzeck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
        john-Pj+rj9U5foFAfugRpC6u6w@public.gmane.org, nbd-Vt+b4OUoWG0@public.gmane.org
To: Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170103172015.13052-2-hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--fkfbxuwrynszkvpr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 03, 2017 at 06:20:14PM +0100, Hauke Mehrtens wrote:

> Currently a call to spi_finalize_current_transfer() will mark the
> transfer as transferred successfully. To return an error it is only
> possible to not call spi_finalize_current_transfer() at all and let
> this time out and result in a timeout error. With this callback the
> driver gets asked about the status of the last transfer.

Errors are returned by setting the status field in the current message.
Look at the code in _transfer_one_message(), if the status changes from
-EINPROGRESS we'll handle this as an error.

--fkfbxuwrynszkvpr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlh01YgACgkQJNaLcl1U
h9DySgf+P9ljh5pyOkxEJea+kIWQiMABQb8jGiFkUz9VqcQ9hibrpoIoYpG116Rb
MePmk91oa8ogE9fzX9QTXCcf+vCxaRbrLvghXUajyYzA2jzI32T4QIaYD0wbHWfd
FqNGtLmcSjta0qxBxgejb3pTWI0XoYteO3T2aNH8OzsD39PUIluwebBeyD0fDog2
yN0JPOZNOpRKGkIvcnFl6q7pJ+d2V1NM+HcTviM9oPAqXFim5QJOsRvNEFFWjdEM
Z4wXIgUwoNKBz+fFfPgmPFUjfoROR4romSeW6zuILIFwXLR4LHamIQC9b535YsBQ
25797lzCNRxH3n60FvSnKBXO7l9JSQ==
=f0G/
-----END PGP SIGNATURE-----

--fkfbxuwrynszkvpr--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
