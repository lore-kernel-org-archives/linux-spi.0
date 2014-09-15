From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: davinci: request cs_gpio's from probe
Date: Mon, 15 Sep 2014 09:38:41 -0700
Message-ID: <20140915163841.GU7960@sirena.org.uk>
References: <1410533640-21469-1-git-send-email-grygorii.strashko@ti.com>
 <20140913162858.GG7960@sirena.org.uk>
 <5416E462.7010406@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="75efu8vkn6QcqU9C"
Cc: santosh.shilimkar-l0cyMroinI0@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	m-karicheri2-l0cyMroinI0@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5416E462.7010406-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--75efu8vkn6QcqU9C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 15, 2014 at 04:06:42PM +0300, Grygorii Strashko wrote:

> The function davinci_spi_cleanup() will be reused by following patch
> "[PATCH v3] spi: davinci: add support for adding delay between word's transmissions"
> http://www.spinics.net/lists/devicetree/msg49141.html

> So, in broonie/spi.git/for-next it will not be empty.

> Again, I've missed description of this dependency, sorry for that.

Don't do things like this, delete the function and then re-add it - it
makes the review simpler and it means that if the second patch doesn't
get applied (as will happen here for v3.17) then the code still looks
good.

--75efu8vkn6QcqU9C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUFxYQAAoJECTWi3JdVIfQytkH/jHFT/WzdRQolrWSNqqN39PT
BoQhnD+qINyf1ZIjRVu29oRfCrjTBCZjTSFDdJ5DsLuaSxofwImBdjv8hpQkGY7e
8AbrnX0mfIZQcK9t/ET7Nr48Ub0gaUcm0EbiySflefhdmhFb3h13kWXbAjAgdjx0
xJfXK5yYCObLU6H171QXtdGRTS8N/XhZL5mNMEkL0Bcxqe4dT/45R9a5ytQEioL0
j9MZFiOFNC2LZ2+7L0CkCQ5RspQsCOgCUkst84CSHtxEmJPY5DMfAF8RtnwXeA2S
7P4eX2NY50pMxvYSbgomQMHShIOY2d6tHGwocQWnNmr86m20nnucPfuozrjYmPI=
=L7k3
-----END PGP SIGNATURE-----

--75efu8vkn6QcqU9C--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
