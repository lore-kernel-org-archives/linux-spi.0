From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] spi/qspi: Add memory mapped read support.
Date: Tue, 15 Oct 2013 23:10:52 +0100
Message-ID: <20131015221052.GB2443@sirena.org.uk>
References: <525CDB77.4040201@ti.com> <20131015111647.GX2443@sirena.org.uk>
 <525D2BB3.4020705@ti.com> <20131015124656.GM2443@sirena.org.uk>
 <525D41E2.30206@ti.com>
 <20131015180142.GS23337@ld-irv-0074.broadcom.com>
 <CA+7tXigv1Q3BPE3uhzdJpx3DsqUpxzrBUaPfWR-i15PsVtMWsQ@mail.gmail.com>
 <20980858CB6D3A4BAE95CA194937D5E73EA23640@DBDE04.ent.ti.com>
 <20131015205254.GX2443@sirena.org.uk>
 <CA+7tXijF8VTsA3Mk3j8Qe7r0nqr+Xri6=GDfEZGH74Doup5=eA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1520970655708247575=="
Cc: Peter Korsgaard <peter@korsgaard.com>, "Balbi, Felipe" <balbi@ti.com>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "Gupta,
 Pekon" <pekon@ti.com>, "spi-devel-general@lists.sourceforge.net"
 <spi-devel-general@lists.sourceforge.net>, "Poddar,
 Sourav" <sourav.poddar@ti.com>, Brian Norris <computersforpeace@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>
To: Trent Piepho <tpiepho@gmail.com>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <CA+7tXijF8VTsA3Mk3j8Qe7r0nqr+Xri6=GDfEZGH74Doup5=eA@mail.gmail.com>
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


--===============1520970655708247575==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DBn2EsnvkVzqM8Y9"
Content-Disposition: inline


--DBn2EsnvkVzqM8Y9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 15, 2013 at 02:03:01PM -0700, Trent Piepho wrote:

> It does get tricky when you're dealing with flash roms, as people
> often want to boot from those really fast, so you want the kernel to
> know how to use them in the fastest way before it boots as opposed to
> after booting when it's obviously too late to configure the kernel to
> boot faster.

I'd guess that having fast as the default would be sane enough, though.

--DBn2EsnvkVzqM8Y9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSXb1pAAoJELSic+t+oim9Kc0P/ia6nYernMVCnEqdb0A2/3DV
KIfs3KxaHrXQS3uFsWkWxjWv6LGrNLelJWuSMuCXpg4HFMCI0U58S6Wquv1iHKME
7IEYZ/D1CV2f5jyH114CPCV4HKvLq9HpdUILSxG7YlKZFgn+8vBKxQsnEgyrAhdG
44FvX4WYC2yINKiwkWEwACzcgviSYsA8aBsQ3WShCx6VI253q0QAWxNu8bJb6Ugd
telKx6F6G4UGi/78Twe8adT2L4YeZiIESHFW7usuqQVol5RHdWNQZMRZSaKf+fdK
KEODvfuNp8of+tJETLfpgfTu5xcy0Q5Jcxqc35nh7+fKv3MA94HWNZworSfPH4Yv
pW0WmhgNLf1UYBvmMn3CioI7rAXr+H9JtxspQBYWKiJ/4oMsTaMCWhfMGbHWAg1r
CcP/83wOkqSPhVK2rOzksl34foaNuji81XqgMp0/Rvp0zHP+TxP4NB7x8o6FSui+
QyBK9wtwjDKU6cMW33ScpLYQPTs+ebGghvBOnO0iklF4BrzYjeeCKEbswUJ+u6wf
5W+J6TN42BIGF37npbrdwMsLw7+YlGz/wBs1dyw25+RbrDVfHYv2nulW2a6qKiJM
khYlgqQBvwPbthpVWT5sDcG4GZ0Re+WTaerSADDbKdjfwGSR1T7tAwJTLDrKrSSh
W5et8CwoCZfUfOdKi/7g
=Viu2
-----END PGP SIGNATURE-----

--DBn2EsnvkVzqM8Y9--


--===============1520970655708247575==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

--===============1520970655708247575==--
