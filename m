From: Jiada Wang <jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH linux-next v2 1/1] spi: imx: dynamic burst length adjust
 for PIO mode
Date: Wed, 17 May 2017 18:50:34 -0700
Message-ID: <591CFDEA.1080204@mentor.com>
References: <1493634704-3545-1-git-send-email-jiada_wang@mentor.com>  <1493634704-3545-2-git-send-email-jiada_wang@mentor.com> <1495042325.26925.15.camel@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Octavian Purdila <octavian.purdila-3arQi8VN3Tc@public.gmane.org>,
        Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>
To: Leonard Crestez <leonard.crestez-3arQi8VN3Tc@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1495042325.26925.15.camel-3arQi8VN3Tc@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hello Leonard

Thanks for the report, can you help to check if the following change 
address the issue?

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 782045f..19b30cf 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -288,6 +288,9 @@ static void spi_imx_u32_swap_u8(struct spi_transfer 
*transfer, u32 *buf)
  {
         int i;

+       if (!buf)
+               return;
+
         for (i = 0; i < transfer->len / 4; i++)
                 *(buf + i) = cpu_to_be32(*(buf + i));
  }
@@ -296,6 +299,9 @@ static void spi_imx_u32_swap_u16(struct spi_transfer 
*transfer, u32 *buf)
  {
         int i;

+       if (!buf)
+               return;
+
         for (i = 0; i < transfer->len / 4; i++) {
                 u16 *temp = (u16 *)buf;


Thanks,
Jiada

On 05/17/2017 10:32 AM, Leonard Crestez wrote:
> On Mon, 2017-05-01 at 03:31 -0700, jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org wrote:
>> From: Jiada Wang<jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
>>
>> previously burst length (BURST_LENGTH) is always set to equal
>> to bits_per_word, causes a 10us gap between each word in
>> transfer, which significantly affects performance.
>>
>> This patch uses 32 bits transfer to simulate lower bits transfer,
>> and adjusts burst length runtimely to use biggeest burst length
>> as possible to reduce the gaps in transfer for PIO mode.
>>
>> Signed-off-by: Jiada Wang<jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
>> ---
>>   drivers/spi/spi-imx.c | 157 +++++++++++++++++++++++++++++++++++++++++++++++---
>>   1 file changed, 149 insertions(+), 8 deletions(-)
> This patch made it's way to linux-next and broke boot on imx6dl-
> sabreauto and imx6sl-evk boards (but others work). The crashes look
> like this:
>
> [    1.442384] spi_imx 2008000.ecspi: dma setup error -19, use pio
> [    1.452930] Unable to handle kernel NULL pointer dereference at virtual address 00000000
> [    1.461320] pgd = c0004000
> [    1.464078] [00000000] *pgd=00000000
> [    1.467821] Internal error: Oops: 5 [#1] SMP ARM
> [    1.472464] Modules linked in:
> [    1.475558] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.12.0-rc1-00001-g8d4a6ca #90
> [    1.483234] Hardware name: Freescale i.MX6 SoloLite (Device Tree)
> [    1.489349] task: ef058000 task.stack: ef054000
> [    1.493926] PC is at spi_imx_transfer+0x2d8/0x364
> [    1.498659] LR is at spi_bitbang_transfer_one+0x80/0xa0
> [    1.503910] pc : [<c05f6264>]    lr : [<c05f3440>]    psr: 20000013
> [    1.503910] sp : ef0558b0  ip : ef0558e0  fp : ef0558dc
> [    1.515412] r10: ee938a98  r9 : ef340c28  r8 : ee938800
> [    1.520658] r7 : ee938800  r6 : ef340800  r5 : ef055aac  r4 : ef340ce0
> [    1.527206] r3 : 00000001  r2 : fffffffc  r1 : 00000000  r0 : ee938800
> [    1.533757] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
> [    1.540913] Control: 10c5387d  Table: 8000404a  DAC: 00000051
> [    1.546680] Process swapper/0 (pid: 1, stack limit = 0xef054210)
> [    1.552709] Stack: (0xef0558b0 to 0xef056000)
> [    1.557093] 58a0:                                     c05f5cfc c05f587c 00000000 ef055aac
> [    1.565301] 58c0: ef340800 ef340ce0 ee938800 ef340c28 ef055904 ef0558e0 c05f3440 c05f5f98
> [    1.573509] 58e0: ee938800 ef055aac ef340800 ef055a38 00000000 ef340c28 ef055944 ef055908
> [    1.581714] 5900: c05f21c0 c05f33cc ee938800 00000000 ef05592c ef055920 c0496c3c 00000000
> [    1.589920] 5920: ef340800 ef055a38 00000000 00000000 ee938a98 00000000 ef055984 ef055948
> [    1.598126] 5940: c05f28c8 c05f2118 ef055a38 ef340800 ef05596c ef340a80 c016d518 ef055990
> [    1.606332] 5960: ee938800 ef055a38 ef340800 ef340c28 ee938a98 00000000 ef055a14 ef055988
> [    1.614537] 5980: c05f2bf0 c05f24e0 ef340ac4 60000013 00000000 00000000 dead4ead ffffffff
> [    1.622743] 59a0: ffffffff c1669b70 00000000 00000000 c0be1d7c ef0559b4 ef0559b4 00000000
> [    1.630948] 59c0: 00000000 dead4ead ffffffff ffffffff c1669b70 00000000 00000000 c0be1d7c
> [    1.639153] 59e0: ef0559b4 ef0559b4 ee938800 ee938800 ef055a38 ef055a38 00000006 c1669b3c
> [    1.647359] 5a00: ee938800 ef055b27 ef055a2c ef055a18 c05f2c34 c05f2a30 ef0c8bc1 ef0c8bc0
> [    1.655565] 5a20: ef055b14 ef055a30 c05f2d20 c05f2c10 ef055a54 ef055b4a ef055aa4 ef055ae0
> [    1.663770] 5a40: ee938800 00000000 c05f0640 ef055990 00000007 00000001 ffffff8d ef055a5c
> [    1.671975] 5a60: ef055a5c 00000000 ef055a68 ef055a68 ef0c8bc0 00000000 00000001 00000000
> [    1.680179] 5a80: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000802
> [    1.688384] 5aa0: 01312d00 ef055ae0 ef055a38 00000000 ef0c8bc1 00000006 00000000 00000000
> [    1.696588] 5ac0: 00000000 00000000 00000000 00000000 00000000 00000000 00000810 01312d00
> [    1.704794] 5ae0: ef055a38 ef055aa4 ef058000 c05c298c ee938800 ee938a70 ee938800 ef341018
> [    1.712999] 5b00: ef7e6f0c c0a669a4 ef055b3c ef055b18 c05c29c4 c05f2c58 00000006 00000000
> [    1.721206] 5b20: ef055b4c 9f055b30 c05c298c c0a669a4 ef055b74 ef055b40 c05d4970 c05c2998
> [    1.729412] 5b40: ef055b5c ef055b50 c016d518 c016d320 ef055b74 ef341018 c0a669a4 ee938a70
> [    1.737617] 5b60: ee938800 00000000 ef055bb4 ef055b78 c05d5634 c05d4954 ef341010 ef341050
> [    1.745822] 5b80: 00000000 ef341018 00000000 ef341010 ee938a70 00000000 ef341018 00000000
> [    1.754027] 5ba0: 00000000 00000000 ef055be4 ef055bb8 c05c2f88 c05d5300 c0e3ed44 00000000
> [    1.762232] 5bc0: 00000000 ee938800 c0e3ed34 00000000 c0e3ed44 00000000 ef055c04 ef055be8
> [    1.770437] 5be0: c05f0070 c05c2e78 ee938800 c166767c 00000000 c0e3ed44 ef055c2c ef055c08
> [    1.778643] 5c00: c053ed28 c05efff8 c0e3ed44 ef055c78 ee938800 00000001 00000000 c1667638
> [    1.786848] 5c20: ef055c4c ef055c30 c053ef1c c053eacc 00000000 ef055c78 c053ee7c 00000001
> [    1.795055] 5c40: ef055c74 ef055c50 c053d050 c053ee88 ef0c0ed4 ee8adfd4 ee938800 ee938800
> [    1.803261] 5c60: ee938834 c0e403a4 ef055c9c ef055c78 c053e998 c053cff0 ee938800 00000001
> [    1.811466] 5c80: ee938808 ee938800 c0e403a4 00000000 ef055cac ef055ca0 c053ef9c c053e8ec
> [    1.819671] 5ca0: ef055ccc ef055cb0 c053df88 c053ef94 ee938808 ef340800 ee938800 00000000
> [    1.827877] 5cc0: ef055d0c ef055cd0 c053c0ec c053df04 c05f07d8 c0450bd8 00000000 ee938800
> [    1.836083] 5ce0: ef055d0c ee938800 ef340800 00000000 ef0f5010 00000000 ef340800 00000000
> [    1.844288] 5d00: ef055d2c ef055d10 c05f1044 c053bd28 ef7e6f0c ef7e6f5c ee938800 00000001
> [    1.852493] 5d20: ef055d74 ef055d30 c05f18f0 c05f0fb8 00000000 c04289b8 ef055d64 ef0f5010
> [    1.860699] 5d40: c040f6f4 01312d00 ef055d74 ef340800 ef340ce0 ef340a60 ffffffed ef0f5010
> [    1.868905] 5d60: ef0f5000 ee8d4f80 ef055d8c ef055d78 c05f3508 c05f14b8 ef340ce0 ef340800
> [    1.877111] 5d80: ef055ddc ef055d90 c05f6700 c05f346c 00000000 ef0c5840 ef340ce0 00000002
> [    1.885316] 5da0: c1667638 ef0f5010 00000000 00000000 c0e40ccc ef0f5010 fffffffe c0e40ccc
> [    1.893522] 5dc0: fffffdfb 00000000 00000000 c0d00618 ef055dfc ef055de0 c05409cc c05f6394
> [    1.901728] 5de0: ef0f5010 c166767c 00000000 c0e40ccc ef055e24 ef055e00 c053ed28 c0540980
> [    1.909934] 5e00: ef0f5010 c0e40ccc ef0f5044 00000000 00000000 c0d5f858 ef055e44 ef055e28
> [    1.918139] 5e20: c053ee78 c053eacc 00000000 c0e40ccc c053edb0 00000000 ef055e6c ef055e48
> [    1.926345] 5e40: c053cf8c c053edbc ef009aa4 ef0bbcd0 ef009ad4 c0e40ccc ee8d7300 c0e3b068
> [    1.934551] 5e60: ef055e7c ef055e70 c053e680 c053cf24 ef055ea4 ef055e80 c053e1a4 c053e66c
> [    1.942756] 5e80: c0c4a470 ef055e90 c0e40ccc ffffe000 c0d5f850 c0cdd42c ef055ebc ef055ea8
> [    1.950963] 5ea0: c053f814 c053e0ac c0d47a14 ffffe000 ef055ecc ef055ec0 c054091c c053f7a0
> [    1.959168] 5ec0: ef055edc ef055ed0 c0d47a2c c05408f0 ef055f4c ef055ee0 c0101934 c0d47a20
> [    1.967374] 5ee0: c0d00634 c04157f0 c0cde600 000000ef ef055f4c ef055f00 c0147468 c0d00624
> [    1.975578] 5f00: 00000000 00000006 00000006 00000000 c0cdd42c c0c53d64 efffcc3a efffcc42
> [    1.983784] 5f20: c0e179e4 00000006 c0e7c000 c0d70ee8 c0e7c000 c0d5f850 c0cdd42c 000000ef
> [    1.991990] 5f40: ef055f94 ef055f50 c0d00e74 c01018fc 00000006 00000006 00000000 c0d00618
> [    2.000194] 5f60: 96fb16ef 00000007 c09af0d8 00000000 c09af0d8 00000000 00000000 00000000
> [    2.008401] 5f80: 00000000 00000000 ef055fac ef055f98 c09af0e8 c0d00d54 00000000 c09af0d8
> [    2.016605] 5fa0: 00000000 ef055fb0 c0107d30 c09af0e4 00000000 00000000 00000000 00000000
> [    2.024810] 5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [    2.033015] 5fe0: 00000000 00000000 00000000 00000000 00000013 00000000 def4d473 a64cea87
> [    2.041206] Backtrace:
> [    2.043707] [<c05f5f8c>] (spi_imx_transfer) from [<c05f3440>] (spi_bitbang_transfer_one+0x80/0xa0)
> [    2.052699]  r9:ef340c28 r8:ee938800 r7:ef340ce0 r6:ef340800 r5:ef055aac r4:00000000
> [    2.060479] [<c05f33c0>] (spi_bitbang_transfer_one) from [<c05f21c0>] (spi_transfer_one_message+0xb4/0x3c8)
> [    2.070251]  r9:ef340c28 r8:00000000 r7:ef055a38 r6:ef340800 r5:ef055aac r4:ee938800
> [    2.078029] [<c05f210c>] (spi_transfer_one_message) from [<c05f28c8>] (__spi_pump_messages+0x3f4/0x534)
> [    2.087452]  r10:00000000 r9:ee938a98 r8:00000000 r7:00000000 r6:ef055a38 r5:ef340800
> [    2.095301]  r4:00000000
> [    2.097869] [<c05f24d4>] (__spi_pump_messages) from [<c05f2bf0>] (__spi_sync+0x1cc/0x1e0)
> [    2.106079]  r10:00000000 r9:ee938a98 r8:ef340c28 r7:ef340800 r6:ef055a38 r5:ee938800
> [    2.113927]  r4:ef055990
> [    2.116492] [<c05f2a24>] (__spi_sync) from [<c05f2c34>] (spi_sync+0x30/0x48)
> [    2.123570]  r10:ef055b27 r9:ee938800 r8:c1669b3c r7:00000006 r6:ef055a38 r5:ef055a38
> [    2.131418]  r4:ee938800
> [    2.133985] [<c05f2c04>] (spi_sync) from [<c05f2d20>] (spi_write_then_read+0xd4/0x184)
> [    2.141924]  r5:ef0c8bc0 r4:ef0c8bc1
> [    2.145534] [<c05f2c4c>] (spi_write_then_read) from [<c05c29c4>] (m25p80_read_reg+0x38/0x70)
> [    2.154002]  r10:c0a669a4 r9:ef7e6f0c r8:ef341018 r7:ee938800 r6:ee938a70 r5:ee938800
> [    2.161851]  r4:c05c298c
> [    2.164415] [<c05c298c>] (m25p80_read_reg) from [<c05d4970>] (spi_nor_read_id+0x28/0xc0)
> [    2.172527]  r5:c0a669a4 r4:c05c298c
> [    2.176132] [<c05d4948>] (spi_nor_read_id) from [<c05d5634>] (spi_nor_scan+0x340/0x8f8)
> [    2.184164]  r8:00000000 r7:ee938800 r6:ee938a70 r5:c0a669a4 r4:ef341018
> [    2.190894] [<c05d52f4>] (spi_nor_scan) from [<c05c2f88>] (m25p_probe+0x11c/0x168)
> [    2.198494]  r10:00000000 r9:00000000 r8:00000000 r7:ef341018 r6:00000000 r5:ee938a70
> [    2.206342]  r4:ef341010
> [    2.208907] [<c05c2e6c>] (m25p_probe) from [<c05f0070>] (spi_drv_probe+0x84/0xb4)
> [    2.216418]  r8:00000000 r7:c0e3ed44 r6:00000000 r5:c0e3ed34 r4:ee938800
> [    2.223162] [<c05effec>] (spi_drv_probe) from [<c053ed28>] (driver_probe_device+0x268/0x2f0)
> [    2.231626]  r7:c0e3ed44 r6:00000000 r5:c166767c r4:ee938800
> [    2.237321] [<c053eac0>] (driver_probe_device) from [<c053ef1c>] (__device_attach_driver+0xa0/0xd4)
> [    2.246396]  r9:c1667638 r8:00000000 r7:00000001 r6:ee938800 r5:ef055c78 r4:c0e3ed44
> [    2.254174] [<c053ee7c>] (__device_attach_driver) from [<c053d050>] (bus_for_each_drv+0x6c/0xa0)
> [    2.262984]  r7:00000001 r6:c053ee7c r5:ef055c78 r4:00000000
> [    2.268675] [<c053cfe4>] (bus_for_each_drv) from [<c053e998>] (__device_attach+0xb8/0x120)
> [    2.276963]  r6:c0e403a4 r5:ee938834 r4:ee938800
> [    2.281614] [<c053e8e0>] (__device_attach) from [<c053ef9c>] (device_initial_probe+0x14/0x18)
> [    2.290164]  r7:00000000 r6:c0e403a4 r5:ee938800 r4:ee938808
> [    2.295857] [<c053ef88>] (device_initial_probe) from [<c053df88>] (bus_probe_device+0x90/0x98)
> [    2.304501] [<c053def8>] (bus_probe_device) from [<c053c0ec>] (device_add+0x3d0/0x584)
> [    2.312443]  r7:00000000 r6:ee938800 r5:ef340800 r4:ee938808
> [    2.318134] [<c053bd1c>] (device_add) from [<c05f1044>] (spi_add_device+0x98/0x13c)
> [    2.325821]  r10:00000000 r9:ef340800 r8:00000000 r7:ef0f5010 r6:00000000 r5:ef340800
> [    2.333669]  r4:ee938800
> [    2.336235] [<c05f0fac>] (spi_add_device) from [<c05f18f0>] (spi_register_master+0x444/0x7a4)
> [    2.344786]  r7:00000001 r6:ee938800 r5:ef7e6f5c r4:ef7e6f0c
> [    2.350478] [<c05f14ac>] (spi_register_master) from [<c05f3508>] (spi_bitbang_start+0xa8/0x12c)
> [    2.359207]  r10:ee8d4f80 r9:ef0f5000 r8:ef0f5010 r7:ffffffed r6:ef340a60 r5:ef340ce0
> [    2.367055]  r4:ef340800
> [    2.369623] [<c05f3460>] (spi_bitbang_start) from [<c05f6700>] (spi_imx_probe+0x378/0x604)
> [    2.377909]  r5:ef340800 r4:ef340ce0
> [    2.381518] [<c05f6388>] (spi_imx_probe) from [<c05409cc>] (platform_drv_probe+0x58/0xb8)
> [    2.389727]  r10:c0d00618 r9:00000000 r8:00000000 r7:fffffdfb r6:c0e40ccc r5:fffffffe
> [    2.397574]  r4:ef0f5010
> [    2.400140] [<c0540974>] (platform_drv_probe) from [<c053ed28>] (driver_probe_device+0x268/0x2f0)
> [    2.409037]  r7:c0e40ccc r6:00000000 r5:c166767c r4:ef0f5010
> [    2.414730] [<c053eac0>] (driver_probe_device) from [<c053ee78>] (__driver_attach+0xc8/0xcc)
> [    2.423197]  r9:c0d5f858 r8:00000000 r7:00000000 r6:ef0f5044 r5:c0e40ccc r4:ef0f5010
> [    2.430973] [<c053edb0>] (__driver_attach) from [<c053cf8c>] (bus_for_each_dev+0x74/0xa8)
> [    2.439175]  r7:00000000 r6:c053edb0 r5:c0e40ccc r4:00000000
> [    2.444867] [<c053cf18>] (bus_for_each_dev) from [<c053e680>] (driver_attach+0x20/0x28)
> [    2.452894]  r6:c0e3b068 r5:ee8d7300 r4:c0e40ccc
> [    2.457544] [<c053e660>] (driver_attach) from [<c053e1a4>] (bus_add_driver+0x104/0x214)
> [    2.465582] [<c053e0a0>] (bus_add_driver) from [<c053f814>] (driver_register+0x80/0xfc)
> [    2.473611]  r7:c0cdd42c r6:c0d5f850 r5:ffffe000 r4:c0e40ccc
> [    2.479302] [<c053f794>] (driver_register) from [<c054091c>] (__platform_driver_register+0x38/0x4c)
> [    2.488369]  r5:ffffe000 r4:c0d47a14
> [    2.491984] [<c05408e4>] (__platform_driver_register) from [<c0d47a2c>] (spi_imx_driver_init+0x18/0x20)
> [    2.501412] [<c0d47a14>] (spi_imx_driver_init) from [<c0101934>] (do_one_initcall+0x44/0x178)
> [    2.509977] [<c01018f0>] (do_one_initcall) from [<c0d00e74>] (kernel_init_freeable+0x12c/0x1ec)
> [    2.518704]  r8:000000ef r7:c0cdd42c r6:c0d5f850 r5:c0e7c000 r4:c0d70ee8
> [    2.525441] [<c0d00d48>] (kernel_init_freeable) from [<c09af0e8>] (kernel_init+0x10/0x118)
> [    2.533735]  r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:c09af0d8
> [    2.541582]  r4:00000000
> [    2.544153] [<c09af0d8>] (kernel_init) from [<c0107d30>] (ret_from_fork+0x14/0x24)
> [    2.551745]  r5:c09af0d8 r4:00000000
> [    2.555349] Code: e1b03123 0affff6a e2422004 e3a01000 (e5923004)
> [    2.561619] ---[ end trace 5e472bb4310ae461 ]---
> [    2.566504] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
> [    2.566504]
> [    2.575695] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
> [    2.575695]
> [    2.604346] random: fast init done
>
> This is at commit 8d4a6cad7adb3ddac32cd52635f20e11de11a658 from
> broonie/spi/topic/imx which has no other patches on top of v4.12-rc1.
>
>  From a very brief investigation it seems this is not handling correctly
> the cases where spi_transfer->rx_buf or tx_buf are NULL?
>
> --
> Regards,
> Leonard

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
