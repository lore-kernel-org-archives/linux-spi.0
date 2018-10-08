From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 1/2] spi: Add MXIC controller driver
Date: Mon, 8 Oct 2018 14:37:52 +0100
Message-ID: <20181008133752.GF5684@sirena.org.uk>
References: <1538965532-8908-1-git-send-email-masonccyang@mxic.com.tw>
 <1538965532-8908-2-git-send-email-masonccyang@mxic.com.tw>
 <20181008103812.106389c1@bbrezillon>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vA66WO2vHvL/CRSR"
Cc: masonccyang@mxic.com.tw, tpiepho@impinj.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        juliensu@mxic.com.tw, zhengxunli@mxic.com.tw
To: Boris Brezillon <boris.brezillon@bootlin.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181008103812.106389c1@bbrezillon>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--vA66WO2vHvL/CRSR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 08, 2018 at 10:38:12AM +0200, Boris Brezillon wrote:

> This is wrong, ->cur_speed_hz should be updated in
> mxic_prepare_transfer_hardware() or mxic_spi_clk_check(), not when
> ->setup() is called. Also, you seem to ignore the xfer->speed_hz value,
> which might be different from spi->max_speed_hz. Maybe the
> ->prepare_transfer() hook is not the right place to do this
> ->cur_speed_hz selection in the end.

xfer->speed_hz should always be filled in so it's the only one you need
to pay attention to (as the code Boris proposed does).

--vA66WO2vHvL/CRSR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlu7XbAACgkQJNaLcl1U
h9Azggf+KEqx8zCV97yIui9BQiy+hHtNztRjvGmyBDUh20puENxqOTeWCYwoat8g
tnlAllUGejF3B1Dfv3sgGinOrXrvfpLexIL59YZp76X9DN+sEliRyR98dvvgKp2L
38b5xMG1+gzHS0Agv+8cGVuWocAVCyr2jH++siOVJZ/liJEatZl/jtvGNsAztDeg
/sHLWbdckRtd/63c43o6sXbn3jAA06lyto1EFauYt4V63beRC3p8OXasmPU/fwn5
i0N7MX1Zs3xx4hJENMgGAMF/e8Vrj7bD5cVH4YEd+sRAAd2/njTBdf1AVrk5/7dj
/V8SPMbNr4Y+RwHIodVt8hs2KvUY5w==
=XY4n
-----END PGP SIGNATURE-----

--vA66WO2vHvL/CRSR--
