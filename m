From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 5/5] spi: ti-qspi: cleanup wait_for_completion return
 handling
Date: Mon, 2 Feb 2015 12:16:01 +0000
Message-ID: <20150202121601.GP21293@sirena.org.uk>
References: <1422865837-10357-1-git-send-email-hofrat@osadl.org>
 <1422865837-10357-5-git-send-email-hofrat@osadl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mQZYU1XZRcIUQ9HK"
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: Nicholas Mc Guire <hofrat@osadl.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1422865837-10357-5-git-send-email-hofrat@osadl.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--mQZYU1XZRcIUQ9HK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 02, 2015 at 03:30:36AM -0500, Nicholas Mc Guire wrote:

> -		ret = wait_for_completion_timeout(&qspi->transfer_complete,
> -						  QSPI_COMPLETION_TIMEOUT);
> -		if (ret == 0) {
> +		if (!wait_for_completion_timeout(&qspi->transfer_complete,
> +		    QSPI_COMPLETION_TIMEOUT)) {

Same indentation issue as with the earlier patch here.  I also just
noticed that you're not CCing driver maintainers, please try to do that
so they get a chance to review things.

--mQZYU1XZRcIUQ9HK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUz2qAAAoJECTWi3JdVIfQoloH/0CCLtprOWLQwM1AzJuEn4by
Cak1k+Y60sYyWsP9vVTN8KXTZa8AipC5dcAXLi6SFj5E/qcBsllL56628NyoETgw
nURPVoXPFGIiq0uRvP/ke1rfAurOI3FFAQ/7pyuaiFHnTKWsQNpXSFQf7znDA68q
IHuipc+lWimN+E0Ta8CM0NL/xoAZ25X35wDfttxyGSmj9/JrEiVPFU9CkUck+urn
TG0/MjQWWDVe++gF2nuMZrE2JnLse16IjkBJuTLOKobZRHO+nAUkOjxXH7Dz03a1
53l4Dqs94EpOLXuC/J4UJAMQwws8fvfn8sotA9kMH0U0Azfid8PP3wszM4isHX0=
=3ZpS
-----END PGP SIGNATURE-----

--mQZYU1XZRcIUQ9HK--
