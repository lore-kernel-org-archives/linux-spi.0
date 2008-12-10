From: "hartleys" <hartleys-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
Subject: Re: [RFC] EP93xx SPI driver
Date: Wed, 10 Dec 2008 12:33:24 -0500
Message-ID: <BD79186B4FD85F4B8E60E381CAEE1909E70DE3@mi8nycmail19.Mi8.com>
References: <BD79186B4FD85F4B8E60E381CAEE1909E70BF9@mi8nycmail19.Mi8.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE1909E70BF9-KURmP/Qoe8Pmp66j18f85VaTQe2KTcn/@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

The original post appears to have been word-wrapped badly. If there are
any issues with this, or someone could instruct me how to get git to
diff the new files correctly, I will re-post.

Thanks,
Hartley 

-----Original Message-----
From: hartleys [mailto:hartleys-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org] 
Sent: Tuesday, December 09, 2008 6:23 PM
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Subject: [spi-devel-general] [RFC] EP93xx SPI driver

Hello all,

Following is a spi driver for the ep93xx based on a driver from Ryan
Mallon at Bluewatersys.

This driver has been cleaned up and modified to handle multiple devices
on the spi bus.  I have been using/testing it with the m25p80 and
mmc_spi drivers with good success.

I would appreciate any comments/suggestions needed to get this driver
ready for mainline.

Sorry that this is not a git diff.  I haven't figured out how to add a
new file yet.

The first block of code below is file
arch/arm/mach-ep93xx/include/mach/spi.h.
The second one is file drivers/spi/spi_ep93xx.c.

Thanks for any help and/or review comments.

Signed-off-by: H Hartley Sweeten <hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>

---


#ifndef __ASM_ARCH_SPI_H
#define __ASM_ARCH_SPI_H

/* device.platform_data for SSP controller devices */ struct
ep93xx_spi_master {
	u16	num_chipselects;
};

/* spi_board_info.controller_data for SPI slave devices,
 * copied to spi_device.platform_data
 */
struct ep93xx_spi_chip {
	void	(*cs_control)(int level);
	void	(*cleanup)(void);
};

#endif /* __ASM_ARCH_SPI_H */



/*
 * Cirrus EP93xx SPI Driver
 *
 * Copyright (c) 2007 Ryan Mallon <ryan-7Wk5F4Od5/oYd5yxfr4S2w@public.gmane.org>
 * Copyright (c) 2008 H Hartley Sweeten <hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
 *
 * Based on the ep93xx spi bitbang driver by Chase Douglas
 * and linux/drivers/spi/spi_txx9.c
 *
 * Licensed under the GPL-2 or later.
 */

#include <linux/platform_device.h>
#include <linux/interrupt.h>
#include <linux/clk.h>
#include <linux/delay.h>
#include <linux/err.h>
#include <linux/spi/spi.h>

#include <mach/hardware.h>
#include <mach/spi.h>

/*
 * Synchronous Serial Port Register offsets  */
#define SSPCR0			0x00
#define SSPCR1			0x04
#define SSPDR			0x08
#define SSPSR			0x0c
#define SSPCPSR			0x10
#define SSPIIR			0x14
#define SSPICR			SSPIIR

