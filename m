From: =?iso-8859-1?Q?LEMERCIER_Gr=E9gory?= <glemercier-zjFYp9kwZlmZox4op4iWzw@public.gmane.org>
Subject: Re: Patch submission for fixing a bug in the
	SPIDEV driver.
Date: Thu, 9 Apr 2009 11:06:11 +0200
Message-ID: <51D9710FF5643747BB605F97B8DE56CD0279E811@STEGOSAURE.adetel.com>
References: <51D9710FF5643747BB605F97B8DE56CD02773126@STEGOSAURE.adetel.com>
	<200904071413.32917.david-b@pacbell.net>
	<51D9710FF5643747BB605F97B8DE56CD027734DA@STEGOSAURE.adetel.com>
	<200904082129.45057.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C9B8F2.6E352BCA"
Cc: =?iso-8859-1?Q?CLEMENT_Gr=E9gory?= <gclement-zjFYp9kwZlmZox4op4iWzw@public.gmane.org>
To: <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
In-Reply-To: <200904082129.45057.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C9B8F2.6E352BCA
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Ok, here it is :

--------Start of =
File-------------------------------------------------------------------

>From 65bbb516aa0e210b92548fd19e4b91d6317a6b1b Mon Sep 17 00:00:00 2001
From: Gregory Lemercier <glemercier-HH5893ap9ioXz/+GnIZSFEEOCMrvLtNR@public.gmane.org>
Date: Thu, 9 Apr 2009 10:55:34 +0200
Subject: [PATCH] Changed ambiguous information in SPIDEV test sample =
code


Signed-off-by: Gregory Lemercier <glemercier-HH5893ap9ioXz/+GnIZSFEEOCMrvLtNR@public.gmane.org>
---
 Documentation/spi/spidev_test.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/spi/spidev_test.c =
