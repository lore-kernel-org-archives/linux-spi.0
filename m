From: Mark Brown <broonie-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Subject: Re: [PATCH] spi: add bits_per_word_mask check
	in spi_setup
Date: Thu, 27 Jun 2013 12:35:22 +0100
Message-ID: <20130627113522.GZ27646@sirena.org.uk>
References: <1372287286-12682-1-git-send-email-scott.jiang.linux@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7130414296596002755=="
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
        spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
        uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
To: Scott Jiang <scott.jiang.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
In-Reply-To: <1372287286-12682-1-git-send-email-scott.jiang.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://blackfin.uclinux.org/mailman/options/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://blackfin.uclinux.org/pipermail/uclinux-dist-devel>
List-Post: <mailto:uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
List-Help: <mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Errors-To: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--===============7130414296596002755==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4X41Nl0d78nB71pl"
Content-Disposition: inline


--4X41Nl0d78nB71pl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2013 at 06:54:46PM -0400, Scott Jiang wrote:

> +	if (spi->master->bits_per_word_mask) {
> +		/* Only 32 bits fit in the mask */
> +		if (spi->bits_per_word > 32)
> +			return -EINVAL;
> +		if (!(spi->master->bits_per_word_mask &
> +				BIT(spi->bits_per_word - 1)))
> +			return -EINVAL;
> +	}

Thinking about this a bit it might reject a valid transfer - it only
checks the setting in the SPI device, not the setting in the transfer.
This means that if the transfer overrides an unsuitable setting in the
controller then an error will be generated as the fixed setting won't be
seen.  It's hard to imagine when that would happen without something
being very confused but still feels better to check the bits per word
=66rom the first transfer too.

--4X41Nl0d78nB71pl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRzCN3AAoJELSic+t+oim9DdMP/RNF0/WS6SEYN0fSajRbE2xu
NZvDUcFQNHCGBx3O9mTyTnJk1o2IGIklN2E1HxsCku+q7RXqaGWxAwUqdA8Waalr
QUS43r/SzrmeNaY82rMiTl0H+GYswvvCuQUisDrif9Bj7MrI/vYh9PXq0x0BxtE9
4jn/7RcmCMybUf5eVCs9/bxbeOQver+bVTTp4PXoPPeN/8j0xcc+Gzx0m2wzkofm
KXa9iB7WUOlRzjK4MyaDBm66KGbroZCrlTStVOf4LhRi9TohZ3UzQmhdsnhbKtZQ
3It67HzvFLqtRkg/5UWRDdtxBNtiZKJpd0JqJUH1TCJhpHTZbTjE0iEau/cuQGyn
QoncUaqz0H0LXwEH2XIK0AeasAvbCikIaCxHb3AwDI1rT192P+vmGlp+xI42xp3x
NJJduwLjb3cyA447GO9f+O+S/2S2YS+wgQdf5cc6OlgRKuHnnFo0uiWOUZGl5s6v
hfwtSwXuNuPHrmzU1frI3nki0PJlNLUQOzKFsf9xnuq95forfokZTt2Hans/m71B
hPOLrOwRshzTfLXgyW5xifJ6vcM+dnDGsoFLJ5kNwInerLTpMTzMHCCZhHjpO+Ym
5HXH6UMogFeBHEQA/c4l/8LWvCKLQv30CCYlrJPmvAnjXNH9tCIhj8AdDTilqzvK
4opNNlCUQbJJ/W5LSKzC
=lJH7
-----END PGP SIGNATURE-----

--4X41Nl0d78nB71pl--

--===============7130414296596002755==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Uclinux-dist-devel mailing list
Uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel
--===============7130414296596002755==--
