From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v1 1/1] spi: bcm-qspi: Make BSPI default mode
Date: Tue, 6 Aug 2019 13:16:12 +0100
Message-ID: <20190806121612.GB4527@sirena.org.uk>
References: <1565086474-4461-1-git-send-email-rayagonda.kokatanur@broadcom.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Bn2rw/3z4jIqBvZU"
Cc: Kamal Dasu <kdasu.kdev@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
To: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1565086474-4461-1-git-send-email-rayagonda.kokatanur@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--Bn2rw/3z4jIqBvZU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 06, 2019 at 03:44:34PM +0530, Rayagonda Kokatanur wrote:
> Switch back to BSPI mode after MSPI operations (write and erase)
> are completed. This change will keep qpsi in BSPI mode by default.

Why?

--Bn2rw/3z4jIqBvZU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1Jb4sACgkQJNaLcl1U
h9DgGgf/XDjuMvbF0gxlnycvschMI54KdALlicilAY/EdgOqMP0nYuI2Aq5ajfLW
iyCZuqnv5yB8zvfCmgkQDpMHCFqvyzOD+1e0uaHzW87GiksgU34YADpCjdhYc+Qw
Ji2fr1lH0NCiCPeMc2ATQ+r431RO2f05Cgo1eUIdtdYdIMGeRt8r3NUbs9P/pTgf
SFvVWF8s+bb3nsQKiLizNjCCzBAjzPcKsxkKIlwYMu5v2dlQQJUVQNA/Wrs6bada
FRHWgV5N1VCYSAWxTG9X0nK9prvb6U2K4RLn4Sx4KQjG9+dXIcON3yIRjqCbIyCg
jWPS/FWELxU9yNtO0ja47BfU2zbm1Q==
=NEaP
-----END PGP SIGNATURE-----

--Bn2rw/3z4jIqBvZU--
