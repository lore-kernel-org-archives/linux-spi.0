From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3] spi: davinci: add support for adding delay between
 word's transmissions
Date: Mon, 15 Sep 2014 09:37:04 -0700
Message-ID: <20140915163704.GT7960@sirena.org.uk>
References: <1410536892-22775-1-git-send-email-grygorii.strashko@ti.com>
 <20140913160628.GF7960@sirena.org.uk>
 <5416E469.3020806@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RDZKVD6KUognMRfE"
Cc: santosh.shilimkar-l0cyMroinI0@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org,
	Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5416E469.3020806-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--RDZKVD6KUognMRfE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 15, 2014 at 04:06:49PM +0300, Grygorii Strashko wrote:
> On 09/13/2014 07:06 PM, Mark Brown wrote:

> > This is fine but it doesn't appear to apply against current code.  Can
> > you please check and resend?

> This one should be applied without conflicts on top of
> git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git
> branch: for-next

> since you've applied the patch:
> "[PATCH] spi: davinci: request cs_gpio's from probe"
> http://www.spinics.net/lists/linux-spi/msg01811.html

> I have to mention about this dependency, sorry for that.

Please resend then as I asked.

--RDZKVD6KUognMRfE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUFxWvAAoJECTWi3JdVIfQsd8H/2IIdobF1ajJ7STmgtMMOFg4
84f0kBBB00t3A6bEaU/abEIANcp8TD+tgj67n6+yRj0za9WpDLNLREjS6iXjyrr6
s9jpTVjOMd0yX70P4tn2ClR6Pbsj2qWXiWOAVPyIH3g/g9mzxtugm1eKFHGqqQCK
cGrmGUwWo+y79Q3x5YXcay0ul/lglC9X565iqnOavEgKvi9NiUCH8CsVNmMtPlcp
/u+71o6il+2xqUpMmlNPrmkVHI7wxSb1qf6DJw7/phJYUnXAPykSgqATlc7execM
RqGhllkqGKFXwmjOmiQMhvlSLLxpKw2yDyC3osHUGikRiWHWFEYyzQ9ffsxrg9A=
=elNf
-----END PGP SIGNATURE-----

--RDZKVD6KUognMRfE--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
