From: Tom <tom.spi.devel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: MRST SPI
Date: Thu, 10 Feb 2011 16:20:55 +0530
Message-ID: <AANLkTincGiw4cd0iu12ZAA+ZdR6CcGyGBKqokREkV1wU@mail.gmail.com>
References: <AANLkTimry3-NehWrundOuB_PWb420yOdrD1APaMXYkr6@mail.gmail.com>
	<AANLkTin60qjesNcaPRiDftt8s83i7JTRkB7zbt1pW31-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <AANLkTin60qjesNcaPRiDftt8s83i7JTRkB7zbt1pW31--JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Following is the debug log from messages after enabling spi debug (starts at
point when i call spi_w8r8()) :

Jan 10 01:54:35 localhost klogd: [  100.202663]  [<c012484f>]
__might_sleep+0xd9/0xe0
Jan 10 01:54:35 localhost klogd: [  100.202699]  [<c059da0b>]
wait_for_common+0x21/0xfd
Jan 10 01:54:35 localhost klogd: [  100.202733]  [<c034b585>] ?
dw_spi_transfer+0x97/0xaa
Jan 10 01:54:35 localhost klogd: [  100.202764]  [<c0349417>] ?
spi_async+0x7f/0x8d
Jan 10 01:54:35 localhost klogd: [  100.202794]  [<c059db68>]
wait_for_completion+0x12/0x14
Jan 10 01:54:35 localhost klogd: [  100.202825]  [<c03496d0>]
spi_sync+0x41/0x53
Jan 10 01:54:35 localhost klogd: [  100.202859]  [<c0349835>]
spi_write_then_read+0x153/0x193
Jan 10 01:54:35 localhost klogd: [  100.202900]  [<c0349875>] ?
spi_complete+0x0/0xa
Jan 10 01:54:35 localhost klogd: [  100.202941]  [<dfbed212>]
spi_trx_probe+0x1cd/0x220 [spitest]
Jan 10 01:54:35 localhost klogd: [  100.202975]  [<c0349350>]
spi_drv_probe+0x14/0x17
Jan 10 01:54:35 localhost klogd: [  100.203009]  [<c031510f>]
driver_probe_device+0x8f/0x117
Jan 10 01:54:35 localhost klogd: [  100.203041]  [<c03151da>]
__driver_attach+0x43/0x5f
Jan 10 01:54:35 localhost klogd: [  100.203041]  [<c0314a8d>]
bus_for_each_dev+0x3d/0x67
Jan 10 01:54:35 localhost klogd: [  100.203041]  [<c0314fd2>]
driver_attach+0x14/0x16
Jan 10 01:54:35 localhost klogd: [  100.203041]  [<c0315197>] ?
__driver_attach+0x0/0x5f
Jan 10 01:54:35 localhost klogd: [  100.203041]  [<c0314520>]
bus_add_driver+0x10b/0x23b
Jan 10 01:54:35 localhost klogd: [  100.203041]  [<c0287e8f>] ?
kset_find_obj+0x56/0x5e
Jan 10 01:54:35 localhost klogd: [  100.203041]  [<dfbf0000>] ?
spi_trx_init+0x0/0x4c [spitest]
Jan 10 01:54:35 localhost klogd: [  100.203041]  [<c0315417>]
driver_register+0x79/0xe0
Jan 10 01:54:35 localhost klogd: [  100.203041]  [<dfbf0000>] ?
spi_trx_init+0x0/0x4c [spitest]
Jan 10 01:54:35 localhost klogd: [  100.203041]  [<c0349e37>]
spi_register_driver+0x39/0x3e
Jan 10 01:54:35 localhost klogd: [  100.203041]  [<dfbf0018>]
spi_trx_init+0x18/0x4c [spitest]
Jan 10 01:54:35 localhost klogd: [  100.203041]  [<c0101051>]
do_one_initcall+0x4c/0x131
Jan 10 01:54:35 localhost klogd: [  100.203041]  [<c015a25e>]
sys_init_module+0x77/0x199
Jan 10 01:54:35 localhost klogd: [  100.203041]  [<c01027d7>]
sysenter_do_call+0x12/0x26


**************** my printk messages *******************************

Regards,
Tom


On Thu, Feb 10, 2011 at 4:18 PM, Tom <tom.spi.devel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> Hi All,
>
> I have a SPI device problem on MRST CDK.
>
> I use a GPIO as SS because my slave device expects the SS to be low between
> byte transfers.
> My probe function does a read as:
>
> int read_val;
> -------
> ---
> read_val = spi_w8r8(&spi_dev,0x20);
>  if ( read_val < 0 )
> printk ( "spi_read err\n");
> else
>  printk ( "spi_read %d\n",read_val );
> ----
> --
>
> The MRST SFI interface passes the device board info. Because, my device is
> not listed in the IA32 f/w I modified the MRST.c code sfi_handle_spi_dev
> function as:
>
> while(dev->name[0])
> {
>                 if (dev->type == SFI_DEV_TYPE_SPI &&
>                                 !strncmp(dev->name, spi_info->modalias,
> 16)) {
>                         if (!strncmp("spi_old_device", spi_info->modalias,
> 16)){
>                                 strncpy (spi_info->modalias,
> "spi_my_dev",16);
>                                 pdata = dev->get_platform_data(spi_info);
>                                 pr_info ( "spi_old_device modalias to
> spi_my_dev ");
>                         }
>                        else
>                        {
>                              pdata = dev->get_platform_data(spi_info);
>                        }
>                       break;
>                 }
>           dev++;
> }
>
> i also modified the devs_id array to change the platform_data
>
>  {"spi_old_dev", SFI_DEV_TYPE_SPI, 0, &no_platform_data}
>
> The issue is  that for the spi_w8r8 call, i get multiple read (multiple *
> (8 clock cycles/SS toggle))on the SPI bus.
>
> Also regarding the spi->irq, is it the responsibility of the protocol
> driver to register for this irq and handle it or does the spi framework or
> master driver take care of this ?
>
> Any pointers would be really helpful. ( attached is the test code)
>
> Regards,
> Tom
>
>
>
------------------------------------------------------------------------------
The ultimate all-in-one performance toolkit: Intel(R) Parallel Studio XE:
Pinpoint memory and threading errors before they happen.
Find and fix more than 250 security defects in the development cycle.
Locate bottlenecks in serial and parallel code that limit performance.
http://p.sf.net/sfu/intel-dev2devfeb
