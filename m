From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH v3 2/3] spi: pxa2xx: Prepare for edge-triggered interrupts
Date: Fri, 20 Jan 2017 16:29:28 +0100
Message-ID: <df89519e-e01a-b88b-ca54-112bbf5346b8@siemens.com>
References: <7b15a0910a3ad861fd32161c72559bafa7b71e29.1484592296.git.jan.kiszka@siemens.com>
 <87ziiqdstr.fsf@belgarion.home>
 <4d97e416-4d32-3b9f-0695-de116a4b26bd@siemens.com>
 <87r340eq28.fsf@belgarion.home>
 <b3e0d393-b841-1556-ddd2-5634f12b6f2c@siemens.com>
 <20170118124645.6ugjwbfeq5vsh2to@sirena.org.uk>
 <7e5fb21d-35bd-6ac3-9e6f-cffed656997f@siemens.com>
 <e692c4a9-6320-b9e0-d6e7-f58bbe6ba867@siemens.com>
 <20170119195701.kueutgmahr6bmxhq@sirena.org.uk>
 <1484856272.2133.253.camel@linux.intel.com>
 <20170120122129.6cn5phrobeldpikp@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1430738987688403144=="
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
 linux-kernel@vger.kernel.org, Haojian Zhuang <haojian.zhuang@gmail.com>,
 linux-spi@vger.kernel.org, Jarkko Nikula <jarkko.nikula@linux.intel.com>,
 linux-arm-kernel@lists.infradead.org, Robert Jarzmik <robert.jarzmik@free.fr>,
 Sascha Weisenberger <sascha.weisenberger@siemens.com>,
 Daniel Mack <daniel@zonque.org>
To: Mark Brown <broonie@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170120122129.6cn5phrobeldpikp@sirena.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============1430738987688403144==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="tp2I6nifge93EDAU6Fhl5qIxBa1NFPgr0"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tp2I6nifge93EDAU6Fhl5qIxBa1NFPgr0
Content-Type: multipart/mixed; boundary="V70RoBfQprV3sMGT6CKci46tx23nJKH0K";
 protected-headers="v1"
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Mark Brown <broonie@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Robert Jarzmik <robert.jarzmik@free.fr>, linux-spi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Daniel Mack <daniel@zonque.org>,
 Haojian Zhuang <haojian.zhuang@gmail.com>, linux-kernel@vger.kernel.org,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Jarkko Nikula <jarkko.nikula@linux.intel.com>,
 Sascha Weisenberger <sascha.weisenberger@siemens.com>
Message-ID: <df89519e-e01a-b88b-ca54-112bbf5346b8@siemens.com>
Subject: Re: [PATCH v3 2/3] spi: pxa2xx: Prepare for edge-triggered interrupts
References: <7b15a0910a3ad861fd32161c72559bafa7b71e29.1484592296.git.jan.kiszka@siemens.com>
 <87ziiqdstr.fsf@belgarion.home>
 <4d97e416-4d32-3b9f-0695-de116a4b26bd@siemens.com>
 <87r340eq28.fsf@belgarion.home>
 <b3e0d393-b841-1556-ddd2-5634f12b6f2c@siemens.com>
 <20170118124645.6ugjwbfeq5vsh2to@sirena.org.uk>
 <7e5fb21d-35bd-6ac3-9e6f-cffed656997f@siemens.com>
 <e692c4a9-6320-b9e0-d6e7-f58bbe6ba867@siemens.com>
 <20170119195701.kueutgmahr6bmxhq@sirena.org.uk>
 <1484856272.2133.253.camel@linux.intel.com>
 <20170120122129.6cn5phrobeldpikp@sirena.org.uk>
In-Reply-To: <20170120122129.6cn5phrobeldpikp@sirena.org.uk>

--V70RoBfQprV3sMGT6CKci46tx23nJKH0K
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 2017-01-20 13:21, Mark Brown wrote:
> On Thu, Jan 19, 2017 at 10:04:32PM +0200, Andy Shevchenko wrote:
>> On Thu, 2017-01-19 at 19:57 +0000, Mark Brown wrote:
>=20
>>> I'm missing patches 1 and 3, what's going on here?
>=20
>> Patch 1 had been applied by you. I think Jan just needs to resend with=

>> proper version and set of patches.
>=20
> OK - Jan, the purpose of numbering patches in a series is so we can tel=
l
> what order they come in.  That's it.  If the set of patches gets change=
d
> due to things being added or removed the numbers will be different but
> that's totally OK as their only relevance is in ordering things within =
a
> given posting.

Sorry if the numbering was confusing for you, it was, of course, a
selective update. Just tell me, if you need a new round with of patches
2 and 3 (as 1 and 2).

Jan

--=20
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux


--V70RoBfQprV3sMGT6CKci46tx23nJKH0K--

--tp2I6nifge93EDAU6Fhl5qIxBa1NFPgr0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAliCLNgACgkQitSsb3rl5xRMCACg7+24N1ST5uQ46mep2xJYiNFB
EhsAoKu5REMieZU/8YzT990cozOd1hrR
=5LMA
-----END PGP SIGNATURE-----

--tp2I6nifge93EDAU6Fhl5qIxBa1NFPgr0--


--===============1430738987688403144==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1430738987688403144==--
