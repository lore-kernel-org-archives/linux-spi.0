From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: spi-gpio: Use 'cansleep' variants to access GPIO
Date: Sun, 24 Nov 2013 14:12:55 +0000
Message-ID: <20131124141255.GZ14725@sirena.org.uk>
References: <1385296621-23638-1-git-send-email-ezequiel.garcia@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="O2g7+miYGsIKoR9l"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1385296621-23638-1-git-send-email-ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--O2g7+miYGsIKoR9l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Nov 24, 2013 at 09:37:01AM -0300, Ezequiel Garcia wrote:
> The GPIO chip in use could be of any kind, and therefore might sleep
> when accesing the GPIO lines. Take account of this by using cansleep
> instead, which is the most generic case.

Applied, thanks.

--O2g7+miYGsIKoR9l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSkgljAAoJELSic+t+oim9b4oP/0uHm/3jrEZ05IpmzfV9/Cdx
jX10bWEDHOcRIgAbc3aCQ3/ZvDN4vnm8D0bDllLwYI3wM79Zd5Q1481xbjhPxwwp
iV8AgYniK6FKgxpo/2rRtj0cFsaJVIT2KvlR6XRyGvBsjGhlsDByWckgxSMYEsNd
/r4jOFJgj8wDcxMqGaOXQAjwAJLum+DKnQUuFj8SkSw7oF+y31JzH/DrGYiWiO3W
sQuXALzoxuFMGnzk9xDbRviNZ7fJW2unLSkT4xWgtGeJ4UswiMLHrabt+UFgLyVN
ttwgZXEdADCX66DqYHUnYc7wo6qk789/xWZqNgw6BJyIpT5m9Uo3KZHzaeiW8JD9
Ltrin03Te7FDuXZduIQAipZZmImb/KebWOFr134JUuDcmA6/mHhQuJIX2ytoZYQW
Isx6VKj1pSysRZdzj5s6EDcD8mzk70brDhgvWptaJKu2MNAnx0oHNYwwNf5dHGED
jFfSm3rtZFB2YN1IX29H6ZO9NQgsnGqPP4ijOFWF75zw/kbytoYH7+1vkw3ZROWI
nHhbMDdcf8s1pT/rehYi2V3JBz6IuCNmKPKdnWOeRCGSfK/0G1C62wMVBisvO1pV
9zXXSYUnDLkWAS41Y/eTyF7P+Xhfj30JAcdnTQAd5QWhxDoeQy1ZCLxqhfgCzwhD
/LnwhdKXPcWMd8PjhYOZ
=APol
-----END PGP SIGNATURE-----

--O2g7+miYGsIKoR9l--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
