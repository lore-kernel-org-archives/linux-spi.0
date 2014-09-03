From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/4] spi: atmel: remove unnecessary #if defined(CONFIG_OF)
Date: Wed, 3 Sep 2014 15:42:04 +0100
Message-ID: <20140903144204.GS29327@sirena.org.uk>
References: <002a01cfc65d$2dc86640$895932c0$%han@samsung.com>
 <002b01cfc65d$569ef570$03dce050$%han@samsung.com>
 <20140902105018.GR29327@sirena.org.uk>
 <CAMuHMdU2S_vwv3=CUtgGjqnq-nbh=up42gDWzR35ai6s4ZVaWQ@mail.gmail.com>
 <20140902163658.GA29327@sirena.org.uk>
 <009801cfc715$e27d8030$a7788090$%han@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fRTiclqxXzPSgD3k"
Cc: 'Geert Uytterhoeven' <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
	'linux-spi' <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	'Nicolas Ferre' <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
	'Axel Lin' <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>,
	'Max Filippov' <jcmvbkbc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <009801cfc715$e27d8030$a7788090$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--fRTiclqxXzPSgD3k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 03, 2014 at 10:25:02AM +0900, Jingoo Han wrote:

> However, personally I don't like #ifdef guards. I think that
> #ifdef guards can be removed for the same binary, regardless
> of kernel config options.

> In this case, the binary size is more important than #ifdef guards,
> right?

Right.  The ideal thing would be to teach the module table stuff to
disable itself when the relevant support isn't in the kernel but that's
probably going to be hard to do in a tasteful fashion; perhaps wrappers
(OF_MODULE_TABLE) might be OK.

--fRTiclqxXzPSgD3k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUByi5AAoJELSic+t+oim9jqgP/12+YJcz2u8FjyxX6izrXW1Q
khs15eUVZmeD73Yv4M87ONoBi2kRnOsmaiaY8NdBD0RIIFyw9LJJqz87s484T2IG
jpTwG7+QQ1iSLPGBEqjwtChRGjFeLwJF/LYN+OJMNeV7o96jskNY3Aejey/TXVHE
324rg/XYUICrMH5YpvwzRzl+DKa98fGkecy9uh+xVSZ3miIKPJj3BtkpSeuNfl/K
OIQrHVEGRs/rqKMQYhuMy01ozE+hfeKWnxtd15jCnQx1Np67vGLP3L5vbbTdSMDe
I0XQTchWRAGXHGwQAD8O7YwnLDaxHV9z7Uz5ge93ldgO/6Z2FFBrzHKlupDEFbeV
V1+P9mb67X4SmGVDyUkcxcv8Xz9oSehHovigh7nERKGpaaeOCHzG5kulwPz4NgLS
4X/vi1JCftWBwMzkk1VGb80Ciyl0S/n52v2cQeutAaEjn7Xt1gFyKRafDtEz644+
cFqwp9oDeo1jBdS2a5ILpCrBsox4zDv0zDRj1XZ62UZ3rzQrJ7XfZ8QcIydIVxV4
nPiInxKz1E9K/zuz06xjlZ36Ne8qoYv5SvQDygworPBkv7KcTvGG37CWGNfah88V
9opso6/TR+nkiNsG94c28obOXE65SHHpCSWaPsl1YcAMKeVQZb22aQnHcWWvYge4
zIopiDspDe7mwzxv34TJ
=TyyT
-----END PGP SIGNATURE-----

--fRTiclqxXzPSgD3k--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
