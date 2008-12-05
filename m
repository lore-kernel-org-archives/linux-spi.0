From: Graham Gower <graham.gower-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: spi protocol driver's probe() not being called
Date: Fri, 05 Dec 2008 13:21:36 +1030
Message-ID: <49389738.8040808@gmail.com>
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

Hi,
I'm having trouble getting a the rtc-m41t94.c spi protocol driver's
probe function to be called on our platform, for which I am writing a
controller driver.

We have a linux 2.6.24.3 kernel patched to support our mips SOC. I have
merged the rtc-m41t94.c protocol driver from 2.6.28. I have begun to
write an spi controller driver for our SOC, called jz_spi.c.

Now, the jz_spi init and probe functions are being called successfully
and does not report any failures. In addition, I added printk()s to the
rtc-m41t94 driver and its init gets called, but its probe does not.

I'm hoping someone can point out what I am missing, a description of my
current code follows.


I have added the relevant platform_device bits:

static struct resource jz_spi_resources[] = {
    [0] = {
        .start          = CPHYSADDR(SSI_BASE),
        .end            = CPHYSADDR(SSI_BASE) + 0xfff,
        .flags          = IORESOURCE_MEM,
    },
    [1] = {
        .start          = IRQ_SSI,
        .end            = IRQ_SSI,
        .flags          = IORESOURCE_IRQ,
    }
};

static u64 jz_spi_dmamask =  ~(u32)0;

static struct platform_device jz_spi_device = {
    .name = "jz_spi",
    .id = 0,
    .dev = {
        .dma_mask               = &jz_spi_dmamask,
        .coherent_dma_mask      = 0xffffffff,
    },
    .num_resources  = ARRAY_SIZE(jz_spi_resources),
    .resource       = jz_spi_resources,
};

static struct platform_device *jz_platform_devices[] __initdata = {

    /* trimmed for brevity
    ...
    */

    &jz_spi_device,
};

static int __init jz_platform_init(void)
{
    return platform_add_devices(jz_platform_devices, ARRAY_SIZE(jz_platform_devices));
}



------------------------------------------------------------------------

I have added the relevant spi_board_info bits:

static struct spi_board_info spi_board_info[] __initdata = {
{
    .modalias    = "rtc-m41t94",
    .max_speed_hz    = 1*1000*1000,
    .bus_num    = 0,
    .chip_select    = 1,
},
};

void __init jz_board_setup(void)
{

    /* trimmed for brevity
    ...
    */
    
    spi_register_board_info(spi_board_info, ARRAY_SIZE(spi_board_info));
}



------------------------------------------------------------------------
I have a platform_driver whose probe function calls spi_alloc_master
followed by spi_register_master. Yes, this is largely incomplete.


/*
* jz_spi.c
*/

#include <linux/kernel.h>
#include <linux/init.h>
#include <linux/platform_device.h>
#include <linux/spi/spi.h>
#include <asm/jzsoc.h>

#define dprintk(fmt, args...) printk(KERN_INFO "%s: %d: " fmt, __FUNCTION__, __LINE__, ##args)

struct jz_spi {
    int irq;
};

static int
jz_spi_setup(struct spi_device *spi)
{
    dprintk("\n");

    if (spi->chip_select == 0)
        __ssi_select_ce();
    else if (spi->chip_select == 1)
        __ssi_select_ce2();
    else {
        printk(KERN_ERR "%s: invalid chip_select %d\n",
                __FUNCTION__, spi->chip_select);
        return -EINVAL;
    }

    if (spi->mode & SPI_LSB_FIRST)
        __ssi_set_lsb();
    else
        __ssi_set_msb();

    if (spi->mode & SPI_LOOP)
        __ssi_enable_loopback();
    else
        __ssi_disable_loopback();

    if (spi->mode & SPI_CPOL)
        __ssi_set_spi_clock_polarity(1);
    else
        __ssi_set_spi_clock_polarity(0);

    if (spi->mode & SPI_CPHA)
        __ssi_set_spi_clock_phase(1);
    else
        __ssi_set_spi_clock_phase(0);

    return 0;
}

static int
jz_spi_transfer(struct spi_device *spi, struct spi_message *msg)
{
    dprintk("\n");
    return 0;
}

static void
jz_spi_cleanup(struct spi_device *spi)
{
    dprintk("\n");
}

