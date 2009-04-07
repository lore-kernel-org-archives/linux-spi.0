From: =?iso-8859-1?Q?LEMERCIER_Gr=E9gory?= <glemercier-zjFYp9kwZlmZox4op4iWzw@public.gmane.org>
Subject: Patch submission for fixing a bug in the SPIDEV
	driver.
Date: Tue, 7 Apr 2009 14:24:45 +0200
Message-ID: <51D9710FF5643747BB605F97B8DE56CD02772FCF@STEGOSAURE.adetel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C9B77B.D678104B"
Cc: dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	=?iso-8859-1?Q?CLEMENT_Gr=E9gory?= <gclement-zjFYp9kwZlmZox4op4iWzw@public.gmane.org>
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

------_=_NextPart_001_01C9B77B.D678104B
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_002_01C9B77B.D678104B"


------_=_NextPart_002_01C9B77B.D678104B
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello,

=20

When using the SPIDEV driver from the kernel, I found out that there is =
a bug that occurs when sending words of width larger than 8 bits. The =
buffer copy from Userspace will only copy "number of words" bytes where =
it should actually copy  "number of words * sizeof(word)" bytes. This is =
harmless when using 8 bit words but becomes an issue when using 32 bit =
words for instance.

=20

Below and attached to this mail is a patch that fixes this:

=20

-----Start of file =
-------------------------------------------------------------------------=
------------------------------

=20

>From 9f7e34189767fff61f5bb48495c43fab9c15394b Mon Sep 17 00:00:00 2001

From: Gregory Lemercier <glemercier-HH5893ap9ioXz/+GnIZSFEEOCMrvLtNR@public.gmane.org>

Date: Tue, 24 Mar 2009 14:53:30 +0100

Subject: [PATCH] Fixes SPIDEV driver bug when used with more than 8bit =
words

=20

=20

Signed-off-by: Gregory Lemercier <glemercier-HH5893ap9ioXz/+GnIZSFEEOCMrvLtNR@public.gmane.org>

---

 drivers/spi/spidev.c |    2 +-

 1 files changed, 1 insertions(+), 1 deletions(-)

=20

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c

index f5b60c7..9c87979 100644

--- a/drivers/spi/spidev.c

+++ b/drivers/spi/spidev.c

@@ -252,7 +252,7 @@ static int spidev_message(struct spidev_data =
*spidev,

                                               k_tmp->tx_buf =3D buf;

                                               if (copy_from_user(buf, =
(const u8 __user *)

                                                                         =
                     (uintptr_t) u_tmp->tx_buf,

-                                                                        =
     u_tmp->len))

+                                                            u_tmp->len =
* (u_tmp->bits_per_word / 8)))

                                                               goto =
done;

                               }

                               buf +=3D k_tmp->len;

--=20

1.5.4.3 =20

=20

-----End of file =
-------------------------------------------------------------------------=
------------------------------

Please let me know about the outcome of this patch submission. Thanks,

Gr=E9gory LEMERCIER
Embedded Software Engineer

Adeneo Embedded

Adetel Group
2, chemin du Ruisseau=20
69134 ECULLY - FRANCE=20
T=E9l. : +33 (0)4 72 18 08 40 - Fax : +33 (0)4 72 18 08 41

www.adeneo-embedded.com <http://www.adeneo-embedded.com/>=20
www.adetelgroup.com <http://www.adetelgroup.com/>=20


------_=_NextPart_002_01C9B77B.D678104B
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<meta name=3DGenerator content=3D"Microsoft Word 12 (filtered medium)">
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Verdana;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page Section1
	{size:612.0pt 792.0pt;
	margin:70.85pt 70.85pt 70.85pt 70.85pt;}
div.Section1
	{page:Section1;}
-->
</style>
<!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext=3D"edit">
  <o:idmap v:ext=3D"edit" data=3D"1" />
 </o:shapelayout></xml><![endif]-->
</head>

