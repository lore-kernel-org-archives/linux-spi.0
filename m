From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH RFC 1/3] spi: Allow SPI controller override device
 buswidth
Date: Tue, 3 Mar 2020 12:43:38 +0000
Message-ID: <20200303124338.GD3866@sirena.org.uk>
References: <1582903131-160033-1-git-send-email-john.garry@huawei.com>
 <1582903131-160033-2-git-send-email-john.garry@huawei.com>
 <CAMuHMdW7Xu6EzfmVFx1+i1byy3KOS5A+h2GuMb8nkZ+-jD1=BA@mail.gmail.com>
 <f6f21e75-7cee-89da-bb87-95327a4ec2cc@huawei.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IDYEmSnFhs3mNXr+"
Cc: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Linuxarm <linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>,
        Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        MTD Maling List <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: John Garry <john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <f6f21e75-7cee-89da-bb87-95327a4ec2cc-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--IDYEmSnFhs3mNXr+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 03, 2020 at 09:42:45AM +0000, John Garry wrote:

> However, maybe another callback could be introduced, .early_setup().

One thing I like about the explicit core code is that it makes it much
easier to see which drivers are doing the worrying thing, with just
overwriting things in a callback everything is very freeform and you
have to audit things individually.

--IDYEmSnFhs3mNXr+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5eUPkACgkQJNaLcl1U
h9BYcAf4kl/gydZycwZtTddrolWZTe5aGp9hdBn91H5K4i0f3Sp/wzjZi9Z7NMLZ
hFT1kd7fwU9kHr5QBDt66s8mnC/A8WU/yLekP7hKQkumLFBXT+EzpW4ZsD0OFB8R
KvAr5BCFqvJMdRPYCqsqi1nvZwNA4jYhWXp5sGlT3T/4GH0ulhQDZghULkx+8e06
Kd23pOwyQmDQgwVTqQ/YuB36cPzriYsoxu3vijQZLIVGO4K/PPqiaoq5Af1EiGlr
mcwa0IaW3IMQbjLk5KPuITz8YUMrPryVc+unOuertCfFYoHcYmgIO/Aq6yOpnbRl
UajtjXoFfB5jRdSGvoDFHjZcfYfJ
=FOcd
-----END PGP SIGNATURE-----

--IDYEmSnFhs3mNXr+--
