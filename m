From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: spi-geni-qcom: Add SPI driver support for GENI
 based QUP
Date: Fri, 10 Aug 2018 17:13:29 +0100
Message-ID: <20180810161329.GF20971@sirena.org.uk>
References: <24b3ef71-18c1-1704-e324-5581fd18a998@codeaurora.org>
 <152700759909.210890.13296077062705155869@swboyd.mtv.corp.google.com>
 <20180522173000.GG24776@sirena.org.uk>
 <8968e04c-a200-ef06-5c33-94e399f7b9fe@codeaurora.org>
 <20180524162940.GA4828@sirena.org.uk>
 <28d8ab5fdeb34e52eba7ca771a17bc06@codeaurora.org>
 <61f2e1fb394bfe47ace42352f2e1b3a6@codeaurora.org>
 <CAD=FV=X-fGukBpSOYCO=rv94_3gorL=9qmttsvZk21=m6mwUgA@mail.gmail.com>
 <20180810105205.GC20971@sirena.org.uk>
 <CAD=FV=XXyL5q1quxUtBohn2GrcadbY9hr6sdw+4qShQnYTgVwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fwqqG+mf3f7vyBCB"
Cc: Dilip Kota <dkota@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Sagar Dharia <sdharia@codeaurora.org>,
        Karthikeyan Ramasubramanian <kramasub@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "Mahadevan, Girish" <girishm@codeaurora.org>
To: Doug Anderson <dianders@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAD=FV=XXyL5q1quxUtBohn2GrcadbY9hr6sdw+4qShQnYTgVwA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--fwqqG+mf3f7vyBCB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 10, 2018 at 08:40:17AM -0700, Doug Anderson wrote:
> On Fri, Aug 10, 2018 at 3:52 AM, Mark Brown <broonie@kernel.org> wrote:

> > This is more about matching the data rate between the two drivers - the
> > clock framework could (and possibly should) reasonably return an error
> > here, we're trying to ensure that drivers and controllers work well
> > together here.

> The clock framework should be able to accomplish what you want.  If
> you just request the rate it will do its best to make the rate
> requested.  If we want to see what clock would be set before setting

The request could be massively off the deliverable rate - 50% or more.

> is "close enough" in this case?  I haven't gone and dug, but I've
> always seen people only specify a max rate for SPI.  ...so as long as
> the clock framework gives us something <= the clock we requested then
> we should be OK, right?  If / when this becomes a problem then we
> should add a min/max to "struct spi_transfer", no?

On the other hand if I ask for my audio to be played at 44.1kHz and the
clock framework says "yes, sure" and gives me 8kHz then the user
experience will be poor.

> Note that there are also clk_set_rate_range(), clk_set_min_rate(), and
> clk_set_max_rate() though I'm told those might be a bit quirky.

They're certainly not widely used at any rate.

> ...but maybe we don't need to argue about this anyway since IMHO we
> should just use the clk framework to figure out our maximum speed.

It looks like that's true in this case.

> >> 3. If you really truly need code in the SPI driver then make sure you
> >> include a compatible string for the SoC and have a table in the driver
> >> that's found with of_device_get_match_data().  AKA:

> >>   compatible = "qcom,geni-spi-sdm845", "qcom,geni-spi";

> > A controller driver really shouldn't need to be open coding anything.

> It wouldn't be open-coding, it would be a different way of specifying
> things.  In my understanding it's always a judgement call about how

If you're saying we need clock rate selection logic (which is what it
sounds like) rather than data then that seems like a problem.

--fwqqG+mf3f7vyBCB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlttuagACgkQJNaLcl1U
h9C56QgAglrArQUJ8e6VWpysiJHTDYTQiBTMu44TKWqCmHfwRIcunxD69KplacD2
fEfFpx7jophEdqkW/cOlEGs5F5cQcRweUpQwCilAPM1zGZGddHTW4ieKg4gsm7Tx
PuyvAUuMlU3iKeBJQq+DxJHSiaJoVDeg/gtE/3rGcWTlkFhRfa3IhOOmewIGEVEr
p852aA2Coj7twDyGDx/rHei1LcduMzSjppgJ3oEzT97isv5ZeDYAHdzOxVrz6sFY
eUACwerhO2Q/M96goAT7p2Evq47K4iIDccrlYeR+BPMXGtIotJY6MnGuHoBE9KJB
fJyMD6/A93ah3utqPgP3o5sfOWJPaw==
=GW8t
-----END PGP SIGNATURE-----

--fwqqG+mf3f7vyBCB--
