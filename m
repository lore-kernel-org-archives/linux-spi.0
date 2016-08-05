From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v5 1/8] Documentation: dt: spi: Add BRCMSTB SoC bindings
Date: Fri, 5 Aug 2016 12:03:36 +0100
Message-ID: <20160805110336.GR10383@sirena.org.uk>
References: <1469830393-13295-1-git-send-email-kdasu.kdev@gmail.com>
 <1469830393-13295-2-git-send-email-kdasu.kdev@gmail.com>
 <20160804210634.GM10383@sirena.org.uk>
 <1fddf72d-cbc1-225f-b482-d6ba99dab823@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6tPipYVl+OcoAvSh"
Cc: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, vigneshr-l0cyMroinI0@public.gmane.org,
	bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, vikram.prakash-dY08KVG/lbpWk0Htik3J/w@public.gmane.org,
	andy.fung-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, jon.mason-dY08KVG/lbpWk0Htik3J/w@public.gmane.org,
	jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org
To: Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1fddf72d-cbc1-225f-b482-d6ba99dab823-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--6tPipYVl+OcoAvSh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 04, 2016 at 03:20:17PM -0700, Florian Fainelli wrote:

> What's wrong with the subjects being used here? It's not like there is a
> consistent subject for DT bindings, is spi/dt what you would expect here?

As a quick look at the git log for the SPI DT bindings should show you
I'm looking for something in the same style as the drivers which at
least starts with "spi".  A *vanishingly* small number of them start
with Documentation which ought to be a bit of a warning sign.

> Can we save Kamal another round of patches and provide feedback on the
> patch contents (as well as their form)?

I will look at them when I have time, this is the result of the triage
where I work out if the patches are in some way relevant to me or I can
just delete them.  Please don't chase me for faster review unless
there's some strong reason, it tends to result in slower review.

--6tPipYVl+OcoAvSh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXpHKHAAoJECTWi3JdVIfQTGAH/1ExBIy6bB/aJ0cyh0PQRkTM
9wS+PFsDquTSGFePK/Uf9UXBqSS1aq51c/X07LJdVWYsbSZgp4eYMhrWAcJs9KRT
HX0Bu5mZPxW72wK6bIODPjQvlhHsoIjJmjwGdnO4pbZ2NYxqKQWGPHys7ISfjD1L
IUgS1rQ3M162DGHIcfVMhOC0IE06Tq6xIUqPzUMom8mWKC68U5m+ApvIrhWAhVjV
y4b5Cz2V5q6+GSZulI26/5tRGAzDF8nVNP2L9x3DuYD2AZCH9YYAy7blu7jiSaJ2
KoQK0B70c4fRpWqhyUxKtKSy/+1qAbtKEiLMyXKZi8HXMLhJM7NShWLmUI69p7Y=
=4De1
-----END PGP SIGNATURE-----

--6tPipYVl+OcoAvSh--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
