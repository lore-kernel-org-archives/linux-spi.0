From: =?iso-8859-1?Q?LEMERCIER_Gr=E9gory?= <glemercier-zjFYp9kwZlmZox4op4iWzw@public.gmane.org>
Subject: Patch submission for fixing a bug in the SPIDEV
	driver.
Date: Tue, 7 Apr 2009 16:17:27 +0200
Message-ID: <51D9710FF5643747BB605F97B8DE56CD02773126@STEGOSAURE.adetel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C9B78B.95183153"
Cc: dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
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

------_=_NextPart_001_01C9B78B.95183153
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

 <<Fixes-SPIDEV-driver-bug-when-used-with-more-than-8bit-words.patch>> =
Hello,

When using the SPIDEV driver from the kernel, I found out that there is =
a bug that occurs when sending words of width larger than 8 bits. The =
buffer copy from Userspace will only copy "number of words" bytes where =
it should actually copy =A0"number of words * sizeof(word)" bytes. This =
is harmless when using 8 bit words but becomes an issue when using 32 =
bit words for instance.

Below and attached to this mail is a patch that fixes this:

-----Start of file =
-------------------------------------------------------------------------=
------------------

>From 9f7e34189767fff61f5bb48495c43fab9c15394b Mon Sep 17 00:00:00 2001
From: Gregory Lemercier <glemercier-HH5893ap9ioXz/+GnIZSFEEOCMrvLtNR@public.gmane.org>
Date: Tue, 24 Mar 2009 14:53:30 +0100
Subject: [PATCH] Fixes SPIDEV driver bug when used with more than 8bit =
words


Signed-off-by: Gregory Lemercier <glemercier-HH5893ap9ioXz/+GnIZSFEEOCMrvLtNR@public.gmane.org>
---
 drivers/spi/spidev.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index f5b60c7..9c87979 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -252,7 +252,7 @@ static int spidev_message(struct spidev_data =
*spidev,
 			k_tmp->tx_buf =3D buf;
 			if (copy_from_user(buf, (const u8 __user *)
 						(uintptr_t) u_tmp->tx_buf,
-					u_tmp->len))
+				u_tmp->len * (u_tmp->bits_per_word / 8)))
 				goto done;
 		}
 		buf +=3D k_tmp->len;
--=20
1.5.4.3

-----End of file =
-------------------------------------------------------------------------=
-------------------

Please let me know about the outcome of this patch submission. Thanks,

Gr=E9gory=A0LEMERCIER

Embedded Software Engineer
Adeneo Embedded
Adetel Group
2, chemin du Ruisseau=20
69134 ECULLY - FRANCE=20
T=E9l. : +33 (0)4 72 18 08 40 - Fax : +33 (0)4 72 18 08 41
www.adeneo-embedded.com
www.adetelgroup.com

------_=_NextPart_001_01C9B78B.95183153
Content-Type: application/octet-stream;
	name="Fixes-SPIDEV-driver-bug-when-used-with-more-than-8bit-words.patch"
Content-Transfer-Encoding: base64
Content-Description: Fixes-SPIDEV-driver-bug-when-used-with-more-than-8bit-words.patch
Content-Disposition: attachment;
	filename="Fixes-SPIDEV-driver-bug-when-used-with-more-than-8bit-words.patch"

RnJvbSA5ZjdlMzQxODk3NjdmZmY2MWY1YmI0ODQ5NWM0M2ZhYjljMTUzOTRiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBHcmVnb3J5IExlbWVyY2llciA8Z2xlbWVyY2llckBhZGVuZW8t
ZW1iZWRkZWQuY29tPgpEYXRlOiBUdWUsIDI0IE1hciAyMDA5IDE0OjUzOjMwICswMTAwClN1Ympl
Y3Q6IFtQQVRDSF0gRml4ZXMgU1BJREVWIGRyaXZlciBidWcgd2hlbiB1c2VkIHdpdGggbW9yZSB0
aGFuIDhiaXQgd29yZHMKCgpTaWduZWQtb2ZmLWJ5OiBHcmVnb3J5IExlbWVyY2llciA8Z2xlbWVy
Y2llckBhZGVuZW8tZW1iZWRkZWQuY29tPgotLS0KIGRyaXZlcnMvc3BpL3NwaWRldi5jIHwgICAg
MiArLQogMSBmaWxlcyBjaGFuZ2VkLCAxIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb25zKC0pCgpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9zcGkvc3BpZGV2LmMgYi9kcml2ZXJzL3NwaS9zcGlkZXYuYwpp
bmRleCBmNWI2MGM3Li45Yzg3OTc5IDEwMDY0NAotLS0gYS9kcml2ZXJzL3NwaS9zcGlkZXYuYwor
KysgYi9kcml2ZXJzL3NwaS9zcGlkZXYuYwpAQCAtMjUyLDcgKzI1Miw3IEBAIHN0YXRpYyBpbnQg
c3BpZGV2X21lc3NhZ2Uoc3RydWN0IHNwaWRldl9kYXRhICpzcGlkZXYsCiAJCQlrX3RtcC0+dHhf
YnVmID0gYnVmOwogCQkJaWYgKGNvcHlfZnJvbV91c2VyKGJ1ZiwgKGNvbnN0IHU4IF9fdXNlciAq
KQogCQkJCQkJKHVpbnRwdHJfdCkgdV90bXAtPnR4X2J1ZiwKLQkJCQkJdV90bXAtPmxlbikpCisJ
CQkJdV90bXAtPmxlbiAqICh1X3RtcC0+Yml0c19wZXJfd29yZCAvIDgpKSkKIAkJCQlnb3RvIGRv
bmU7CiAJCX0KIAkJYnVmICs9IGtfdG1wLT5sZW47Ci0tIAoxLjUuNC4zCgo=

------_=_NextPart_001_01C9B78B.95183153
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.net email is sponsored by:
High Quality Requirements in a Collaborative Environment.
Download a free trial of Rational Requirements Composer Now!
http://p.sf.net/sfu/www-ibm-com
------_=_NextPart_001_01C9B78B.95183153
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
spi-devel-general mailing list
spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/spi-devel-general

------_=_NextPart_001_01C9B78B.95183153--
