From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 2/4] spi: Split spi message into max_dma_len size chunks
Date: Fri, 12 Apr 2019 10:08:26 +0100
Message-ID: <20190412090826.GD6909@sirena.org.uk>
References: <20190411164235.49771-1-noralf@tronnes.org>
 <20190411164235.49771-3-noralf@tronnes.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5095537813464106717=="
Cc: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
 linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, meghana.madhyastha-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
To: Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf-L59+Z2yzLopAfugRpC6u6w@public.gmane.org>
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20190411164235.49771-3-noralf-L59+Z2yzLopAfugRpC6u6w@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rpi-kernel/>
List-Post: <mailto:linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "linux-rpi-kernel" <linux-rpi-kernel-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--===============5095537813464106717==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="at6+YcpfzWZg/htY"
Content-Disposition: inline


--at6+YcpfzWZg/htY
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2019 at 06:42:33PM +0200, Noralf Tr=F8nnes wrote:

> +++ b/drivers/spi/spi.c
> @@ -1299,6 +1299,11 @@ static void __spi_pump_messages(struct spi_control=
ler *ctlr, bool in_kthread)
> =20
>  	trace_spi_message_start(ctlr->cur_msg);
> =20
> +	ret =3D spi_split_transfers_maxsize(ctlr, ctlr->cur_msg, ctlr->max_dma_=
len,
> +					  GFP_KERNEL | GFP_DMA);
> +	if (ret)
> +		goto out;
> +

We should do any message maipulation in __spi_validate() with all the
other mainpulation, the message pump should just be pushing messages
out.

--at6+YcpfzWZg/htY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlywVYkACgkQJNaLcl1U
h9Di0gf/ey4NlD1dmDWB2CdmV+MO7sLXZNFBNDjb2uV6agbEZ0zLYgeQogiasm7u
tT/+5Lp72Gr6JmXVzHn7Az4mYJuI3w/J59n+9eq2StLCR0YnAT2wDecTwjukK60C
T1m13kq0dBD5gD0nrPoOlXczkrg3RmqCh+0YPvygw+pd+VVDtkPqQ+6wFPDay7Wb
wZFPVRKr33j9gWAoXvVuIcTjVpdhjL+Jf0lfBhZrvZ1g2tOzA0jYP3gDSSv1wa8Z
Q1AvIVVNKjY7pKYfGQ/frEgANLO2e/W39o2nx3jMp6WxH7obbB3j7kSpXqQ/cJsd
OXLaySUlb0qTqsirx06r5fZBfpcafg==
=Wc3K
-----END PGP SIGNATURE-----

--at6+YcpfzWZg/htY--


--===============5095537813464106717==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-rpi-kernel mailing list
linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel

--===============5095537813464106717==--
