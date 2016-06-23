From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH, V4, 2/5] spi: bcm-qspi: Add SPI flash and MSPI driver
Date: Thu, 23 Jun 2016 10:27:07 +0100
Message-ID: <20160623092707.GT28202@sirena.org.uk>
References: <1466197433-11290-1-git-send-email-kdasu.kdev@gmail.com>
 <1466197433-11290-2-git-send-email-kdasu.kdev@gmail.com>
 <20160622160726.GQ28202@sirena.org.uk>
 <576AC71C.9090202@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CMEQapY8OuP5ao1l"
Cc: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, vikram.prakash-dY08KVG/lbpWk0Htik3J/w@public.gmane.org,
	andy.fung-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, jon.mason-dY08KVG/lbpWk0Htik3J/w@public.gmane.org,
	Yendapally Reddy Dhananjaya Reddy
	<yendapally.reddy-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
To: Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <576AC71C.9090202-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--CMEQapY8OuP5ao1l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 22, 2016 at 10:13:00AM -0700, Florian Fainelli wrote:
> On 06/22/2016 09:07 AM, Mark Brown wrote:

> > Just put this in the DT like we do for other MIPS IPs.

> As in, putting a native-endian property for this node, right?

Right, and then parsing that.

--CMEQapY8OuP5ao1l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXa6tqAAoJECTWi3JdVIfQFPEIAIHT5s07pfAgG4J5k4r+XCgJ
707noaPvLhO/CWLkLyRbh27a+laxf/T9MsMOxVQea7KXKVWrgyzgc6ixRlOPtmdz
U83jTRMtLKUVHbaEPtgtmZsOJu0JLXD2Ct5/aL4TEyQTKQZGSa0XZp1Z//m+um1x
iGV4elrzOT17ABTjHAO3/p+w7o33Ko9/+9QbN8ZenKqv2FsflK96/QmgBkwK2J3v
rdytBnAg+GyWPLtQabbj9lqgTH6cAbx9XEuhHFICgH6mwzg8TUGmZq+lNj/kV0k5
3PFTepJDkaRyf3PWq6NJl3NvYRQDKtTKaHdlT1fldzs5TtYwrUfrUG9gQEgM64M=
=RaQr
-----END PGP SIGNATURE-----

--CMEQapY8OuP5ao1l--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
