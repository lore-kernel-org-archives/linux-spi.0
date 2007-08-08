From: "=?UTF-8?B?6rCV7IOB7Jqw?=" <ksw412-cum4M3oa/1ZBDgjK7y7TUQ@public.gmane.org>
Subject: Re:
	=?utf-8?q?I_can=27t_see_the_SPI_device_file_i?=
	=?utf-8?q?n_/dev=2E?=
Date: Wed, 08 Aug 2007 10:27:51 +0900
Message-ID: <1186536477528398.0.mail04@mail04>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1437695236=="
Cc: =?UTF-8?B?RGF2aWQgQnJvd25lbGw=?= <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

--===============1437695236==
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<style> BODY { background-color: #ffffff;}            BODY, TD, TH { colo=
r: black; font-family: =EA=B5=B4=EB=A6=BC; font-size: 12px; }            =
TD { border: 0px}             P { margin: 0px; }     </style><P>hum...I'm=
 sorry.I resend the post</P>
<P>&nbsp;
<P>----------------------------------------------------------------------=
--------------
<P>Hi~&nbsp; <BR>My developing Environment is below. </P>
<P>Kernel-2.6.22.1<BR>&nbsp;&nbsp;&nbsp;&nbsp; tar jxvf linux-2.6.22.1.ta=
r.bz2<BR>&nbsp;&nbsp;&nbsp;&nbsp; cd linux-2.6.22.1<BR>&nbsp;&nbsp;&nbsp;=
&nbsp; zcat ../2.6.22-rc1-at91.patch.gz | patch -p1 &gt; patchresult.txt<=
BR>CPU-AT91SAM9260 </P>
<P>Through the web searching and kernel documentation, I know that use th=
e spidev kernel module. <BR>And I modify arch/at-91/board_sam9260.c file =
as like below </P>
<P>&nbsp;</P>
<P>static struct spi_board_info ek_spi_devices[] =3D { <BR>{ //spi1.0-slo=
t1 <BR>&nbsp;&nbsp; .modalias =3D "spidev", <BR>&nbsp;&nbsp; .chip_select=
 =3D 0, <BR>&nbsp;&nbsp; .max_speed_hz =3D 15*1000*1000, <BR>&nbsp;&nbsp;=
 .bus_num=3D1, <BR>}, <BR>{ //spi1.1-slot2 <BR>&nbsp;&nbsp; .modalias =3D=
 "spidev", <BR>&nbsp;&nbsp; .chip_select =3D 1, <BR>&nbsp;&nbsp; .max_spe=
ed_hz =3D 15*1000*1000, <BR>&nbsp;&nbsp; .bus_num=3D1, <BR>}, <BR>&nbsp;&=
nbsp;&nbsp; ~<BR>} </P>
<P>&nbsp;</P>
<P>After compiling the kernel, download kernel img to the target. <BR>Ker=
nel menu_config.</P>
<P>&nbsp;</P>
<P>Device Drivers<BR>&nbsp;SPI support<BR>&nbsp;&nbsp;&nbsp; [*]SPI suppo=
rt<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [*]Debug support for SPI=
 drivers<BR>&nbsp;&nbsp;&nbsp;&nbsp; SPI Master Controller Drivers<BR>&nb=
sp;&nbsp;&nbsp;&nbsp; [*]Atmel SPI controller<BR>&nbsp;&nbsp;&nbsp;&nbsp;=
 [ ]Bitbanging SPI master<BR>&nbsp;&nbsp;&nbsp;&nbsp; SPI Protocol Master=
s<BR>&nbsp;&nbsp;&nbsp;&nbsp; [ ]SPI EEPROMs from most vendors<BR>&nbsp;&=
nbsp;&nbsp;&nbsp; [*]User mode SPI device driver support</P>
<P>&nbsp;</P>
<P>I execute the "/sbin/mdev -s" command into the target shell as expecti=
ng the /dev/spidev. <BR>But I can't see the device file for SPI in target=
 /dev folder. And I examin my /sys folder at target. <BR>Of course, I can=
 find the spi device nodes created from modified board_sam9260.c. <BR>Hum=
...I don't know why did not populate the SPI device file in /dev file? </=
P>
<P>&nbsp;</P>
<P>#dmesg | grep spi<BR>atmel_spi atmel_spi.1: Atmel SPI Controller at 0x=
fffcc000 (irq 13) <BR>atmel_spi atmel_spi.1: registered master spi1 <BR>s=
pi spi1.0: setup: 14189714 Hz bpw 8 mode 0x0 -&gt; csr0 0a0a0702 <BR>atme=
l_spi atmel_spi.1: registered child spi1.0 <BR>spi spi1.1: setup: 1418971=
4 Hz bpw 8 mode 0x0 -&gt; csr1 0a0a0702 <BR>atmel_spi atmel_spi.1: regist=
ered child spi1.1 <BR>spi spi1.2: setup: 14189714 Hz bpw 8 mode 0x0 -&gt;=
 csr2 0a0a0702 <BR>atmel_spi atmel_spi.1: registered child spi1.2 <BR>spi=
 spi1.3: setup: 14189714 Hz bpw 8 mode 0x0 -&gt; csr3 0a0a0702 <BR>atmel_=
spi atmel_spi.1: registered child spi1.3 </P>
<P>&nbsp;</P>
<P>Does root file system (NFS) has the problem ? or Kernel menu configura=
tion ?<BR>Could you teach check point for this problem?</P>
<P>&nbsp;</P>
<P>This project name - Access control Unit<BR>The system is configured tw=
o kind of board.<BR>Main b'd has the AT91SAM9260 which has the Linux OS.<=
BR>Sub b'd has the Atmega2560 which is developing the AVR32 studio.<BR>On=
e Main b'd is connected 5 Sub b'd by SPI<BR>Sub b'd is connected door loc=
k by wiegend.<BR>Main b'd is connected ACU server by TCP/IP.</P>
<P>&nbsp;</P>
<P>And SPI Interface is very important!. Other communication interface is=
 done.</P>
<P>Please Help me~. I had reported this problems to atmel and at91 but I =
did not receive any reply~</P>
<img src=3D"http://mbox03.hanafos.com/mail/PutAck.jsp?ack_args=3Dc2VudF9m=
aWxlPWtzdzQxMkBoYW5hZm9zLmNvbS8uU2VudC8xMTg2NTM2NDcxMTAyLjQ2MDc0LmhhbmFmb=
3Mmc2VuZF9kYXRlPTIwMDcwODA4MTAyNzUxJnN1YmplY3Q9UmU6UmU6IFtzcGktZGV2ZWwtZ2=
VuZXJhbF0gSSBjYW4ndCBzZWUgdGhlIFNQSSBkZXZpY2UgZmlsZSBpbiAvZGV2Lg=3D=3D&to=
_email=3Dspi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org_________________________=
_________________________________________________________________________=
_____________" width=3D"1" border=3D"0" height=3D"1">




--===============1437695236==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--===============1437695236==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
spi-devel-general mailing list
spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/spi-devel-general

--===============1437695236==--
