From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] spi/qspi: Add memory mapped read support.
Date: Tue, 15 Oct 2013 13:46:56 +0100
Message-ID: <20131015124656.GM2443@sirena.org.uk>
References: <52566ACC.1080100@ti.com> <20131010101410.GG21581@sirena.org.uk>
 <52568AA3.9080203@ti.com> <20131011100839.GA21581@sirena.org.uk>
 <525CDB77.4040201@ti.com> <20131015111647.GX2443@sirena.org.uk>
 <525D2BB3.4020705@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0031295974385907960=="
Cc: Peter Korsgaard <peter@korsgaard.com>, Trent Piepho <tpiepho@gmail.com>,
 balbi@ti.com, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "spi-devel-general@lists.sourceforge.net"
 <spi-devel-general@lists.sourceforge.net>, computersforpeace@gmail.com,
 dwmw2@infradead.org
To: Sourav Poddar <sourav.poddar@ti.com>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <525D2BB3.4020705@ti.com>
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


--===============0031295974385907960==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ig8UoZYzcROCqCtm"
Content-Disposition: inline


--Ig8UoZYzcROCqCtm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 15, 2013 at 05:19:07PM +0530, Sourav Poddar wrote:
> On Tuesday 15 October 2013 04:46 PM, Mark Brown wrote:

> >Can you fix this by enabling the clock is enabled when you return the
> >buffer to the MTD layer and then disabling the clock when the buffer is
> >released?

> Sorry, I did not get you here. With memory mapped read, there is no
> buffer exchanged, everything takes place at the mtd layer only, what gets
> exchanged is just the memory mapped address.

The buffer is the memory mapped address - part of getting the address
should be preparing the hardware for it.

>      if (spi->mode && SPI_RX_MMAP) {
>          printk("memory mapped mode set\n");
> -        flash->mmap_read = true;
> +        flash->mmap_read = spi->memory_map;

So this probably needs to be a function call to get the buffer (and a
corresponding one to free it).

--Ig8UoZYzcROCqCtm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSXTk9AAoJELSic+t+oim9AnIP/3Zeh9U0w12jhEppg+gdkDan
XRh2gv3ZOjuRvmBb6vk+jS73jNdqoyyWRyLOhqtUvmQEaKMIPeM0cuMHpFPNBRhi
GsBOicZTZF4QuCobkqdG/l/MtaphKF9yWcHMfLyYcu4wnNnhFcJvhGFfMqguKhz5
JaBCk7+vHmjMspAz1lJSg+y7ylAWMqxeIw+ygq518zTSu31E6NBAce7RsAHkzxgL
LS05Zx8eqxFx38mLn9QDXqhytGgAkWnFREzC+VU7mKQvxbCur3LeSsAubpQO8EIT
zglocztrT6EksTnDsORoOD6bpshThhdoUUgfrKUnkCU4XgkCsk1pMvJy2mt5aC8j
gG+rpnjv07TBzxPAozT2hye+cZUThYLUz4DAOS5urGUk5jwoFp16eecI3CKrSW8h
9P1ZJLuZ6hfRIdGnSF4Y9IPiuBPsMxLkfpepiE4BCK+6N1t8RKfZ7Q8Vtlo+fgZv
dUGflLipcVmFGvgipnDIDN3oMJemb0I6FpugNJ46hmHiNS51khx6t3Na7nPyr5R/
VtyguB3xqNxMvZuOf7ULBlxWgKNkL490as994Lm9InwD7VGQ3uzpp+NiGMRmUVN1
7tzEmI1CcG9mn3VJUtEVCprLCuG/gwdkIjwe4d/Ql3h2UT/iZ2B+FZB9BPNo0pug
W+dDFparKQWE9pGsKCeu
=buyV
-----END PGP SIGNATURE-----

--Ig8UoZYzcROCqCtm--


--===============0031295974385907960==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

--===============0031295974385907960==--
