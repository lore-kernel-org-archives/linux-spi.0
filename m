From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: spi: OF module autoloading is still broken (was: Re: m25p80:
 Commit "allow arbitrary OF matching for "jedec,spi-nor"" breaks module
 autoloading)
Date: Fri, 13 Nov 2015 22:12:28 +0000
Message-ID: <20151113221228.GT12392@sirena.org.uk>
References: <56104E88.3040807@gmail.com>
 <20151112185926.GC8456@google.com>
 <20151113194031.GI8456@google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZNotpC0yWfjHZxBL"
Cc: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>,
	linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20151113194031.GI8456-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--ZNotpC0yWfjHZxBL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 13, 2015 at 11:40:31AM -0800, Brian Norris wrote:

> (Changing subject line, because apparently some people ignore mail if it
> doesn't have 'SPI' in the subject line)

Well, if you mean me I'm getting CCed on such a large number of large
threads about MTD patches that only have relevance to SPI in that
they're for a driver that uses SPI that I pretty delete a very large
proportion of mail that looks like it's about MTD patch unread I'm
afraid.  It's almost all completely irrelevant and uninteresting to me.

> > Is this [1] getting fixed in SPI any time soon? Looks like there was
> > some progress [2], but AFAICT it's not completed.

Please include human readable descriptions of things like commits IDs
and issues being discussed in e-mail in your mails, this makes them much
easier for humans to read especially when they have no internet access.
I do frequently catch up on my mail on flights or while otherwise
travelling so this is even more pressing for me than just being about
making things a bit easier to read.

> > I'd just like to know what the way forward here should be for m25p80.
> > Really, "jedec,spi-nor" never autoloaded modules very reliably because
> > of the SPI core constaints. So I'm not sure I'd consider this a
> > regression, and I might be OK waiting around if it'll be fixed in a
> > reasonable time frame.

Someone will need to tell me what the actual problem is for m25p80
before I can understand what the way forward might be.  From a brief
scan through of the thread it looks like if Javier's series solves the
problem it needs a bit more analysis and/or a clearer presentation and
probably a resubmit.

--ZNotpC0yWfjHZxBL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWRmBMAAoJECTWi3JdVIfQOToH/29eMcGoWfQvUycC8pIA5jgG
Cgla/RW3QTCWfenJ9POx39Srp09zGj+ic1ftrf8xrazV9fcUcwXtST2aU3EnMauC
FQOCwwSVTpDQwnc4qJ7rZfsRkovJqmKNRmITEcHJbcng9RK6PacpgsENKSC/Iw/u
PQQRD2sSc66joqiyus8pT5RVY+qH3McSEVEt3XRUE+STnRJs6s/oJIwgEjs1/oW8
XosjNW0ukTpA9d59Vz1DeGkYoDJOAi46rqSMpG6G0CgvcSnV7iNFpGICQvZ778P1
VZ/xyeTXuYik5eJAKZZepUwm6nrE012Inisz8YBXyBbahf2GxtsNwXFsiiRevPk=
=W4xW
-----END PGP SIGNATURE-----

--ZNotpC0yWfjHZxBL--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
