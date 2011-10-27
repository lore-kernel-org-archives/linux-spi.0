From: Wayne Tams <wayne.tams-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Kernel Panics when trying to use at25 eeprom driver
Date: Thu, 27 Oct 2011 15:03:19 +0100
Message-ID: <CAN=k24=-t+uX_SbcO4Mqy4_CvuyO+ocwuFdtuZLqKfO7GojgfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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

Hello,

I'm hoping someone maybe able to help me fix my problem, before I do
something silly ;-)

I have been developing a system based on the Freescale i.MX53 SoC and the
2.6.35 kernel, as part of the project I need to write a custom kernel
driver that will use the SPI interface. In an effort to make sure the bus
is operating as described by the OEM I tried to test the bus using an SPI
EEPROM (AT25512) and the at25 driver.

When I load the at25 module the kernel panics with the following message,
which I traced to a line in drivers/spi/spi.c the problem is rooted in the
function spi_async and the line that is causing problems is, return
master->transfer(spi, message);

[   26.694166] Unable to handle kernel NULL pointer dereference at virtual
address 00000000
[   26.716855] pgd = 80004000
[   26.719576] [00000000] *pgd=00000000
[   26.723178] Internal error: Oops: 17 [#1] PREEMPT
[   26.727889] last sysfs file: /sys/class/gsl_kmod/gsl_kmod/dev
[   26.733646] Modules linked in: at25(+)
[   26.737432] CPU: 0    Not tainted  (2.6.35.3-744-g27fdf7b-gd22ecaa-dirty
#64)
[   26.744594] PC is at mxc_spi_buf_tx_u8+0x1c/0x28
[   26.749223] LR is at spi_put_tx_data+0x34/0x5c
[   26.753676] pc : [<80241900>]    lr : [<80241a50>]    psr: 60000013
[   26.753686] sp : 95123ee8  ip : 802418f8  fp : 95123ef4
[   26.765180] r10: 95122000  r9 : 95108800  r8 : 95108718
[   26.770413] r7 : 00000000  r6 : 95108718  r5 : 00000001  r4 : 9686e000
[   26.776950] r3 : 00000000  r2 : 95108718  r1 : 00000001  r0 : 95108718
[   26.783488] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment
kernel
[   26.790808] Control: 10c5387d  Table: 853a0019  DAC: 00000017
[   26.796564] Process mxc_spi.0 (pid: 144, stack limit = 0x951222e8)
[   26.802753] Stack: (0x95123ee8 to 0x95124000)
[   26.807122] 3ee0:                   95123f14 95123ef8 80241a50 802418f0
95108718 95429d80
[   26.815315] 3f00: 95108800 00000000 95123f34 95123f18 802425cc 80241a28
95429d80 00000000
[   26.823509] 3f20: 95429dc4 95429da4 95123f74 95123f38 80240bfc 802424ec
9510872c 80241aa4
[   26.831702] 3f40: 00000000 ffffffff 95109b28 95122000 95109b20 95109b28
95108720 9510871c
[   26.839895] 3f60: 80240a70 804a29c0 95123fc4 95123f78 8009b414 80240a7c
95122000 950968a0
[   26.848089] 3f80: 95123fc4 00000000 950968a0 8009f80c 95123f90 95123f90
95123fc4 95029d98
[   26.856282] 3fa0: 95123fcc 8009b214 95109b20 00000000 00000000 00000000
95123ff4 95123fc8
[   26.864475] 3fc0: 8009f34c 8009b220 00000000 00000000 95123fd0 95123fd0
95029d98 8009f2c0
[   26.872668] 3fe0: 8005916c 00000013 00000000 95123ff8 8005916c 8009f2cc
00000fff 00000fff
[   26.880877] [<80241900>] (mxc_spi_buf_tx_u8+0x1c/0x28) from [<80241a50>]
(spi_put_tx_data+0x34/0x5c)
[   26.890031] [<80241a50>] (spi_put_tx_data+0x34/0x5c) from [<802425cc>]
(mxc_spi_transfer+0xec/0x16c)
[   26.899185] [<802425cc>] (mxc_spi_transfer+0xec/0x16c) from [<80240bfc>]
(bitbang_work+0x18c/0x314)
[   26.908254] [<80240bfc>] (bitbang_work+0x18c/0x314) from [<8009b414>]
(worker_thread+0x200/0x2b4)
[   26.917152] [<8009b414>] (worker_thread+0x200/0x2b4) from [<8009f34c>]
(kthread+0x8c/0x94)
[   26.925441] [<8009f34c>] (kthread+0x8c/0x94) from [<8005916c>]
(kernel_thread_exit+0x0/0x8)
[   26.933811] Code: e92d4000 ebf859fe e590304c e1a02000 (e4d30001)
[   26.940129] ---[ end trace 671158ca92b68e5b ]---

It would seem to be a problem with one of the two structures being used in
master->transfer, but I am struggling to work out which one it would be.

For the sake of completeness below is the EEPROMS's platform data and the
register function to go with them, just in case I have made a fatal mistake
in the configuration.

static struct spi_eeprom at25512 = {
.name = "at25512",
 .byte_len = 65536,
.page_size = 128,
 .flags = EE_ADDR2,
};

static struct spi_board_info eft_spi_board_info[] __initdata = {
 {
.modalias = "at25",
 .max_speed_hz = 5000000,
.bus_num = 1,
 .chip_select = 0,
.platform_data   = &at25512,
 .mode = SPI_MODE_0,
//.irq = 99,
 //.controller_data = NULL,
},
};

Located in init function: spi_register_board_info(eft_spi_board_info,
ARRAY_SIZE(eft_spi_board_info));

I really hope someone can assist.

Kind regards

Wayne
------------------------------------------------------------------------------
The demand for IT networking professionals continues to grow, and the
demand for specialized networking skills is growing even more rapidly.
Take a complimentary Learning@Cisco Self-Assessment and learn 
about Cisco certifications, training, and career opportunities. 
http://p.sf.net/sfu/cisco-dev2dev
