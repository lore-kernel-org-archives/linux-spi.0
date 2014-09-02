From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/4] spi: atmel: remove unnecessary #if defined(CONFIG_OF)
Date: Tue, 2 Sep 2014 11:50:18 +0100
Message-ID: <20140902105018.GR29327@sirena.org.uk>
References: <002a01cfc65d$2dc86640$895932c0$%han@samsung.com>
 <002b01cfc65d$569ef570$03dce050$%han@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7kZSb73GAX5WIGXJ"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	'Nicolas Ferre' <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
To: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <002b01cfc65d$569ef570$03dce050$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--7kZSb73GAX5WIGXJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 02, 2014 at 12:24:00PM +0900, Jingoo Han wrote:
> Remove unnecessary  #if defined(CONFIG_OF), because this is
> already handled by the of_match_ptr macro.

Applied, thanks.

--7kZSb73GAX5WIGXJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUBaDnAAoJELSic+t+oim9nxIQAJLqWUe6rtBvA8U1AC5XPoHN
zS94eLsh59qDz3p7BR2SIxZDJt+smLDNiKhR6eCsw5RnVHWwYI5WmY5GIb0soqvw
cxo6wxdCnhvPLpbKDOaC1z4IZbsN2PU+IAGQ62PsjMqlgXWSJHF0VtoCTyXHiF2N
IVrQwKxoN9XhZwZhqQalTVgIZV7CsXOUFQHWvPm11M8viVAtfrIq3+4oCnOvADwf
a11KahazLfSUKEC3O8Ry4qxLNcjgs3ZsDR+pQJLhU/PX43FG2pnn0KgLnJlhG2Bd
pJ4JW3djn0uH5C79F2+GKR5tkwi8AaAfMJ6DYyWzwpqcDELyjrTST3aWErYmWeJz
q3y0Dc2SBSS2G6Y2eB0r4cz1VHEXNJyV+aws2mCucXaQMvN2TeLjp8atxr5pDErx
0NydFHayaeeKZBdKru5mC0s1LZorLqfq7bBT5Riwkq7TpZJmKJ++m80qRxfufXvE
LwQ4ga+a52FBU2NPBiNXCjer0oSBDfpp5EEtQ3/HvAbLprEF0drffz3UUJasNy0D
NJm/YV3hwPO9AEhPXwCaLlEul5A1ZpdCvtI1hjCBGyxSMUgrNwEqLYriWsTxa90L
UtTsNOoIxE5WqLDvmqzljoXJ4An2UNPc5Kc60Y05MfFKbCMVPxr0Ar1n8I7ztjvu
pRrtVvKZ/xq4pyZPD3zH
=BB3q
-----END PGP SIGNATURE-----

--7kZSb73GAX5WIGXJ--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
