From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 10/11] spi: add more debug prints in s3c64xx
Date: Thu, 4 Jun 2015 11:26:21 +0100
Message-ID: <20150604102621.GB14071@sirena.org.uk>
References: <cover.1433364398.git.hramrach@gmail.com>
 <305830ebf9c0ae98c4f6e0ebbdec7414d6762b36.1433364398.git.hramrach@gmail.com>
 <20150604091634.GY14071@sirena.org.uk>
 <CAOMqctQxn6UY2DJ9Syp6Ay9SYKLgdU+8EjiTK_48-R3dZ8PcvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="d5L/0NH1d7AMGItx"
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Russell King <linux@arm.linux.org.uk>,
	Kukjin Kim <kgene@kernel.org>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Vinod Koul <vinod.koul@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Brian Norris <computersforpeace@gmail.com>,
	Han Xu <han.xu@freescale.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Marek Vasut <marex@denx.de>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
	Alison Chaiken <alison_chaiken@mentor.com>,
	Huang Shijie <b32955@freescale.com>,
	Ben Hutchings <ben@decadent.org.uk>,
	Knut Wohlrab <knut.wohlrab@de.bosch.com>,
	Bean Huo =?utf-8?B?6ZyN5paM5paMIChiZWFuaHVvKQ==?=
	<beanhuo@micron.com>, "grmoore@altera.com" <g
To: Michal Suchanek <hramrach@gmail.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAOMqctQxn6UY2DJ9Syp6Ay9SYKLgdU+8EjiTK_48-R3dZ8PcvA@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--d5L/0NH1d7AMGItx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 04, 2015 at 11:33:37AM +0200, Michal Suchanek wrote:
> On 4 June 2015 at 11:16, Mark Brown <broonie@kernel.org> wrote:

> > Also for this patch (which just adds some trace) there isn't any clear
> > reason for it to be sent as part of the series at all, it doesn't help
> > deliver the functionality and doesn't depend on the rest of the series.

> I used this patch to add missing information to dmesg output so I
> could diagnose the SPI failures so I think it is relevant.

The fact that you used this to debug problems is not relevant to any fix
you might have developed for those problems; the fix can be explained
without needing to know how you got there.  Similarly the debugging is
hopefully useful in general without needing to know which particular
problem prompted it's creation.

> To print a clock name you AFAICT need this header. I think this is an
> abstraction problem in the clock framework. Fixing the abstraction
> problem with clock framework would only grow the list of recipients
> which is already so long you complain about it.

This is a bit of a warning sign that the series isn't very focused.
It's also just not good practice, sending patches with obvious problems
(especially obvious problems that aren't clearly flagged up as something
temporary) will frustrate reviewers and can often lead to other issues
being obscured.

--d5L/0NH1d7AMGItx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVcCfMAAoJECTWi3JdVIfQUqUH/R+Nlv9ELNPw+tGGYlunfVzE
pZJBF4wKZFs3MkZX1tctiv2eJjQv2qimy62Z1DUvmctXq2KEopZMgcQfWeQrgG0U
qxsYrvENti7NSigt7sWJ4yOurV2QY4M8Xej14XCe0ss96W56U2XQ8vwvQhqrbbr4
+t1Pwd6Evw5aL9BJdm+KS87owraQ2wdz2bs6H3gouVwzZ1Xg3NPYNjV10BP8uzqn
trwS8HwLAg49bjmD5NlChj2JQCrx+5b2fVyugeIhIK5pMvVLGaaVmzkQJW4pjcrb
yK4U3jT4AuVhzaNaiMHBxBUC6HQvS/ZIJvmT10BdRdX+9JGEqOLzlakEvbVpw/Y=
=BZSM
-----END PGP SIGNATURE-----

--d5L/0NH1d7AMGItx--
