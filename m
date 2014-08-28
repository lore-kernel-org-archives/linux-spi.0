From: leroy christophe <christophe.leroy-GgN8y9CXRhA@public.gmane.org>
Subject: Re: Linux 3.16: all my drivers on SPI bus report WARNING: at drivers/base/dd.c:286
Date: Thu, 28 Aug 2014 17:53:59 +0200
Message-ID: <53FF5097.7090000@c-s.fr>
References: <53F31707.4040300@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	LinuxPPC-dev <linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>, Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <53F31707.4040300-GgN8y9CXRhA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

I've been able to identify the origin of the issue. It happens since th=
e below commit.
Do you know what should be done to fix that ?

Christophe


 From 7a40054361162d2f78f332aa868fed137beb7901 Mon Sep 17 00:00:00 2001
=46rom: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Date: Sun, 30 Mar 2014 16:42:57 +0800
Subject: spi: fsl-spi: Fix memory leak

mpc8xxx_spi_probe() has set master->cleanup =3D mpc8xxx_spi_cleanup,
however current code overrides the setting in fsl_spi_probe() and set
master->cleanup =3D fsl_spi_cleanup.
Thus the memory allocated for cs is not freed anywhere.
Convert to use devm_kzalloc to fix the memory leak.

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
index b3e7775..98ccd23 100644
--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -431,7 +431,7 @@ static int fsl_spi_setup(struct spi_device *spi)
  		return -EINVAL;
 =20
  	if (!cs) {
-		cs =3D kzalloc(sizeof *cs, GFP_KERNEL);
+		cs =3D devm_kzalloc(&spi->dev, sizeof(*cs), GFP_KERNEL);
  		if (!cs)
  			return -ENOMEM;
  		spi->controller_state =3D cs;
--=20
cgit v0.10.1


Le 19/08/2014 11:21, leroy christophe a =E9crit :
> Since Linux 3.16, for all drivers tied to SPI bus, I get the followin=
g=20
> warning on a PowerPC 8xx.
> It doesn't happen with Linux 3.15
>
> What can be the reason / what should I look at ?
>
> [    3.086957] device: 'spi32766.1': device_add
> [    3.087179] bus: 'spi': add device spi32766.1
> [    3.087653] bus: 'spi': driver_probe_device: matched device=20
> spi32766.1 with driver lm70
> [    3.087743] bus: 'spi': really_probe: probing driver lm70 with=20
> device spi32766.1
> [    3.088014] ------------[ cut here ]------------
> [    3.092348] WARNING: at drivers/base/dd.c:286
> [    3.096637] Modules linked in:
> [    3.099697] CPU: 0 PID: 25 Comm: kworker/u2:1 Tainted: G W=20
> 3.16.1-s3k-drv-999-svn5771_knld-999 #158
> [    3.109610] Workqueue: deferwq deferred_probe_work_func
> [    3.114736] task: c787f020 ti: c790c000 task.ti: c790c000
> [    3.120062] NIP: c01df158 LR: c01df144 CTR: 00000000
> [    3.124983] REGS: c790db30 TRAP: 0700   Tainted: G        W=20
> (3.16.1-s3k-drv-999-svn5771_knld-999)
> [    3.134162] MSR: 00029032 <EE,ME,IR,DR,RI>  CR: 22002082 XER: 2000=
0000
> [    3.140703]
> [    3.140703] GPR00: 00000001 c790dbe0 c787f020 00000044 00000054=20
> 00000308 c056da0e 20737069
> [    3.140703] GPR08: 33323736 000ebfe0 00000308 000ebfdf 22002082=20
> 00000000 c046c5a0 c046c608
> [    3.140703] GPR16: c046c614 c046c620 c046c62c c046c638 c046c648=20
> c046c654 c046c68c c046c6c4
> [    3.140703] GPR24: 00000000 00000000 00000003 c0401aa0 c0596638=20
> c059662c c054e7a8 c7996800
> [    3.170102] NIP [c01df158] driver_probe_device+0xf8/0x334
> [    3.175431] LR [c01df144] driver_probe_device+0xe4/0x334
> [    3.180633] Call Trace:
> [    3.183093] [c790dbe0] [c01df144] driver_probe_device+0xe4/0x334=20
> (unreliable)
> [    3.190147] [c790dc10] [c01dd15c] bus_for_each_drv+0x7c/0xc0
> [    3.195741] [c790dc40] [c01df5fc] device_attach+0xcc/0xf8
> [    3.201076] [c790dc60] [c01dd6d4] bus_probe_device+0xb4/0xc4
> [    3.206666] [c790dc80] [c01db9f8] device_add+0x270/0x564
> [    3.211923] [c790dcc0] [c0219e84] spi_add_device+0xc0/0x190
> [    3.217427] [c790dce0] [c021a79c] spi_register_master+0x720/0x834
> [    3.223455] [c790dd40] [c021cb48] of_fsl_spi_probe+0x55c/0x614
> [    3.229234] [c790dda0] [c01e0d2c] platform_drv_probe+0x30/0x74
> [    3.234987] [c790ddb0] [c01df18c] driver_probe_device+0x12c/0x334
> [    3.241008] [c790dde0] [c01dd15c] bus_for_each_drv+0x7c/0xc0
> [    3.246602] [c790de10] [c01df5fc] device_attach+0xcc/0xf8
> [    3.251937] [c790de30] [c01dd6d4] bus_probe_device+0xb4/0xc4
> [    3.257536] [c790de50] [c01de9d8] deferred_probe_work_func+0x98/0x=
e0
> [    3.263816] [c790de70] [c00305b8] process_one_work+0x18c/0x440
> [    3.269577] [c790dea0] [c0030a00] worker_thread+0x194/0x67c
> [    3.275105] [c790def0] [c0039198] kthread+0xd0/0xe4
> [    3.279911] [c790df40] [c000c6d0] ret_from_kernel_thread+0x5c/0x64
> [    3.285970] Instruction dump:
> [    3.288900] 80de0000 419e01d0 3b7b0038 3c60c046 7f65db78 38635264=20
> 48211b99 813f00a0
> [    3.296559] 381f00a0 7d290278 3169ffff 7c0b4910 <0f000000> 93df004=
4=20
> 7fe3fb78 4bfffd4d
> [    3.304401] ---[ end trace c75d3461bf9e2961 ]---
> [    3.309598] device: 'hwmon1': device_add
> [    3.310246] driver: 'lm70': driver_bound: bound to device 'spi3276=
6.1'
> [    3.310342] bus: 'spi': really_probe: bound device spi32766.1 to=20
> driver lm70
>
> Christophe

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
