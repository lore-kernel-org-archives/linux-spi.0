From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 3/4] spi: dw: fix memory leak on error path
Date: Mon, 30 Dec 2013 13:08:14 +0000
Message-ID: <20131230130814.GY31886@sirena.org.uk>
References: <cover.1388040447.git.baruch@tkos.co.il>
 <4ed40da8c93766ac05ee8d3507ae1d9fdc0a68a7.1388040447.git.baruch@tkos.co.il>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5DFjIrIHbGf/FHYW"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Jean-Hugues Deschenes <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>
To: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4ed40da8c93766ac05ee8d3507ae1d9fdc0a68a7.1388040447.git.baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--5DFjIrIHbGf/FHYW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 26, 2013 at 09:00:14AM +0200, Baruch Siach wrote:

> @@ -669,6 +671,11 @@ static int dw_spi_setup(struct spi_device *spi)
> =20
>  	spi_set_ctldata(spi, chip);
>  	return 0;
> +
> +err_kfree:
> +	kfree(chip);
> +
> +	return ret;
>  }

A better fix would be to convert to devm_kzalloc() so there is no
possibility of paths that don't free (and move the ctldata set earlier
so we don't forget about it on creation).

Indeed this patch will introduce a bug - on the second call to this
function if we hit an error then the struct will be freed but ctldata
won't be cleared.  This will mean that if there is a further call then
ctldata will still point at the old struct and the function will try to
use it rather than allocating a new one.

--5DFjIrIHbGf/FHYW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSwXA7AAoJELSic+t+oim9Yj0P/0260GbSAIwPUevynu/DEnN0
LXRDEtMKNUxWRrOo2WRlRjSt8ij8IKZBqaZtfkVn3btTExM3/hAjtPFYO/7S3hRB
YhLVz5PjtyRQWlHEobiJN6LTTTYy5OgBB12x6FEzw0IClUVettnojg0wQL/7zvm5
OJsm7LMFOsJ9IlftsJ4NjGaipNNhQlKRVdgYhXTWenLNe7HN3FVxwn7aBtJny1Br
b2RyyLAe+WlIiFBstn+oNX2hqKHDvXkUpa9PcfBukuhbRpdYlmNNF5zg5JwaHyzm
YrawQsyCKid6tzK5Tx+Uri6D/45A4IXM8B91KyrQ84Rfz6NUWsO2NAxmJgLkAPAM
du4IXItQQIHzbsFURS5mX9qNNUtnufsRXsaXdHzEDXnwcBJTIGiUveADakirZ4k9
WSMjm3UPYRZFWJ8YhQfJhSYacxfCuqa0J4alD/LPisAetzsNVAIQ+/YQYd/27n82
xu/JjEBPMlxTBYwicdurMovKsrEpCgmTjDGUr4MHxP6uAg0TcMu/b2v/crz6igKw
x2J9BS6LhDfQwp905N1I125onk2/5Qax7cY09Sf9pJWpf1owPL792Ch8QsLZHdRP
IiW7I9eOb0+TdtlMcsZ/UxTP+t2ImaQWrH/kyvqOaJTK/QvjfLl6TPikxnPmx5pB
QKJblswtZ6/XkE35YIz9
=eWgf
-----END PGP SIGNATURE-----

--5DFjIrIHbGf/FHYW--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
