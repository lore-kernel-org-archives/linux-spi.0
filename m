From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: fsl-spi: Allow dynamic allocation of CPM1
 parameter RAM
Date: Fri, 3 Oct 2014 15:44:20 +0100
Message-ID: <20141003144420.GC24441@sirena.org.uk>
References: <20141003125609.5BEA11AB276@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ghzN8eJ9Qlbqn3iT"
Cc: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>,
	Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>,
	Marcelo Tosatti <marcelo-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org>,
	Vitaly Bordug <vitb-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Joakim Tjernlund <joakim.tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>,
	scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org
To: Christophe Leroy <christophe.leroy-GgN8y9CXRhA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141003125609.5BEA11AB276-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--ghzN8eJ9Qlbqn3iT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 03, 2014 at 02:56:09PM +0200, Christophe Leroy wrote:

> +config CPM1_RELOCSPI
> +	bool "Dynamic SPI relocation"
> +	default n
> +	help
> +	  On recent MPC8xx (at least MPC866 and MPC885) SPI can be relocated
> +	  without micropatch. This activates relocation to a dynamically
> +	  allocated area in the CPM Dual port RAM.
> +	  When combined with SPI relocation patch (for older MPC8xx) it avoids
> +	  the "loss" of additional Dual port RAM space just above the patch,
> +	  which might be needed for example when using the CPM QMC.

Something like this shouldn't be a compile time option.  Either it
should be unconditional or it should be triggered in some system
specific manner (from DT, from knowing about other users or similar).

--ghzN8eJ9Qlbqn3iT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJULrZDAAoJECTWi3JdVIfQbywH/0vlIbyDtXeXSo8Qg0xKxfu+
NmGzbVSizdDFhjhq8+LRSFjKdl6u8cXF+Vuyt+hGXsvAc1c6Vc2XNSWO0eXbq+kg
soGV9Y9UfLx4smuhdcuWqri1qZOJG2k7058AzSZwDWfEwTQ88Sb47cGHv8L69jhn
s7TR2SMnMZ+Gk4JWiZ/lETGbVYspRnKSAnKtu4ubsPRG34wJnhQvc9V9WhGynlKu
hhA/5II3+8grWKmEdWTK/mTQBMoikxJxElN8FPQnogoApnJONM6fsmLH/1O4979K
o/3DAS80NGnPDC23k65b+iOHg2EIXnzfFSYdHXaSUAiWvN5Rjg4hrxyC1IBgxpw=
=cnSl
-----END PGP SIGNATURE-----

--ghzN8eJ9Qlbqn3iT--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
