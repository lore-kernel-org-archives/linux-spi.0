From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 13/14] spi/of: Create new device registration method
 and accessors
Date: Tue, 25 Nov 2014 11:32:51 +0000
Message-ID: <20141125113251.GN7712@sirena.org.uk>
References: <1416868422-22103-1-git-send-email-grant.likely@linaro.org>
 <1416868422-22103-14-git-send-email-grant.likely@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hF9BROpwVWvPzXeD"
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
	Rob Herring <robh+dt@kernel.org>,
	Wolfram Sang <wsa@the-dreams.de>, linux-spi@vger.kernel.org
To: Grant Likely <grant.likely@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1416868422-22103-14-git-send-email-grant.likely@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--hF9BROpwVWvPzXeD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 24, 2014 at 10:33:41PM +0000, Grant Likely wrote:
> From: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
>=20
> Dynamically inserting spi device nodes requires the use of a single
> device registration method. Refactor the existing
> of_register_spi_devices() to split out the core functionality for a
> single device into a separate function; of_register_spi_device(). This
> function will be used by the OF_DYNAMIC overlay code to make live
> modifications to the tree.
>=20
> Methods to lookup a device/master using a device node are added
> as well, of_find_spi_master_by_node() & of_find_spi_device_by_node().
>=20
> Changes since v1:
> * Brown paper bug with parameter on of_register_spi_device().

Please don't include things like this in the commit message, if you want
to include a changelog put it after the --- like SubmittingPatches says.
Once it's in mainline this is just noise.

Otherwise

Reviewed-by: Mark Brown <broonie@kernel.org>

--hF9BROpwVWvPzXeD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUdGjjAAoJECTWi3JdVIfQRO0H/20xoSTdwqX7g0P6SiVMcI2j
XaNgzZED/Vvzk+U7oD4GxLPyk6eTTipeefYWy9exRB/tWriBWJwLiWY7+7MaSflI
4Rr4dG/bhSVEu4Z0jTRJqFrxPxgxc5WNCfRkS8Lth74YmxK5Hd3C1f72fT/mHFAE
668TWP7/Eklz0+uVtTMLjMq/jQTfFIwceFYULH6zOvknZCgBopPlUJOARPdJjX5/
ve4w9mrauTDW02fpf128UOm6ecxq7jM9tXyHyJx8PMZMc0acsixBYtwPQt42cWTs
yk3u1BJ2MQUwbJ+Lpr7qYofjYCuR9ixx987/9w4DdhJ4GGOlJyNHZjJCqhojcyw=
=uJBJ
-----END PGP SIGNATURE-----

--hF9BROpwVWvPzXeD--
