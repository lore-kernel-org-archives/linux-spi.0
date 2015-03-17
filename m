From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 15/35 linux-next] spi: constify of_device_id array
Date: Tue, 17 Mar 2015 12:15:30 +0000
Message-ID: <20150317121530.GI28806@sirena.org.uk>
References: <1426533469-25458-1-git-send-email-fabf@skynet.be>
 <1426533651-25586-1-git-send-email-fabf@skynet.be>
 <1426533651-25586-6-git-send-email-fabf@skynet.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1l41tKZdfcKQM/aP"
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Fabian Frederick <fabf-AgBVmzD5pcezQB+pC5nmwQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1426533651-25586-6-git-send-email-fabf-AgBVmzD5pcezQB+pC5nmwQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--1l41tKZdfcKQM/aP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 16, 2015 at 08:20:31PM +0100, Fabian Frederick wrote:
> of_device_id is always used as const.
> (See driver.of_match_table and open firmware functions)

Applied, thanks.

--1l41tKZdfcKQM/aP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVCBrhAAoJECTWi3JdVIfQqxcH/3bMfyteZevDLD/PkIqPbVRr
DN0l+N5x2LeWplL/vj3Elagziq7Hu4eOvvrA+YrsfTSIjeu3iWVdccea1Fo7ENwf
yaK86zH97fCMz08VaJkU/ZvYFZ0oGQN8HPbdEyjKsd7DmAclaSHbPVR3MUjhnwdV
Y9x/HYIjwPHgBwReg7io3GhESkGdPYB3bdlNC+SET6CUCh+n+zWZIgw4jE7UrWCn
eKEJStjaXi0OK/3UoGa/D1iPi5tjzU3Eb9s7sMaZ7bEH5izkOULF2QaYswPGuRfY
viMYwMJ4LygMkEAgozkUB7z3acpfQF+yrDjRLsQED/rhSCmWrGgv2gXgj0Vrf1A=
=qzkl
-----END PGP SIGNATURE-----

--1l41tKZdfcKQM/aP--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
