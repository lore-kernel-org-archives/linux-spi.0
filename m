From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] spi: sirf: Avoid duplicate code in various
 bits_per_word cases
Date: Mon, 27 Jan 2014 20:30:12 +0000
Message-ID: <20140127203012.GV11841@sirena.org.uk>
References: <1389776863.28509.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="S1dYL6sY+prtcMLk"
Cc: Zhiwu Song <Zhiwu.Song-kQvG35nSl+M@public.gmane.org>, Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>,
	Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1389776863.28509.0.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--S1dYL6sY+prtcMLk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 15, 2014 at 05:07:43PM +0800, Axel Lin wrote:
> Trivial cleanup to avoid duplicate code in various bits_per_word cases.

Applied, thanks.

--S1dYL6sY+prtcMLk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS5sHRAAoJELSic+t+oim9PrkQAIBN5HE2ZvlIpWbz4LOnD5VZ
YyzNkjtyQU3Pgd9dzC+wTmKynBicVMP8IWOddCWItkL09y/w2p8VuLBKecepLUk2
mvaLfUjZpfGF3kTtAlKYwMgqFRUUS46cvF0kfQp4H/32sBdbvrH3Y/gYM8COEy+K
YOD3s8YhpXl7MjATlwlIpSonNefjFqq9ntJDyrnQskLtaK8MMTXBj87w+7uPZULm
XtzqMQtRK3Vpih6leMVe2syvJ4PB6Ux2JOSgGNYs+AtD9aAub6AO9LsC48fy3164
jwPw3MdE0pL514tnIAgJJJjs/zVBt3gusuCCRvHC8wedpMas7Qt/nJb0FMWbGTM1
/VUVvBpQstx/AKbMVhWVmfVt615RSnezM4N108Tp/ZjluVkky+lOayMGR/EDYU9N
tzVVJ5LdS2vapD7UqIVtFmC03k6pFaamUX+5b0J1Z9LKo1B3fGhfYoDZwn7sabiU
nmf+BcyMh0w3eDwZkoCHurbA2LCKb23YK5QodQw4XLrmWIbigydp7IAfNj50nr9/
G04ERxJrQ28A8mMFlRi+/Z672BKtTCDS7few5rofSfcEXWN+Y2ILu9jGVPFHl3Oy
Bx4FOt+nSr+8WJxM4x4LQkT8BvCc6l75aLyWLo5ZsYh7ZiGdmcrAqOgRycdieaQk
rTLRbuVEjaw9a809Mkqg
=llaI
-----END PGP SIGNATURE-----

--S1dYL6sY+prtcMLk--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