<body lang=3DFR link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><span =
style=3D'color:#1F497D'>Hello,<o:p></o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'color:#1F497D'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'color:#1F497D'>When =
using the SPIDEV
driver from the kernel, I found out that there is a bug that occurs when
sending words of width larger than 8 bits. The buffer copy from =
Userspace will
only copy &#8220;number of words&#8221; bytes where it should actually =
copy =A0&#8220;number
of words * sizeof(word)&#8221; bytes. This is harmless when using 8 bit =
words
but becomes an issue when using 32 bit words for =
instance.<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US =
style=3D'color:#1F497D'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'color:#1F497D'>Below =
and attached to
this mail is a patch that fixes this:<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>-----Start of file =
-------------------------------------------------------------------------=
------------------------------<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>From
9f7e34189767fff61f5bb48495c43fab9c15394b Mon Sep 17 00:00:00 =
2001<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>From: Gregory Lemercier
&lt;glemercier-HH5893ap9ioXz/+GnIZSFEEOCMrvLtNR@public.gmane.org&gt;<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>Date: Tue, 24 Mar 2009 14:53:30 =
+0100<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>Subject: [PATCH] Fixes SPIDEV =
driver bug
when used with more than 8bit words<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>Signed-off-by: Gregory Lemercier
&lt;glemercier-HH5893ap9ioXz/+GnIZSFEEOCMrvLtNR@public.gmane.org&gt;<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>---<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>=A0drivers/spi/spidev.c =
|=A0=A0=A0 2 +-<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>=A01 files changed, 1 =
insertions(+), 1 deletions(-)<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>diff --git =
a/drivers/spi/spidev.c
b/drivers/spi/spidev.c<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>index f5b60c7..9c87979 =
100644<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>--- =
a/drivers/spi/spidev.c<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>+++ =
b/drivers/spi/spidev.c<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>@@ -252,7 +252,7 @@ static int
spidev_message(struct spidev_data *spidev,<o:p></o:p></span></p>

<p class=3DMsoNormal><span =
lang=3DEN-US>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 k_tmp-&gt;tx_buf
=3D buf;<o:p></o:p></span></p>

<p class=3DMsoNormal><span =
lang=3DEN-US>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 if
(copy_from_user(buf, (const u8 __user *)<o:p></o:p></span></p>

<p class=3DMsoNormal><span =
lang=3DEN-US>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
</span>(uintptr_t)
u_tmp-&gt;tx_buf,<o:p></o:p></p>

<p class=3DMsoNormal><span =
lang=3DEN-US>-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 u_tmp-&gt;len))<o:p></o:p></span></p>

<p class=3DMsoNormal><span =
lang=3DEN-US>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 u_tmp-&gt;len
* (u_tmp-&gt;bits_per_word / 8)))<o:p></o:p></span></p>

<p class=3DMsoNormal><span =
lang=3DEN-US>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto
done;<o:p></o:p></span></p>

<p class=3DMsoNormal><span =
lang=3DEN-US>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }<o:p></o:p></span></p>

<p class=3DMsoNormal><span =
lang=3DEN-US>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 buf +=3D
k_tmp-&gt;len;<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>-- <o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>1.5.4.3 =
=A0<o:p></o:p></span></p>

<div>

<p class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>-----End of file =
-------------------------------------------------------------------------=
------------------------------<o:p></o:p></span></p>

<p class=3DMsoNormal =
style=3D'mso-margin-top-alt:auto;mso-margin-bottom-alt:auto'><span
lang=3DEN-US style=3D'color:#1F497D'>Please let me know about the =
outcome of this
patch submission. Thanks,</span><i><span lang=3DEN-GB =
style=3D'font-family:"Verdana","sans-serif";
color:#1F497D'><o:p></o:p></span></i></p>

<p class=3DMsoNormal =
style=3D'mso-margin-top-alt:auto;mso-margin-bottom-alt:auto'><i><span
lang=3DEN-GB =
style=3D'font-family:"Verdana","sans-serif";color:#1F497D'>Gr=E9gory&nbsp=
;LEMERCIER</span></i><i><span
lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Times New =
Roman","serif";
color:navy'><br>
</span></i><i><span lang=3DEN-GB =
style=3D'font-size:12.0pt;font-family:"Verdana","sans-serif";
color:navy'>Embedded Software Engineer</span></i><span lang=3DEN-GB
style=3D'font-size:12.0pt;font-family:"Times New =
Roman","serif";color:navy'><o:p></o:p></span></p>

