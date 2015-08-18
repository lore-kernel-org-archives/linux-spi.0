From: =?iso-8859-1?Q?Br=FCns=2C_Stefan?= <Stefan.Bruens-vA1bhqPz9FBZXbeN9DUtxg@public.gmane.org>
Subject: Re: [PATCH 0/2] Fix displays requiring 9 bit transfers on RPi
Date: Tue, 18 Aug 2015 20:41:55 +0000
Message-ID: <2396767.SsPboNIpj6@sbruens-linux>
References: <1439278071-21110-1-git-send-email-stefan.bruens@rwth-aachen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1439278071-21110-1-git-send-email-stefan.bruens-vA1bhqPz9FBZXbeN9DUtxg@public.gmane.org>
Content-Language: en-US
Content-ID: <C23630BA022A734F86669CBC9C9DF7D8-KnNo0XtUZUuELgA04lAiVw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi,

any comments on these two patches, please?

Kind regards,

Stefan


On Tuesday, August 11, 2015 09:27:49 you wrote:
> Some displays need 9 bit long SPI transfers (Command/Data flag plus
> 8 bit data). FBTFT has emulation code in case the controller only
> supports 8 bit transfers, but this is only used if the controller
> setup function report an error if bits_per_word is set to 9.
>=20
> Report unsupported bits_per_word settings in spi_setup Currently the
> SPI core only checks bits_per_word on transfer, but not on setup.
>=20
> Replace invocations of master->setup(...) with spi_setup(...).
>=20
> Tested on RPi B with an Ilitek9341 based TFT display in 9 bit mode.
>=20
> Stefan Br=FCns (2):
>   spi: check bits_per_word in spi_setup
>   staging/fbtft: use spi_setup instead of direct call to master->setu=
p
>=20
>  drivers/spi/spi.c                    | 27 +++++++++++++++++++-------=
-
>  drivers/staging/fbtft/fb_watterott.c |  4 ++--
>  drivers/staging/fbtft/fbtft-core.c   |  4 ++--
>  drivers/staging/fbtft/flexfb.c       |  4 ++--
>  4 files changed, 25 insertions(+), 14 deletions(-)

--=20
Stefan Br=FCns  /  Bergstra=DFe 21  /  52062 Aachen
home: +49 241 53809034     mobile: +49 151 50412019
work: +49 2405 49936-424--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
