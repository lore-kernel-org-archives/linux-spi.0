From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 8/8] spi: sirf: make DMA transfer mode optional
Date: Thu, 4 Sep 2014 23:41:32 +0100
Message-ID: <20140904224132.GW29327@sirena.org.uk>
References: <1409648557-5470-1-git-send-email-Barry.Song@csr.com>
 <1409648557-5470-4-git-send-email-Barry.Song@csr.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tnSXTZOLuLJuusSZ"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	workgroup.linux-kQvG35nSl+M@public.gmane.org, Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>,
	Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
To: Barry Song <Barry.Song-kQvG35nSl+M@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1409648557-5470-4-git-send-email-Barry.Song-kQvG35nSl+M@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--tnSXTZOLuLJuusSZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 02, 2014 at 05:02:37PM +0800, Barry Song wrote:
> From: Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>
>=20
> some customers want a pure PIO transfer mode even though DMA mode is
> supported. here we give them a Kconfig option, but still keep the DMA
> enabled in default.

This doesn't feel like something for the standard kernel - can you
explain the benefit the customers think they're getting here?  It seems
like either this is something we should have as a more general option,
perhaps controllable at runtime or there's likely to be some bug or
other problem that's being worked around here.

--tnSXTZOLuLJuusSZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUCOqZAAoJELSic+t+oim9neYP/j4mS7TOYMZ3aCNvHbIuSFcQ
smIc5ImBIWJFwP2+qmMRcG+v+hcLMCB6iBrOEC68ZznHU/Demg7IL+ptt5Pa87lB
B1eu6LvZx9AjIvPaEak0ltVTy66PpWCT/rJS/Jqhf0kAi2gx4Z4zbngvpHM97A8+
5yoc3wMDHzNjXJufwO+H3ihgD3KFWK6BjlmAbTiYz7O8z/I3jcOW9wpFNDk2TtHq
tTQRPDAtzEJGbXEsTw+k1F2yo1mg54gOq5pN6NkqHfmM/YVJjVEY+8rli48H5EsH
XUeADr+t2gKTSN988w8hAE92U/YhCEeflwGbe1vjqnYMlsCclnsJAHwgxwL0a4tR
7WOps/ZioOuyN+9qK/qpYCdY886wi74ixyrUABHImj0q4XNtonVbaj9UOw9wDxg7
qXSGAV/lRhc4NqBL0uQOoqqMaY/kZ0G5mqpNmQXbWuKPewCZLwHn2Tf896KPIUnt
A6SU/3oRU5SLEbpxV7JCtQmJZBKSABHN19LKCT/HhpKfjhxhx5tvIPkc7ub/IEOQ
2p8i1kG2VBJ6fKzxXG3V3XQZMNCs3J5dTNPXSv8v08HZMUfZJnipidh4whB/3LTT
fVoGhG+dkVuqEUY+iv/vlS2gcUFrmaeUeNiqXOGTxWcHO+Mrd7f2R8xeNIgFzwGH
41IcI3muAQVQ90hW6rmg
=kqxt
-----END PGP SIGNATURE-----

--tnSXTZOLuLJuusSZ--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
