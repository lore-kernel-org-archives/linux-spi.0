From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] spi: davinci: add support for adding delay between
 word's transmission
Date: Tue, 9 Sep 2014 20:58:19 +0100
Message-ID: <20140909195819.GJ2601@sirena.org.uk>
References: <1410278851-10783-1-git-send-email-grygorii.strashko@ti.com>
 <20140909165555.GD2601@sirena.org.uk>
 <540F3447.3020609@ti.com>
 <20140909172057.GH2601@sirena.org.uk>
 <540F44EB.8090700@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="y06s9PvpQ1Ch5mdL"
Cc: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>,
	santosh.shilimkar-l0cyMroinI0@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <540F44EB.8090700-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--y06s9PvpQ1Ch5mdL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 09, 2014 at 02:20:27PM -0400, Murali Karicheri wrote:
> On 09/09/2014 01:20 PM, Mark Brown wrote:

> >If these delays are not related to chip select then the documentation
> >needs to be fixed to not refer to chip select.

> Ok. So what I understand is the issue is not having the right description to
> indicate that these parameters are delays associated with tranmission of
> successive words on the wire. Personally I like these description match with
> what is described in the device spec/ user guide and what is described above
> match with that. However we could add additional description as below to to
> make it more explicit.

> spi-c2t-delay - delay after CS is asserted before output bits on wire
> spi-t2c-delay - delay after tramission of bits and before deasserting CS

> Do you think this will help?

No, that doesn't help at all.  You keep claiming that these parameters
are related to the intervals between words but then providing
descriptions of these parameters which relate to intervals around
changes in /CS which is patently not something connected with the gaps
between words.  Either your description of parameters which do not
relate to /CS should not need to mention /CS or the parameters are in
fact related to /CS, both can't simultaneously be true.

--y06s9PvpQ1Ch5mdL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUD1vWAAoJECTWi3JdVIfQrwQH/1EdE0KzL3TyDq37T3UhGGE4
5ZoPIdyOslVaU2g7wdfdLcHvyhpCYQTmXrNa7NcnF8ombRlWv396T76aSGd+7SgG
G1kVXtC5UaM4yitU5MU3bTeZ3w4eC8RmXH36FgDfey7FIKya2clJbswY4los+3Re
oSyG3Q3JIDCuBG36fV4/hjJAL9Vi78+ePjXKaSHvyZF1PvmEjoIbC7f+qcLaZB9n
5n4U8hsh0GkJpz/TcooWvbvy07NV6YydKfXgfQgd7Auph4FuAfJLovRDp7HSzFIh
CRebFPlEOz7rdJBKN4PJ/tcteai/PmeqGWVQ/XiKx0Dii/woi+lYAZL8JkzIy0c=
=v6Ak
-----END PGP SIGNATURE-----

--y06s9PvpQ1Ch5mdL--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
