From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH net-next 04/11] spi: spi-fsl-dspi: Cosmetic cleanup
Date: Fri, 16 Aug 2019 13:21:03 +0100
Message-ID: <20190816122103.GE4039@sirena.co.uk>
References: <20190816004449.10100-1-olteanv@gmail.com>
 <20190816004449.10100-5-olteanv@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Q8BnQc91gJZX4vDc"
Cc: h.feurstein@gmail.com, mlichvar@redhat.com,
        richardcochran@gmail.com, andrew@lunn.ch, f.fainelli@gmail.com,
        linux-spi@vger.kernel.org, netdev@vger.kernel.org
To: Vladimir Oltean <olteanv@gmail.com>
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190816004449.10100-5-olteanv@gmail.com>
Sender: netdev-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--Q8BnQc91gJZX4vDc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 16, 2019 at 03:44:42AM +0300, Vladimir Oltean wrote:
> This patch addresses some cosmetic issues:
> - Alignment
> - Typos
> - (Non-)use of BIT() and GENMASK() macros
> - Unused definitions
> - Unused includes
> - Abuse of ternary operator in detriment of readability
> - Reduce indentation level

This is difficult to review since there's a bunch of largely unrelated
changes all munged into one patch.  It'd be better to split this up so
each change makes one kind of fix, and better to do this separately to
the rest of the series.  In particular having alignment changes along
with other changes hurts reviewability as it's less immediately clear
what's a like for liken substitution.

--Q8BnQc91gJZX4vDc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1Wn64ACgkQJNaLcl1U
h9D5Bwf+OKuQMiT2y6NsdVvC4VV6RHVuXDYQxs3lIWdb2gLw+ikQZum3e77gvc+Z
If4Yc1d+XAwqFbrD81a522yH0cyGfWIed/Hlmc6CwkKMZC1j+0ngO2PSIKeBdZzA
cuVlqNjke4qPs6lsNcBN9tig3A7Qer4de9hkCCtctdPGBalJSBprV+ow85cjyXbp
4wvnTojb1EzWCMplDPvoTeAGgZHZjsfp5lpf+eTI+isYBjRFeyokFvsosUZiMdZI
Wi+o/Swe1nL/6jM8+EVmJpUzTUDtT191cSM4KaHEifU9zXdrSk1ss09wlruRAETy
ACNvbL2isq76eFbeLwIwtDqf/mfaaA==
=2xml
-----END PGP SIGNATURE-----

--Q8BnQc91gJZX4vDc--
