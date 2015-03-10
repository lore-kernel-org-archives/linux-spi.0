From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC/PATCHv2 3/3] spi: dw-spi: Pointers select 16b vs. 32b
 DesignWare access
Date: Tue, 10 Mar 2015 20:40:36 +0000
Message-ID: <20150310204036.GP28806@sirena.org.uk>
References: <1425685594-26595-1-git-send-email-tthayer@opensource.altera.com>
 <1425685594-26595-4-git-send-email-tthayer@opensource.altera.com>
 <CAHp75VcceG2O+YCw4twBzC_2v9+XQRpfBxMqGXERi3amnj3rdA@mail.gmail.com>
 <54FDDFE6.8010109@opensource.altera.com>
 <CAHp75Vf6dgobzZyJxu8eiqGgC7FRrwLCmyMf5Agk6S3jHDj4bw@mail.gmail.com>
 <54FDF8BB.4050202@opensource.altera.com>
 <CAHp75VcmNOaiyRNLFzQT7nKS6piZzpYSoS785J86rKtNXx6KNg@mail.gmail.com>
 <54FF556A.3020408@opensource.altera.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5okFfQlUf1yFo9NP"
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Grant Likely <grant.likely@linaro.org>,
	Jiri Kosina <jkosina@suse.cz>, Pawel Moll <pawel.moll@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	ijc+devicetree@hellion.org.uk, dinguyen@opensource.altera.com,
	Linux Documentation List <linux-doc@vger.kernel.org>,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	Thor Thayer <tthayer.linux@gmail.com>,
	Axel Lin <axel.lin@ingics.com>, baruch@tkos.co.il,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Kumar Gala <galak@codeaurora.org>
To: Thor Thayer <tthayer@opensource.altera.com>
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <54FF556A.3020408@opensource.altera.com>
Sender: linux-doc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--5okFfQlUf1yFo9NP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 10, 2015 at 03:34:50PM -0500, Thor Thayer wrote:

> Is it preferable to have both 32 bit reads and writes for consistency?

> Or is it preferable to make the minimal number of changes which would be to
> only add a 32 bit write function?

It's probably preferable to be symmetric, if only to help anyone else
who has a similar system that generates errors instead of silently
handling, but unless someone has any great reason it's not a blocker for
me.

--5okFfQlUf1yFo9NP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU/1bDAAoJECTWi3JdVIfQ7CsH/jVpg+TCsdKorSYTSFLYgGzr
fkEu3oN/toI3C9rHsgPNPIGbvhayJ5L5TOfYgvIDercdkmEM9ex5Q/ym9wi3U4YD
W7ggzehNWUk2Vb1CZtXp8exR789kaf6eEGhf4sJIaz350YYPML2iL+Vo3dFknZsA
6Jqmy4dCGa6HpqT/l5Z6Ra+LlA9vhMtNL4jtVlvrlEN/X2W45ABABdNBuXLG+70d
tfwTYL1ra49/N5+UCQs6CEOaKeZ/Sg8KzEsKw+mvgX9SnFtTVVliYg2PwUnAc4aq
iRcgHLXbpWlsSdeOZjVoA8te62xwGPOzR25AaUZfFhk6srEcluc48X8iGO9Z6Jc=
=e7d2
-----END PGP SIGNATURE-----

--5okFfQlUf1yFo9NP--