b/Documentation/spi/spidev_test.c
index cf0e3ce..315c0f1 100644
--- a/Documentation/spi/spidev_test.c
+++ b/Documentation/spi/spidev_test.c
@@ -51,7 +51,7 @@ static void transfer(int fd)
 	struct spi_ioc_transfer tr =3D {
 		.tx_buf =3D (unsigned long)tx,
 		.rx_buf =3D (unsigned long)rx,
-		.len =3D ARRAY_SIZE(tx),
+		.len =3D sizeof(tx),
 		.delay_usecs =3D delay,
 		.speed_hz =3D speed,
 		.bits_per_word =3D bits,
--=20
1.5.4.3

--------End of =
File-------------------------------------------------------------------

-----Message d'origine-----
De=A0: David Brownell [mailto:david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org]=20
Envoy=E9=A0: jeudi 9 avril 2009 06:30
=C0=A0: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc=A0: LEMERCIER Gr=E9gory; CLEMENT Gr=E9gory
Objet=A0: Re: [spi-devel-general] Patch submission for fixing a bug in =
the SPIDEV driver.

On Wednesday 08 April 2009, LEMERCIER Gr=E9gory wrote:
> Ok, after verification (that I definitely should have
> made earlier) it turns out that the issue comes from
> my SPI driver which does not make the conversion
> "bytes / words to send". However, what got me confused
> in the first place is in "Documentation/spi/spidev_test.c":   =20

You might submit a patch for that ...


> #define ARRAY_SIZE(a) (sizeof(a) / sizeof((a)[0]))
>=20
> static const char *device =3D "/dev/spidev1.1";
> static uint8_t mode;
> static uint8_t bits =3D 8;
> static uint32_t speed =3D 500000;
> static uint16_t delay;
>=20
> ...
>=20
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
>=20
>=20
> ARRAY_SIZE here is used for both "number of elements in the array" and =
"number of bytes of the array" which might be misleading in some cases. =
But I admit that a quick look at spidev.h would have led me to the right =
way to go :-)
>=20
> Anyway, thanks for your feedback.
>=20
> Greg
>=20
> -----Message d'origine-----
> De=A0: David Brownell [mailto:david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org]=20
> Envoy=E9=A0: mardi 7 avril 2009 23:14
> =C0=A0: LEMERCIER Gr=E9gory
> Cc=A0: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Objet=A0: Re: Patch submission for fixing a bug in the SPIDEV driver.
>=20
> On Tuesday 07 April 2009, LEMERCIER Gr=E9gory wrote:
> > When using the SPIDEV driver from the kernel, I found out that
> > there is a bug that occurs when sending words of width larger
> > than 8 bits. The buffer copy from Userspace will only copy=20
> > "number of words" bytes where it should actually copy
> > "number of words * sizeof(word)" bytes.
>=20
> On closer examination ... <linux/spi/spidev.h> clearly
> specifies that this value is in bytes.  So, not a bug
> in the kernel, just in your userspace code.
>=20
> As a rule, you should expect buffers to be described to
> any OS using byte lengths; anything else is unusual.
>=20
> - Dave
>=20
> /**
>  * struct spi_ioc_transfer - describes a single SPI transfer
>  * @tx_buf: Holds pointer to userspace buffer with transmit data, or =
null.
>  *	If no data is provided, zeroes are shifted out.
>  * @rx_buf: Holds pointer to userspace buffer for receive data, or =
null.
>  * @len: Length of tx and rx buffers, in bytes.
>  * ...
>=20

------_=_NextPart_001_01C9B8F2.6E352BCA
Content-Type: application/octet-stream;
	name="Changed-ambiguous-information-in-SPIDEV-test-sample.patch"
Content-Transfer-Encoding: base64
Content-Description: Changed-ambiguous-information-in-SPIDEV-test-sample.patch
Content-Disposition: attachment;
	filename="Changed-ambiguous-information-in-SPIDEV-test-sample.patch"

RnJvbSA2NWJiYjUxNmFhMGUyMTBiOTI1NDhmZDE5ZTRiOTFkNjMxN2E2YjFiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBHcmVnb3J5IExlbWVyY2llciA8Z2xlbWVyY2llckBhZGVuZW8t
ZW1iZWRkZWQuY29tPgpEYXRlOiBUaHUsIDkgQXByIDIwMDkgMTA6NTU6MzQgKzAyMDAKU3ViamVj
dDogW1BBVENIXSBDaGFuZ2VkIGFtYmlndW91cyBpbmZvcm1hdGlvbiBpbiBTUElERVYgdGVzdCBz
YW1wbGUgY29kZQoKClNpZ25lZC1vZmYtYnk6IEdyZWdvcnkgTGVtZXJjaWVyIDxnbGVtZXJjaWVy
QGFkZW5lby1lbWJlZGRlZC5jb20+Ci0tLQogRG9jdW1lbnRhdGlvbi9zcGkvc3BpZGV2X3Rlc3Qu
YyB8ICAgIDIgKy0KIDEgZmlsZXMgY2hhbmdlZCwgMSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9u
cygtKQoKZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vc3BpL3NwaWRldl90ZXN0LmMgYi9Eb2N1
bWVudGF0aW9uL3NwaS9zcGlkZXZfdGVzdC5jCmluZGV4IGNmMGUzY2UuLjMxNWMwZjEgMTAwNjQ0
Ci0tLSBhL0RvY3VtZW50YXRpb24vc3BpL3NwaWRldl90ZXN0LmMKKysrIGIvRG9jdW1lbnRhdGlv
bi9zcGkvc3BpZGV2X3Rlc3QuYwpAQCAtNTEsNyArNTEsNyBAQCBzdGF0aWMgdm9pZCB0cmFuc2Zl
cihpbnQgZmQpCiAJc3RydWN0IHNwaV9pb2NfdHJhbnNmZXIgdHIgPSB7CiAJCS50eF9idWYgPSAo
dW5zaWduZWQgbG9uZyl0eCwKIAkJLnJ4X2J1ZiA9ICh1bnNpZ25lZCBsb25nKXJ4LAotCQkubGVu
ID0gQVJSQVlfU0laRSh0eCksCisJCS5sZW4gPSBzaXplb2YodHgpLAogCQkuZGVsYXlfdXNlY3Mg
PSBkZWxheSwKIAkJLnNwZWVkX2h6ID0gc3BlZWQsCiAJCS5iaXRzX3Blcl93b3JkID0gYml0cywK
LS0gCjEuNS40LjMKCg==

------_=_NextPart_001_01C9B8F2.6E352BCA
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.net email is sponsored by:
High Quality Requirements in a Collaborative Environment.
Download a free trial of Rational Requirements Composer Now!
http://p.sf.net/sfu/www-ibm-com
------_=_NextPart_001_01C9B8F2.6E352BCA
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
spi-devel-general mailing list
spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/spi-devel-general

------_=_NextPart_001_01C9B8F2.6E352BCA--
