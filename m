From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 17/28] spi: fsl-espi: avoid processing uninitalized data
 on error
Date: Tue, 25 Oct 2016 20:13:09 +0100
Message-ID: <20161025191309.GX17252@sirena.org.uk>
References: <20161017220342.1627073-1-arnd@arndb.de>
 <f364c025-91c0-6625-e2a3-d00baf17d71c@gmail.com>
 <20161024184543.GR17252@sirena.org.uk>
 <3945489.MQiL9ES5FK@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sBvc846/5FzkyDmz"
Cc: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Heiner Kallweit <heiner.kallweit-S0/GAf8tV78@public.gmane.org>,
        Nobuteru Hayashi <hayashi.nbb-MBed0sS7vigTBYAz+LHnZg@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3945489.MQiL9ES5FK@wuerfel>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--sBvc846/5FzkyDmz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 24, 2016 at 10:37:53PM +0200, Arnd Bergmann wrote:

> I think my patch (the version I sent) should ideally make it into
> v4.9 as a bugfix. This was the powerpc warning I saw from Olof's
> autobuilder with the -Wmaybe-uninitialized warning added back, and
> it's one of the actual bugs I found (though rather unlikely
> to hit in practice).

> Merging with Heiner's patches should be trivial, and I'm pretty
> sure we want the patch either way. Not sure if we need a backport,
> it was introduced earlier this year in commit 6319a68011b8
> ("spi/fsl-espi: avoid infinite loops on fsl_espi_cpu_irq()") as
> I now found.

Sorry but I've lost track of which patches are being talked about here.
If there's stuff for v4.9 can you send me a version that applies on
Linus' tree and I'll merge that up into what's applied for -next?

--sBvc846/5FzkyDmz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJYD67EAAoJECTWi3JdVIfQ6VYH/2hdtTJ/cQ2LM0lpb3yFiU1Q
FsyNeRw/7J9GnBuoFYChSY9IiRuEDRAqYhOj/m2+rlMAkgMvGSC52cSek7jzk4X+
/vdQA7x6mKIt/VLu9gWyJCnq6pU7yaa0H5BjXsT9TbZb6K3DmQkq4c1h1hVZkziy
quRCNO63MIHgf8ywKWHUBRd2xCWIcJbzyMJ08OCLy2EgPP6yb7EP4JDlSCyKpjZs
Jz873iox1ilrMf+fb+2JRqSHPH1Sz5y4ophqR7hNeX2lu/jE6RWAioRs+e4/1N/Y
bBAERZy5qjNO7+emb+AUry2IzMMpnYg0RNAUsWsCk5zzDcBXFlAbJGnCl9qx+z0=
=rxJr
-----END PGP SIGNATURE-----

--sBvc846/5FzkyDmz--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
