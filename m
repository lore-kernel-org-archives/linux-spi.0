From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: Add DT bindings documentation for Netlogic XLP
 SPI controller
Date: Wed, 26 Aug 2015 11:22:48 +0100
Message-ID: <20150826102248.GN12878@sirena.org.uk>
References: <1439960957-4213-1-git-send-email-kamlakant.patel@broadcom.com>
 <1439960957-4213-3-git-send-email-kamlakant.patel@broadcom.com>
 <20150819175304.GX10748@sirena.org.uk>
 <20150826054301.GB10532@patelk@broadcom.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LvAn5G4Ewe70kJ1i"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>,
	linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org
To: Kamlakant Patel <kamlakant.patel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150826054301.GB10532@patelk-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--LvAn5G4Ewe70kJ1i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 26, 2015 at 11:13:01AM +0530, Kamlakant Patel wrote:
> On Wed, Aug 19, 2015 at 10:53:04AM -0700, Mark Brown wrote:
> > On Wed, Aug 19, 2015 at 10:39:17AM +0530, kamlakant.patel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org wrote:

> > > +- clock-frequency : [OPTIONAL] Input clock frequency to the SPI block in Hz.
> > > +		    Default is 133333333 Hz.

> > I would expect this to be specifying the input clock to the block via
> > the standard clock binding rather than just hard coding a number in
> > here.  This means the binding will continue to work for more complex
> > sysetems with programmable clocks and is generally more standard.  SoCs
> > can still specify hard coded fixed frequency clocks as fixed clocks in
> > the DT.

> We don't have our clock framework upstream yet, and don't have
> of_clk_init hook for Netlogic XLP platform to use fixed-clock. I will
> update the driver and dts to use standard clock framework but for now we
> will continue using "clock-frequency" and will update when clock framework
> is upstream.

No, you should leave it out - DT bindings are supposed to be permanent
so we don't want to have temporary bindings that are expected to be
removed quickly.

--LvAn5G4Ewe70kJ1i
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV3ZN3AAoJECTWi3JdVIfQ+TgH/RZ+Dtb+9QbwdS4luC41B6az
KorO6kjqpTBbH18fFzpx68PHQz7nJOb6a7UGpWDXswXMTj1xOtfOdU12891q1NjR
chHAMVRYzt4ssQfAQNtos0stfp0I0a2k0fzrf5zkyKCBQsNUd1YZSe9D9Y1gQb45
mlPy7OWR9sA2hwiHBLaEriLj9wMtNwm+hj+c4n9ymLS/zGAdv8RM1e8pqMGU5K5W
i1Sc/cY9x6ipsbCoJOmMPeCB4U6OZqiDXA6HmCZdz7Yn9/XYYIa7LpZ06742ia76
TwhlkJ/eple4HqNIJX9S60YqYayZNk1iSZc9wfGxsbTe7iIl6oZvD6NsyCDzntg=
=ZQU+
-----END PGP SIGNATURE-----

--LvAn5G4Ewe70kJ1i--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
