From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 3/4] spi: Patch Macronix SPI controller driver
 according to MX25F0A MFD driver
Date: Fri, 19 Apr 2019 15:51:51 +0100
Message-ID: <20190419145151.GR2803@sirena.org.uk>
References: <1555320234-15802-1-git-send-email-masonccyang@mxic.com.tw>
 <1555320234-15802-4-git-send-email-masonccyang@mxic.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5567328658075726434=="
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, juliensu@mxic.com.tw,
 christophe.kerello@st.com, richard@nod.at, bbrezillon@kernel.org,
 marcel.ziswiler@toradex.com, dwmw2@infradead.org, miquel.raynal@bootlin.com,
 linux-kernel@vger.kernel.org, stefan@agner.ch, linux-spi@vger.kernel.org,
 marek.vasut@gmail.com, paul.burton@mips.com, robh+dt@kernel.org,
 geert@linux-m68k.org, linux-mtd@lists.infradead.org,
 computersforpeace@gmal.com, liang.yang@amlogic.com, lee.jones@linaro.org,
 zhengxunli@mxic.com.tw
To: Mason Yang <masonccyang@mxic.com.tw>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <1555320234-15802-4-git-send-email-masonccyang@mxic.com.tw>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org


--===============5567328658075726434==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IUSVF+LtaR4kWxuH"
Content-Disposition: inline


--IUSVF+LtaR4kWxuH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 15, 2019 at 05:23:53PM +0800, Mason Yang wrote:
> Patch Macronix MX25F0A SPI controller driver according to it's MFD driver.

It'd be much better to describe what the above actually means - what
changes have been made in the introduction of the MFD driver?  It does
feel like there's not as much abstraction as I'd expect between the MFD
and the child, there's a lot of peering into the parent and enabling and
disabling individual clocks for example rather than either having this
hidden behind a function or just having the clocks owned by the child
driver.  The driver also isn't using the MFD interfaces to pass through
the register subblocks for the IP - instead the child driver is peering
straight into the MFD structure and looking at a variable in there.

--IUSVF+LtaR4kWxuH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAly54IYACgkQJNaLcl1U
h9D0PQf/erY3gZlhAvdcG9BNLPO9WNE8OrfW8W1e5MFQI3MEhJC9fi3BynwsbKtq
oYO7n4IlWTIXmNDQdlZTdlGU2ybIAMGbUmRh0sP2UB5dh2nNnCTfzdOKdszWov18
JFDl2+5xeyM5ensdZqRVNaXOP/j3eavC/1AOgDTlVummvycoxPH7AeDEg/+UTHrb
blDrIxdutZnG+hGdmdoDBZdMsP/eWTS2FJ1t3bnU2AVnftWS/35E5NXpJG4o+gz+
kb+NmEWgrDFoCOk03rq02pudfkdQawONL85giQwm5Apz4OcKeGRV7tIUjfVr0DxT
9Rw+gkXFeqGyyD3rS25VYKnDsuXRCg==
=WftF
-----END PGP SIGNATURE-----

--IUSVF+LtaR4kWxuH--


--===============5567328658075726434==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

--===============5567328658075726434==--