/* Control Register 0 bit defines */
#define SSPCR0_SCR_MASK		(0x0000ff00)
#define SSPCR0_SCR_SHIFT	(8)
#define SSPCR0_SPH		(1<<7)
#define SSPCR0_SPO		(1<<6)
#define SSPCR0_FRF_MASK		(0x00000030)
#define SSPCR0_FRF_SHIFT	(4)
#define SSPCR0_FRF_MOTOROLA	(0<<4)
#define SSPCR0_FRF_TI		(1<<4)
#define SSPCR0_FRF_NI		(2<<4)
#define SSPCR0_DSS_MASK		(0x0000000f)
#define SSPCR0_DSS_SHIFT	(0)
#define SSPCR0_DSS_4BIT		(3<<0)
#define SSPCR0_DSS_5BIT		(4<<0)
#define SSPCR0_DSS_6BIT		(5<<0)
#define SSPCR0_DSS_7BIT		(6<<0)
#define SSPCR0_DSS_8BIT		(7<<0)
#define SSPCR0_DSS_9BIT		(8<<0)
#define SSPCR0_DSS_10BIT	(9<<0)
#define SSPCR0_DSS_11BIT	(10<<0)
#define SSPCR0_DSS_12BIT	(11<<0)
#define SSPCR0_DSS_13BIT	(12<<0)
#define SSPCR0_DSS_14BIT	(13<<0)
#define SSPCR0_DSS_15BIT	(14<<0)
#define SSPCR0_DSS_16BIT	(15<<0)

/* Control Register 1 bit defines */
#define SSPCR1_SOD		(1<<6)
#define SSPCR1_MS		(1<<5)
#define SSPCR1_SSE		(1<<4)
#define SSPCR1_LBM		(1<<3)
#define SSPCR1_RORIE		(1<<2)
#define SSPCR1_TIE		(1<<1)
#define SSPCR1_RIE		(1<<0)

/* Receive (read) / Transmit (write) FIFO Register bit defines */
#define SSPDR_MASK		(0x0000ffff)
#define SSPDR_SHIFT		(0)

#define FIFO_SIZE		8

/* Status Register bit defines */
#define SSPSR_BSY		(1<<4)
#define SSPSR_RFF		(1<<3)
#define SSPSR_RNE		(1<<2)
#define SSPSR_TNF		(1<<1)
#define SSPSR_TFE		(1<<0)

/* Clock Prescale Register bit defines */
#define SSPCPSR_MASK		(0x000000ff)
#define SSPCPSR_SHIFT		(0)

/* Interrupt Identification (read) / Interrupt Clear (write) register
bit defines */
#define SSPIIR_RORIS		(1<<2)
#define SSPIIR_TIS		(1<<1)
#define SSPIIR_RIS		(1<<0)

#define spi_readl(off)		__raw_readl(info->mmio_base + (off))
#define spi_writel(v, off)	__raw_writel((v), info->mmio_base +
(off))


struct ep93xx_chip_data {
	u32	max_speed_hz;
	u8	bits_per_word;
	int	cs_active_high;
	void	(*cs_control)(int level);
	void	(*cleanup)(void);
};

struct ep93xxspi {
	struct spi_master		*master;
	struct device			*dev;
	struct ep93xx_spi_master	*pdata;
	struct clk			*sspclk;
	struct clk			*sspclkout;
	void __iomem			*mmio_base;

	struct ep93xx_chip_data		*chip;

	struct list_head		msg_queue;
	struct workqueue_struct 	*workq;
	struct work_struct		work;
	wait_queue_head_t		waitq;

	spinlock_t			lock;

	int				tx_irq;
	int				rx_irq;
};

/*
 * Read a value from the Receive FIFO
 */
static inline unsigned int ep93xx_spi_read(struct ep93xxspi *info) {
	return spi_readl(SSPDR) & SSPDR_MASK;
}

/*
 * Write a value to the Transmit FIFO
 */
static inline void ep93xx_spi_write(struct ep93xxspi *info,
		unsigned int val)
{
	spi_writel(val & SSPDR_MASK, SSPDR);
}

/*
 * Check if the Transmit FIFO is full
 */
static inline int ep93xx_spi_tx_full(struct ep93xxspi *info) {
	return (spi_readl(SSPSR) & SSPSR_TNF) ? 0 : 1; }

/*
 * Check if the Receive FIFO is empty
 */
static inline int ep93xx_spi_rx_empty(struct ep93xxspi *info) {
	return (spi_readl(SSPSR) & SSPSR_RNE) ? 0 : 1; }

