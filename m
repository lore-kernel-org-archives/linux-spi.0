From: Juergen Beisert <jbe-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: MPC5200-SPI: Where to search
Date: Thu, 11 Oct 2007 12:54:46 +0200
Message-ID: <200710111254.47316.jbe@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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

Hi,

the following error happens on my system:

--------------------------------
Oops: Kernel access of bad area, sig: 11 [#1]
PREEMPT
Modules linked in: cam_spi_driver
NIP: 00000000 LR: C30626C4 CTR: 00000000
REGS: c0329a30 TRAP: 0400   Not tainted  (2.6.20-rt3-pcm030-3CAM-1)
MSR: 20009032 <EE,ME,IR,DR>  CR: 24008222  XER: 20000000
TASK =3D c030abf0[216] 'insmod' THREAD: c0328000
GPR00: 00000000 C0329AE0 C030ABF0 C1F01CC0 00000002 00000000 00000000 00000=
000
GPR08: 00000000 FFFFFF8D 00000000 C0329B24 22008282 10069448 C3060714 C0791=
840
GPR16: C305F03C C305F064 00000000 00000124 C305EB3E C305F08C C0230000 C0329=
C19
GPR24: C0322800 C0329C18 C0240000 C1F01D14 C0329B68 C1F01CC0 C0329B68 00000=
000
NIP [00000000] _start+0x40000000/0xc
LR [C30626C4] mpc52xx_psc_spi_transfer+0x44/0x94 [cam_spi_driver]
Call Trace:
[C0329AE0] [0000001C] 0x1c (unreliable)
[C0329B00] [C0130DEC] spi_sync+0x90/0xbc
[C0329B60] [C01315B0] spi_write_then_read+0x104/0x188
[C0329C10] [C01305C8] dataflash_probe+0x30/0x178
[C0329C30] [C0131460] spi_drv_probe+0x2c/0x3c
[C0329C40] [C011367C] really_probe+0x64/0x14c
[C0329C60] [C0112778] bus_for_each_drv+0x5c/0x9c
[C0329C90] [C011399C] device_attach+0x98/0xbc
[C0329CA0] [C011265C] bus_attach_device+0x34/0x88
[C0329CB0] [C01111C0] device_add+0x450/0x514
[C0329CF0] [C01310C0] spi_new_device+0xe0/0x148
[C0329D10] [C0131208] spi_register_master+0xe0/0x13c
[C0329D30] [C306298C] mpc52xx_spi_master_init+0x134/0x1c8 [cam_spi_driver]
[C0329D60] [C30622D4] mpc52xx_spi_of_probe+0x174/0x458 [cam_spi_driver]
[C0329DA0] [C00095E8] of_platform_device_probe+0x58/0x80
[C0329DC0] [C011367C] really_probe+0x64/0x14c
[C0329DE0] [C01138CC] __driver_attach+0x84/0x88
[C0329E00] [C0112A70] bus_for_each_dev+0x58/0x94
[C0329E30] [C01134E0] driver_attach+0x24/0x34
[C0329E40] [C0112EC4] bus_add_driver+0x88/0x1b4
[C0329E60] [C0113A9C] driver_register+0x68/0xb0
[C0329E70] [C0009928] of_register_platform_driver+0x28/0x38
[C0329E80] [C300601C] mpc52xx_spi_of_driver_init+0x1c/0xa8 [cam_spi_driver]
[C0329E90] [C00403F4] sys_init_module+0x16c/0x1600
[C0329F40] [C000E9F8] ret_from_syscall+0x0/0x38
--- Exception: c01 at 0xff21a7c
    LR =3D 0x1001d38c
--------------------------------

Its an RT preempt patched kernel. This happens most of the time when:

- Running from JFFS2 flash
- when insmod the SPI based MTD dataflash driver

It happens always, when the JFFS2 is a fresh one (whole area was erased and =

the new jffs2 image was written at the beginning of this flash area) and th=
e =

kernel boots the first time into it. It happens *not always*, if this jffs2 =

filesystem was at least one times mounted and modified ($ touch <anything>; =

sync; reboot).
It never happens if I'm using NFS root instead.

SPI related? MTD related? JFFS2 related? Any hints where to start the searc=
h?

JB
-- =

Dipl.-Ing. Juergen Beisert | http://www.pengutronix.de
=A0Pengutronix - Linux Solutions for Science and Industry
=A0   Handelsregister: Amtsgericht Hildesheim, HRA 2686
=A0 =A0 =A0    Vertretung Sued/Muenchen, Germany
   Phone: +49-8766-939 228 |  Fax: +49-5121-206917-9

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
