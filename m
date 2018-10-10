From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: spi: dw: add cs-override property
Date: Wed, 10 Oct 2018 12:27:53 +0100
Message-ID: <20181010112753.GC6294@sirena.org.uk>
References: <1539155293-21750-1-git-send-email-talel@amazon.com>
 <20181010101825.GA6294@sirena.org.uk>
 <dbac7f00-e9cc-ddac-5734-9763b5985ead@amazon.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XWOWbaMNXpFDWE00"
Cc: linux-spi@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ronenk@amazon.com, barakw@amazon.com,
        David Woodhouse <dwmw@amazon.co.uk>
To: Talel Shenhar <talel@amazon.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <dbac7f00-e9cc-ddac-5734-9763b5985ead@amazon.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--XWOWbaMNXpFDWE00
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 10, 2018 at 02:23:40PM +0300, Talel Shenhar wrote:
> On 10/10/2018 01:18 PM, Mark Brown wrote:
> > On Wed, Oct 10, 2018 at 10:08:12AM +0300, Talel Shenhar wrote:

> >> The dw spi controller has an auto-deselect of Chip-Select, in case there is
> >> no data inside the Tx FIFO. While working on platforms with Alpine chips,

> > Why would we ever want to use this behaviour?  It will be broken for any
> > non-trivial SPI message such as those made with multiple transfers
> > anyway.  Why not just unconditionally control it manually?

> This behavior (auto-deselect of Chip-Select) is the default behavior of dw spi controller hw.
> On Alpine chip there is additional behavior added to the dw spi controller hw that allows the sw to disable this behavior.
> This patch allows the dw driver to enable this hw workaround and add the needed sw manual control for it.

If this is a modified IP with additional features then it should be
given a new compatible string rather than having a property - it's not
just configuration of the existing IP, it's a new thing and we may find
there are other quirks that have to be taken care of for it.

--XWOWbaMNXpFDWE00
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlu94jgACgkQJNaLcl1U
h9ApoQf/bZoqz6AzEschlNCke1wLPI98oWSDZLffCSfz9cw1bkrYYqkHInTWRcH6
kDWI4TUt7/y/Vfe2KZOB5B14B05XJh5y4NB21zLNc7BQCbmY1TPNHKb4Q/ums5qp
cPnz+jyFf2wUrRBsu9MZ6G5LbwameBAjy0aw1YlIzvtMHovsT1TCoAcazwCWrZoD
5oe0ZTvJ5L8ht6ML7RQl2nRBVLlTlVmmxqlZwmomnhQ+meM9TkYORREI4AmfM5V1
CUMMwpg8BB7WA5SYhvgtdd4mZIw3uVrY66Xh1gIOq+zrIOxMDwzvva0pHoWYiuPn
oiwyTZEzTYPdn4p3yum2O4EvASuj7g==
=hB4N
-----END PGP SIGNATURE-----

--XWOWbaMNXpFDWE00--
