From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V2] SPI: DUAL and QUAD support
Date: Mon, 29 Jul 2013 07:42:34 +0100
Message-ID: <20130729064234.GS9858@sirena.org.uk>
References: <1374917973-7083-1-git-send-email-wangyuhang2014@gmail.com>
 <CA+7tXihU+JODQec-h2joUYiVY=otuSOu8BwADn+mtgELCFHPng@mail.gmail.com>
 <CAHSAbzNTUpsftZ1-fpv7UefuSdUvUidg9-SLOUXCTmSBhM0ZJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0915014743891228327=="
Cc: "spi-devel-general@lists.sourceforge.net"
 <spi-devel-general@lists.sourceforge.net>,
 Sourav Poddar <sourav.poddar@ti.com>, Trent Piepho <tpiepho@gmail.com>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "Gupta,
 Pekon" <pekon@ti.com>
To: yuhang wang <wangyuhang2014@gmail.com>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <CAHSAbzNTUpsftZ1-fpv7UefuSdUvUidg9-SLOUXCTmSBhM0ZJQ@mail.gmail.com>
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


--===============0915014743891228327==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BHAjPJTFBOjGMyr2"
Content-Disposition: inline


--BHAjPJTFBOjGMyr2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 29, 2013 at 10:44:43AM +0800, yuhang wang wrote:

> > Your changes to spidev are not backward compatible at all.  You can
> > not change the data types in the ioctl and maintain backward
> > compatibility.  You can also not delete ioctls!

> well, please give me some details or specific situations. Why ioctl
> can not be changed. The operation that SPI_IOC_RD_LSB_FIRST do can be
> done in SPI_IOC_RD_MODE, so I dont think there is any necessary using
> SPI_IOC_RD_LSB_FIRST. What you worry about is the user already used
> SPI_IOC_RD_LSB_FIRST?

You need to make sure that existing userspace binaries can run
unmodified, changing the types will change the layout of the ioctl
arguments.  This may mean that you need to add new ioctls if you need to
change types.

--BHAjPJTFBOjGMyr2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR9g7XAAoJELSic+t+oim97XkP/35ldbY8ckpgh16STPv3AtCi
vdftc2y7jmkF5RqPCEGZYAxryXIZCxRCkWKIoFSAC34geQ0mNMYpVUstDUL3pne4
/6RE3uO00x4TnVXgKyNrt9Mcd7j2FsV3ym0kTy6Q66mfUzQlUCOrQwgpuak2FR+P
JNmLGxA/mzan19UIxKfQKldXis9esBnGYJyUCDwwvVOBe0gShPagw7Ps7uNkuWGP
gEv1HL7UAINVXtQX6nLUuq+eoUAepSCIRwTjaXB93sVvXySTAk5T8Ez1h6Os1DiQ
qynKiK+hksyFtwPoba5WNWjkd3qmpYq/oeSIlb4B/kDTCI1Cf28473gTekoDLJIT
3ipnmrcvwOEyeouwgkPdoPP7WdOTx6r4nbuZsgtvFEW8qHQEK1YqG1EMWkEqH2Fo
fw8i43UFuOcjHx8u2EP0CG20eckJd4Vat6WDZ9Z1/k1sOrJR4cTv9NvXeFbM6jkD
/7zmmdvpEIQHqyW3w+m+HxJ/dky4zf1m1/gFDfJ9R1tFn1oEfVRynTDU1q1+HhFm
yBeEDJ3mXRApc1fNaTebf0b/SFiLTPOsowdQW7Xpxo8gZr4ZCmFJnH8lXOHugLsx
xZX+3AGY9D1TP5YFqNYoxNkwwj4xhUPOrwyoDVdp6Z0bBy69WAg1yreC+4G0UTe0
mdiUUCJosjQpct1oO9oE
=WGQ3
-----END PGP SIGNATURE-----

--BHAjPJTFBOjGMyr2--


--===============0915014743891228327==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

--===============0915014743891228327==--
