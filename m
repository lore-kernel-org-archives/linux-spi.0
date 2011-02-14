From: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: MRST SPI
Date: Mon, 14 Feb 2011 09:05:43 +0800
Message-ID: <20110214090543.63312e78@feng-i7>
References: <AANLkTimry3-NehWrundOuB_PWb420yOdrD1APaMXYkr6@mail.gmail.com>
	<AANLkTin60qjesNcaPRiDftt8s83i7JTRkB7zbt1pW31-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
To: Tom <tom.spi.devel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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

Hi Tom,

On Thu, 10 Feb 2011 18:48:00 +0800
Tom <tom.spi.devel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> Hi All,
> 
> I have a SPI device problem on MRST CDK.
> 
> I use a GPIO as SS because my slave device expects the SS to be low
> between byte transfers.

The DW spi controller has a slave select register for that purpose, and
myself don't have experience of using an external GPIO lines for SS, so
no comment here.

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
> The MRST SFI interface passes the device board info. Because, my
> device is not listed in the IA32 f/w I modified the MRST.c code
> sfi_handle_spi_dev function as:
> 
> while(dev->name[0])
> {
>                 if (dev->type == SFI_DEV_TYPE_SPI &&
>                                 !strncmp(dev->name,
> spi_info->modalias, 16)) {
>                         if (!strncmp("spi_old_device",
> spi_info->modalias, 16)){
>                                 strncpy (spi_info->modalias,
> "spi_my_dev",16);
>                                 pdata =
> dev->get_platform_data(spi_info); pr_info ( "spi_old_device modalias
> to spi_my_dev ");
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
> The issue is  that for the spi_w8r8 call, i get multiple read
> (multiple * (8 clock cycles/SS toggle))on the SPI bus.
> 
> Also regarding the spi->irq, is it the responsibility of the protocol
> driver to register for this irq and handle it or does the spi
> framework or master driver take care of this ?
> 
> Any pointers would be really helpful. ( attached is the test code)

Suggest you refer the arch/platform/mrst/mrst.c about setting up
the max3110 spi device's platform and controller data, you can 
find it in Alan Cox's MID reference tree:

git://git.kernel.org/pub/scm/linux/kernel/git/alan/linux-2.6-mid-ref.git 

Thanks,
Feng

> 
> Regards,
> Tom

------------------------------------------------------------------------------
The ultimate all-in-one performance toolkit: Intel(R) Parallel Studio XE:
Pinpoint memory and threading errors before they happen.
Find and fix more than 250 security defects in the development cycle.
Locate bottlenecks in serial and parallel code that limit performance.
http://p.sf.net/sfu/intel-dev2devfeb
