From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH RFT] spi: mpc512x-psc: Refactor to use core message
 parsing
Date: Thu, 27 Mar 2014 18:20:49 +0000
Message-ID: <20140327182049.GT30768@sirena.org.uk>
References: <1395932757.17331.1.camel@phoenix>
 <20140327172416.GW3998@book.gsilab.sittig.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VjP/dwTbBl6I9PQk"
Cc: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>, Anatolij Gustschin <agust-ynQEQJNshbs@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gerhard Sittig <gsi-ynQEQJNshbs@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140327172416.GW3998-kDjWylLy9wD0K7fsECOQyeGNnDKD8DIp@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--VjP/dwTbBl6I9PQk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 27, 2014 at 06:24:16PM +0100, Gerhard Sittig wrote:

> can you reproduce this on other hardware?  the change looks
> innocent, and the core routine looks straight forward -- is some
> expensive diagnostics enabled ATM during transition to common
> logic?

Right, the loops look almost identical (as they should, that's the whole
reason for pulling things into the core).  I've not noticed this with
s3c64xx though I don't have flash there.  Can you try turning the
tracepoints on and see if they show where the delays are?  Both the
message pump and transfer loops have a reasonable number of tracepoints
in them.

--VjP/dwTbBl6I9PQk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTNGv+AAoJELSic+t+oim91ZgP/jYoWBxGbmorwGiXp3SSVueU
7cKb7Hrk3L7gk9gsTDLnO9yOmcsqFIhpsrI2IQpEdzuFlmTFjSw+n1HnbHxaFL66
8dxfWuWlOtDJL9bj8uEamOiQLQ+hNSKl66yiYccrczGK23KPrwh9Sama+67ZlsaI
7HCYm65DGYyShfsrGJqoD0xwJUy9VfK5PVLqyP6UMvWro2AoJXPwZXJXTkiktaKC
guCT1wBhjXYoz/T+S7j9NXviTspFENCtflH4xbIrfcRlS/4X6vlbtuUxk5vyyO7d
GrU/4r6/+jF11FYZI2M+BmBSgmyUzTghAQSAyv1xvFEPwMnlZ5fHeow7Q6bt8EAb
aLur7ICQ8Z++cdxA07UtrnMMfh05Dj/ml+8qN+Z9kyMS2xbaFb4IU4XmPFg3n7uu
SGYVBX9PHPRd9Zs9Tz3Xq2SD2adb4955ur4GKIeu3pBSStBpMjFZByn1QtZi9olv
Vjy/1Uf3zM05dBDTAobQeM/beIrVVHJq4O2uifsIysn4NbFA3FyHZSwUnr67WDfg
gayVGmGW7p2oTwwJ8psX1ZTQ3mFjEla1+MY45VDnhT3PJJn4ADyiBgLNxWU0huwj
/Ow/qmYimQ7gY1htckd5oesJSEbngY609y6TRltiU9NVMTdZRM4fSpzCf/+qRyUn
8B04WCWLFEbu/qA5Kc58
=ZwCk
-----END PGP SIGNATURE-----

--VjP/dwTbBl6I9PQk--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
