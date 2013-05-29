From: =?GB2312?B?0OzHvg==?= <xuqiang.xjtu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: can't find spidevB.C in /dev
Date: Wed, 29 May 2013 17:57:07 +0800
Message-ID: <CAPFhN+CvMX+qkBy6-6-iEGxdeQxwkpvcTMcnvmU7yyk-=SJR0w@mail.gmail.com>
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

Hi all
I am working on linux 2.6.31, to support our SOC SPI module.

But after linux boot up, I can't find spidev* in /dev

# find / -name "spidev"
/sys/devices/platform/XXXXX_spi_poe.0/spi0.0/spidev
/sys/bus/spi/drivers/spidev
/sys/class/spidev
/sys/module/spidev

~ # ls /dev/spidev*
ls: /dev/spidev*: No such file or directory

My code is :


in my arch/platform.c, I register XXXXX_spi_poe driver and register spi
board whose modalias is "spidev"
struct platform_device XXXXX_spi0 = {
     .name = "XXXXX_spi_poe",
     .id = 0,
     .num_resources = ARRAY_SIZE(XXXXX_spi0_resource),
     .resource = XXXXX_spi0_resource
};

static struct spi_board_info XXXXX_spi0_board[] = {
     [0] = {
         .modalias = "spidev",
         .bus_num = 0,
         .chip_select = 0,
         .max_speed_hz = 500*1000,
     },
};

__init int
XXXXX_spi_platform_init(void)
{
     platform_device_register(&XXXXX_spi0);
     spi_register_board_info(XXXXX_spi0_board,
    ARRAY_SIZE(XXXXX_spi0_board));//for spi
     return 0;
}



in my module file which realize SPI driver.
The __init code is XXXXX_spi_driver_init
and __exit funciton is  XXXXX_spi_driver_cleanup


static struct platform_driver XXXXX_spi_driver = {
     .driver = {
         .name = "XXXXX_spi_poe",
         .owner = THIS_MODULE,
     },
    .remove = __exit_p(XXXXX_spi_remove),
};


int __init
XXXXX_spi_driver_init(void)
{
     XXXXX_spi_wq = create_singlethread_workqueue(
                XXXXX_spi_driver.driver.name);

    if (XXXXX_spi_wq == NULL)
        return -ENOMEM;
     return platform_driver_probe(&XXXXX_spi_driver, XXXXX_spi_probe);
}

void __exit
XXXXX_spi_driver_cleanup(void)
{
     flush_workqueue(XXXXX_spi_wq);
     platform_driver_unregister(&XXXXX_spi_driver);
     destroy_workqueue(XXXXX_spi_wq);
     printk("XXXXX unregister SPI: success\n");
     return;
}

 XXXXX_spi_probe will call function spi_register_master




static int __init
XXXXX_spi_probe(struct platform_device *pdev)
{
     struct spi_master *master;
     struct XXXXX_spi_dev *XXXXX_spi;
     struct resource *XXXXX_spi_resource;
     struct XXXXX_spi_info *spi_info;
     int status = 0;

     spi_info = pdev->dev.platform_data;
     master = spi_alloc_master(&pdev->dev, sizeof *XXXXX_spi);
     if (master == NULL) {
         osal_print("MUSIC spi master allocation failed\n");
         return -ENOMEM;
     }

     if (pdev->id != -1)
         master->bus_num = pdev->id;

     /* we support only mode 0, and no options */
    master->mode_bits = 0;
    master->num_chipselect = XXXXX_NUM_CHIPSELECTS;
     master->setup = XXXXX_spi_setup;
     master->transfer = XXXXX_spi_transfer;

     dev_set_drvdata(&pdev->dev, master);

     XXXXX_spi = spi_master_get_devdata(master);
     XXXXX_spi->spi_info = spi_info;
     XXXXX_spi->master = master;

     XXXXX_spi_resource = platform_get_resource(pdev, IORESOURCE_MEM, 0);
     if (XXXXX_spi_resource == NULL) {
         printk("XXXXX spi request platform resource failed\n");
        status = -ENODEV;
         goto XXXXX_spi_probe_failed;
    }

     if (!request_mem_region(XXXXX_spi_resource->start,
             (XXXXX_spi_resource->end - XXXXX_spi_resource->start) + 1,
            dev_name(&pdev->dev))) {
                  PRINTK("XXXXXspi request platform memory region
failed\n");
                  status = -EBUSY;
            goto XXXXX_spi_probe_failed;
      }

      INIT_WORK(&XXXXX_spi->work, XXXXX_spi_work);

     spin_lock_init(&XXXXX_spi->lock);
     INIT_LIST_HEAD(&XXXXX_spi->msg_queue);

     status = spi_register_master(master);
     if (status < 0) {
         PRINTK("XXXXXspi request platform memory region failed\n");
         goto XXXXX_spi_probe_failed_no_mem;
     }

     printK("XXXXX register SPI: success\n");
     return status;

XXXXX_spi_probe_failed_no_mem:
     release_mem_region(XXXXX_spi_resource->start,
         (XXXXX_spi_resource->end - XXXXX_spi_resource->start) + 1);

XXXXX_spi_probe_failed:
     spi_master_put(master);
     return status;
}


Anybody please check it with me, thanks very much
------------------------------------------------------------------------------
Introducing AppDynamics Lite, a free troubleshooting tool for Java/.NET
Get 100% visibility into your production application - at no cost.
Code-level diagnostics for performance bottlenecks with <2% overhead
Download for free and get started troubleshooting in minutes.
http://p.sf.net/sfu/appdyn_d2d_ap1
