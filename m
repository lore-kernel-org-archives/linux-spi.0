From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] documentation: add rockchip spi documentation
Date: Tue, 24 Jun 2014 11:33:36 +0100
Message-ID: <20140624103336.GG23300@sirena.org.uk>
References: <1403582324-9485-1-git-send-email-addy.ke@rock-chips.com>
 <1403582324-9485-2-git-send-email-addy.ke@rock-chips.com>
 <20140624101802.GE5856@leverpostej>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Sw7tCqrGA+HQ0/zt"
Cc: addy ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>,
	"heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org" <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>,
	"grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	"robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org" <huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"yzq-TNX95d0MmH7DzftRWevZcw@public.gmane.org" <yzq-TNX95d0MmH7DzftRWevZcw@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"kever.yang-TNX95d0MmH7DzftRWevZcw@public.gmane.org" <kever.yang-TNX95d0MmH7DzftRWevZcw@public.gmane.org>,
	"zyw-TNX95d0MmH7DzftRWevZcw@public.gmane.org" <zyw-TNX95d0MmH7DzftRWevZcw@public.gmane.org>,
	"xjq-TNX95d0MmH7DzftRWevZcw@public.gmane.org" <xjq-TNX95d0MmH7DzftRWevZcw@public.gmane.org>,
	"zhenfu.fang-TNX95d0MmH7DzftRWevZcw@public.gmane.org" <zhenfu.fang-TNX95d0MmH7DzftRWevZcw@public.gmane.org>,
	"olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org" <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>,
	"cf-TNX95d0MmH7DzftRWevZcw@public.gmane.org" <cf-TNX95d0MmH7DzftRWevZcw@public.gmane.org>,
	"hj-TNX95d0MmH7DzftRWevZcw@public.gmane.org" <hj-TNX95d0MmH7DzftRWevZcw@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140624101802.GE5856@leverpostej>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--Sw7tCqrGA+HQ0/zt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 24, 2014 at 11:18:02AM +0100, Mark Rutland wrote:
> On Tue, Jun 24, 2014 at 04:58:43AM +0100, addy ke wrote:

> > +- Board Specific Portion:
> > +
> > +	&spi0 {
> > +		status = "okay";
> > +		spi_test@00 {
> > +			compatible = "rockchip,spi_test";

> Huh?

I expect that's just intended as an example of how to set up a device
and they're doing something like use a driver that generates known
patterns.  We'd normally omit such examples from the binding document
since it's generic and covered well enough elsehwere.

--Sw7tCqrGA+HQ0/zt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTqVP8AAoJELSic+t+oim9768P/2wmhn+zUELR+Afyz9m7T1uS
F0B7iV9hm3LD98h96hGeaqax8XVEreR8E5DiF0pMxxkkalMsJetT0hXcU2edvM/k
UuE9lYAX6ExcxlWjDpHF+2pZHPqjHH6s1cU4nOthZY/uBaQdVLS+WadU7Ng+JkYN
0/udpOY53so3g93zMFNtpcAha4oOBMyBnwz3JmITfRvRPG/nzyPLA0hiGxPShdk8
4ha3e18Tk/vvMFQzIWI5XcDE4L0hB7+fCkElXs5nJfDGhGA/U/0IFMmXcupVXLMM
W4xXfQcfxEhWTCvCw4j/T0of36PNwvJnFMu0Djdq3VxAz9+2bQ1ZTAQMEbn+xPHg
KwzLE1ESBJUhn8i8IM7PeliHjdu7AJ/IfNNCAFAqTLBeUR5/rnUtIT4D7Fj0pyiK
LdfmIVwDjM0S4O5XTbOKVY0zWh/3JQFjr15wYTaNswLfqfNDBO2AVlT3biry7tn2
InVk+efm+MFzg/SDVa8gnYEjghf0R09GtjVmSE6pl55HKlSountDkF3roMwZMdsi
PyRZPxjCKt5GaoQt38S7OKyh6oCa9nnWO4onnpMoZWBt8f3eSTNJneZuY1N1TUQR
hWsVYRmGakHjwSDMOVOEKFL8DnfaGI/a2E8NDO7OK9AzD3Y8XQyIQt8tgQbNZoCE
WduhD98mr656/bTmqlMh
=Haop
-----END PGP SIGNATURE-----

--Sw7tCqrGA+HQ0/zt--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
