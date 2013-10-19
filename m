From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V4] spi: s3c64xx: Enable Word transfer
Date: Sat, 19 Oct 2013 17:25:04 +0100
Message-ID: <20131019162504.GA1863@sirena.org.uk>
References: <1382074356-28430-1-git-send-email-rajeshwari.s@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Cc: linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, alim.akhtar-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, dianders-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org,
	t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
To: Rajeshwari S Shinde <rajeshwari.s-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1382074356-28430-1-git-send-email-rajeshwari.s-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2013 at 11:02:36AM +0530, Rajeshwari S Shinde wrote:
> This patch enables word transfer for s3c64xx spi driver.
> User can set bits_per_word to 32 or 16 or 8, before calling
> spi_setup, which would enable the corresponding transfer mode.

> Change-Id: Ib04f9851a3ea891d2bfa527f2100acd314fe1c98

Please don't include stuff like this in upstrem submissions, it's of no
use to anyone outside your organisation. =20

This patch is still not setting bits_per_word_mask as far as I can see?

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSYrJdAAoJELSic+t+oim9QTAP/RrAQ63m7g23Z+lSkUXZCCX6
1Hi/6gubepev92ECT97jcsD11/WTKAc/mpiUHVowHha+qunaM55ciqawOam/04vL
64TtVtP0H0crfFSn8yl9XAisBWjcPMR1eaor6DYn41XmPUGUySc0HNcGtmqxS9J5
pT582dAyvjpXTfUmmnz1ghjhuSc1iWdYJ/jWX5k97/s+ax19LUBLTOB0evY5+cFQ
NEsl3QGngHtJ7VBjvvSzxwt2o+RcCYf6m3Uiq2qhfO/uzrfWmAt150+IMahIKOgA
w/ZdfdsHqLqv0mThv7d+0dygWwQ5+UJEeYDXTJfdLlaozPhIUfH9VmQA39nlGdXv
H4voF6R9SSBG1JBSgZTOG3CWswwFE8ud6pCERKl/Ehw81u2OgKUOZNLEoZ+bgW6j
coiCXhz6Kit0ci+9seqf2IOf5B160XEtaXpJ6Pe8Mi42K2FFQWmVgMGpR2EWwez1
e8UHKc2HNNhH6oPzPnwJdyiVKbVL6QQq2VDvGNAziE2ysY9TqrEPfiNINq5Ob08d
yFBoTW5VxWjewLrwE30o+5kbQWrknCsQif85YxKo86b3By+kns4d9HGC0H8mBf6H
nCGqCetUzE1Fm/7d72zxjoN0tQJZSjCpW/6HB8AXT09vGPY3c8CGsvFrDrQ99/AE
5AXzftnkBFzzEKdIVEmA
=YEF3
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
