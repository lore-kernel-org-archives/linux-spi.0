From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: sirf: fix the issue while transferring more than
 256 words
Date: Thu, 16 May 2013 18:23:58 +0100
Message-ID: <20130516172358.GA1627@sirena.org.uk>
References: <1363592828-6347-1-git-send-email-Barry.Song@csr.com>
 <CAGsJ_4wamqzwLZkUz4h6ex=oVQZhzhw7S6r41wt9tTUoMR=aXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7079180506282066074=="
Cc: Qipan Li <Qipan.Li@csr.com>, workgroup.linux@csr.com,
 Zhiwu Song <Zhiwu.Song@csr.com>, grant.likely@secretlab.ca,
 Barry Song <Baohua.Song@csr.com>, spi-devel-general@lists.sourceforge.net,
 linux-arm-kernel@lists.infradead.org
To: Barry Song <21cnbao@gmail.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAGsJ_4wamqzwLZkUz4h6ex=oVQZhzhw7S6r41wt9tTUoMR=aXw@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org


--===============7079180506282066074==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 15, 2013 at 08:59:47PM +0800, Barry Song wrote:
> ping Mark, Ping Grant.

Don't top post, don't send contentless pings.  At a guess you didn't CC
me...

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRlRYrAAoJELSic+t+oim93yAQAIUez6vHcem3kS5U6vji//me
XXbrhYH/gC5POlWmYH9eFOv2MsRYrM3oOk+ptn49HdTsdhVjz/o1ZT6+QS0kH8Mw
Wls2ajwegQp/ZZPIB45dm1IdMER0wpIs3IEeSym6W+HlqpWUuSh/jwWpcrkd2Hap
w9Uh9NuAE3joc9+1h9JSSuBVp3OyCm5adrLIcugP9ZF+R0hU0CVQ2W8zNE9QrK08
P8PeMNFSsIflXdIq1g7O6C3GJB8MB2qY3WMoIuyLJ6Q9mBMpBm1ZxaTxJKvkdj2c
NEFvQG+PPjSmdlXjylIGCtwfDUShGGJ/iRnOSBFX4CZ/AykE5quKJU9heH/jvAnR
FXy+h9Q4HquxHY+4rrwg2mnxTduC5Fed6durNQV4z6Ny52ffnpJlHWTxWaBBYEAn
WPrjB3w5UREFxp4stPejyN+nAfSzA+qTu8t4zJzwKmkx0CSF9aYD/vKIjXfZTvca
DTjgwcj/hq53smzbntgxb25TfcMlFgdpbH0Y3gyMGxEBFf/ANszI+WtnDvracPKz
sa0XujXgrfqlDTb2dtQ5pUWcgaQUHsFSDjq4o5ly22oetzboSU+62Ji6nk9j4BMR
NKKWulhhwLyNGJZ9q34KeIKZHO2xyNZnAy/62eUO92WM3GQ3v56e/KfS5kkq6lzQ
YgXKnNjQuXkwFTjyq+Q0
=57d/
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--


--===============7079180506282066074==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7079180506282066074==--