static irqreturn_t
jz_spi_irqhandler(int irq, void *dev_id)
{
    return IRQ_HANDLED;
}

static int
jz_spi_probe(struct platform_device *pdev)
{
    struct spi_master *master;
    struct jz_spi *js;
    int ret, irq;

    dprintk("\n");

    irq = platform_get_irq(pdev, 0);
    if (irq < 0) {
        printk(KERN_ERR "%s: Couldn't get platform irq\n",
                __FUNCTION__);
        ret = irq;
        goto err0;
    }

    master = spi_alloc_master(&pdev->dev, sizeof(struct jz_spi));
    if (master == NULL) {
        printk(KERN_ERR "%s: Couldn't allocate spi master\n",
                __FUNCTION__);
        ret = -ENOMEM;
        goto err0;
    }

    master->bus_num = 0;
    master->num_chipselect = 2;
    master->setup = jz_spi_setup;
    master->transfer = jz_spi_transfer;
    master->cleanup = jz_spi_cleanup;

    platform_set_drvdata(pdev, master);
    js = spi_master_get_devdata(master);

    js->irq = irq;

    ret = request_irq(irq, jz_spi_irqhandler, 0, pdev->dev.bus_id, master);
    if (ret) {
        printk(KERN_ERR "%s: Couldn't obtain irq %d\n",
                __FUNCTION__, irq);
        goto err1;
    }

    dprintk("Obtained irq %d\n", irq);

    __gpio_as_ssi();
    __ssi_spi_format();
    __ssi_set_rx_trigger(1);

    if ((ret = spi_register_master(master))) {
        printk(KERN_ERR "%s: Couldn't register spi master\n",
                __FUNCTION__);
        goto err2;
    }

    return 0;

err2:
    free_irq(irq, master);
err1:
    spi_master_put(master);
err0:
    return ret;
}

static int
jz_spi_remove(struct platform_device *pdev)
{
    struct spi_master *master = platform_get_drvdata(pdev);
    struct jz_spi *js = spi_master_get_devdata(master);

    dprintk("\n");

    spi_unregister_master(master);
    free_irq(js->irq, master);
    spi_master_put(master);

    return 0;
}

#ifdef CONFIG_PM
static int
jz_spi_suspend(struct platform_device *pdev, pm_message_t state)
{
    return 0;
}

static int
jz_spi_resume(struct platform_device *pdev)
{
    return 0;
}
#else
#define jz_spi_suspend NULL
#define jz_spi_resum NULL
#endif /* CONFIG_PM */

struct platform_driver jz_spi_driver =
{
    .driver = {
        .name = "jz_spi",
        .owner = THIS_MODULE,
    },
    .probe = jz_spi_probe,
    .remove = jz_spi_remove,
    .suspend = jz_spi_suspend,
    .resume = jz_spi_resume,
};

static int __init
jz_spi_init(void)
{
    dprintk("\n");
    return platform_driver_register(&jz_spi_driver);
}

static void __exit
jz_spi_exit(void)
{
    dprintk("\n");
    platform_driver_unregister(&jz_spi_driver);
}

module_init(jz_spi_init);
module_exit(jz_spi_exit);

MODULE_AUTHOR("Graham Gower");
MODULE_LICENSE("GPL");


------------------------------------------------------------------------
My kernel config contains:

$ grep CONFIG_RTC .config | grep -v ^#
CONFIG_RTC_LIB=y
CONFIG_RTC_CLASS=m
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
CONFIG_RTC_DRV_M41T94=m

$ grep CONFIG_SPI .config | grep -v ^#
CONFIG_SPI=y
CONFIG_SPI_MASTER=y
CONFIG_SPI_JZ=m

$ grep JZ drivers/spi/Kconfig config SPI_JZ
       tristate "JZSOC SPI Controller"
       depends on JZSOC && SPI_MASTER
         Driver for the SPI Controller found on JZ4730 SOC.


Assistance would be apreciated,
-Graham


------------------------------------------------------------------------------
SF.Net email is Sponsored by MIX09, March 18-20, 2009 in Las Vegas, Nevada.
The future of the web can't happen without you.  Join us at MIX09 to help
pave the way to the Next Web now. Learn more and register at
http://ad.doubleclick.net/clk;208669438;13503038;i?http://2009.visitmix.com/
