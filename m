From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: spi: Add Spreadtrum SPI controller
 documentation
Date: Wed, 8 Aug 2018 10:50:25 +0100
Message-ID: <20180808095025.GB9346@sirena.org.uk>
References: <64681bf903104c8a02f118294e616e2a12a5ebe4.1533638405.git.baolin.wang@linaro.org>
 <20180807134121.GA7958@sirena.org.uk>
 <CAMz4kuJsyKv_fvrqRR3pdfKsLVy53Uj0KX+m_9jLxpcVcMvs9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KFztAG8eRSV9hGtP"
Cc: Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        lanqing.liu@spreadtrum.com, linux-spi@vger.kernel.org,
        DTML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
To: Baolin Wang <baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMz4kuJsyKv_fvrqRR3pdfKsLVy53Uj0KX+m_9jLxpcVcMvs9g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--KFztAG8eRSV9hGtP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 08, 2018 at 10:26:42AM +0800, Baolin Wang wrote:

> Sorry for confusing. Let me try to explain it explicitly.
> We can set the word size (bits_per_word) for each transmission, for
> our SPI controller,  after every word size transmission, we need one
> interval time (hardware automatically) to make sure the slave has
> enough time to receive the whole data.

OK, so it's an inter word delay.  Some other controllers definitely have
the same feature.

> Yes, I agree we should configure it at runtime by the device, but we
> did not find one member to use in 'struct spi_transfer', we just find
> one similar 'delay_usecs' member in 'struct spi_transfer' but not
> same. We can use  'delay_usecs' to set our hardware interval value,
> but we should clean it when transfer is done, since we do not need to
> delay after the transfer in spi_transfer_one _message(). Or can we add
> one new member maybe named 'word_interval' to indicate the interval
> time between word size transmission?

Right, I don't think we added this yet (if we did I can't see it).  I'd
add a new field to spi_transfer for this, then other controllers with
the same support can implement it as well and drivers can start using
it too.

--KFztAG8eRSV9hGtP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltqvOEACgkQJNaLcl1U
h9CY0Af/eBUJ7rNaApVEZ8zpR9awGuzC9IkLgzgDsXKKYPO7657rD75vSDe7NhbK
s+qaczqcFz7hBawHtE8wHyZP4WRyDVp5H7RiFxQ1XWCG8Sj31l3sEEXtNC3BuvLn
6sS+pqWgyyElqcyrysHOnqam2EI6VyMUTq2mNFSu+Z5GIAzMYtsQhg39aNbsG70E
F3xh/Wn84anaLdYqt+2kjLoD1FaS2snHcFWRAH7sop+bz7vzd02lDeczUOOPbdFT
sQ+33BqFpVb6wOaPP+lkOrACkoi0wIbHzfkZZifJ6olGqxlQpELH4hjP8M8zrXqa
rzHzUapZ1Duu7QuW0UyTQ/lgPtSFuw==
=vp/V
-----END PGP SIGNATURE-----

--KFztAG8eRSV9hGtP--
