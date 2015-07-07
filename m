From: David Binderman <dcb314-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Subject: linux-4.2-rc1/drivers/spi/spi-zynqmp-gqspi.c:215: possible missing
 break ?
Date: Tue, 7 Jul 2015 11:13:29 +0000
Message-ID: <DUB128-W25045AFECC31BCFA9FC1D59C920@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hello there,

[linux-4.2-rc1/drivers/spi/spi-zynqmp-gqspi.c:218]: (warning) Variable =
'genfifocs' is reassigned a value before the old one has been used. 'br=
eak;' missing?

Source code is

=A0=A0=A0 case GQSPI_SELECT_FLASH_CS_BOTH:
=A0=A0=A0=A0=A0=A0=A0 instanceptr->genfifocs =3D GQSPI_GENFIFO_CS_LOWER=
 |
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 GQSPI_GENFIFO_CS_UPPER;
=A0=A0=A0 case GQSPI_SELECT_FLASH_CS_UPPER:

Regards

David Binderman

 		 	   		  --
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
