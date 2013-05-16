From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: coldfire-qspi: fix error return code in
 mcfqspi_probe()
Date: Thu, 16 May 2013 19:22:11 +0100
Message-ID: <20130516182211.GH1627@sirena.org.uk>
References: <CAPgLHd93xOKX3ot+RUP5FXM_Nz6xZD-ODU_=ZEebBEJm=OM76g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PW0Eas8rCkcu1VkF"
Cc: grant.likely@linaro.org, yongjun_wei@trendmicro.com.cn,
	spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPgLHd93xOKX3ot+RUP5FXM_Nz6xZD-ODU_=ZEebBEJm=OM76g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--PW0Eas8rCkcu1VkF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2013 at 01:11:32PM +0800, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>=20
> If pdev->dev.platform_data is not set, mcfqspi_probe() will return 0
> and release all the resources, in this case, we should return a error
> code instead of 0.

Applied, thanks.

--PW0Eas8rCkcu1VkF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRlSPQAAoJELSic+t+oim9fGsP/Rd7ghUlvuqvcr2NLx/QXIab
631Qg5+zkCD40lehZEG9SZCsooTm5ca0FcuLa9yP8j4fzkGAnvLAvZ426I70W9oj
CLYnB/NvzGt3EGuPCA9L5T7tAIM+aAuSQTWJ8skQ5XlbZOVvMpeeWTemng1VjcjW
QN4OJ/t+JMZpPHZfIByqHLVAg4Ob1JZ03TbM79HgqFK/118unEEMN8FCAOjHDnBS
bzjHN1fMtmz83OPzsew60Jm/+tjKda1GsIrxS+kiRbVQuCiIf/2RPzrSX4a+VIfQ
R3oSDpHOR/4TCKFqT/OvYHvPwiXoCbN6R3KQtNr/JzwyP04+T5HStMuxNyAY+SX9
qmAtBKjO9ABqpyYghMgpH3rXF5Vdy6KCISttkx2bRMyBhvZVpBdqD+GMcWLJNmFK
cadSYPNuM+ir5sBxqLjHRWFTr42N9r7U8uICGcSHhnMBaUtVRua/puBUZVRXqbND
nyFNFAcy8LMHRpKImWVQt4nMehHSxTICeW3hKQ2oWHJlfQ29BB8Se19CK3be6v15
P5myQIVlnXSa6CAu1oySuYjz7dvO3Jte/YvYXrGfTa3cDhhXCrsgnpV9NYC0GTil
XH920pjueTjbAbVSmBHxogwcrYFF601Q8NYpNzZmiJcSlEl2v5AbWg1yRhaCRCpp
2HnhSAVI+r7jeD4QcIZD
=mSnn
-----END PGP SIGNATURE-----

--PW0Eas8rCkcu1VkF--
