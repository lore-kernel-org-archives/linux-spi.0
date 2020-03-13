From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V2 6/8] spi: spi-geni-qcom: Add interconnect support
Date: Fri, 13 Mar 2020 13:16:03 +0000
Message-ID: <20200313131603.GG5528@sirena.org.uk>
References: <1584105134-13583-1-git-send-email-akashast@codeaurora.org>
 <1584105134-13583-7-git-send-email-akashast@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yZnyZsPjQYjG7xG7"
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, agross-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org,
        mark.rutland-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, swboyd-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org,
        mgautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org,
        dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, evgreen-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org
To: Akash Asthana <akashast-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1584105134-13583-7-git-send-email-akashast-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--yZnyZsPjQYjG7xG7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 13, 2020 at 06:42:12PM +0530, Akash Asthana wrote:

> +	se->avg_bw_cpu = Bps_to_icc(mas->cur_speed_hz);
> +	se->peak_bw_cpu = Bps_to_icc(2 * mas->cur_speed_hz);

As I commented on the previous version to no reply there seem to be a
lot of cases where the peak bandwidth is just set to double the normal
bandwidth without obvious analysis.  Should this default be centralized?

--yZnyZsPjQYjG7xG7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5rh5IACgkQJNaLcl1U
h9AtyAf/XGCSN/P2UBMgDB7zS2/kHyiB75d+zQ4/Y9kOYRRUEmraGjcBvlQ7hPn0
8hDCOOdWQp+X3iY8ttBkizIjAaCUiZmBd2aG7POa4PTMB1+oS1TFXrmws+ay3y3k
AGSiIcaVWMok+DPTsNcRAwnjI+qw+4kzyvvShiRE6Ph/T1EE5/UL96CFf6pW8phf
x3ehV4YsJ+ZIhHFe1NAD+xKtlO6WrQxin6K3D9KxfjAp8qF7BobdNMxQZZh0kff1
432vNAgsp/g/O+SHfSZWzUtsTiznj9IQ1WcQQVHQmhAsiOKd8xihsUYcsL+B8biv
xaZIVqWrbN9/wiOrtAxMRsrXMJFJpg==
=l0mj
-----END PGP SIGNATURE-----

--yZnyZsPjQYjG7xG7--
