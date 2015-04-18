From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: fsl-espi: fix behaviour for full-duplex xfers
Date: Sat, 18 Apr 2015 13:55:56 +0100
Message-ID: <20150418125556.GR26185@sirena.org.uk>
References: <1429111398-21444-1-git-send-email-jonatas.rech@datacom.ind.br>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OrT4iOlIQZp3kw4S"
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: Jonatas Rech <jonatas.rech@datacom.ind.br>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1429111398-21444-1-git-send-email-jonatas.rech@datacom.ind.br>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--OrT4iOlIQZp3kw4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 15, 2015 at 12:23:18PM -0300, Jonatas Rech wrote:

> Furthermore, this correction has exposed an inconsistency in the
> protocol driver <-> controller driver interaction. The spi-fsl-espi
> driver artificially inserts TX bytes when message fragmentation is
> necessary (due to SPCOM_TRANLEN_MAX) instead of informing the
> protocol driver of the hardware limitation. This was tested with the
> m25p80 NOR flash protocol driver. Since fixing this issue may cause
> other client drivers to malfunction, it was left as is.

Sorry, you're saying that the driver is sending more data than it's
being asked to in some situations?  That is a *very* serious bug in both
this driver and any other driver which relies on (as opposed to merely
tolerates) this behaviour.  If that is the case it really needs to be
fixed fairly urgently.

--OrT4iOlIQZp3kw4S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVMlRbAAoJECTWi3JdVIfQFE8H/iEQbgW4EJrgWv4pgYC3jQzs
erydLJdZHbJErbdef9YEeIPrmYC1CBKuiRYuk89LTbScvnrBDAfijEHMYGjRJdLg
BrIE48uvfHEHlDIUEatfxsyQOqLwfmzbAIZryantWzFa8/BsTP349q+d2HtXH3JU
ERcLjnlqaRStc6K+7XL3Dc1N2R1qy6jukZ8Qfh71pj+kwFQX4W/q2MpuToHLfwhk
IfkFkySM4oiZxClvrK86TGEU9GwKELN2gYwNsBRz95fFuC8Ec3yOdXwtVF3GBWnW
s9K03SYxbTGoEaaZCi3KWz28gJEL/HrbNY5UBiaU501Qr1/0rxRkZUcrRnYjyMc=
=9zud
-----END PGP SIGNATURE-----

--OrT4iOlIQZp3kw4S--
