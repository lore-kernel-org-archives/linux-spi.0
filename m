From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: Patch submission for fixing a bug in the
	SPIDEV driver.
Date: Wed, 8 Apr 2009 21:29:44 -0700
Message-ID: <200904082129.45057.david-b@pacbell.net>
References: <51D9710FF5643747BB605F97B8DE56CD02773126@STEGOSAURE.adetel.com>
	<200904071413.32917.david-b@pacbell.net>
	<51D9710FF5643747BB605F97B8DE56CD027734DA@STEGOSAURE.adetel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: LEMERCIER =?iso-8859-1?q?Gr=E9gory?= <glemercier-zjFYp9kwZlmZox4op4iWzw@public.gmane.org>,
	CLEMENT =?iso-8859-1?q?Gr=E9gory?= <gclement-zjFYp9kwZlmZox4op4iWzw@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <51D9710FF5643747BB605F97B8DE56CD027734DA-60eonUy6E0Ou6pEdMXsbNRL4W9x8LtSr@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wednesday 08 April 2009, LEMERCIER Gr=E9gory wrote:
> Ok, after verification (that I definitely should have
> made earlier) it turns out that the issue comes from
> my SPI driver which does not make the conversion
> "bytes / words to send". However, what got me confused
> in the first place is in "Documentation/spi/spidev_test.c":    =


You might submit a patch for that ...


> #define ARRAY_SIZE(a) (sizeof(a) / sizeof((a)[0]))
> =

> static const char *device =3D "/dev/spidev1.1";
> static uint8_t mode;
> static uint8_t bits =3D 8;
> static uint32_t speed =3D 500000;
> static uint16_t delay;
> =

> ...
> =

> 	uint8_t tx[] =3D {
> 		0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
> 		0x40, 0x00, 0x00, 0x00, 0x00, 0x95,
> 		0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
> 		0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
> 		0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
> 		0xDE, 0xAD, 0xBE, 0xEF, 0xBA, 0xAD,
> 		0xF0, 0x0D,
> 	};
> 	uint8_t rx[ARRAY_SIZE(tx)] =3D {0, };
> 	struct spi_ioc_transfer tr =3D {
> 		.tx_buf =3D (unsigned long)tx,
> 		.rx_buf =3D (unsigned long)rx,
> 		.len =3D ARRAY_SIZE(tx),

... making this be "sizeof tx".  You're right, someone seems to
have gone out of their way to do the most misleading thing here.  :(


> 		.delay_usecs =3D delay,
> 		.speed_hz =3D speed,
> 		.bits_per_word =3D bits,
> 	};
> =

> =

> ARRAY_SIZE here is used for both "number of elements in the array" and "n=
umber of bytes of the array" which might be misleading in some cases. But I=
 admit that a quick look at spidev.h would have led me to the right way to =
go :-)
> =

> Anyway, thanks for your feedback.
> =

> Greg
> =

> -----Message d'origine-----
> De=A0: David Brownell [mailto:david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org] =

> Envoy=E9=A0: mardi 7 avril 2009 23:14
> =C0=A0: LEMERCIER Gr=E9gory
> Cc=A0: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Objet=A0: Re: Patch submission for fixing a bug in the SPIDEV driver.
> =

> On Tuesday 07 April 2009, LEMERCIER Gr=E9gory wrote:
> > When using the SPIDEV driver from the kernel, I found out that
> > there is a bug that occurs when sending words of width larger
> > than 8 bits. The buffer copy from Userspace will only copy =

> > "number of words" bytes where it should actually copy
> > "number of words * sizeof(word)" bytes.
> =

> On closer examination ... <linux/spi/spidev.h> clearly
> specifies that this value is in bytes.  So, not a bug
> in the kernel, just in your userspace code.
> =

> As a rule, you should expect buffers to be described to
> any OS using byte lengths; anything else is unusual.
> =

> - Dave
> =

> /**
>  * struct spi_ioc_transfer - describes a single SPI transfer
>  * @tx_buf: Holds pointer to userspace buffer with transmit data, or null.
>  *	If no data is provided, zeroes are shifted out.
>  * @rx_buf: Holds pointer to userspace buffer for receive data, or null.
>  * @len: Length of tx and rx buffers, in bytes.
>  * ...
> =


---------------------------------------------------------------------------=
---
This SF.net email is sponsored by:
High Quality Requirements in a Collaborative Environment.
Download a free trial of Rational Requirements Composer Now!
http://p.sf.net/sfu/www-ibm-com
