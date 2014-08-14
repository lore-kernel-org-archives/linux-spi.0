From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: rockchip: return 0 if tx_buf and rx_buf are NULL
Date: Thu, 14 Aug 2014 22:02:53 +0100
Message-ID: <20140814210253.GF17528@sirena.org.uk>
References: <1407977544-2989-1-git-send-email-addy.ke@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DMVR+kHVjCKdhElC"
Cc: heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org,
	robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, hj-TNX95d0MmH7DzftRWevZcw@public.gmane.org,
	kever.yang-TNX95d0MmH7DzftRWevZcw@public.gmane.org, xjq-TNX95d0MmH7DzftRWevZcw@public.gmane.org,
	huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, zyw-TNX95d0MmH7DzftRWevZcw@public.gmane.org, yzq-TNX95d0MmH7DzftRWevZcw@public.gmane.org,
	zhenfu.fang-TNX95d0MmH7DzftRWevZcw@public.gmane.org, cf-TNX95d0MmH7DzftRWevZcw@public.gmane.org,
	zhangqing-TNX95d0MmH7DzftRWevZcw@public.gmane.org, hl-TNX95d0MmH7DzftRWevZcw@public.gmane.org, wei.luo-TNX95d0MmH7DzftRWevZcw@public.gmane.org
To: Addy Ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1407977544-2989-1-git-send-email-addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--DMVR+kHVjCKdhElC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 14, 2014 at 08:52:24AM +0800, Addy Ke wrote:
> To do so, spi communication can use an empty buf to pull up CS.

> This patch merged from ChromiumOS tree.
> Cros_ec use this function to turn off CS and add a delay to ensure
> the rising edge doesn't come too soon after the end of the data.

>  	if (!xfer->tx_buf && !xfer->rx_buf) {
> -		dev_err(rs->dev, "No buffer for transfer\n");
> -		return -EINVAL;
> +		dev_dbg(rs->dev, "No buffer for transfer\n");
> +		return 0;
>  	}

We should be implementing this in the core rather than the driver - just
not even call into the controller driver if there's nothing to do.  That
way we make sure that every driver works properly.  After all, the delay
itself is implemented in the core.

--DMVR+kHVjCKdhElC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT7SP6AAoJELSic+t+oim9b2kP/17R09sfWwDcnHSoljRanevO
4FnFbkGMsAmkHwjC8MFF8bJ0V1RhD8ZCiL+0KC4HDBErCOgtkCaIcbwiyYFb/hOB
6Ft9/D1BbyM+PqgAUiugv4wB8RSwN0UkUkOyKN5HzYJz5NAB7xsHTjCGATVoswQp
S46f6JNCW3BAikBnGA9Iq6IdF1tJpw5/3UM6zFBpdjpIJy5pNFf0E9GftbgdfjIR
qo3GML9sOGVR1UYsdWkvujDb7HnRaF/ACRi06swA9cMl1kk81sy7FNPUXfPfoNdN
wO8RAJVt9ZdZOhLw51PhJjUMU3toEUnpY252g5FOdC2F2h1WN9OYmuJfkwTu3433
FQM59PfZB62Dh+UPx84LTgQD9q6pGnwyfj9o+OmPgSCzCsXOMde5LaTzuxbBCbTO
BvBPt3VbPavnvwuJ2XcC118xYjn3aD7XhFfSc6JhgP8gcyPz1xHyKJOcS15SJEFO
Rp/Ug7fZzOGRW2PyVrVxUW77xkM79K5bNJDKpgxoRl9bJ/2dBurI5poaaSLNkc6h
xIUji6FGMXZUZOySKuwYWyqGMnsz5YKB6NcK2aXQzyy1d0eArWkEXbZAIa6IPFpu
tIC1+6rJCIVT+EGIkJTsjVsL58Vdh/6fmbcDYxDpwtfn3nHbineXiQgFMyYusCH1
7XicWLyUrdA9IldCImxd
=IId5
-----END PGP SIGNATURE-----

--DMVR+kHVjCKdhElC--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
