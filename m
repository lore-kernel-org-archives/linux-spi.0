From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: spi-geni-qcom: Add SPI driver support for GENI
 based QUP
Date: Fri, 10 Aug 2018 17:46:36 +0100
Message-ID: <20180810164636.GI20971@sirena.org.uk>
References: <20180522173000.GG24776@sirena.org.uk>
 <8968e04c-a200-ef06-5c33-94e399f7b9fe@codeaurora.org>
 <20180524162940.GA4828@sirena.org.uk>
 <28d8ab5fdeb34e52eba7ca771a17bc06@codeaurora.org>
 <61f2e1fb394bfe47ace42352f2e1b3a6@codeaurora.org>
 <CAD=FV=X-fGukBpSOYCO=rv94_3gorL=9qmttsvZk21=m6mwUgA@mail.gmail.com>
 <20180810105205.GC20971@sirena.org.uk>
 <CAD=FV=XXyL5q1quxUtBohn2GrcadbY9hr6sdw+4qShQnYTgVwA@mail.gmail.com>
 <20180810161329.GF20971@sirena.org.uk>
 <c1bc416ba407b5a3cc098e78a529752e@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MPkR1dXiUZqK+927"
Cc: Doug Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Sagar Dharia <sdharia@codeaurora.org>,
        Karthikeyan Ramasubramanian <kramasub@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "Mahadevan, Girish" <girishm@codeaurora.org>
To: dkota@codeaurora.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <c1bc416ba407b5a3cc098e78a529752e@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--MPkR1dXiUZqK+927
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 10, 2018 at 09:59:46PM +0530, dkota@codeaurora.org wrote:

> Now the need is, how to communicate the SPI controller maximum frequency to
> SPI core framework?
> Is it by DTSI entry or hardcoding in the SPI controller driver?

If you've got a limit that exists in the IP the hard code it in the
driver.

> My stand is for providing the DTSI entry.
> Why because, this keeps SPI controller driver generic across the boards and
> portable.
> Also it is not against to Device tree usage because maximum frequency
> is describing the property of the hardware.

If the limit the controller has is not coming from the clock tree then
presumably it's a physical limitation of the silicon and isn't going to
vary per board.  If the limit is coming from the board then it should be
specified per slave since different slaves may have different
requirements on different boards.

--MPkR1dXiUZqK+927
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlttwWwACgkQJNaLcl1U
h9BPcwf+JNWdFryuW2eK9kP9w/E8+jHe6SMG9VTzvgwMXSdHOv7xs8iZYKUKoYJt
mXIOa8c2HKAK0BJYqXqceA5XtPZ4/+Xtw3PZGOaoQiv90WNHSdgN80ngek/ozRev
BjJyrrbiNTYbH2kq9nSCLu0Paw5kl1PfLRpZgfFrrZhn+H0W85+wGo7i0BkLlOmx
YfwbgV1WiawSv8UABQu/AJzWyj1trYZOqrF4NKKR9V3tFsoNwIZgtlOJpF4uz3u+
qeqe62thRBqRrX3jBVZuj77Fb3r5Pl13RaqngtG8BwWv8oZ0xx0qkkaX66GBf1OC
mco07vPbT7C7Y52ucvyNGWEte6b01g==
=wK88
-----END PGP SIGNATURE-----

--MPkR1dXiUZqK+927--
