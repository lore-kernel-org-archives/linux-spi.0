From: Dmitri Belimov <d.belimov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: SPI bitbang master for TV cards next question
Date: Mon, 30 Nov 2009 13:15:02 +0900
Message-ID: <20091130131502.1724dbb7@glory.loctelecom.ru>
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

Hi All

Main question is when SPI is standalon module it has *_probe function it called when module is loaded
kernel push to this function platform_device structure. The probe function use this structure for work.

In my case a SPI module has *_register function. This function called with saa7134_dev structure. It is different then
platform_device structure.

I try use saa7134_dev, this is dmesg of modprobe saa7134 alsa=1 secam=d
Oops when calling spi_bitbang_start

int saa7134_spi_register(struct saa7134_dev *dev)
{
	struct spi_master *master = dev->spi_adap.master;
	struct saa7134_spi_gpio *sb = &dev->spi_adap;
	int ret = 0;

printk("SPI register start\n");

	if (!dev->spi.spi_enable)
	{
	printk("SPI is not configured\n");
		return 0;
	}

printk("spi_alloc master\n");
	master = spi_alloc_master(&dev, sizeof(struct saa7134_spi_gpio));

	if (master == NULL) {
		dev_err(dev, "failed to allocate spi master\n");
		ret = -ENOMEM;
		goto err;
	}
printk("spi_master_get_devdata\n");
	sb = spi_master_get_devdata(master);

	master->num_chipselect = dev->spi.num_chipselect;
	master->bus_num = -1;
printk("spi_master_get\n");
	sb->master = spi_master_get(master);

	sb->bitbang.master = sb->master;
	sb->bitbang.master->bus_num = -1;
	sb->bitbang.chipselect = saa7134_spi_gpio_chipsel;
	sb->bitbang.master->num_chipselect = dev->spi.num_chipselect;

	/* set state of spi pins */
	saa7134_set_gpio(dev, dev->spi.cs, 1);
	saa7134_set_gpio(dev, dev->spi.clock, 1);
	saa7134_set_gpio(dev, dev->spi.mosi, 1);
	saa7134_set_gpio(dev, dev->spi.miso, 3);

printk("spi_bitbang_start\n");
	ret = spi_bitbang_start(&sb->bitbang);

	if (ret) {
		dev_err(&dev, "Failed to register SPI master\n");
		goto err_no_bitbang;
	}

	dev_info(&dev,
		"spi master registered: bus_num=%d num_chipselect=%d\n",
		master->bus_num, master->num_chipselect);

	sb->controller_data = dev;
printk("SPI register stop and OK\n");
	return 0;

err_no_bitbang:
	spi_master_put(&sb->bitbang.master);
err:
printk("SPI register stop and FAIL\n");
	return ret;
}


