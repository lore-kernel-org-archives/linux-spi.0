From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: sirf: fix the issue while transferring more than
 256 words
Date: Fri, 17 May 2013 12:03:30 +0100
Message-ID: <20130517110330.GJ1627@sirena.org.uk>
References: <1363592828-6347-1-git-send-email-Barry.Song@csr.com>
 <CAGsJ_4wamqzwLZkUz4h6ex=oVQZhzhw7S6r41wt9tTUoMR=aXw@mail.gmail.com>
 <20130516172358.GA1627@sirena.org.uk>
 <CAGsJ_4z9=2RYkwntnCD4X-JVsZoYEgzwdWO_uryp3RpbEHu7fA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4295352428486731395=="
Cc: Qipan Li <Qipan.Li@csr.com>, workgroup.linux@csr.com,
 Zhiwu Song <Zhiwu.Song@csr.com>, grant.likely@secretlab.ca,
 Barry Song <Baohua.Song@csr.com>, spi-devel-general@lists.sourceforge.net,
 linux-arm-kernel@lists.infradead.org
To: Barry Song <21cnbao@gmail.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAGsJ_4z9=2RYkwntnCD4X-JVsZoYEgzwdWO_uryp3RpbEHu7fA@mail.gmail.com>
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


--===============4295352428486731395==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UlxN1C6awaFNesUv"
Content-Disposition: inline


--UlxN1C6awaFNesUv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 17, 2013 at 09:58:24AM +0800, Barry Song wrote:
> 2013/5/17 Mark Brown <broonie@kernel.org>:

> > Don't top post, don't send contentless pings.  At a guess you didn't CC
> > me...

> yes. i missed you in CC. sorry for that, Mark. so do you want me to resend it?

Yes, please.

--UlxN1C6awaFNesUv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRlg5/AAoJELSic+t+oim9zgMP/0FFsgPJAK/48ZYKrXfIXzy5
ez/Y/mqfz1tV0LROA1jE+p9TbtzSVtYLWZCigNulMCrZpyaKIQq2WQLLny+C4oGd
Dw7AdKCCA4A2esgQ9SDDzb0eJMtWfySNT9ai2XqV3t8ZzWAxDb9LwUcPPXRsEyO9
jUv7SeYQlv8yveEKhxDM91wQrtyfJGVdLAPERjnI4WM7BPJx+CsG7fONZrUrGD9U
tk3WOFoDwGpN4m09jY/Ycss9o6UVTv8akL3zsRi+Ku9PqpPeEjL2ub/L4iCa4Lck
9msN2r+CyHyUSo/XIJw2r4tIxcUt6M21MnjXjUYH1mNIqeoFacXKCtuFuJmT+AcP
ZWcCJlL02Z0Chp+rthlYHhuaFWchH10kCLqZpR5tnieht+1U3cbHvfLHr0orkpmD
BrinvcmBWQQFhQpGZqMVBssYbLr1/VUv2TxmlYvSrtLKnAIBGmGO9yWORr0gztNT
TbzntNJQuWziBcX7gyMx+7y4hagv9QF7+bFrBi7eQttp7soBgpu7GDyx9+KAYH4P
u3tf6f+tL05RhfvRB0RF88qIlFeVRXaEkLXtnSRRZIzGkUv3LbQf6sS4UJAbdTEg
4e0kete2EtWDT739R60y4c+BkuPPZLkw2WC53EgQHcseB6imFIN/fJRy+Jqw1Rss
JkgUsfIyzhhcMF/k4IE8
=Yiok
-----END PGP SIGNATURE-----

--UlxN1C6awaFNesUv--


--===============4295352428486731395==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4295352428486731395==--
