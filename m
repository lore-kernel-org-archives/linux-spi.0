From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] spi: orion.c: Add direct access mode
Date: Tue, 29 Mar 2016 14:28:42 -0700
Message-ID: <20160329212842.GN2350@sirena.org.uk>
References: <1458663893-13766-1-git-send-email-sr@denx.de>
 <7339827.UeYZLZET5g@wuerfel>
 <20160329210018.GL2350@sirena.org.uk>
 <3108005.nUMWsj4kjp@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="80d3ujMCT5hHQAFF"
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>,
	Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3108005.nUMWsj4kjp@wuerfel>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--80d3ujMCT5hHQAFF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 29, 2016 at 11:08:55PM +0200, Arnd Bergmann wrote:
> On Tuesday 29 March 2016 14:00:18 Mark Brown wrote:

> > Implementing that would require the SPI core to export something
> > providing access to the memory regions.  We don't currently do that,
> > it'd require us to deal with the interaction with access as a SPI device
> > (this hardware often seems to only accelerate reads so we still need to
> > use regular SPI access for writes).

> The manual lists both read and write accesses as handled through
> direct mode.

That is not in general the case for this sort of hardware, and there's
also erase support to consider here.

> > I don't like having to assign windows per device, like I say it seems
> > like more work.

> Ok, but that's something else that can be implemented independently
> as I explained earlier: We currently rely on the windows to be assigned
> in the DT, but it's also possible to extend the mbus driver in a way
> that lets it pick its own windows in one way or another. It should

That's what I've been asking for but people keep saying it's not
possible...

> not impact the binding for the SPI host controller in any way, the
> binding just describes how the internal addressing is wired up to
> the mbus in hardware, and the mbus driver takes care of mapping those
> into CPU addresses.

If we're able to do it automatically without baking this into the DT and
there's enough space to cope with this and PCI together then that's more
reasonable.

--80d3ujMCT5hHQAFF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW+vOIAAoJECTWi3JdVIfQp50H/Riyw6IaK8CWvZCYn3EX7ThK
TMoVjJyLF6wQnzt+Wh101I+IAM4QaOZDtSG0E0qIPtSR6+nKOPg2YWhAd2HOW8+N
ZLqZuvHc+5SeW+1UKsBYPjT5zYwFY8IbjZku3aQJwonpOS0wOy4sSLe8Ei+vb6e8
xMOPEbagvnK/SNKJa2OB73jQDkSxjQpj5cQu28ID6L81qHz0eE/Y+z4bMZxVAfrs
g/YiulQbAF3+45iy+HLKgWwsbzKAQRxExiWibmPB4wxNg8vQUs9umdGiUd4y0q3Y
8Be3DvyL3VWSza/4T+Zqnv5CX52skgXr6ziXz86upFhYkN1b+DjeYkEI0RB1pwI=
=DFuk
-----END PGP SIGNATURE-----

--80d3ujMCT5hHQAFF--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
