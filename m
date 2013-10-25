From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC 2/2] spi: Use stable dev_name for ACPI
	enumerated SPI slaves
Date: Fri, 25 Oct 2013 13:59:09 +0100
Message-ID: <20131025125909.GA12932@sirena.org.uk>
References: <1382703540-3769-1-git-send-email-jarkko.nikula@linux.intel.com>
 <1382703540-3769-3-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3400078545978527398=="
Cc: linux-acpi@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-spi@vger.kernel.org, linux-i2c@vger.kernel.org,
 Wolfram Sang <wsa@the-dreams.de>
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1382703540-3769-3-git-send-email-jarkko.nikula@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
List-Id: linux-spi.vger.kernel.org


--===============3400078545978527398==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 25, 2013 at 03:19:00PM +0300, Jarkko Nikula wrote:
> Current spi bus_num.chip_select "spix.y" based device naming scheme may not
> be stable enough to be used in name based matching, for instance within
> ALSA SoC subsystem.

I'm happy with this from the SPI side modulo Raphael's comments - are
folks happy from the ACPI side?

--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSamsTAAoJELSic+t+oim9N0QP/A0kRxbrkYg9lpIBb+seOC+H
STL+41jpU5Yo/UhdSrSOCSlw9LoyNRwlppfJQ65kNpnuRz7SCqOmUkeJ8+FQUQQ7
5LyWktRKhRqy6s4n7RB5B/+rZKJu83JvYNIUz/3siKbzofiEoYwU+uaBRdngVM60
MchZO78lhdUCeTG1qMAbb9mly/oDp96VpwnBpKMIP+NMCA38JFX4AqhFFJLGxmv+
+pOsClJeqC0BrZnUIBNqkiMNQ99+RejilG+cd0uasfqbF/aBNAxiGIHgURxHhTFZ
TCVXe2/m38CpAtg0tsnQo8wYZDP0y2vzd8zgOAQpQogsrZwUL4arfp8pWWctoNKv
g/kzSGf5HyIpsXrAuBYjBz/BlLe+hcAw/aO++PXtimXofosrSs8IDHCbhEi9100x
aDbQ0YVxv1rZH2ZG8TSrnfl2P5FuQIPg/wAKUPhSZP0Su9kFHDnm/Pgv5fDBVzWA
wW5jg5ycRq61VTETUQlI88HRZoEfccJ+oXTXUfDVIS8MvC0z3W8fr2utg89mjqvO
G6rZOBgcTP8iuWFQUVDkxpz1gvdSTC9zIaZmV2cJ1HEDS4dlmqlaIf+UQDhPTRsr
D0D9WUiD6gP41r51XGF0pAP990Un9/DxfH3kULa/Cg2JphgCAGtEimo+jxLV5bbG
VM7p95OvbDm2ZNOXtE1d
=A36A
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--

--===============3400078545978527398==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3400078545978527398==--
