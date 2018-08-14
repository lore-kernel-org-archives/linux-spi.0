From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: spi-geni-qcom: Add SPI driver support for GENI
 based QUP
Date: Tue, 14 Aug 2018 16:03:40 +0100
Message-ID: <20180814150340.GE5810@sirena.org.uk>
References: <20180524162940.GA4828@sirena.org.uk>
 <28d8ab5fdeb34e52eba7ca771a17bc06@codeaurora.org>
 <61f2e1fb394bfe47ace42352f2e1b3a6@codeaurora.org>
 <CAD=FV=X-fGukBpSOYCO=rv94_3gorL=9qmttsvZk21=m6mwUgA@mail.gmail.com>
 <20180810105205.GC20971@sirena.org.uk>
 <CAD=FV=XXyL5q1quxUtBohn2GrcadbY9hr6sdw+4qShQnYTgVwA@mail.gmail.com>
 <20180810161329.GF20971@sirena.org.uk>
 <c1bc416ba407b5a3cc098e78a529752e@codeaurora.org>
 <20180810164636.GI20971@sirena.org.uk>
 <b32c205955e0f42182b16e90f539a919@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="X3gaHHMYHkYqP6yf"
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
In-Reply-To: <b32c205955e0f42182b16e90f539a919@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--X3gaHHMYHkYqP6yf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 14, 2018 at 02:30:02PM +0530, dkota@codeaurora.org wrote:
> On 2018-08-10 22:16, Mark Brown wrote:
> > On Fri, Aug 10, 2018 at 09:59:46PM +0530, dkota@codeaurora.org wrote:

> > > delay_usecs is for inter-transfer delays within a message rather than
> > > after the initial chip select assert (it can be used to keep chip
> > > select
> > > asserted for longer after the final transfer too).  Obviously this is
> > > also something that shouldn't be configured in a driver specific
> > > fashion.

> > Hmmm ok, so you mean don't send these as controller_data, rather add
> > new
> > members to the spi_device struct ?

> spi_cs_clk_delay -> Adds Delay from CS line toggle to Clock line toggle
> spi_inter_words_delay -> Adds inter-word delay for each transfer.

> Could you please provide more information on accommodating these
> parameters in SPI core structures like spi_device or spi_transfer? Why
> because these are very
> specific to Qualcomm SPI GENI controller.

I'm not sure what specific information you're looking for here - these
things are not obviously specific to your controller, I'm even aware of
other controllers which can do them.

> If we define them in spi core framework structures, SPI Slave driver will
> program and expect it in the SPI transfers.

Sure.

--X3gaHHMYHkYqP6yf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlty70wACgkQJNaLcl1U
h9C6EQf+MI9wpvQNCHMVn/4MvVEBuFzqeRkFsXgMF1dMQXli8MKY5y2plko5f9JV
Wu57KVeKDFx67EmDATZ0qIvDZYSBHL1zbNREffKZpOx6r5tuVTvqh5NiybpUWxor
gx9+NBTsV9lpZV1lkxQ2rAfEfRcBKDSjPxswCvWvBpFl+FC87mVexMZ1uhTUAdO6
uFMxlAtxS6OTMQvLdkctJOLh2b/TY1WKUtlZdqvWb3KvsUexsibevEJ9Gr3MoL4o
dKbcw0m5uJiWKpR9uRvpvA2QY4nZHUPV/eY60St7hK7E0x87BR2CjoXCvCD6PVGB
MsRMU5ODPSqRpXHYzM+bkEv6wqepng==
=6hLB
-----END PGP SIGNATURE-----

--X3gaHHMYHkYqP6yf--
