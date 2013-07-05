From: Mark Brown <broonie@kernel.org>
Subject: Re: SPI: DUAL/QUAD support
Date: Fri, 5 Jul 2013 11:12:04 +0100
Message-ID: <20130705101204.GT27646@sirena.org.uk>
References: <CAHSAbzPNDSr_6N79fh0DTWSEg8buRRPyiw8SPodtKLPjzWXJsg@mail.gmail.com>
 <20130704143645.GA27646@sirena.org.uk>
 <20130704180656.GA1974@sig21.net>
 <20130704191216.GK27646@sirena.org.uk>
 <CAHSAbzNBkZPFOfGHqFxZH_id=PFj=BmZ4Q302zGKeM-0yJBtHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7645878986088807372=="
Cc: Grant Likely <grant.likely@secretlab.ca>,
 spi-devel-general@lists.sourceforge.net, Johannes Stezenbach <js@sig21.net>,
 linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org
To: yuhang wang <wangyuhang2014@gmail.com>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <CAHSAbzNBkZPFOfGHqFxZH_id=PFj=BmZ4Q302zGKeM-0yJBtHg@mail.gmail.com>
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


--===============7645878986088807372==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0zFmc7P4JeMfRocR"
Content-Disposition: inline


--0zFmc7P4JeMfRocR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 05, 2013 at 05:41:57PM +0800, yuhang wang wrote:

> Yes. I agree with you. This should be described in SPI level.
> So to SPI controller, if it has the ability to transfer in 2x or 4x, but
> what a pity no device can tell this info to it. No matter what the slave
> is and no matter whether they will use the spi transfer width member,
> firstly SPI controller should provide these members. If the slave do
> not set the member, that means the slave wants to communicate
> in 1 line traditionally.

Yes, it definitely makes sense to have this as a feature in the SPI
core.  We just need a good API for it, which I think is mostly just
about working out what to call things.

--0zFmc7P4JeMfRocR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR1pvwAAoJELSic+t+oim918YQAI2yO97qPXPHzY1RQUe/JaaU
5cNp/UVK9skvLWNysakFYMkR/UAbKGihvLv0cn4TTbgeEdUlGE7IPeFIdeQP+4jP
t1Itz9KAkZ3pAhMsD/dwGccFAUSPCJoZq4AbvDOsm4xZkoHw3hHKkagvCVZwy3+U
uSRSXbG0iypYieZXZ2c+BscuLzC1Y4sjUMon0+iRvsvtGGT8XaR1uKNTziK1799Y
em/yu2+1niYduaec3SkbKeX4lBl/PJPrb8gyPyUhzEq/sJ+VvYKzIjkF2pl7+q2a
eBWFZe0nT16ZUGf523I10QFVo4V5TnSEyU9y9au1ul3ZwJOaooAYoXGZp1CB5eY4
TZJ9NBbOiyNj/wPuaNgWMwv1tmlFnRsvAA1CrvnEdHpb/a7kNyjbbK1OHjsDwNNI
N6jDvS3S1b1wKec01lOnY8nYHuFJxP+kfjtdrST9raOOlH36d3MUdW3KytleRA84
kz8B0W7bE9vnmV3UOMbtZjTl+WInByaNnNYPvtlUWEjBh96josLlSe0szlBgF5M8
KHNCjZ0uyG493baHSzht0Z12Gw2t7FUiGbkKYHM/4W9MMoNZxAQWZcvCsptf57FB
J2t80d+NT4HqDcIeapjPGBaIiuI92QUb2b4BbUkM+rdON6nVBOYCEI8xYUhlhRHB
avnStUCFlNghIDOMZgWx
=LJvG
-----END PGP SIGNATURE-----

--0zFmc7P4JeMfRocR--


--===============7645878986088807372==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

--===============7645878986088807372==--
