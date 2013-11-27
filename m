From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] spi: rcar: Fix uninitialized variable warning
Date: Wed, 27 Nov 2013 16:31:59 +0000
Message-ID: <20131127163159.GG14725@sirena.org.uk>
References: <1385512906-13108-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="D5hdKamO53XmQjsc"
Cc: linux-sh@vger.kernel.org, linux-spi@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1385512906-13108-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--D5hdKamO53XmQjsc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 27, 2013 at 01:41:44AM +0100, Laurent Pinchart wrote:
> The transfer data length variable is set based on the desired access
> size, without a default case. This results in a compiler warning, even
> though the access size is always set to a supported value. Create a
> default case to silence the warning.

Applied all, thanks.

--D5hdKamO53XmQjsc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSlh58AAoJELSic+t+oim90z8P/10fVcWIERKDhEgfrRcaTAqW
IwpwSqY/A2bW36fB77i63rUiiQZDJ2haxtQuWbWGivkufHg3C2ACaUeBJIelCV9T
velhw8jF3MWA8NaahFzdTpLDg/slBfZedXlsiGb2TTeltR9xbxsZ9TGAB9cZ/Z2+
Gv+ggiryqeyc4Nkn6G3Ez74Aqu5YOutaTJIuptd3eyWnliJNsWjpTA0SDEfTHguH
m+oI2/mVUS+SZlep6aVtTMw3sR/MDKwUWjw0bDLn5ToiBEYJhpDsvvlFRDJ+8fww
Ceh45yetT0jhN97aCrlShOrTi2NGAVMekdKSAPqUA6ictX2J/9AAX2lJr3QFCBdV
PKLK4omNgxKBGyHfMLCqAFaVWNRhKxRK61Of6uErpxNlZ2Wf5YqxgTDsx7aVtMPN
JtRpsjmxEIDkfJJHg8s63uJhoPHUfcOrNxFe3am/6RgOfza04AO1iArhJ2vpQvP0
QrTK2jr4MjXsCn2HBX1vncLmcs/rKI89X7ESoI870hnnWUq2zsk1XlCqOINRpS1q
B07ZPjxB/ps5wjPQRV4jsMGYpJSW/bSs8+z55eiHc/8tY9DH8QKWzarKpLOE4B+F
i+emDKc/JTxJCGYTIeQslCCW1EtXHQv/aH8bBFKjRdC/wEpeOn+EPZ2uRQkuhpSP
lxmEwItnrPwKLR8Trc7l
=xwn9
-----END PGP SIGNATURE-----

--D5hdKamO53XmQjsc--
