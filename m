From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 6/6] spi: st-ssc4: Remove 'no clocking' hack
Date: Fri, 1 Jul 2016 11:59:43 +0200
Message-ID: <20160701095943.GL6247@sirena.org.uk>
References: <20160607111930.10375-1-lee.jones@linaro.org>
 <20160607111930.10375-7-lee.jones@linaro.org>
 <20160607151712.GA7510@sirena.org.uk>
 <20160630205215.GF1707@dell>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="J/pvEKOcHgREgBce"
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel@stlinux.com, maxime.coquelin@st.com, patrice.chotard@st.com,
	mturquette@baylibre.com, sboyd@codeaurora.org,
	linux-clk@vger.kernel.org, linux-spi@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160630205215.GF1707@dell>
Sender: linux-clk-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--J/pvEKOcHgREgBce
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 30, 2016 at 09:52:15PM +0100, Lee Jones wrote:
> On Tue, 07 Jun 2016, Mark Brown wrote:
> > On Tue, Jun 07, 2016 at 12:19:30PM +0100, Lee Jones wrote:
> > > Due to the newly upstreamed 'critical clocks' API we can now
> > > safely handle clocking in the SPI and I2C drivers without fear
> > > of catastrophically crippling the running platform.

> > Acked-by: Mark Brown <broonie@kernel.org>

> We really need to guarantee that this goes in *after* the other
> patches have landed, and it looks like they're heading in via their
> own respective trees.  Any chance you can hold this back and submit it
> via your v4.8-fixes submission?

I've not applied this patch and had no intention of applying it, the
whole point in me acking it was that I was expecting it to get applied
as part of the series since AFAICT everything needed to go in together.
Your pattern of acking patches you're expecting to be apply yourself is
fairly unusual, if it's someone else it's generally safe to assume
they're expecting the patch to go via another tree.

If this still needs sorting after the merge window please resend it, or
ideally it can go in along with the rest of the series via whatever path
that's taking.

--J/pvEKOcHgREgBce
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXdj8NAAoJECTWi3JdVIfQWaYH/0HAssuQfDN6WVtDw6B3EkE1
o6Y3atrxYQQDhPt1t2R1hnB40wwAhyYW8SoicYZhKU91cyn1H5QTmNhGD49ItySM
qEeLxXZ9El+f/260hxk60o3lQWMei/Tu8631+kNTQjNPKtxgWFv90uQtaMktWDNF
HNiZJukpyxQfFosymm8nHvimEDo8ani8VH5FILaiWawCJlrCNVOuPoVFIcGlpCW1
wclps7EGyqbGDfUqUhm5dyCjx6tCDo2SnCfU9m5BlzmJksUMSrUFXIP8+/Uo34Jw
CNp5Vn8yEkNyN1VOgV9lDW307kWqQOMbfSBRQfvN9ONxmxRmLVW5HIPRfepfM6Y=
=oFh6
-----END PGP SIGNATURE-----

--J/pvEKOcHgREgBce--
