From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 1/2]spi: DUAL and QUAD support
Date: Thu, 22 Aug 2013 13:37:35 +0100
Message-ID: <20130822123735.GA9902@sirena.org.uk>
References: <1376216117-5864-1-git-send-email-wangyuhang2014@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8330416264503987166=="
Cc: spi-devel-general@lists.sourceforge.net, sourav.poddar@ti.com,
 tpiepho@gmail.com, linux-mtd@lists.infradead.org, pekon@ti.com
To: wangyuhang <wangyuhang2014@gmail.com>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <1376216117-5864-1-git-send-email-wangyuhang2014@gmail.com>
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


--===============8330416264503987166==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Aug 11, 2013 at 06:15:17PM +0800, wangyuhang wrote:
> fix the previous patch some mistake below:

One other thing: this wasn't sent against current code, it seems to have
been generated against an old kernel version.  Please make sure when you
submit that you submit against either Linus' tree or ideally the latest
development code for the subsystem.

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSFgYMAAoJELSic+t+oim9U9oP/2qOfnQ4SIMeRcGdD7Ee2yap
ylbbdECwA/duEyv5+lSfyh3/QrYsLDCFCjHM+dNhUkp7n4/33grh7lXe/p3YlFcH
krSd2PcvW7r/9QF0pqY8oOsJFlmjzKfDBX1C01GLNrwK/0y/+Bl6quDHnyq+9dJC
hg72m3DaHL+g0Ebt/uPc6SwzVeu2MdMX1XOgY/bso+XsZIp4aO3s7ikpS8v9VIBc
aHFdoPfe/zMWBMjlzPkgLklIqGbABpW23HqLygNbuifTbhs2CFQjkP5KlaJxtPy1
kihvBEogpxx/p7FjUm70I1Im/kxuhAZxXe66Rb15yu3fgr5ZXwPUIdfZp/lJrZ92
SxBitsp7pkIV+0rPcw0pXy0pq9DHTBeEkjCjgA/gmbghMTk6aotjTN04S6WjzXS2
WdLjimuqKfqd1rWTkozMTJ3FtpVBPxnGnQLH9WITh9ba23TLXfrq+c9oixCy6mPK
T5ENCJR94ffqH0SZ47t9wjbXTjaQBKkUd1eFP1qMURNM881TyHru0p1DejqeorhP
BwgWLqazRR2G4jfxq+86uYBkdCxWTwoJRLQATef6G5eRAEUHcfZYBhhc+onj8LDY
gFLWPCl84HhNb9mViQn0xWJCO/BhEttfISqY8SnKjGneWtifvH8baO6XGIKuBjsQ
SS88i8fyHRZrJkTqPpgj
=aVw4
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--


--===============8330416264503987166==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

--===============8330416264503987166==--
