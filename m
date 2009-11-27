From: Dmitri Belimov <d.belimov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: SPI bitbang master for TV cards
Date: Fri, 27 Nov 2009 14:15:48 +0900
Message-ID: <20091127141548.36e8e58d@glory.loctelecom.ru>
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

Hi All.

I write some support for our TV cards (open source of course)
One of them has hardware MPEG2 encoder connected to host chip
via GPIO. In our windows drivers we wrote internal simple SPI bitbang
driver. For Linux we want use generic SPI subsystem.
I wrote my ugly code, not working yet.


#include "saa7134-reg.h"
#include "saa7134.h"
#include <media/v4l2-common.h>

/* ----------------------------------------------------------- */

static unsigned int spi_debug;
module_param(spi_debug, int, 0644);
MODULE_PARM_DESC(spi_debug,"enable debug messages [spi]");

#define d1printk if (1 == spi_debug) printk
#define d2printk if (2 == spi_debug) printk

static inline struct saa7134_spi_gpio *to_sb(struct spi_device *spi)
{
	return spi_master_get_devdata(spi->master);
}

static inline void setsck(struct spi_device *dev, int on)
{
	struct saa7134_spi_gpio *sb = to_sb(dev);

	saa7134_set_gpio(sb->controller_data, sb->controller_data->spi.clock, on ? 1 : 0);
}

static inline void setmosi(struct spi_device *dev, int on)
{
	struct saa7134_spi_gpio *sb = to_sb(dev);

	saa7134_set_gpio(sb->controller_data, sb->controller_data->spi.mosi, on ? 1 : 0);
}

static inline u32 getmiso(struct spi_device *dev)
{
	struct saa7134_spi_gpio *sb = to_sb(dev);
	unsigned long status;

	status = saa7134_get_gpio(sb->controller_data);
	if ( status & (1 << sb->controller_data->spi.miso)) return 1;
	else
		return 0;
}

static void saa7134_spi_gpio_chipsel(struct spi_device *dev, int on)
{
	struct saa7134_spi_gpio *sb = to_sb(dev);

	saa7134_set_gpio(sb->controller_data, sb->controller_data->spi.cs, on ? 1 : 0);
}

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

	master = spi_alloc_master(&dev->spi_adap.pdev->dev, sizeof(struct saa7134_spi_gpio));

	if (master == NULL) {
		dev_err(&dev->spi_adap.pdev->dev, "failed to allocate spi master\n");
		ret = -ENOMEM;
		goto err;
	}

	sb = spi_master_get_devdata(master);

	master->num_chipselect = dev->spi.num_chipselect;
	master->bus_num = -1;

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

//	drv_set_drvdata(&sb->master->dev, sb);

	ret = spi_bitbang_start(&sb->bitbang);

	if (ret) {
		dev_err(&dev->spi_adap.pdev->dev, "Failed to register SPI master\n");
		goto err_no_bitbang;
	}

	dev_info(&dev->spi_adap.pdev->dev,
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

int saa7134_spi_unregister(struct saa7134_dev *dev)
{
	spi_bitbang_stop(&dev->spi_adap.bitbang);
	spi_master_put(&dev->spi_adap.bitbang.master);
	return 0;
}


Some structures from saa7134.h

Structure for store config of GPIO
struct saa7134_software_spi {
	unsigned char cs:5;
	unsigned char clock:5;
	unsigned char mosi:5;
	unsigned char miso:5;
	unsigned char num_chipselect:3;
	unsigned char spi_enable:1;
};

Structure for SPI controller
struct saa7134_spi_gpio {
	struct spi_bitbang	bitbang;
	struct spi_master	*master;
	struct platform_device	*pdev;
	struct saa7134_dev	*controller_data;
};

/* global device status */
struct saa7134_dev {

skip

	/* software spi */
	struct saa7134_spi_gpio    spi_adap;
	struct saa7134_software_spi spi;

skip
};

/* ----------------------------------------------------------- */
/* saa7134-spi.c                                               */

int saa7134_spi_register(struct saa7134_dev *dev);
int saa7134_spi_unregister(struct saa7134_dev *dev);

saa7134-spi build to one saa7134 module. When modprobe I get NULL pointer operation.
I don't understand how to write device driver structure for store data about driver.
How to init all structure.
Must sources consist standalon SPI master driver.

With my best regards, Dmitry.

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
