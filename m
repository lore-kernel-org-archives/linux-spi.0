From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 22/31] spi: tegra: use reset framework
Date: Sat, 16 Nov 2013 10:07:28 +0000
Message-ID: <20131116100728.GJ15393@sirena.org.uk>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
 <1384548866-13141-23-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4369387845624726519=="
Cc: Stephen Warren <swarren@nvidia.com>, pdeschrijver@nvidia.com,
 linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org, treding@nvidia.com,
 linux-arm-kernel@lists.infradead.org
To: Stephen Warren <swarren@wwwdotorg.org>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1384548866-13141-23-git-send-email-swarren@wwwdotorg.org>
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


--===============4369387845624726519==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UlxN1C6awaFNesUv"
Content-Disposition: inline


--UlxN1C6awaFNesUv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2013 at 01:54:17PM -0700, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
>=20
> Tegra's clock driver now provides an implementation of the common
> reset API (include/linux/reset.h). Use this instead of the old Tegra-
> specific API; that will soon be removed.

Acked-by: Mark Brown <broonie@linaro.org>

--UlxN1C6awaFNesUv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSh0PcAAoJELSic+t+oim9fXwP/RVY9RYmtCIh4WGKDONQfOP3
x4M7y/NpGuJJ9Dpw0jLCjEAh5o58NL/6YrLO1TDdBt6ofnY4LkjLf+4RFRDZwNsH
kLGAUpj/r1zSeGVvVLyILWt8v3i0dIpi+B8w8JolUBhWfmzLwy2pQAINpbGq8cwW
IQfdcHRpxs+yaPmChiQr3Moy7U+dS49ESchmcreAqmYh2CqWer0JE8InusxnEvYL
9NWbWBALPl+yfScBx1l3nsExDLhrw9uq8pEieVL71sHW3sjnsXXMw9oMFIdqkIH/
3tjzrug0DZqfgNgKBSrJiGPrib3WxFQamMSqcGCjSN55e5nPF9oNHOoeyRFaDkpW
29rY9wxbvaTjSPGQ3489AD4bJIBXQyxpKeAervMGUBYJDkFr+hX5vqc20UlgC65Y
auhqr7LS6o7jRU9J3E4bczTbjUwJzzfzfOA86XsG6gW3FelKa6spFrbu3z1tU0SG
mow1DDD6pIMGIR7guGibneW5apnZJLw23genkXOgSaobpekELOw6/8d5Gr5m1LGJ
Y5zQUXlDzSEeEQCvTwn/M1+EdGVbu3B6DsXTiGYJNykNOATnKsl11DlweNcjaBos
W+6WBY3eAUjnJVvDAgkfNX94W5tLG9dPfh4agne9W1ZChk6hi58mVQql6odfqDoT
sMuKpNOD4Vqu5YISNemP
=UXCM
-----END PGP SIGNATURE-----

--UlxN1C6awaFNesUv--


--===============4369387845624726519==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4369387845624726519==--
