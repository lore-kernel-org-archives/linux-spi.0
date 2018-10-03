From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: slave: Fix missing break in switch
Date: Wed, 3 Oct 2018 16:01:11 +0100
Message-ID: <20181003150111.GD7132@sirena.org.uk>
References: <20181003123328.GA29471@embeddedor.com>
 <CAMuHMdX2YL2PG390ej0WMct7DciAbzO=66z7TJ-VnS8_phjdaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="at6+YcpfzWZg/htY"
Cc: gustavo@embeddedor.com, linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdX2YL2PG390ej0WMct7DciAbzO=66z7TJ-VnS8_phjdaQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--at6+YcpfzWZg/htY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 03, 2018 at 04:46:45PM +0200, Geert Uytterhoeven wrote:
> On Wed, Oct 3, 2018 at 2:57 PM Gustavo A. R. Silva

> >         case CMD_REBOOT:
> >                 dev_info(&priv->spi->dev, "Rebooting system...\n");
> >                 kernel_restart(NULL);
> > +               break;

> Alternatively, kernel_restart() and friends could be marked __noreturn.

Yes, that seems more sensible though there's no harm in this patch even
with that.  It'd definitely avoid other issues in future.

--at6+YcpfzWZg/htY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlu02bcACgkQJNaLcl1U
h9CQ4Qf/UT41AauCZW2vahDh97EFbG6pfv9sqsby6e9VcHHAXooKhBXW0Eg891ob
qfa19xiKfDuFeWvTKWToTERdNKMIO9IHkBBpxKsjqNYSk+wos9qPIo2+/w7PHTNZ
Xs5DlCa+IPUE2IMVNZGkLnEVzUvENgL5BviES4f06JBNIJKiKuvS5A/I33eKABT/
6EOd989RQ8l1rDIvhJPvES5L3+r3aJicu/T/SJ647cuvY9i6EEXF7R7nixr1bT8F
JhKw3PjT5zWBOlhRzGabtKAC5aQVHqa34NYI6AmrKPVd69gCkyz5AqzKJ2P9J47E
XBdeMWbs4lyAtD1APyImZY520WpPqA==
=g23z
-----END PGP SIGNATURE-----

--at6+YcpfzWZg/htY--