/*
 * Get the next transfer from the list, lock is already held  */ static
inline struct spi_transfer *ep93xx_spi_next_transfer(
		struct spi_transfer *transfer, struct spi_message *msg)
{
	if (transfer->transfer_list.next == &msg->transfers)
		return NULL;

	return list_entry(transfer->transfer_list.next,
			  struct spi_transfer, transfer_list); }

/*
 * Process all the transfers in a spi message  */ static void
ep93xx_spi_handle_message(struct ep93xxspi *info,
		struct spi_message *msg)
{
	struct spi_transfer *rx, *tx;
	int rx_left, tx_left, sent = 0, recv = 0;
	const u8 *tx_buf;
	u8 *rx_buf;
	unsigned long flags;

	spin_lock_irqsave(&info->lock, flags);
	rx = tx = list_entry(msg->transfers.next, struct spi_transfer,
transfer_list);
	spin_unlock_irqrestore(&info->lock, flags);

	tx_left = tx->len;
	rx_left = rx->len;
	tx_buf = tx->tx_buf;
	rx_buf = rx->rx_buf;

	msg->actual_length = 0;

	spi_writel(SSPCR1_SSE, SSPCR1);

	/* Change speed for the transfer */
	if (tx->speed_hz) {
		dev_dbg(info->dev, "transfer->speed_hz = %u\n",
tx->speed_hz);
		clk_set_rate(info->sspclkout, tx->speed_hz);
	} else {
		clk_set_rate(info->sspclkout, info->chip->max_speed_hz);
	}

	/* FIXME: Change bits per word for the transfer? */
	if (tx->bits_per_word && tx->bits_per_word !=
info->chip->bits_per_word) {
		dev_dbg(info->dev,
			"transfer->bits_per_word = %d\n",
tx->bits_per_word);
	}

	spi_writel(0x0, SSPCR1);
	spi_writel(SSPCR1_SSE, SSPCR1);

	/* Enable the frame latch */
	if (info->chip->cs_control)
		info->chip->cs_control(info->chip->cs_active_high);

	while (tx || rx) {

		/* Send */
		while (tx && !ep93xx_spi_tx_full(info)) {
			/* Don't send more bytes than we have read */
			if (sent - recv >= FIFO_SIZE)
				break;

			if (tx_left) {
				if (tx_buf) {
					ep93xx_spi_write(info, *tx_buf);
					tx_buf++;
				} else {
					ep93xx_spi_write(info, 0);
				}
				tx_left--;
				sent++;
			}

			if (!tx_left) {
				/* Next transfer */
				spin_lock_irqsave(&info->lock, flags);
				tx = ep93xx_spi_next_transfer(tx, msg);
				spin_unlock_irqrestore(&info->lock,
flags);

				if (tx) {
					tx_left = tx->len;
					tx_buf = tx->tx_buf;
					if (tx->speed_hz) {
						/* FIXME: Change speed?
*/
						dev_dbg(info->dev,
	
"transfer->speed_hz = %u\n",
							tx->speed_hz);
					}
				}
			}
		}

		/* Receive */
		while (rx && !ep93xx_spi_rx_empty(info)) {
			/* Don't empty the rx fifo to early */
			if (tx && (sent - recv <= FIFO_SIZE / 2))
				break;

			if (rx_left) {
				u8 data;

				data = ep93xx_spi_read(info);
				if (rx_buf) {
					*rx_buf = data;
					rx_buf++;
				}
				rx_left--;
				recv++;
			}

			if (!rx_left) {
				/* Next transfer */
				spin_lock_irqsave(&info->lock, flags);
				rx = ep93xx_spi_next_transfer(rx, msg);
				spin_unlock_irqrestore(&info->lock,
flags);

				if (rx) {
					rx_left = rx->len;
					rx_buf = rx->rx_buf;
					if (rx->speed_hz) {
						/* FIXME: Change speed?
*/
						dev_dbg(info->dev,
	
"transfer->speed_hz = %u\n",
							rx->speed_hz);
					}
				}
			}
		}
	}