<p class=3DMsoNormal =
style=3D'mso-margin-top-alt:auto;mso-margin-bottom-alt:auto'><b><i><span
lang=3DEN-GB =
style=3D'font-size:14.0pt;font-family:"Verdana","sans-serif";
color:#000099'>Aden</span></i></b><b><i><span lang=3DEN-GB =
style=3D'font-size:14.0pt;
font-family:"Verdana","sans-serif";color:#99CC00'>e</span></i></b><b><i><=
span
lang=3DEN-GB =
style=3D'font-size:14.0pt;font-family:"Verdana","sans-serif";
color:#FF8B16'>o </span></i></b><b><i><span lang=3DEN-GB =
style=3D'font-size:14.0pt;
font-family:"Verdana","sans-serif";color:#000099'>Embedded</span></i></b>=
<span
lang=3DEN-GB style=3D'font-size:14.0pt;font-family:"Times New =
Roman","serif";
color:navy'><o:p></o:p></span></p>

<p class=3DMsoNormal =
style=3D'mso-margin-top-alt:auto;mso-margin-bottom-alt:auto'><b><i><span
style=3D'font-size:10.0pt;font-family:"Verdana","sans-serif";color:#00009=
9'>Adetel
</span></i></b><b><i><span =
style=3D'font-size:10.0pt;font-family:"Verdana","sans-serif";
color:#99CC00'>Group</span></i></b><span =
style=3D'font-size:10.0pt;font-family:
"Times New Roman","serif";color:navy'><br>
</span><i><span =
style=3D'font-size:10.0pt;font-family:"Verdana","sans-serif";
color:navy'>2, chemin du Ruisseau</span></i><span =
style=3D'font-size:12.0pt;
font-family:"Verdana","sans-serif";color:navy'> <br>
</span><i><span =
style=3D'font-size:10.0pt;font-family:"Verdana","sans-serif";
color:navy'>69134 ECULLY - FRANCE</span></i><span =
style=3D'font-size:12.0pt;
font-family:"Verdana","sans-serif";color:navy'> <br>
</span><i><u><span =
style=3D'font-size:10.0pt;font-family:"Verdana","sans-serif";
color:navy'>T=E9l.</span></u></i><i><span =
style=3D'font-size:10.0pt;font-family:
"Verdana","sans-serif";color:navy'> : +33 (0)4 72 18 08 40 =
-</span></i><i><u><span
style=3D'font-size:12.0pt;font-family:"Verdana","sans-serif";color:navy'>=
 </span></u></i><i><u><span
style=3D'font-size:10.0pt;font-family:"Verdana","sans-serif";color:navy'>=
Fax</span></u></i><i><span
style=3D'font-size:10.0pt;font-family:"Verdana","sans-serif";color:navy'>=
 : +33
(0)4 72 18 08 41</span></i><span =
style=3D'font-size:12.0pt;font-family:"Times New Roman","serif";
color:navy'><o:p></o:p></span></p>

</div>

<p class=3DMsoNormal><i><span =
style=3D'font-size:10.0pt;font-family:"Verdana","sans-serif";
color:navy'><a href=3D"http://www.adeneo-embedded.com/"
title=3D"http://www.adeneo-embedded.com/"><span =
style=3D'color:blue'>www.adeneo-embedded.com</span></a></span></i><b><i><=
span
style=3D'font-size:10.0pt;font-family:"Verdana","sans-serif";color:#7030A=
0'><br>
</span></i></b><i><span =
style=3D'font-size:10.0pt;font-family:"Verdana","sans-serif";
color:navy'><a href=3D"http://www.adetelgroup.com/"
title=3D"http://www.adetelgroup.com/"><span =
style=3D'color:blue'>www.adetelgroup.com</span></a></span></i><o:p></o:p>=
</p>

</div>

</body>

</html>

------_=_NextPart_002_01C9B77B.D678104B--

------_=_NextPart_001_01C9B77B.D678104B
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

------_=_NextPart_001_01C9B77B.D678104B
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.net email is sponsored by:
High Quality Requirements in a Collaborative Environment.
Download a free trial of Rational Requirements Composer Now!
http://p.sf.net/sfu/www-ibm-com
------_=_NextPart_001_01C9B77B.D678104B
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
spi-devel-general mailing list
spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/spi-devel-general

------_=_NextPart_001_01C9B77B.D678104B--
