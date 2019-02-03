From: NeilBrown <neil@brown.name>
Subject: Re: [PATCH 1/9 v3] staging: spi: mt7621: Switch to SPDX identifier
Date: Mon, 04 Feb 2019 09:34:56 +1100
Message-ID: <87muncjyb3.fsf@notabene.neil.brown.name>
References: <20190201101715.3760-1-sr@denx.de>
 <20190201130355.GG20797@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1759132811536472613=="
Cc: devel@driverdev.osuosl.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-spi@vger.kernel.org, Sankalp Negi <sankalpnegi2310@gmail.com>,
 John Crispin <john@phrozen.org>
To: Mark Brown <broonie@kernel.org>, Stefan Roese <sr@denx.de>
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20190201130355.GG20797@sirena.org.uk>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
List-Id: linux-spi.vger.kernel.org

--===============1759132811536472613==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain

On Fri, Feb 01 2019, Mark Brown wrote:

> On Fri, Feb 01, 2019 at 11:17:07AM +0100, Stefan Roese wrote:
>
>> @@ -1,3 +1,4 @@
>> +// SPDX-License-Identifier: GPL-2.0
>>  /*
>>   * spi-mt7621.c -- MediaTek MT7621 SPI controller driver
>>   *
>
> Please convert the entire comment into a C++ comment so it looks more
> intentional.

Hi Mark,
 I don't understand what you mean by this, or possibly I do understand
 and strongly disagree.

 It is extremely common in the kernel for a file to start
   // SPDX-License-Identifier.....

 and to have that immediately followed by a comment lile:

 /*
  * .....
  * ....


 This patch makes this file match much of the rest of the kernel.  Why
 do you want something different?

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlxXbJAACgkQOeye3VZi
gbltCQ/9FgqVzUormjzJU2X7U0rCNYFWKxgx7qqYVBk4MU0+ULAoimhCTk7rPaIp
GQCHMiu5dCc6rMzdC1sn1SaW/ooJeSM8r8a/4evFWsiq0a4QGEaJA2F+REnvDQA8
FqBkk1oa+lM9HoVnpQCzFqo7VET5D9E1qkg2sXCEYTtrM4C/8uLO6C4jev/Vsi2e
8Xb/tlCRUW6uen75rbBeRdB96Torv7+cEo37L7cHdeGTgQIsWq1ybCGzNkufSrSe
OfLFB2TtX/P5S4u7O4BgUmlf1md9kv6Ij7ajQMA2TYbvjHPlfvLL7i94mplci2EH
xwBobm6j/+9tNgTd2JiykLDDMDfp7gJDKglbaj/tZS/KY84XCEMmSzTkdgKIV98x
2pgbaUZXsluM2nHVRL0QZXPLSYAktMJQsbbddqj4eOdLtUWbJEqvylX3d+R/Irns
q3FbftoQWZyN7LHAxLQcMlMddpNGORpdERDkowxclilM/Z3YsmM0fsPOKDSx+gNO
pUXPIhFk8eRrOnS7KaNyAFqGSc95I7LnF4rxC2evWRbMZeMEfY8UXpalia36y6xQ
iVOYc48l7ITq1irpow38KjXHI/McdQV4Bg1W/i6IfvW+jhPaQYfJk4SOY/05IERz
xlWgoYQ5zBzz2jYoSkFpSQ/xh2a6+GhAiVuytB1ka+lf3N3uo08=
=j4U1
-----END PGP SIGNATURE-----
--=-=-=--

--===============1759132811536472613==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

--===============1759132811536472613==--