	dev_dbg(info->dev, "sent = %d, received = %d\n", sent, recv);

	/* Wait for the Transmit FIFO to drain */
	while (!(spi_readl(SSPSR) & SSPSR_TFE))
		;

	/* FIXME: Do I need to empty the receive FIFO? */

	/* Disable the frame latch */
	if (info->chip->cs_control)
		info->chip->cs_control(!info->chip->cs_active_high);

	msg->actual_length = sent;
	msg->complete(msg->context);
}

/*
 * Work queue handler to process all queued spi messages from
 * ep93xx_spi_transfer()
 */
static void ep93xx_spi_work(struct work_struct *work) {
	struct ep93xxspi *info = container_of(work, struct ep93xxspi,
work);
	unsigned long flags;

	spin_lock_irqsave(&info->lock, flags);
	while (!list_empty(&info->msg_queue)) {
		struct spi_message *msg;

		msg = container_of(info->msg_queue.next,
				struct spi_message, queue);
		list_del(&msg->queue);
		spin_unlock_irqrestore(&info->lock, flags);

		info->chip = spi_get_ctldata(msg->spi);

		ep93xx_spi_handle_message(info, msg);

		spin_lock_irqsave(&info->lock, flags);
	}
	spin_unlock_irqrestore(&info->lock, flags); }

/*
 * spi_master->transfer() - adds a message to the controller's transfer
queue.
 */
static int ep93xx_spi_transfer(struct spi_device *spi, struct
spi_message *msg) {
	struct ep93xxspi *info = spi_master_get_devdata(spi->master);
	unsigned long flags;

	spin_lock_irqsave(&info->lock, flags);

	msg->actual_length = 0;

	list_add_tail(&msg->queue, &info->msg_queue);
	queue_work(info->workq, &info->work);

	spin_unlock_irqrestore(&info->lock, flags);

	return 0;
}

/* the spi->mode bits understood by this driver */
#define MODEBITS	(SPI_CPHA | SPI_CPOL | SPI_CS_HIGH)

/*
 * spi_master->setup() - updates the device mode and clocking records
used
 *                       by a device's SPI controller; protocol code may
 *                       call this.
 *
 * This must fail if an unrecognized or unsupported mode is requested.
 * It's always safe to call this unless transfers are pending on the
 * device whose settings are being modified.
 */
