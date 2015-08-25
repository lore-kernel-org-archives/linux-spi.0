From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [alsa-devel] Fwd: [PATCH 1/1] SPI : spi-pxa2xx : fix spi init of
 WM510205 codec via ACPI (resend)
Date: Tue, 25 Aug 2015 07:21:57 +0100
Message-ID: <20150825062157.GB27431@sirena.org.uk>
References: <20150819134328.GU1552@lahna.fi.intel.com>
 <CAKor6Tc6RDW+2uuX2yMszk3O69=6QTPdd+emC-m_Cro67VPR8g@mail.gmail.com>
 <20150820094542.GC30005@lahna.fi.intel.com>
 <CAKor6Te-DSDxx711-EQi=fw46nNPGnQNqhj-+6upBxhOOp5XvA@mail.gmail.com>
 <20150820115845.GF30005@lahna.fi.intel.com>
 <CAKor6Teq=Aoa6WYkTEVpjBPsWziL-o5FzQHxJWOMeaTrMzXpMg@mail.gmail.com>
 <20150821074310.GM30005@lahna.fi.intel.com>
 <CAKor6TeJp4ti6_QVCEpz0x7c2NwvUiS5wq_=_WDjM3B7T4=1Yg@mail.gmail.com>
 <20150824085140.GA5647@ck-lbox>
 <CAKor6TcRWgn-Z+Va0JKCBqxVA9HBSLMR_vh-z8MSBZebn9kDVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oLBj+sq0vYjzfsbl"
Cc: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
	Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org,
	Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
	Pierre-Louis Bossart <pierre-louis.bossart-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org,
	dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>
To: Christian Hartmann <cornogle-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAKor6TcRWgn-Z+Va0JKCBqxVA9HBSLMR_vh-z8MSBZebn9kDVg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--oLBj+sq0vYjzfsbl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 24, 2015 at 03:25:57PM +0200, Christian Hartmann wrote:

> /* Start out with /RESET low to put the chip into reset */
> ret = devm_gpio_request_one(arizona->dev, arizona->pdata.reset,
> GPIOF_DIR_OUT | GPIOF_INIT_LOW,
> "arizona /RESET");
> </code>

> the string arizona /RESET, where is this documented, where can I find
> it? It fails here, and my question is, is this string correct at all
> for my case? Should it be called only "reset" in my case??

That string is documentation - it's used purely for display purposes,
which is what this...

> in devres.c its documented as a label only:
> @label: a literal description string of this GPIO

...says.  In cases like this looking at the code is often helpful (you
can see exactly how the string gets used...) but obviously patches to
improve the doumentation are welcome.

--oLBj+sq0vYjzfsbl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV3AmFAAoJECTWi3JdVIfQ3AcH/R7EIgsWQtaFWfgcAA2JbB7X
4x8beSU8p5UEe7ibm0J5hwOtxytwZnjWGiwwiiODE+XEodnP1wT9LeWDnAwNeLLd
rWl+nDp+KJz/PHwQNtey9Rm/q/ZEgzHzcVi6drpT2Mgsa/uv6VjvEmcOpkSoFd+K
fcM1XV1dulWdE8fl2/V6EGcTo+B0bZy8sxgswWiHoSn0DDcJVaHyffAXdvrF+4A2
GEPPGLkqlvyk95tNIH440XsbU9B+aBLYQ92DbxEo/76o4YkaYWJYqGlGigxD5JST
YF3M3dhNiveJLwaH8fLP4m2r1ZWrIadXDXA4dupiCJgbcMpJtyWq+PIc0ZSD/xo=
=b1rD
-----END PGP SIGNATURE-----

--oLBj+sq0vYjzfsbl--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
