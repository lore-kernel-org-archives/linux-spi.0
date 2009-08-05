From: nitin vishnoi <nitvishnoi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Regarding SPI DRIVER
Date: Wed, 5 Aug 2009 11:48:34 +0530
Message-ID: <64a922780908042318o7adfd135o4e86d5e806b683ec@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2236636447926361354=="
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

--===============2236636447926361354==
Content-Type: multipart/alternative; boundary=0016363b7d7417bb7704705ef983

--0016363b7d7417bb7704705ef983
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi All

As of now i am making a spi slave driver,But in the probe of my slave device
driver which i am writing in linux plateform,i am not able to read and write
registers value of my slave chip using spi_write and spi_read.And whenever
its going to spi_async  its giving kernel panic.

The code flow will be like this.

/include/linux/spi/spi.h

static inline int
spi_write(struct spi_device *spi, const u8 *buf, size_t len)
{
       printk("*********inside spi_write************\n");
       struct spi_transfer     t = {
                       .tx_buf         = buf,
                       .len            = len,
               };
       struct spi_message      m;

       spi_message_init(&m);
       spi_message_add_tail(&t, &m);
       return spi_sync(spi, &m);
}

/include/linux/spi.c

int spi_sync(struct spi_device *spi, struct spi_message *message)
{
       DECLARE_COMPLETION_ONSTACK(done);
       int status;

       message->complete = spi_complete;
       message->context = &done;
       status = spi_async(spi, message);           //Error is giving in this
function
       if (status == 0)
               wait_for_completion(&done);
       message->context = NULL;
       return status;
}


And the following error is coming.


