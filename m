From: "Nikesh Gawande" <nikelinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Segmentation fault when calling spi_sync
	function
Date: Wed, 30 Jan 2008 15:48:02 +0530
Message-ID: <c60870f00801300218u799eb1pebbf2681bb6865b5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0165948620=="
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

--===============0165948620==
Content-Type: multipart/alternative;
	boundary="----=_Part_8019_5310068.1201688282105"

------=_Part_8019_5310068.1201688282105
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Everybody,

I am developing a driver for clrc632 chip interfaced at spi bus.
My intuition about sending data over spi bus is to create spi_transfers and
add them to the spi_message and then using spi_sync() send it to the device
which is completely handled by atmel_spi driver. I am doing this in my
driver but at the point when spi_sync() is called I get the following
messages. which is something about segmentation fault. I am not
understanding the error.
Is it compulsory to call spi_sync() or spi_async() functions for data
transfer. Is there any other way to do it?
  Please help me.


PC is at spi_sync+0x3c/0x6c        ttyb8           tty
LR is at clrc632_ioctl+0xc4/0x284ab_dlci_
Enter 'help'
ptyd0
pc : [<c0161860>]    lr : [<c01303d8>]    Not taintedkern
 r7 = 00000000  r6 = C3CE6200  r5 =
ptyd1
sp : c3a21edc  ip : c3a21f08  fp : c3a21f04r 6 0lim_allowab_journal_u
[<c0088fb0>] (sh
r10: 00000000  r9 : 00000001  r8 : c36afe98bb           ttyvcut
ttyqck_create_kern0
r7 : 00000000  r6 : c36afedc  r5 : c36b0004  tyx4
wn_super+0x24/
1f20: 00000001 00000001 00000003 c0021ec4 c3a20000 00000000 c3a21f5c
c3a21f48
1f40: c0082d60 c0130324 c3cf9160 bebf8c16 c3a21f84 c3a21f60 c0082fd8
c0082d0c
1f60: 00000000 00000000 c3cf9160 fffffff7 00000001 00000036 c3a21fa4
c3a21f88
1f80: c0083048 c0082d80 00000000 00000000 0007151c 00000000 00000000
c3a21fa8
1fa0: c0021d20 c0083018 00000000 0007151c 00000003 00000001 bebf8c16
00000003
1fc0: 00000000 0007151c 00000000 00000000 00008c34 00008bf0 00000000
bebf8c30
1fe0: 00000013 bebf8c14 000082a8 00012f04 80000010 00000003 40016420
400236cc
Backtrace:
[<c0161824>] (spi_sync+0x0/0x6c) from [<c01303d8>]
(clrc632_ioctl+0xc4/0x284)
 r7 = C36AFEB8  r6 = C36AFEDC  r5 = C36B00C0  r4 = C36B0004
[<c0130314>] (clrc632_ioctl+0x0/0x284) from [<c0082d60>]
(do_ioctl+0x64/0x74)
[<c0082cfc>] (do_ioctl+0x0/0x74) from [<c0082fd8>] (vfs_ioctl+0x268/0x298)
 r5 = BEBF8C16  r4 = C3CF9160
[<c0082d70>] (vfs_ioctl+0x0/0x298) from [<c0083048>] (sys_ioctl+0x40/0x60)
 r7 = 00000036  r6 = 00000001  r5 = FFFFFFF7  r4 = C3CF9160
[<c0083008>] (sys_ioctl+0x0/0x60) from [<c0021d20>]
(ret_fast_syscall+0x0/0x2c)
 r6 = 00000000  r5 = 0007151C  r4 = 00000000
Code: e5850008 e50b3020 e50b7028 e50b3024 (e590312c)
 <1>In Release<1>CLRC pointer at 3278569112
Segmentation fault


Regards,

Nikesh

------=_Part_8019_5310068.1201688282105
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Everybody,<br><br>I am developing a driver for clrc632 chip interfaced at spi bus.<br>My intuition about sending data over spi bus is to create spi_transfers and add them to the spi_message and then using spi_sync() send it to the device which is completely handled by atmel_spi driver. I am doing this in my driver but at the point when spi_sync() is called I get the following messages. which is something about segmentation fault. I am not understanding the error. <br>
Is it compulsory to call spi_sync() or spi_async() functions for data transfer. Is there any other way to do it?<br>&nbsp; Please help me. <br><br><br>PC is at spi_sync+0x3c/0x6c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ttyb8&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tty<br>LR is at clrc632_ioctl+0xc4/0x284ab_dlci_<br>
Enter &#39;help&#39;<br>ptyd0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>pc : [&lt;c0161860&gt;]&nbsp;&nbsp;&nbsp; lr : [&lt;c01303d8&gt;]&nbsp;&nbsp;&nbsp; Not taintedkern<br>&nbsp;r7 = 00000000&nbsp; r6 = C3CE6200&nbsp; r5 = <br>ptyd1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>sp : c3a21edc&nbsp; ip : c3a21f08&nbsp; fp : c3a21f04r 6 0lim_allowab_journal_u<br>
[&lt;c0088fb0&gt;] (sh<br>r10: 00000000&nbsp; r9 : 00000001&nbsp; r8 : c36afe98bb&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ttyvcut&nbsp;&nbsp;&nbsp; ttyqck_create_kern0<br>r7 : 00000000&nbsp; r6 : c36afedc&nbsp; r5 : c36b0004&nbsp; tyx4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wn_super+0x24/&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>1f20: 00000001 00000001 00000003 c0021ec4 c3a20000 00000000 c3a21f5c c3a21f48<br>
1f40: c0082d60 c0130324 c3cf9160 bebf8c16 c3a21f84 c3a21f60 c0082fd8 c0082d0c<br>1f60: 00000000 00000000 c3cf9160 fffffff7 00000001 00000036 c3a21fa4 c3a21f88<br>1f80: c0083048 c0082d80 00000000 00000000 0007151c 00000000 00000000 c3a21fa8<br>
1fa0: c0021d20 c0083018 00000000 0007151c 00000003 00000001 bebf8c16 00000003<br>1fc0: 00000000 0007151c 00000000 00000000 00008c34 00008bf0 00000000 bebf8c30<br>1fe0: 00000013 bebf8c14 000082a8 00012f04 80000010 00000003 40016420 400236cc<br>
Backtrace:<br>[&lt;c0161824&gt;] (spi_sync+0x0/0x6c) from [&lt;c01303d8&gt;] (clrc632_ioctl+0xc4/0x284)<br>&nbsp;r7 = C36AFEB8&nbsp; r6 = C36AFEDC&nbsp; r5 = C36B00C0&nbsp; r4 = C36B0004<br>[&lt;c0130314&gt;] (clrc632_ioctl+0x0/0x284) from [&lt;c0082d60&gt;] (do_ioctl+0x64/0x74)<br>
[&lt;c0082cfc&gt;] (do_ioctl+0x0/0x74) from [&lt;c0082fd8&gt;] (vfs_ioctl+0x268/0x298)<br>&nbsp;r5 = BEBF8C16&nbsp; r4 = C3CF9160<br>[&lt;c0082d70&gt;] (vfs_ioctl+0x0/0x298) from [&lt;c0083048&gt;] (sys_ioctl+0x40/0x60)<br>&nbsp;r7 = 00000036&nbsp; r6 = 00000001&nbsp; r5 = FFFFFFF7&nbsp; r4 = C3CF9160<br>
[&lt;c0083008&gt;] (sys_ioctl+0x0/0x60) from [&lt;c0021d20&gt;] (ret_fast_syscall+0x0/0x2c)<br>&nbsp;r6 = 00000000&nbsp; r5 = 0007151C&nbsp; r4 = 00000000<br>Code: e5850008 e50b3020 e50b7028 e50b3024 (e590312c)<br>&nbsp;&lt;1&gt;In Release&lt;1&gt;CLRC pointer at 3278569112<br>
Segmentation fault<br><br><br>Regards,<br><br>Nikesh<br>

------=_Part_8019_5310068.1201688282105--


--===============0165948620==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============0165948620==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
spi-devel-general mailing list
spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/spi-devel-general

--===============0165948620==--
