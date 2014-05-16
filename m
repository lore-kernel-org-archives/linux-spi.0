From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi-topcliff-pch: Fix Kconfig dependencies
Date: Fri, 16 May 2014 20:08:13 +0100
Message-ID: <20140516190813.GU22111@sirena.org.uk>
References: <20140516164718.5ea30de0@endymion.delvare>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zAi3veRTHMyLkSNS"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140516164718.5ea30de0-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--zAi3veRTHMyLkSNS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 16, 2014 at 04:47:18PM +0200, Jean Delvare wrote:
> The spi-topcliff-pch driver is for a companion chip to the Intel Atom
> E600 series processors. These are 32-bit x86 processors so the driver
> is only needed on X86_32. Add COMPILE_TEST as an alternative, so that
> the driver can still be build-tested elsewhere.

Applied, thanks.

--zAi3veRTHMyLkSNS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTdmIaAAoJELSic+t+oim9WIEQAIyB/bv1uyulVsZC7Ehnk46e
37BHCnMQggqNysdSGWuivV29jXCCmHDU+f1zyiHNdAOUf4zGKJm+lIy7P9YJhZRR
FFmZL87y89bPxBqqDlJ68JAkrQxczEw32gZWeYXbAjq39KHN65cKTETx0tGPVq2z
ktpb28cfCJxd1yB6Ih8f0i9cojmsf9QqCRbkkNHCskP83ufw4d/Mpm2t3bVL7gaS
deQ+kr7/3nVCLjiNxDxWejGVCfb74Ty+JkamhNwnC3/MAPM7NqfxJCNF7SlxKF7C
wUnE8vc2x8kpBC2aE4OiWZrMcyTNNhgmOfBsIX5TbWpCXR4w6zA8DM+FkNXpFOJV
PyhoK3WKMiaN6ub0TxFksEnwJmr6mS6VfNiFApDSjK0vKvL7Souey7X0XJ9BqY5y
O8sj7Dim2bqtHWHjmIMltFEdCy+S0b50DlvRjr09ncvoz+gawRJa/cfHfl8km+0N
Oud3VH50af1q0lbSUTEENk0+lwPj0GnferWwCFZhXR/+3+WBx/F03QLzbFGOJT3p
c4hJggox5zn7svvLNWqphIVY9NSeWG9YEpGlnWdDn+Z1wrsNMafpKNPbKvMluO3B
GheutADb5ANTyX+gDkPLAgCYDE6gEMV4QiyGzQEnYI4BFRFsE+JU0CHC65RuL2hC
ubQw8OXdGuZxq0KzVuCl
=Tne2
-----END PGP SIGNATURE-----

--zAi3veRTHMyLkSNS--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
