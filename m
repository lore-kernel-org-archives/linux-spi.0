From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] spi/qspi: Add memory mapped read support.
Date: Thu, 17 Oct 2013 13:38:50 +0100
Message-ID: <20131017123850.GN2443@sirena.org.uk>
References: <20131011100839.GA21581@sirena.org.uk> <525CDB77.4040201@ti.com>
 <20131015111647.GX2443@sirena.org.uk> <525D2BB3.4020705@ti.com>
 <20131015124656.GM2443@sirena.org.uk> <525D41E2.30206@ti.com>
 <20131015180142.GS23337@ld-irv-0074.broadcom.com>
 <CA+7tXigv1Q3BPE3uhzdJpx3DsqUpxzrBUaPfWR-i15PsVtMWsQ@mail.gmail.com>
 <20980858CB6D3A4BAE95CA194937D5E73EA23640@DBDE04.ent.ti.com>
 <525FD715.50703@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1118134290844829152=="
Cc: Peter Korsgaard <peter@korsgaard.com>,
 Brian Norris <computersforpeace@gmail.com>, "Balbi, Felipe" <balbi@ti.com>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "Gupta,
 Pekon" <pekon@ti.com>, "spi-devel-general@lists.sourceforge.net"
 <spi-devel-general@lists.sourceforge.net>, Trent Piepho <tpiepho@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>
To: Sourav Poddar <sourav.poddar@ti.com>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <525FD715.50703@ti.com>
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


--===============1118134290844829152==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FpS+xW6Acftweoct"
Content-Disposition: inline


--FpS+xW6Acftweoct
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 17, 2013 at 05:54:53PM +0530, Sourav Poddar wrote:

>   Setup:
>     Here, the actual memcpy is done in the spi controller, and flash
>     communicates to the qspi controller to do the memcpy using the
>     SPI framework. This is what is propsed in the $subject patch.

>   Setup:
>     Here, the actual memcpy is done in the mtd read api itself, by
> getting the
>     memmap address from the spi controller.

> So, time reduced almost to half while bypassing the SPI framework.

The interesting case for benchmarking here is more a comparison between
normal DMA driven transfers and the memcpy().  Some consideration of the
CPU load would also be interesting here, if the SoC is waiting for the
flash then it's probably useful if it can make progress on other things.

--FpS+xW6Acftweoct
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSX9pXAAoJELSic+t+oim9cz0P/A+640Vl0u1qdg1vm9dhhwf9
dOT4CeJbqnP/mSSDFuZklmlARyS6udx1llLPEXJzsUrFqAOWm1rdql/PAVywDOF7
SoMBNxf/DcK7RnoSL+HLhI9QmEB09AfH3FQNevvk5uxL+Klu8IOmIC04Se4Ks1HT
pSg4DVXZex1Rs+Zdgzp26hw+JRyRi8fXSD7pNfYB6lpv7rrqLL0rdl3NNuG82w06
x5uIZnzLo5ZQwkNODdPQabrvnhbfwPQAvYIYcTYSTbWAJcZwgEsRUVjH0wi1yR0S
8SAkWQuP8hM8GOKyK5/lOvrYO5mYKSqEnvOymAoL82RBf4jR717ayL8sT54/xnpq
w5DYiLXb/VWttwEonk9cZt3QSmOV6RNleOKSe7g31xKQyRbEMhuoFkyK8O8qi9Bs
QBDMuyvgz7fZEIYHVghiq+DuLXJ7cOXq5/RE6AbO30dNtyXHB1bz+/PCxvw5BWs/
3vQLZbJyLkBQYnSeWAIG51Go0MynH0zGM7kU3YT48jrznGZnHg4RXgh9kWYLL2bJ
ZDcLKZf2/zOxEIVAURZMRj71z3IC1lpa/6lfKSkYHlv4pkKm23wK26B61yQC/x96
0Y7EIuBf2/IRq3hG3HD4soN/bRuDWjOrgXGPAnk8dEDL6q1Gvp67syXYMpg1JPuV
MRGEES32s5vuJtghaiQ2
=CTbU
-----END PGP SIGNATURE-----

--FpS+xW6Acftweoct--


--===============1118134290844829152==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

--===============1118134290844829152==--
