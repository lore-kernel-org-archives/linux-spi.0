From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/4] spi: Allow SPI devices to specify that they are
 timing sensitive
Date: Sun, 12 May 2019 16:42:53 +0900
Message-ID: <20190512074252.GD21483@sirena.org.uk>
References: <20190510223437.84368-1-dianders@chromium.org>
 <20190510223437.84368-3-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7029108184277579259=="
Cc: drinkcat-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org,
 linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
 linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org,
 Enric Balletbo i Serra <enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>,
 Guenter Roeck <groeck-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Benson Leung <bleung-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
To: Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20190510223437.84368-3-dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--===============7029108184277579259==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+B+y8wtTXqdUj1xM"
Content-Disposition: inline


--+B+y8wtTXqdUj1xM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 10, 2019 at 03:34:35PM -0700, Douglas Anderson wrote:

> + * @timing_sensitive: Transfers for this device are senstive to timing
> + *	so we should do our transfer at high priority.

Not sure this is the best name.  Every device is timing sensitive to
some extent and it's a bit wooly about what it's trying to accomplish,
it's specifically about the timing involved in ensuring that the entire
message goes out as quickly as possible AIUI.  I think if anything I'd
just have the caller specifying a RT priority for the thread, but that's
awkward as we might want to switch over to deadline at some point.  How
about just calling the parameter rt the same as it is when the
controller does the same configuration?

--+B+y8wtTXqdUj1xM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzXznkACgkQJNaLcl1U
h9BbrAf/QuZJvvnzSN9f3YRIMrxOcWjPSXe8m7cpjjYwT8RgFk/K/D2EtHZqpPa8
elj2mlHof5nWuPrCydyTZz4dV2Q7K49cprgr2q7oK+nifKWCIVDFZvB5NjIP165o
dI34Xs1qOUui3KPVSl1CGed2W9d2y+5TEck0os5MsnjpL89b4NrMr/lq3z8zZ0dE
6WfF7Tr49s10iLyo0g7QYPqvw1/nGoxKloIEGs2j2GALOqzDZgd6UjXOTig8UfgR
VYCn8zQ3IO2FBFLnnS+jSqzNwacaKtqLIP+4oeKiQWCzIiw6HDvV/vMbOg6PvAUO
cWErMjpY5aVcL/XP4BawO+V+ivVgVw==
=Eybc
-----END PGP SIGNATURE-----

--+B+y8wtTXqdUj1xM--


--===============7029108184277579259==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-rockchip mailing list
Linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
http://lists.infradead.org/mailman/listinfo/linux-rockchip

--===============7029108184277579259==--
