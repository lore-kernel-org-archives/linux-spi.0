From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] spi: sirf: replace kmalloc by devm_kzalloc
Date: Thu, 7 May 2015 10:46:39 +0100
Message-ID: <20150507094639.GJ22845@sirena.org.uk>
References: <1430982791-8681-1-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8225787863768158804=="
Cc: Qipan Li <Qipan.Li@csr.com>, Barry Song <Baohua.Song@csr.com>,
 workgroup.linux@csr.com, linux-arm-kernel@lists.infradead.org,
 linux-spi@vger.kernel.org
To: Barry Song <21cnbao@gmail.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1430982791-8681-1-git-send-email-21cnbao@gmail.com>
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


--===============8225787863768158804==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NtRSAxJqMOGPBnPG"
Content-Disposition: inline


--NtRSAxJqMOGPBnPG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 07, 2015 at 07:13:10AM +0000, Barry Song wrote:
> From: Qipan Li <Qipan.Li@csr.com>
>=20

Applied since it's an improvement but please do update to use the core
features like Geert suggested.

--NtRSAxJqMOGPBnPG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVSzR+AAoJECTWi3JdVIfQdX8H/3XX69DFhXz6FkTPZ40853pk
R0ZfxbCcPSvBs95EJOzRsE+mzr8g+zPEYiuBhFgIe9RQwR9BlwnvcEIXYX9/z8zF
iEQARA36Pg5MgAybzP8Pk6CWd2bwJqSLa3GqL0jYtUB4XUb6xKHazCAK/m7+Lmk6
HULRXzT0impk29qtfpS1d73mACUtSkm8FUAKTygo9OlV///c3BHMF4bEgMNTbzaI
QqGgQjoZrTluQig5EQAaKeF+z8yXaHyzPG93w+k86RL63LFsUsnCJhjJTGojxo5r
eOTdoeEmNVLCUTrY0zqradnLuql2+69QEDeOKFMtJSMREmeAa2/yhrD1oG4D3W0=
=GLpz
-----END PGP SIGNATURE-----

--NtRSAxJqMOGPBnPG--


--===============8225787863768158804==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8225787863768158804==--
