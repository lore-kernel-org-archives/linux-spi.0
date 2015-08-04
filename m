From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: spi-pxa2xx: Remove unused legacy PXA DMA API
 channel numbers
Date: Tue, 4 Aug 2015 10:50:15 +0100
Message-ID: <20150804095015.GG20873@sirena.org.uk>
References: <1438598472-1145-1-git-send-email-jarkko.nikula@linux.intel.com>
 <20150803161413.GY20873@sirena.org.uk>
 <55C05392.80905@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jHP/eq8oeUshSv2p"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>
To: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <55C05392.80905-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--jHP/eq8oeUshSv2p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 04, 2015 at 08:54:26AM +0300, Jarkko Nikula wrote:
> On 08/03/2015 07:14 PM, Mark Brown wrote:

> >This doesn't apply against current code, please check and resend.

> Hmm... I'm confused, both patches were done on top of commit 34cadd9c1bcb
> ("spi: pxa2xx: Add support for Intel Sunrisepoint") in spi/topic/pxa2xx and
> I see this patch 1/2 applied there and merged into for-next now. Anyway,
> patch 2/2 should still apply fine.

It didn't apply when I tried it yesterday.

--jHP/eq8oeUshSv2p
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVwIrWAAoJECTWi3JdVIfQWKIH/1hztMEOwO2igmzpcutnyjSM
D689TmxMRRnZzL4uv4HXlAjG70LHUGq8mVj9b7b1pTWB0hvRYMzISikIKvYZsvXZ
jRC83NpSZWHEN/qEYn1UQuViHUqvhxP7fgGQ/UQZ7D0Kgdk+id8jWTFuf/HBXt9t
zBTwH2WxjKO9BW4Vcs8ug8Ims27GAZ4/LvjDGumxaARo7m/nhzAEYWlbH8WhMAA8
BpjrhRIR83M3/T/sbK0X8Jhu4Gp+M4WuLRGVUiEYhi2n2wI/GygVDY3OHkHSUmyf
CDlAXQV1lTZ++bseZ445Fxak/sqPi+dVl6EDJvmV8ukkvhJtiUkXogJVHCK7Y3k=
=6V5q
-----END PGP SIGNATURE-----

--jHP/eq8oeUshSv2p--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