*********inside spi_write************
*********inside spi_message_init*********
********inside spi_message_add_tail*******
*****1***inside spi_sync*************
*****2***inside spi_sync*************
****3****inside spi_sync*************
****4****inside spi_sync*************
Unable to handle kernel NULL pointer dereference at virtual address 00000000
pgd = c0004000
[00000000] *pgd=00000000
Internal error: Oops: 0 [#1]
Modules linked in:
CPU: 0
PC is at __init_begin+0x3fff8000/0x30
LR is at spi_sync+0x74/0xec
pc : [<00000000>]    lr : [<c0143ad8>]    Not tainted
sp : c028dc48  ip : c028db80  fp : c028dc74
r10: c1f56668  r9 : c1f56600  r8 : 00000002
r7 : 00000000  r6 : c028dc4c  r5 : c028dc84  r4 : c1f56600
r3 : c02ec800  r2 : 00000000  r1 : c028dc84  r0 : c1f56600
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  Segment kernel
Control: 5317F
Table: 30004000  DAC: 00000017
Process swapper (pid: 1, stack limit = 0xc028c258)
Stack: (0xc028dc48 to 0xc028e000)
dc40:                   c003b0d8 00000000 c028dc50 c028dc50 c028dc84
c028dccc
dc60: c028dcd6 c028dcb0 c028dd04 c028dc78 c011c780 c0143a74 c2bb68c0
c2bb5c60
dc80: c028dcac c028dccc c028dccc c1f56600 00000000 c0143b50 c028dc4c
00000000
dca0: 00000000 00000000 00000000 00000000 c028dcd6 00000000 00000002
00000000
dcc0: 00000000 00000000 00000000 c028dc84 c028dc84 90000000 c1f56668
c1f56600
dce0: c01baf14 c01baf14 c028dd74 c2bb5cc0 00000000 c1f56668 c028dd14
c028dd08
dd00: c01441dc c011c624 c028dd3c c028dd18 c0124a7c c01441cc c028dd64
c2bb5cc0
dd20: c01baf14 c1f56600 c028dd74 00000000 c028dd5c c028dd40 c0124bec
c01249d8
dd40: c028dd6c 00000000 c0124bfc c1f56600 c028dd6c c028dd60 c0124c0c
c0124b4c
dd60: c028dd9c c028dd70 c0123dbc c0124c0c c00b66b0 c01bd138 c01bd138
c01baf74
dd80: c1f566d8 c01bd028 c02ec800 00000000 c028ddb4 c028dda0 c0124ca0
c0123d7c
dda0: 00000000 c1f56600 c028ddcc c028ddb8 c0123cec c0124c4c c1f56600
c1f56600
ddc0: c028de14 c028ddd0 c0122794 c0123ccc 00000000 c1f566a4 c1f566c0
c01b0078
dde0: 00000000 c00f03dc c1f56600 c1f56600 c1f56600 c02ec800 c01b0078
c1f566a4
de00: c02ec800 c02ec950 c028de2c c028de18 c0122aac c01223b4 c028de5c
c01b2568
de20: c028de5c c028de30 c0143d00 c0122a9c 00000000 c003adb4 c01b2568
c02ec9f0
de40: 00000001 c01b0070 c01b0078 00000000 c028de94 c028de60 c0145b44
c0143c28
de60: c01bd3c0 00000000 c01b00e0 c01b0078 c01bd320 c01bd320 c01bd320
c2bb5e80
de80: 00000000 c001bb84 c028dea4 c028de98 c01264e8 c014581c c028decc
c028dea8
dea0: c0124a7c c01264d8 c02a1047 c2bb5e80 c01bd320 c01b0078 c01bd320
c028dfa0
dec0: c028deec c028ded0 c0124bec c01249d8 c0150e94 c01b0150 c01b0078
c0124ccc
dee0: c028df04 c028def0 c0124d50 c0124b4c 00000000 c028df0c c028df34
c028df08
df00: c0123ef0 c0124cdc 00000000 c01bb708 c01bb708 c01b00c0 c01bd320
c01bd334
df20: 00000000 c01bb608 c028df44 c028df38 c01248e4 c0123eb0 c028df64
c028df48
df40: c0124244 c01248d4 c01bd320 c001b684 c028c000 00000000 c028df7c
c028df68
df60: c0125004 c01241f4 c028c000 00000000 c028df8c c028df80 c0126780
c0124f80
df80: c028df9c c028df90 c001ad58 c0126724 c028dff4 c028dfa0 c000890c
c001ad4c
dfa0: 00000000 c028dfb0 c001fce4 c0036d2c 00000000 00000000 c0008874
c003d21c
dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000
dfe0: 00000000 00000000 00000000 c028dff8 c003d21c c0008884 7369646c
6c665f63
Backtrace:
[<c0143a64>] (spi_sync+0x0/0xec) from [<c011c780>] (m1172_probe+0x16c/0x390)
r7 = C028DCB0  r6 = C028DCD6  r5 = C028DCCC  r4 = C028DC84
[<c011c614>] (m1172_probe+0x0/0x390) from [<c01441dc>]
(spi_drv_probe+0x20/0x24)
[<c01441bc>] (spi_drv_probe+0x0/0x24) from [<c0124a7c>]
(really_probe+0xb4/0x174)
[<c01249c8>] (really_probe+0x0/0x174) from [<c0124bec>]
(driver_probe_device+0xb0/0xc0)
r8 = 00000000  r7 = C028DD74  r6 = C1F56600  r5 = C01BAF14
r4 = C2BB5CC0




Please help me out for this why any register reading writing is not
happening at slave device level.

Regards

Nitin vishnoi

--0016363b7d7417bb7704705ef983
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi All<br><br>As of now i am making a spi slave driver,But in the probe of =
my slave device driver which i am writing in linux plateform,i am not able =
to read and write registers value of my slave chip using spi_write and spi_=
read.And whenever its going to spi_async =A0its giving kernel panic.<br>
<br>The code flow will be like this.<br><br>/include/linux/spi/spi.h<br><br=
>static inline int<br>spi_write(struct spi_device *spi, const u8 *buf, size=
_t len)<br>{<br>=A0 =A0 =A0 =A0printk(&quot;*********inside spi_write******=
******\n&quot;);<br>
=A0 =A0 =A0 =A0struct spi_transfer =A0 =A0 t =3D {<br>=A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0.tx_buf =A0 =A0 =A0 =A0 =3D buf,<br>=A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.len =A0 =A0 =A0 =A0 =A0 =A0=3D len,<br>=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0};<br>=A0 =A0 =A0 =A0struct spi_message =A0 =
=A0 =A0m;<br><br>=A0 =A0 =A0 =A0spi_message_init(&amp;m);<br>
=A0 =A0 =A0 =A0spi_message_add_tail(&amp;t, &amp;m);<br>=A0 =A0 =A0 =A0retu=
rn spi_sync(spi, &amp;m);<br>}<br><br>/include/linux/spi.c<br><br>int spi_s=
ync(struct spi_device *spi, struct spi_message *message)<br>{<br>=A0 =A0 =
=A0 =A0DECLARE_COMPLETION_ONSTACK(done);<br>
=A0 =A0 =A0 =A0int status;<br><br>=A0 =A0 =A0 =A0message-&gt;complete =3D s=
pi_complete;<br>=A0 =A0 =A0 =A0message-&gt;context =3D &amp;done;<br>=A0 =
=A0 =A0 =A0status =3D spi_async(spi, message); =A0 =A0 =A0 =A0 =A0<span sty=
le=3D"color: rgb(255, 102, 102);"> //Error is giving in this function</span=
><br>
=A0 =A0 =A0 =A0if (status =3D=3D 0)<br>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0wait_=
for_completion(&amp;done);<br>=A0 =A0 =A0 =A0message-&gt;context =3D NULL;<=
br>=A0 =A0 =A0 =A0return status;<br>}<br><br><br>And the following error is=
 coming.<br><br><br>*********inside spi_write************<br>
*********inside spi_message_init*********<br>********inside spi_message_add=
_tail*******<br>*****1***inside spi_sync*************<br>*****2***inside sp=
i_sync*************<br>****3****inside spi_sync*************<br>****4****in=
side spi_sync*************<br>
Unable to handle kernel NULL pointer dereference at virtual address 0000000=
0<br>pgd =3D c0004000<br>[00000000] *pgd=3D00000000<br>Internal error: Oops=
: 0 [#1]<br>Modules linked in:<br>CPU: 0<br>PC is at __init_begin+0x3fff800=
0/0x30<br>
LR is at spi_sync+0x74/0xec<br>pc : [&lt;00000000&gt;] =A0 =A0lr : [&lt;c01=
43ad8&gt;] =A0 =A0Not tainted<br>sp : c028dc48 =A0ip : c028db80 =A0fp : c02=
8dc74<br>r10: c1f56668 =A0r9 : c1f56600 =A0r8 : 00000002<br>r7 : 00000000 =
=A0r6 : c028dc4c =A0r5 : c028dc84 =A0r4 : c1f56600<br>
r3 : c02ec800 =A0r2 : 00000000 =A0r1 : c028dc84 =A0r0 : c1f56600<br>Flags: =
nZCv =A0IRQs on =A0FIQs on =A0Mode SVC_32 =A0Segment kernel<br>Control: 531=
7F<br>Table: 30004000 =A0DAC: 00000017<br>Process swapper (pid: 1, stack li=
mit =3D 0xc028c258)<br>
Stack: (0xc028dc48 to 0xc028e000)<br>dc40: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 c003b0d8 00000000 c028dc50 c028dc50 c028dc84 c028dccc <br>dc60: c028dcd=
6 c028dcb0 c028dd04 c028dc78 c011c780 c0143a74 c2bb68c0 c2bb5c60 <br>dc80: =
c028dcac c028dccc c028dccc c1f56600 00000000 c0143b50 c028dc4c 00000000 <br=
>
dca0: 00000000 00000000 00000000 00000000 c028dcd6 00000000 00000002 000000=
00 <br>dcc0: 00000000 00000000 00000000 c028dc84 c028dc84 90000000 c1f56668=
 c1f56600 <br>dce0: c01baf14 c01baf14 c028dd74 c2bb5cc0 00000000 c1f56668 c=
028dd14 c028dd08 <br>
dd00: c01441dc c011c624 c028dd3c c028dd18 c0124a7c c01441cc c028dd64 c2bb5c=
c0 <br>dd20: c01baf14 c1f56600 c028dd74 00000000 c028dd5c c028dd40 c0124bec=
 c01249d8 <br>dd40: c028dd6c 00000000 c0124bfc c1f56600 c028dd6c c028dd60 c=
0124c0c c0124b4c <br>
dd60: c028dd9c c028dd70 c0123dbc c0124c0c c00b66b0 c01bd138 c01bd138 c01baf=
74 <br>dd80: c1f566d8 c01bd028 c02ec800 00000000 c028ddb4 c028dda0 c0124ca0=
 c0123d7c <br>dda0: 00000000 c1f56600 c028ddcc c028ddb8 c0123cec c0124c4c c=
1f56600 c1f56600 <br>
ddc0: c028de14 c028ddd0 c0122794 c0123ccc 00000000 c1f566a4 c1f566c0 c01b00=
78 <br>dde0: 00000000 c00f03dc c1f56600 c1f56600 c1f56600 c02ec800 c01b0078=
 c1f566a4 <br>de00: c02ec800 c02ec950 c028de2c c028de18 c0122aac c01223b4 c=
028de5c c01b2568 <br>
de20: c028de5c c028de30 c0143d00 c0122a9c 00000000 c003adb4 c01b2568 c02ec9=
f0 <br>de40: 00000001 c01b0070 c01b0078 00000000 c028de94 c028de60 c0145b44=
 c0143c28 <br>de60: c01bd3c0 00000000 c01b00e0 c01b0078 c01bd320 c01bd320 c=
01bd320 c2bb5e80 <br>
de80: 00000000 c001bb84 c028dea4 c028de98 c01264e8 c014581c c028decc c028de=
a8 <br>dea0: c0124a7c c01264d8 c02a1047 c2bb5e80 c01bd320 c01b0078 c01bd320=
 c028dfa0 <br>dec0: c028deec c028ded0 c0124bec c01249d8 c0150e94 c01b0150 c=
01b0078 c0124ccc <br>
dee0: c028df04 c028def0 c0124d50 c0124b4c 00000000 c028df0c c028df34 c028df=
08 <br>df00: c0123ef0 c0124cdc 00000000 c01bb708 c01bb708 c01b00c0 c01bd320=
 c01bd334 <br>df20: 00000000 c01bb608 c028df44 c028df38 c01248e4 c0123eb0 c=
028df64 c028df48 <br>
df40: c0124244 c01248d4 c01bd320 c001b684 c028c000 00000000 c028df7c c028df=
68 <br>df60: c0125004 c01241f4 c028c000 00000000 c028df8c c028df80 c0126780=
 c0124f80 <br>df80: c028df9c c028df90 c001ad58 c0126724 c028dff4 c028dfa0 c=
000890c c001ad4c <br>
dfa0: 00000000 c028dfb0 c001fce4 c0036d2c 00000000 00000000 c0008874 c003d2=
1c <br>dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000=
 00000000 <br>dfe0: 00000000 00000000 00000000 c028dff8 c003d21c c0008884 7=
369646c 6c665f63 <br>
Backtrace: <br>[&lt;c0143a64&gt;] (spi_sync+0x0/0xec) from [&lt;c011c780&gt=
;] (m1172_probe+0x16c/0x390)<br> r7 =3D C028DCB0 =A0r6 =3D C028DCD6 =A0r5 =
=3D C028DCCC =A0r4 =3D C028DC84<br>[&lt;c011c614&gt;] (m1172_probe+0x0/0x39=
0) from [&lt;c01441dc&gt;] (spi_drv_probe+0x20/0x24)<br>
[&lt;c01441bc&gt;] (spi_drv_probe+0x0/0x24) from [&lt;c0124a7c&gt;] (really=
_probe+0xb4/0x174)<br>[&lt;c01249c8&gt;] (really_probe+0x0/0x174) from [&lt=
;c0124bec&gt;] (driver_probe_device+0xb0/0xc0)<br> r8 =3D 00000000 =A0r7 =
=3D C028DD74 =A0r6 =3D C1F56600 =A0r5 =3D C01BAF14<br>
 r4 =3D C2BB5CC0 <br><br><br><br><br><span style=3D"color: rgb(51, 102, 255=
);">Please help me out for this why any register reading writing is not hap=
pening at slave device level.</span><br><br>Regards<br><br>Nitin vishnoi<br=
>
<br>

--0016363b7d7417bb7704705ef983--


--===============2236636447926361354==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--===============2236636447926361354==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
spi-devel-general mailing list
spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/spi-devel-general

--===============2236636447926361354==--
