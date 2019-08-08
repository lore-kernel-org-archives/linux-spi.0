From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/2] spi: npcm-fiu: add NPCM FIU controller driver
Date: Thu, 8 Aug 2019 19:55:22 +0100
Message-ID: <20190808185522.GJ3795@sirena.co.uk>
References: <20190808131448.349161-1-tmaimon77@gmail.com>
 <20190808131448.349161-3-tmaimon77@gmail.com>
 <20190808132740.GG3795@sirena.co.uk>
 <CAP6Zq1j7jHejdx9h-nxCJcVjtGx_3rHmay7R8nn11DLaE8Q4gA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5me2qT3T17SWzdxI"
Cc: Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Vignesh Raghavendra <vigneshr@ti.com>, bbrezillon@kernel.org,
        Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        linux-spi@vger.kernel.org, devicetree <devicetree@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Tomer Maimon <tmaimon77@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAP6Zq1j7jHejdx9h-nxCJcVjtGx_3rHmay7R8nn11DLaE8Q4gA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--5me2qT3T17SWzdxI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 08, 2019 at 06:37:06PM +0300, Tomer Maimon wrote:

> for example in our driver we modify the access type (singe, dual or quad)
> according the op->addr.buswidth
> for example in the npcm_fiu_set_drd function.

>         regmap_update_bits(fiu->regmap, NPCM_FIU_DRD_CFG,
>                            NPCM_FIU_DRD_CFG_ACCTYPE,
>                            ilog2(op->addr.buswidth) <<
>                            NPCM_FIU_DRD_ACCTYPE_SHIFT);

> we also modify it in the UMA R/W functions.

Ah, it's only for the flash functions - that's fine.

--5me2qT3T17SWzdxI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1McBkACgkQJNaLcl1U
h9CSyQf9HMQyWI7F+/mz/TefzbACHnpE0c8lwToPC8gs3NlHo8g0orLblfG3DsLm
UEB893DEnNq2PyAZ3RalNBeet13paLEA0qBru8OSMUWpeNwDNxNPJnw0LKgWMfJd
hR7ajSCzI8nNleQRxNko7depUDzpemRXDWxmIyeoBPOYzHxX3AWFoyuaz9aUo2Rl
Unh0Hf1osxqIy1e/McvePEnPv0TT99Ymj8k6/8GnvioyP4EpahOXI8dSR2jI0EhD
E00zLhgmAoNpkwrV/jtjy/U4bWl2oEXrySbQ9Ljy8b0iFVArSIEFILHO06iXOkXP
gKzJeeqWsQ6fz//+fGxegx1F6fcTpg==
=AZer
-----END PGP SIGNATURE-----

--5me2qT3T17SWzdxI--
