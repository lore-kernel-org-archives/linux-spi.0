From: Mark Brown <broonie@kernel.org>
Subject: Re: [patch v2] spi: bcm63xx-hsspi: checking for ERR_PTR instead of
 NULL
Date: Mon, 9 Dec 2013 17:24:40 +0000
Message-ID: <20131209172440.GA29268@sirena.org.uk>
References: <CAOiHx=k87c_bFqFtJ7zJc9HxnjOEr2oMofNUsLkQbfQPrC04hQ@mail.gmail.com>
 <20131206141212.GA956@elgon.mountain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bEH3Ad9qdU9b/Xs9"
Cc: Jonas Gorski <jogo@openwrt.org>, linux-spi@vger.kernel.org,
	kernel-janitors@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20131206141212.GA956@elgon.mountain>
Sender: kernel-janitors-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--bEH3Ad9qdU9b/Xs9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 06, 2013 at 05:12:13PM +0300, Dan Carpenter wrote:
> devm_request_and_ioremap() returns NULL on error, it doesn't return an
> ERR_PTR().  This patch fixes it by switching to devm_ioremap_resource()
> which is the prefered function anyway.

Applied, thanks.

--bEH3Ad9qdU9b/Xs9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSpfzVAAoJELSic+t+oim9gIsP+gLyT6X6TDxQckQmjZVi7Pl4
CtZMoXUp0deg9RIUxUjXoaAsi9ABAPb8yDCS4NFeIwb6j2KCTmcII5PFkYXvVPp9
RtL9P13gdkt3Aw2FWOhWeuPle2kCzCdXLuybE4uMGnY3DJfC+dZH93Q1qBgtS2YT
R8Qma4SIsbwBVTctHU3m5askm1Rvlp/7KfAZlFLr8eMiRU6L78w83ealSLNt3YKt
rozTJ7BOp2VUVywYyPEFbHk0YrWHclpLnVFI5wSQN9fvfg6LVIy1b8315WUpe+H/
A2pAlYagHIZ4yigYJm5SU7G7bKAunpvgUfYyENv4yexcpXpotJaNOBdgEX5SrI3A
+xR8ErTPgRggDRpoAbgmrbMDK1ap3MWkBZ3q/YnAFFBOc4NMct+Ewii/lvwS7LER
hMySqXzHb4gGe988SqKmZ2SaPZHEabFIn/0iEihJ5fRAQOM+LBahr69HrS3Gv6Xu
1sDxFAfMX/ThdOPmIOq46C9BzK2AHkqaoDdvGwMmLdswH/xMgEypbJnCK7gTAqso
2grrgBQ2+D90sVAzQUagfrilXbVE1me1RznDbqGwOMNL/KISIgP+stqRN1HH2qyN
J7j963evNcJrETEYmCUrIpMu0TKX3Mj3rvtF35AkAdNECV3Bukbz6kMvBaoniwBp
5dtDHE7bs3mdXnVSFXdD
=Hoi0
-----END PGP SIGNATURE-----

--bEH3Ad9qdU9b/Xs9--