static int ep93xx_spi_setup(struct spi_device *spi) {
	struct ep93xxspi *info = spi_master_get_devdata(spi->master);
	struct ep93xx_spi_chip *chip_info = NULL;
	struct ep93xx_chip_data *chip;
	unsigned int val;

	if (!spi->bits_per_word)
		spi->bits_per_word = 8;
	if (spi->bits_per_word < 4 || spi->bits_per_word > 16) {
		dev_err(&spi->dev,
			"failed setup: unsupported bits/word %d\n",
			spi->bits_per_word);
		return -EINVAL;
	}

	if (spi->mode & ~MODEBITS) {
		dev_err(&spi->dev,
			"failed setup: unsupported mode bits %x\n",
			spi->mode & ~MODEBITS);
		return -EINVAL;
	}

	/*
	 * Only alloc chip data on first setup
	 */
	chip = spi_get_ctldata(spi);
	if (!chip) {
		chip = kzalloc(sizeof(struct ep93xx_chip_data),
GFP_KERNEL);
		if (!chip) {
			dev_err(&spi->dev,
				"failed setup: cannot allocate chip
data");
			return -ENOMEM;
		}

		chip_info = spi->controller_data;
		if (!chip_info) {
			dev_err(&spi->dev,
				"failed setup: %s is missing
controller_data\n",
				spi->modalias);
			kfree(chip);
			return -ENODEV;
		}

		if (chip_info->cs_control)
			chip->cs_control = chip_info->cs_control;
		if (chip_info->cleanup)
			chip->cleanup = chip_info->cleanup;

		spi_set_ctldata(spi, chip);

		dev_info(&spi->dev, "initial setup for %s\n",
spi->modalias);
	}

	chip->max_speed_hz = spi->max_speed_hz;
	chip->bits_per_word = spi->bits_per_word;
	chip->cs_active_high = !!(spi->mode & SPI_CS_HIGH);

	clk_set_rate(info->sspclkout, spi->max_speed_hz);

	val = spi_readl(SSPCR0);
	val &= SSPCR0_SCR_MASK;
	val |= SSPCR0_FRF_MOTOROLA;
	val |= SSPCR0_SPH | SSPCR0_SPO;
//	val |= ((spi->mode & SPI_CPHA) ? SSPCR0_SPH : 0);
//	val |= ((spi->mode & SPI_CPOL) ? SSPCR0_SPO : 0);
	val |= (spi->bits_per_word - 1);
	spi_writel(val, SSPCR0);

	spi_writel(SSPCR1_SSE, SSPCR1);
	spi_writel(0x0, SSPCR1);
	spi_writel(SSPCR1_SSE, SSPCR1);

	return 0;
}

/*
 * spi_master->cleanup() - frees controller-specific state  */ static
void ep93xx_spi_cleanup(struct spi_device *spi) {
	struct ep93xx_chip_data *chip = spi_get_ctldata(spi);

	if (chip->cleanup)
		chip->cleanup();

	kfree(chip);
}

static int ep93xx_spi_probe(struct platform_device *pdev) {
	struct ep93xxspi *info = NULL;
	struct spi_master *master;
	struct resource *res;
	int err = 0;

	master = spi_alloc_master(&pdev->dev, sizeof(struct ep93xxspi));
	if (!master) {
		dev_err(&pdev->dev, "failed to allocate spi_master\n");
		return -ENOMEM;
	}

	info = spi_master_get_devdata(master);
	memset(info, 0, sizeof(struct ep93xxspi));
	info->master = spi_master_get(master);

	info->pdata = pdev->dev.platform_data;
	if (!info->pdata) {
		dev_err(&pdev->dev, "no platform data defined\n");
		err = -EINVAL;
		goto failed_free;
	}

	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
	if (res == NULL) {
		dev_err(&pdev->dev, "failed to get I/O memory\n");
		err = -ENXIO;
		goto failed_free;
	}

	res = request_mem_region(res->start, resource_size(res),
pdev->name);
	if (res == NULL) {
		dev_err(&pdev->dev, "failed to request I/O memory\n");
		err = -EBUSY;
		goto failed_free;
	}

	info->mmio_base = ioremap(res->start, resource_size(res));
	if (info->mmio_base == NULL) {
		dev_err(&pdev->dev, "failed to remap I/O memory\n");
		err = -ENXIO;
		goto failed_free_mem;
	}

	info->sspclk = clk_get(&pdev->dev, "ssp_clk");
	if (IS_ERR(info->sspclk)) {
		dev_err(&pdev->dev, "failed to get ssp input clock\n");
		err = PTR_ERR(info->sspclk);
		goto failed_free_io;
	}

	info->sspclkout = clk_get(&pdev->dev, "ssp_clkout");
	if (IS_ERR(info->sspclkout)) {
		dev_err(&pdev->dev, "failed to get ssp output clock\n");
		err = PTR_ERR(info->sspclkout);
		goto failed_put_sspclk;
	}

	info->dev = &pdev->dev;
	platform_set_drvdata(pdev, info);

	spin_lock_init(&info->lock);

	INIT_LIST_HEAD(&info->msg_queue);
	INIT_WORK(&info->work, ep93xx_spi_work);

	init_waitqueue_head(&info->waitq);

	info->workq =
create_singlethread_workqueue(master->dev.parent->bus_id);
	if (!info->workq) {
		dev_err(&pdev->dev, "Cannot create work queue\n");
		goto failed_put_sspclkout;
	}

	master->bus_num		= pdev->id;
	master->num_chipselect	= info->pdata->num_chipselects;
	master->setup		= ep93xx_spi_setup;
	master->transfer	= ep93xx_spi_transfer;
	master->cleanup		= ep93xx_spi_cleanup;

	clk_enable(info->sspclk);
	clk_enable(info->sspclkout);

	err = spi_register_master(master);
	if (err)
		goto failed_disable_clks;

	dev_info(&pdev->dev, "registered in bit-bang mode\n");

	return 0;

failed_disable_clks:
	clk_disable(info->sspclkout);
	clk_disable(info->sspclk);
failed_put_sspclkout:
	platform_set_drvdata(pdev, NULL);
	clk_put(info->sspclkout);
failed_put_sspclk:
	clk_put(info->sspclk);
failed_free_io:
	iounmap(info->mmio_base);
failed_free_mem:
	release_mem_region(res->start, resource_size(res));
failed_free:
	spi_master_put(info->master);
	return err;
}

static int ep93xx_spi_remove(struct platform_device *pdev) {
	struct ep93xxspi *info = platform_get_drvdata(pdev);
	struct resource *res;

	platform_set_drvdata(pdev, NULL);
	spi_unregister_master(info->master);

	spi_writel(0x0, SSPCR1);

	clk_disable(info->sspclkout);
	clk_disable(info->sspclk);

	clk_put(info->sspclkout);
	clk_put(info->sspclk);

	spi_master_put(info->master);

	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
	release_mem_region(res->start, resource_size(res));

	return 0;
}


#ifdef CONFIG_PM
static int ep93xx_spi_suspend(struct platform_device *pdev, pm_message_t
msg)
{
	return 0;
}

static int ep93xx_spi_resume(struct platform_device *pdev) {
	return 0;
}
#else
#define ep93xx_spi_suspend	NULL
#define ep93xx_spi_resume	NULL
#endif /* CONFIG_PM */

static struct platform_driver ep93xx_spidrv = {
	.driver		= {
		.name	= "ep93xx-spi",
		.owner	= THIS_MODULE,
	},
	.suspend	= ep93xx_spi_suspend,
	.resume		= ep93xx_spi_resume,
	.remove		= ep93xx_spi_remove,
};

static int __init ep93xx_spi_init(void)
{
        return platform_driver_probe(&ep93xx_spidrv, ep93xx_spi_probe);
}

static void __exit ep93xx_spi_exit(void) {
        platform_driver_unregister(&ep93xx_spidrv);
}

module_init(ep93xx_spi_init);
module_exit(ep93xx_spi_exit);

MODULE_DESCRIPTION("EP93XX SPI Driver"); MODULE_AUTHOR("Ryan Mallon
<ryan-7Wk5F4Od5/oYd5yxfr4S2w@public.gmane.org>"); MODULE_LICENSE("GPL");

------------------------------------------------------------------------
------
SF.Net email is Sponsored by MIX09, March 18-20, 2009 in Las Vegas,
Nevada.
The future of the web can't happen without you.  Join us at MIX09 to
help pave the way to the Next Web now. Learn more and register at
http://ad.doubleclick.net/clk;208669438;13503038;i?http://2009.visitmix.
com/
_______________________________________________
spi-devel-general mailing list
spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/spi-devel-general

------------------------------------------------------------------------------
SF.Net email is Sponsored by MIX09, March 18-20, 2009 in Las Vegas, Nevada.
The future of the web can't happen without you.  Join us at MIX09 to help
pave the way to the Next Web now. Learn more and register at
http://ad.doubleclick.net/clk;208669438;13503038;i?http://2009.visitmix.com/
