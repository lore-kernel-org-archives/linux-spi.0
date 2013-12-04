From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 5/5] spi: add bcm63xx HSSPI driver
Date: Wed, 4 Dec 2013 14:35:40 +0000
Message-ID: <20131204143540.GX29268@sirena.org.uk>
References: <1385811726-6746-1-git-send-email-jogo@openwrt.org>
 <1385811726-6746-6-git-send-email-jogo@openwrt.org>
 <20131204133823.GS29268@sirena.org.uk>
 <CAOiHx==utbmYUS4BLoSaaGi91Kw5voQ2vFiA97GLmwn8yU19Dw@mail.gmail.com>
 <20131204140853.GU29268@sirena.org.uk>
 <CAOiHx==Lp7FFCCWaSiohvdAyzErBuz5n7sUVs1+A4S1axD9qCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6B5oiwbC31sfIr4n"
Cc: MIPS Mailing List <linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>,
	John Crispin <blogic-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>,
	Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>,
	Kevin Cernekee <cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Maxime Bizon <mbizon-MmRyKUhfbQ9GWvitb5QawA@public.gmane.org>
To: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAOiHx==Lp7FFCCWaSiohvdAyzErBuz5n7sUVs1+A4S1axD9qCA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--6B5oiwbC31sfIr4n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 04, 2013 at 03:28:25PM +0100, Jonas Gorski wrote:
> On Wed, Dec 4, 2013 at 3:08 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> > You'll need to call pm_runtime_enable() and so on to turn on runtime PM
> > in probe() and reverse that in remove() but otherwise no, just adding
> > the runtime callbacks should be fine.

> I see. Looks like I just copied your oversight from
> 5355d96d6fb56507761f261a23c0831f67fa0e0f ("spi/bcm63xx: Convert to
> core runtime PM") :P I'll add that to my list of things to fix.

The driver was already broken there - the requirement to enable runtime
PM is a part of the core runtime PM API.  All that change did was factor
out the enable and disable calls.

> Grepping through drivers/spi, I see a few drivers not calling
> pm_runtime_enable(), but setting auto_runtime_pm to true, and a few
> doing the opposite. These should probably aligned, too.

Not using the core runtime PM is fine, there may be reasons the driver
wants to do this by hand.  Things not enabling runtime PM are definitely
buggy though.

--6B5oiwbC31sfIr4n
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSnz25AAoJELSic+t+oim9e+EQAIRuEYdZlzhj3sQ0P6ZkN4DA
8F6QyGXOPXsLv17eD3tw5GEEtSLL3nDqZW6mIHrNLLk8Au5mrk0DoNzlH3nU+HPG
OT7VjFTwkibN70XANLxheXjF0bgFWf4j9lX2Mm5Yuil6EYqfy8ergfndO7dU+/4Q
GXolvEQBoBrwarzwrVSf5VC10WJ5HfhvqmaWh4aHFA2oWZm0WqtUy03SNpghSH6d
ee3jswIMD+0Yvyj7mtx/lqAo9fynmw2b0hlhEj2gwOOYTqL0N6bR/p7lSRyZYvWX
IztrHZ1bxcfq3RRbEW5G/MhTmWFwOtQTCpaLwtuIWHOcPClQIvZlORiBbi7FwfHP
eWOSYBrSmlvctJbU41EXYdgUOPye81Unxw7cdzHjroUHHx+apGjYeGPtasVIMcw1
JyUeAWe9yNl8P54XmFYcIDWvoviEwE7CpFy5NgzrNx827eLA2oBI/vcVz7OhAE1S
jQVtlGDhUjlC2pxYDRoeuJ/j9fJl8Uc+OTsdkpvqOyPw9uL9M9+u+11nEYUsrLTe
2OIQYySwUoFwT+CwiPjBROdhjjvh6GkQKJNpairKBkxBP5DcvzbvDVM2fwABvhRY
/yfRTKbUsfVAsjMo3EtH7IHhg2IwO7CykR63G0QUosmzI9IbYkxUa1GX38uXsURS
OIS18va8vmTpya9Vd4DT
=ZQMj
-----END PGP SIGNATURE-----

--6B5oiwbC31sfIr4n--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