[ 1459.099081] Linux video capture interface: v2.00
[ 1459.111333] saa7130/34: v4l2 driver version 0.2.15 loaded
[ 1459.111375] saa7134 0000:04:01.0: PCI INT A -> GSI 19 (level, low) -> IRQ 19
[ 1459.111380] saa7133[0]: found at 0000:04:01.0, rev: 209, irq: 19, latency: 32, mmio: 0xe5100000
[ 1459.111386] saa7133[0]: subsystem: 5ace:7595, board: Beholder BeholdTV X7 [card=171,autodetected]
[ 1459.111396] saa7133[0]: board init: gpio is 200000
[ 1459.111403] IRQ 19/saa7133[0]: IRQF_DISABLED is not guaranteed on shared IRQs
[ 1459.260008] saa7133[0]: i2c eeprom 00: ce 5a 95 75 54 20 00 00 00 00 00 00 00 00 00 01
[ 1459.260028] saa7133[0]: i2c eeprom 10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[ 1459.260046] saa7133[0]: i2c eeprom 20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[ 1459.260063] saa7133[0]: i2c eeprom 30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[ 1459.260080] saa7133[0]: i2c eeprom 40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[ 1459.260097] saa7133[0]: i2c eeprom 50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[ 1459.260114] saa7133[0]: i2c eeprom 60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[ 1459.260132] saa7133[0]: i2c eeprom 70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[ 1459.260149] saa7133[0]: i2c eeprom 80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[ 1459.260166] saa7133[0]: i2c eeprom 90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[ 1459.260183] saa7133[0]: i2c eeprom a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[ 1459.260200] saa7133[0]: i2c eeprom b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[ 1459.260208] saa7133[0]: i2c eeprom c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[ 1459.260216] saa7133[0]: i2c eeprom d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[ 1459.260224] saa7133[0]: i2c eeprom e0: 00 00 00 00 ff ff ff ff ff ff ff ff ff ff ff ff
[ 1459.260232] saa7133[0]: i2c eeprom f0: 42 54 56 30 30 30 30 ff ff ff ff ff ff ff ff ff
[ 1459.260242] i2c-adapter i2c-7: Invalid 7-bit address 0x7a
[ 1459.284532] tuner 7-0061: chip found @ 0xc2 (saa7133[0])
[ 1459.303538] xc5000 7-0061: creating new instance
[ 1459.312508] xc5000: Successfully identified at address 0x61
[ 1459.312510] xc5000: Firmware has not been loaded previously
[ 1487.568445] input: i2c IR (BeholdTV) as /class/input/input5
[ 1487.568481] ir-kbd-i2c: i2c IR (BeholdTV) detected at i2c-7/7-002d/ir0 [saa7133[0]]
[ 1487.569699] saa7133[0]: found muPD61151 MPEG encoder
[ 1487.569702] SPI register start
[ 1487.569703] spi_alloc master
[ 1487.569705] spi_master_get_devdata
[ 1487.569706] spi_master_get
[ 1487.569717] spi_bitbang_start
[ 1487.569749] spi_master spi32766: parent  should not be sleeping
[ 1487.569765] BUG: unable to handle kernel paging request at 006a4feb
[ 1487.569768] IP: [<c0208182>] strlen+0x8/0x11
[ 1487.569774] *pde = 00000000 
[ 1487.569776] Oops: 0000 [#1] SMP 
[ 1487.569779] last sysfs file: /sys/devices/pci0000:00/0000:00:1e.0/0000:04:01.0/resource
[ 1487.569781] Modules linked in: ir_kbd_i2c xc5000 tuner saa7134(+) ir_common v4l2_common videodev v4l1_compat videobuf_dma_sg videobuf_core spi_bitbang tveeprom nvidia(P) ipv6 dm_snapshot dm_mirror dm_region_hash dm_log dm_mod loop snd_hda_codec_realtek snd_hda_intel snd_hda_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_seq_dummy snd_seq_oss snd_seq_midi snd_rawmidi snd_seq_midi_event snd_seq snd_timer snd_seq_device psmouse serio_raw snd parport_pc parport processor button soundcore i2c_i801 snd_page_alloc i2c_core rng_core pcspkr intel_agp agpgart evdev ext3 jbd mbcache sg sr_mod cdrom sd_mod ata_generic ata_piix libata scsi_mod ide_pci_generic ide_core ehci_hcd uhci_hcd usbcore r8169 mii thermal fan thermal_sys [last unloaded: scsi_wait_scan]
[ 1487.569826] 
[ 1487.569829] Pid: 26408, comm: modprobe Tainted: P           (2.6.30.5 #1) G31M-ES2L
[ 1487.569831] EIP: 0060:[<c0208182>] EFLAGS: 00210246 CPU: 1
[ 1487.569833] EIP is at strlen+0x8/0x11
[ 1487.569835] EAX: 00000000 EBX: f8194dcc ECX: ffffffff EDX: 000000d0
[ 1487.569837] ESI: 00000002 EDI: 006a4feb EBP: f04a7e64 ESP: f04a7d88
[ 1487.569839]  DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068
[ 1487.569841] Process modprobe (pid: 26408, ti=f04a6000 task=f693e080 task.ti=f04a6000)
[ 1487.569842] Stack:
[ 1487.569843]  000000d0 c02037ed f15ef608 f04a7e5c f15ef600 f056d000 c026aba4 c026ab09
[ 1487.569848]  00000000 f056d000 f15ef608 c0203c60 00000000 f7049b00 f156d9c0 c03861e0
[ 1487.569853]  c037e288 c03c7c54 c037de7e c037e288 f156db00 f156dde0 f15ef600 00000000
[ 1487.569858] Call Trace:
[ 1487.569859]  [<c02037ed>] ? kobject_get_path+0x1a/0x74
[ 1487.569863]  [<c026aba4>] ? dev_uevent+0x9b/0x14a
[ 1487.569867]  [<c026ab09>] ? dev_uevent+0x0/0x14a
[ 1487.569869]  [<c0203c60>] ? kobject_uevent_env+0x198/0x351
[ 1487.569872]  [<c026b891>] ? device_add+0x404/0x526
[ 1487.569875]  [<c0271efd>] ? spi_register_master+0x5e/0xc0
[ 1487.569879]  [<f805b2d4>] ? spi_bitbang_start+0xd8/0xf1 [spi_bitbang]
[ 1487.569884]  [<f81944ea>] ? saa7134_spi_register+0x165/0x231 [saa7134]
[ 1487.569898]  [<f8194dcc>] ? saa7134_initdev+0x68f/0xa54 [saa7134]
[ 1487.569908]  [<c0213045>] ? local_pci_probe+0xb/0xc
[ 1487.569912]  [<c02139bd>] ? pci_device_probe+0x41/0x63
[ 1487.569915]  [<c026d03c>] ? driver_probe_device+0x76/0xfe
[ 1487.569919]  [<c026d104>] ? __driver_attach+0x40/0x5b
[ 1487.569922]  [<c026cad8>] ? bus_for_each_dev+0x37/0x5f
[ 1487.569924]  [<c026cf23>] ? driver_attach+0x11/0x13
[ 1487.569927]  [<c026d0c4>] ? __driver_attach+0x0/0x5b
[ 1487.569930]  [<c026c56a>] ? bus_add_driver+0xcb/0x1ee
[ 1487.569933]  [<f818cf47>] ? saa7134_init+0x0/0x3b [saa7134]
[ 1487.569943]  [<c026d31f>] ? driver_register+0x87/0xe0
[ 1487.569946]  [<f818cf47>] ? saa7134_init+0x0/0x3b [saa7134]
[ 1487.569956]  [<c0213cf5>] ? __pci_register_driver+0x33/0x8a
[ 1487.569959]  [<f818cf47>] ? saa7134_init+0x0/0x3b [saa7134]
[ 1487.569968]  [<c010112d>] ? do_one_initcall+0x44/0x111
[ 1487.569972]  [<c016107f>] ? tracepoint_module_notify+0x21/0x24
[ 1487.569975]  [<c013a5b6>] ? notifier_call_chain+0x2a/0x47
[ 1487.569980]  [<c013a80b>] ? __blocking_notifier_call_chain+0x3f/0x49
[ 1487.569983]  [<c0147a67>] ? sys_init_module+0x87/0x187
[ 1487.569986]  [<c0102f74>] ? sysenter_do_call+0x12/0x28
[ 1487.569989] Code: eb 04 19 c0 0c 01 5e 5f c3 56 89 c6 89 d0 88 c4 ac 38 e0 74 09 84 c0 75 f7 be 01 00 00 00 89 f0 48 5e c3 57 83 c9 ff 89 c7 31 c0 <f2> ae f7 d1 49 89 c8 5f c3 57 31 ff 85 c9 74 0e 89 c7 89 d0 f2 
[ 1487.570017] EIP: [<c0208182>] strlen+0x8/0x11 SS:ESP 0068:f04a7d88
[ 1487.570020] CR2: 00000000006a4feb
[ 1487.570023] ---[ end trace 993bba733b804ded ]---


With my best regards, Dmitry.

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
