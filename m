From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: spi: Add Spreadtrum SPI controller
 documentation
Date: Wed, 8 Aug 2018 11:54:51 +0100
Message-ID: <20180808105451.GE9346@sirena.org.uk>
References: <64681bf903104c8a02f118294e616e2a12a5ebe4.1533638405.git.baolin.wang@linaro.org>
 <20180807134121.GA7958@sirena.org.uk>
 <CAMz4kuJsyKv_fvrqRR3pdfKsLVy53Uj0KX+m_9jLxpcVcMvs9g@mail.gmail.com>
 <20180808095025.GB9346@sirena.org.uk>
 <CAMz4kuKZHxYiJaMHnqdAGth8XkfGnq3-Tsfc59cGjsHQHZaY7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wTWi5aaYRw9ix9vO"
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
In-Reply-To: <CAMz4kuKZHxYiJaMHnqdAGth8XkfGnq3-Tsfc59cGjsHQHZaY7A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--wTWi5aaYRw9ix9vO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 08, 2018 at 06:35:28PM +0800, Baolin Wang wrote:
> On 8 August 2018 at 17:50, Mark Brown <broonie@kernel.org> wrote:

> > Right, I don't think we added this yet (if we did I can't see it).  I'd
> > add a new field to spi_transfer for this, then other controllers with
> > the same support can implement it as well and drivers can start using
> > it too.

> OK. So I will name the new filed as 'word_delay', is it OK for you?

Sounds good, yes.

--wTWi5aaYRw9ix9vO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltqy/oACgkQJNaLcl1U
h9BSngf+O6aFSOfDpXwr5AddxQgIlIyX7YbAzjK2EdVa4i8i9tK4gZS7S1sBeDpI
HA4xqVsac/HiSLr1ZdJbggoTV0Cq0IHFGH6vZ7/u+MPYi6XVIBy6Xmj3QlRRmX3b
zjYCuobVsSrGAK+/nUjJyhtfYb+eSfucKWhn4cWrX6D8d/cB4EBMRKwXMWaL8P8v
IMCmvLJpAWU8PADkZ0LIaUaUo7irzrIHOQRT/dfTa+4+SJ7MD/K6DPD5qfRMKmdW
y389qijvn3iKyi0Vqz6PbQ7/MkKE9/Yf4NsCILkdax+9DVCqEDxSSkchgt7d3KwE
adBUmgVEmc2i9yP8JjSI5SdBBnfU2w==
=9Hur
-----END PGP SIGNATURE-----

--wTWi5aaYRw9ix9vO--
