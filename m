From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/7] spi: Patch Macronix MX25F0A SPI controller driver
Date: Mon, 1 Apr 2019 14:51:27 +0700
Message-ID: <20190401075127.GM2059@sirena.org.uk>
References: <1553768318-23149-1-git-send-email-masonccyang@mxic.com.tw>
 <1553768318-23149-4-git-send-email-masonccyang@mxic.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0723319962662507437=="
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
In-Reply-To: <1553768318-23149-4-git-send-email-masonccyang@mxic.com.tw>
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


--===============0723319962662507437==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xtx0sNU5lZ46KfgK"
Content-Disposition: inline


--xtx0sNU5lZ46KfgK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2019 at 06:18:34PM +0800, Mason Yang wrote:
> Patch a MFD driver for Macronix MX25F0A SPI controller.
>=20
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>

I can't tell what this commit is supposed to do based on this commit
message which makes it hard to review :(

--xtx0sNU5lZ46KfgK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyhwv4ACgkQJNaLcl1U
h9DLegf+I4q4dklppx9CBbUDzY7TJuYMR9fUaHEJ+PERL25QB7175CTrJAMJwNUT
VYMvdLaDFLhYbL5W340U3TsnndEAr5Ad+8UyN6UKyLnDEJ9St1a+mF+s3bGIDh/y
9eoAmlwLizsthxqUJvBRh7ZhvKvwhSqfJ4AsiNFhXfq1BnPeYks5pHRtzAa2Y4Qn
2y6UJEi9pKVrl2Dd8Uer91pO51KSbeT8ScjjbDd8/mD1kTNTxejhvJyzrT2jiqnh
Zqhjwv1kZB6Nx4IvOiLD5SeRi0QPV987Z95qpDgo2EBeY81zRHEt4wcACe95mGcf
6+BzLYW9fOms8zU/qBIE5kPY923RZw==
=IEo0
-----END PGP SIGNATURE-----

--xtx0sNU5lZ46KfgK--


--===============0723319962662507437==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

--===============0723319962662507437==--
