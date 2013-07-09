From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] spi: convert drivers to use bits_per_word_mask
Date: Tue, 9 Jul 2013 22:49:10 +0100
Message-ID: <20130709214910.GA3179@sirena.org.uk>
References: <1369190195-14598-1-git-send-email-swarren@wwwdotorg.org>
 <1369190195-14598-2-git-send-email-swarren@wwwdotorg.org>
 <51DC3078.5090602@monstr.eu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3MwIy2ne0vdjdPXF"
Cc: Stephen Warren <swarren@wwwdotorg.org>,
	Grant Likely <grant.likely@linaro.org>,
	spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org,
	Mike Frysinger <vapier@gentoo.org>
To: Michal Simek <monstr@monstr.eu>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <51DC3078.5090602@monstr.eu>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 09, 2013 at 05:47:04PM +0200, Michal Simek wrote:

> Probably the best solution is just revert this part of patch.
> Mark: What do you think?

We should make it so that the user does not need to supply empty
functions if none are needed.

--3MwIy2ne0vdjdPXF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR3IVNAAoJELSic+t+oim9nBsQAIYo5DNkhCVhn6w07wS4uEhw
Cj2l3REMOwkhG/YLXKcbm6HCWC+ezwATCBS8qBJE5XmRAJg/YGWKW5Ge0flSlmJj
W8lKsxxpLKkAWnfmgGWKYZhMfwbL1ZsPABQYdEcfCkfNkFfm49eqDQZKlKIFpTrK
5pcNcDB+z/KILVTTyo01iZhfZPa/HtJ7N/GF5sNxI6b3IAxDsTi1Ri1XBzhjEsf9
T9F/m7HhPR3y/mN2sQVZmIm2IE844oPkiWUJfoLPl3COpgSXupPrud1MgdKZmKCh
H052aooI0T08gRoxsWGNobYw+fyKtR1fD6sajtDcFzCjY/0MKTl70j5E0pnF4Gi4
4C47O0KSNcPoj+xMAqJsFMo5h69LeqzUhqjlhrAW1bOGj5J7lY9xlK03JZ9wOwdY
dIMMfybS+Coe44VYNeJqehToqOlmNfMOJSrLPKfq/bfqt6Pb4f7wCymUmbDSkP1E
6LMEWslW9l2ytX7E9vIHqk1OgKc01mfulYdg1miOXh+wsv6A5XzPKNFcqMEgODkS
lLxf4khHw0IMAXgSVt3/78NbOhDPaAfi5wg0CU7dk/05GPMrqsvPabR8Gx6NNUjl
ISrg7UAS8lO66Yzokc/lLr3c2dyYGYGnHyp9k4MicjnOwKGqCHfniig4uzKzazr/
zU4ygTItpHuvp73KCVZa
=E3yT
-----END PGP SIGNATURE-----

--3MwIy2ne0vdjdPXF--
