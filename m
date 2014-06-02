From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 18/18] [RFC] spi: rspi: Add DT support to DMA setup
Date: Mon, 2 Jun 2014 15:54:47 +0100
Message-ID: <20140602145447.GJ31751@sirena.org.uk>
References: <1401716301-29612-1-git-send-email-geert+renesas@glider.be>
 <1401716301-29612-19-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6J7GEvtanOfV9oXA"
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Magnus Damm <magnus.damm@gmail.com>, linux-spi@vger.kernel.org,
	linux-sh@vger.kernel.org, devicetree@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1401716301-29612-19-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--6J7GEvtanOfV9oXA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 02, 2014 at 03:38:20PM +0200, Geert Uytterhoeven wrote:
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: devicetree@vger.kernel.org
> ---
> The format of the DMA specifiers depends on the DT bindings for SHDMA,
> which are still under development.

This looks fine to me, can you resend when the DMA specifiers for the
controller are resolved?  I've applied everything up to here, it all
looks good especially the performance improvement.

--6J7GEvtanOfV9oXA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTjJA0AAoJELSic+t+oim9f5oP/jNe9N62L+UjWeF+LLpYdqIN
r/+8JVNuy/o8Mia6XHcYAyrDvE2dloc8WTPMicbG6XesrKVTS0ZKIac+pBbRxyIy
fgeATegTkp3y66q+OIFJkabmbIvb/U+Q18hIUufj5yA3ae5iVBWATEDqO0K3MrLj
/n6PIb8ZtVhFFKO2XcsI007nXOc615b79gKlXlAuVhNslFSKBAvv4BHPjuDHjv9b
sK2FWfjQFLfcZkYfhApTValhd97w1uk5OqEmYtktVHahXVHy/qoUCVNDTiN1NKBB
rkOhrH2rgqGZ22sYiJ8b1wOxuUIWpugUQb+uV8hXQOCcTu7q94Twdk/MPtvpSG/4
2OpBm1uyjLIYJtYxd52mJkcVQg9PosGdJK+wpiXoL4fYEoh/H4GpwWhNiNp0yTT9
3CGbz8X3SAeKDJftzkvImWLqbqqiT8KSrxQRuroCS5hQLU1a29v4G4gCuuVwnZ07
I1+0uLTPoEZBKqXR/BJtGDVcUj45DA5nE8Ep0R75EHT/myDJH3TouKI71dPkhM2x
aE8vJrojfA/WjOPafOBhal/RbUStdSBAIQz4RnrPHGX2O6u9ThEuVypTgHtDag6D
aD4dYKR8/sdk+iyZPtqcYTNnK2is1nqVDnFTRYuF0nJH7Sd6+GZFBScDul1kc/ZV
8l0F53+mPfIRYO0QmN64
=t/re
-----END PGP SIGNATURE-----

--6J7GEvtanOfV9oXA--
