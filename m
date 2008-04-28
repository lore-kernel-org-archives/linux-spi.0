From: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Subject: Re: [PATCH 1/1] Initial support for ST
 Microelectronics lis3l02dq accelerometer via SPI
Date: Mon, 28 Apr 2008 15:05:26 +0100
Message-ID: <4815D9A6.4040306@cam.ac.uk>
References: <481210CC.9080702@cam.ac.uk> <481226C4.9010806@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <481226C4.9010806-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

from Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>

Initial support for ST Microelectronics LISS3L02DQ accelerometer via SPI

Signed-off-by: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>

---

This is a corrected version of the patch I posted the other day.  
All comments / feedback welcomed. Would it be preferable to submit this
as two patches, the first containing the basic functionality for directly
accessing the device and second patching against that to add ring buffer /
interrupt support?

 drivers/spi/Kconfig           |   14
 drivers/spi/LIS3L02DQ.c       |  774 ++++++++++++++++++++++++++++++++
 drivers/spi/Makefile          |    1
 include/linux/spi/LIS3L02DQ.h |  168 ++++++
 4 files changed, 957 insertions(+)


--- a/drivers/spi/Kconfig	2008-04-17 03:49:44.000000000 +0100
+++ b/drivers/spi/Kconfig	2008-04-24 19:16:32.000000000 +0100
@@ -239,6 +239,20 @@ config SPI_TLE62X0
 	  sysfs interface, with each line presented as a kind of GPIO
 	  exposing both switch control and diagnostic feedback.
 
+config SPI_LIS3L02DQ
+       tristate "STMicroelectronics LIS3L02DQ Accelerometer" 
+       depends on SPI_MASTER && SYSFS 
+       help
+         SPI driver for the STMicroelectrincs LIS3L02DQ 3-Axis 2g digital 
+	 output linear accelerometer.  This provides a sysfs interface.
+
+config SPI_LIS3L02DQ_GPIO_INTERRUPT
+       bool "Use data ready interrupt in conjunction with a ring buffer"
+       depends on SPI_LIS3L02DQ && GENERIC_GPIO
+       help
+	 Select this option if you want to capture the maximum possible 
+	 amount of data from you accelerometer.
+       
 #
 # Add new SPI protocol masters in alphabetical order above this line
 #
--- a/drivers/spi/Makefile	2008-04-17 03:49:44.000000000 +0100
+++ b/drivers/spi/Makefile	2008-04-25 19:13:51.000000000 +0100
@@ -34,6 +34,7 @@ obj-$(CONFIG_SPI_SH_SCI)		+= spi_sh_sci.
 obj-$(CONFIG_SPI_AT25)		+= at25.o
 obj-$(CONFIG_SPI_SPIDEV)	+= spidev.o
 obj-$(CONFIG_SPI_TLE62X0)	+= tle62x0.o
+obj-$(CONFIG_SPI_LIS3L02DQ)     += LIS3L02DQ.o
 # 	... add above this line ...
 
 # SPI slave controller drivers (upstream link)
--- a/include/linux/spi/LIS3L02DQ.h	1970-01-01 01:00:00.000000000 +0100
+++ b/include/linux/spi/LIS3L02DQ.h	2008-04-26 12:21:25.000000000 +0100
@@ -0,0 +1,168 @@
+ 
+
+#ifndef _LIS3L02DQ_H_
+#define _LIS3L02DQ_H_
+#define LIS3L02DQ_READ_REG(a) a | 0x80
+#define LIS3L02DQ_WRITE_REG(a) a 
+
+/* Calibration parameters */
+#define LIS3L02DQ_REG_OFFSET_X_ADDRESS 0x16
+#define LIS3L02DQ_REG_OFFSET_Y_ADDRESS 0x17
+#define LIS3L02DQ_REG_OFFSET_Z_ADDRESS 0x18
+
+#define LIS3L02DQ_REG_GAIN_X_ADDRESS 0x19
+#define LIS3L02DQ_REG_GAIN_Y_ADDRESS 0x1A
+#define LIS3L02DQ_REG_GAIN_Z_ADDRESS 0x1B
+
+/* Control Register (1 of 2) */
+#define LIS3L02DQ_REG_CTRL_1_ADDRESS 0x20
+/* Power ctrl - either bit set corresponds to on*/
+#define LIS3L02DQ_REG_CTRL_1_PD_ON 0xC0
+
+/* Decimation Factor  */
+#define LIS3L02DQ_REG_CTRL_1_DF_128 0x00
+#define LIS3L02DQ_REG_CTRL_1_DF_64  0x10
+#define LIS3L02DQ_REG_CTRL_1_DF_32  0x20
+#define LIS3L02DQ_REG_CTRL_1_DF_8   0x10 | 0x20
+
+/* Self Test Enable */ 
+#define LIS3L02DQ_REG_CTRL_1_SELF_TEST_ON 0x08
+
+/* Axes enable ctrls */
+#define LIS3L02DQ_REG_CTRL_1_AXES_Z_ENABLE  0x04
+#define LIS3L02DQ_REG_CTRL_1_AXES_Y_ENABLE  0x02
+#define LIS3L02DQ_REG_CTRL_1_AXES_X_ENABLE  0x01
+
+/* Control Register (2 of 2) */
+#define LIS3L02DQ_REG_CTRL_2_ADDRESS 0x21
+
+/* Block Data Update only after MSB and LSB read */
+#define LIS3L02DQ_REG_CTRL_2_BLOCK_UPDATE 0x40
+ 
+/* Set to big endian output */
+#define LIS3L02DQ_REG_CTRL_2_BIG_ENDIAN   0x20
+
+/* Reboot memory content */
+#define LIS3L02DQ_REG_CTRL_2_REBOOT_MEMORY 0x10
+
+/* Interupt Enable - applies data ready to the RDY pad */
+#define LIS3L02DQ_REG_CTRL_2_ENABLE_INTERUPT 0x08
+
+/* Enable Data Ready Generation - relationship with previous unclear in docs */
+#define LIS3L02DQ_REG_CTRL_2_ENABLE_DATA_READY_GENERATION 0x04
+
+/* SPI 3 wire mode */
+#define LIS3L02DQ_REG_CTRL_2_THREE_WIRE_SPI_MODE 0x02
+
+/* Data alignment, default is 12 bit right justified  - option for 16 bit left justified */
+#define LIS3L02DQ_REG_CTRL_2_DATA_ALIGNMENT_16_BIT_LEFT_JUSTIFIED 0x01
+
+/* Interupt related stuff */
+#define LIS3L02DQ_REG_WAKE_UP_CFG_ADDRESS 0x23
+
+/* Switch from or combination fo conditions to and */
+#define LIS3L02DQ_REG_WAKE_UP_CFG_BOOLEAN_AND 0x80
+
+/* Latch interupt request, if on ack must be given by reading the ack register */
+#define LIS3L02DQ_REG_WAKE_UP_CFG_LATCH_SRC 0x40
+
+/* Z Interupt on High (above threshold)*/
+#define LIS3L02DQ_REG_WAKE_UP_CFG_INTERRUPT_Z_HIGH 0x20
+/* Z Interupt on Low */
+#define LIS3L02DQ_REG_WAKE_UP_CFG_INTERRUPT_Z_LOW 0x10
+/* Y Interupt on High */
+#define LIS3L02DQ_REG_WAKE_UP_CFG_INTERRUPT_Y_HIGH 0x08
+/* Y Interupt on Low */
+#define LIS3L02DQ_REG_WAKE_UP_CFG_INTERRUPT_Y_LOW 0x04
+/* X Interupt on Hight */
+#define LIS3L02DQ_REG_WAKE_UP_CFG_INTERRUPT_X_HGIH 0x02
+/* X Interupt on Low */
+#define LIS3L02DQ_REG_WAKT_UP_CFG_INTERRUPT_X_LOW 0x01
+
+/* Register that gives description of what caused interupt - latched if set in CFG_ADDRES */
+#define LIS3L02DQ_REG_WAKE_UP_SRC_ADDRESS 0x24
+/* top bit ignored */
+/* Interupt Active */
+#define LIS3L02DQ_REG_WAKE_UP_SRC_INTERRUPT_ACTIVATED 0x40
+/* Interupts that have been triggered */
+#define LIS3L02DQ_REG_WAKE_UP_SRC_INTERRUPT_Z_HIGH 0x20
+#define LIS3L02DQ_REG_WAKE_UP_SRC_INTERRUPT_Z_LOW 0x10
+#define LIS3L02DQ_REG_WAKE_UP_SRC_INTERRUPT_Y_HIGH 0x08
+#define LIS3L02DQ_REG_WAKE_UP_SRC_INTERRUPT_Y_LOW 0x04
+#define LIS3L02DQ_REG_WAKE_UP_SRC_INTERRUPT_X_HIGH 0x02
+#define LIS3L02DQ_REG_WAKE_UP_SRC_INTERRUPT_X_LOW 0x01
+
+#define LIS3L02DQ_REG_WAKE_UP_ACK_ADDRESS 0x25
+
+/* Status register */
+#define LIS3L02DQ_REG_STATUS_ADDRESS 0x27
+/* XYZ axis data overrun - first is all overrun? */
+#define LIS3L02DQ_REG_STATUS_XYZ_OVERRUN 0x80
+#define LIS3L02DQ_REG_STATUS_Z_OVERRUN 0x40
+#define LIS3L02DQ_REG_STATUS_Y_OVERRUN 0x20
+#define LIS3L02DQ_REG_STATUS_X_OVERRUN 0x10
+/* XYZ new data available - first is all 3 available? */
+#define LIS3L02DQ_REG_STATUS_XYZ_NEW_DATA 0x08
+#define LIS3L02DQ_REG_STATUS_Z_NEW_DATA 0x04
+#define LIS3L02DQ_REG_STATUS_Y_NEW_DATA 0x02
+#define LIS3L02DQ_REG_STATUS_X_NEW_DATA 0x01
+
+/* The accelerometer readings - low and high bytes.
+Form of high byte dependant on justification set in ctrl reg */
+#define LIS3L02DQ_REG_OUT_X_L_ADDRESS 0x28
+#define LIS3L02DQ_REG_OUT_X_H_ADDRESS 0x29
+#define LIS3L02DQ_REG_OUT_Y_L_ADDRESS 0x2A
+#define LIS3L02DQ_REG_OUT_Y_H_ADDRESS 0x2B
+#define LIS3L02DQ_REG_OUT_Z_L_ADDRESS 0x2C
+#define LIS3L02DQ_REG_OUT_Z_H_ADDRESS 0x2D
+
+/* Threshold values for all axes and both above and below thresholds - i.e. there is only one value */
+#define LIS3L02DQ_REG_THS_L_ADDRESS 0x2E
+#define LIS3L02DQ_REG_THS_H_ADDRESS 0x2D
+
+
+/* SPI MODE */
+#define LIS3L02DQ_SPI_MODE SPI_MODE_3
+
+#define LIS3L02DQ_DEFAULT_CTRL1 LIS3L02DQ_REG_CTRL_1_PD_ON \
+	| LIS3L02DQ_REG_CTRL_1_AXES_Z_ENABLE \
+	| LIS3L02DQ_REG_CTRL_1_AXES_Y_ENABLE \
+	| LIS3L02DQ_REG_CTRL_1_AXES_X_ENABLE \
+	| LIS3L02DQ_REG_CTRL_1_DF_128 
+
+#define LIS3L02DQ_DEFAULT_CTRL2 LIS3L02DQ_REG_CTRL_2_ENABLE_DATA_READY_GENERATION \
+	| LIS3L02DQ_REG_CTRL_2_BLOCK_UPDATE
+
+struct LIS3L02DQ_platform_data
+{
+  unsigned data_ready_gpio;
+};
+
+#define LIS3L02DQ_BUFFER_LENGTH 100
+
+
+struct LIS3L02DQ_state {
+	struct spi_device*     us;
+	unsigned char          tx_buff[2*6];
+	unsigned char          rx_buff[2*6];
+	
+#ifdef CONFIG_SPI_LIS3L02DQ_GPIO_INTERRUPT
+	struct work_struct     work;
+	bool                   inter;
+	uint8_t                ring_buffer[LIS3L02DQ_BUFFER_LENGTH*6];
+	uint8_t*               read_pointer;
+	uint8_t*               write_pointer;
+	uint8_t*               last_written_pointer;
+#endif /* CONFIG_SPI_LIS3L02DQ_GPIO_INTERRUPT */
+};
+
+
+#ifdef CONFIG_SPI_LIS3L02DQ_GPIO_INTERRUPT
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/gpio.h>
+#include <linux/workqueue.h>
+#endif /* CONFIG_SPI_LIS3L02DQ_GPIO_INTERRUPT */
+
+
+#endif /* _LIS3L02DQ_H_ */ 
--- a/drivers/spi/LIS3L02DQ.c	1970-01-01 01:00:00.000000000 +0100
+++ b/drivers/spi/LIS3L02DQ.c	2008-04-28 14:52:31.000000000 +0100
@@ -0,0 +1,774 @@
+/* 
+ * LISL02DQ.c -- support STMicroelectronics LISD02DQ 
+ *               3d 2g Linear Accelerometers via SPI
+ *
+ * Copyright (c) 2007 Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
+ *
+ * Loosely based upon tle62x0.c 
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This driver has two modes, one is interrupt based, the other on demand */
+
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/LIS3L02DQ.h>
+
+static const char read_all_tx_array[] =
+{
+	0, LIS3L02DQ_READ_REG(LIS3L02DQ_REG_OUT_X_L_ADDRESS),
+	0, LIS3L02DQ_READ_REG(LIS3L02DQ_REG_OUT_X_H_ADDRESS),
+	0, LIS3L02DQ_READ_REG(LIS3L02DQ_REG_OUT_Y_L_ADDRESS),
+	0, LIS3L02DQ_READ_REG(LIS3L02DQ_REG_OUT_Y_H_ADDRESS),
+	0, LIS3L02DQ_READ_REG(LIS3L02DQ_REG_OUT_Z_L_ADDRESS),
+	0, LIS3L02DQ_READ_REG(LIS3L02DQ_REG_OUT_Z_H_ADDRESS),	
+};
+
+static int LIS3L02DQ_read_all(struct LIS3L02DQ_state* st)
+{
+	/* Sadly the device appears to require deselection between 
+	 * reading the different registers - hence the somewhat
+	 * convoluted nature of this transfer */
+	struct spi_transfer xfers[] = {
+		/* x low byte */
+		{
+			.tx_buf = read_all_tx_array,
+			.rx_buf = st->rx_buff,
+			.bits_per_word = 16,
+			.len = 2,
+		},
+		/* x high byte */
+		{
+			.tx_buf = read_all_tx_array+2,
+			.rx_buf = st->rx_buff+2,
+			.bits_per_word = 16,
+			.len = 2,
+		},
+		/* y low byte */
+		{
+			.tx_buf = read_all_tx_array+4,
+			.rx_buf = st->rx_buff+4,
+			.bits_per_word = 16,
+			.len = 2,
+		},
+		/* y high byte */
+		{
+			.tx_buf = read_all_tx_array+6,
+			.rx_buf = st->rx_buff+6,
+			.bits_per_word = 16,
+			.len = 2,
+		},
+		/* z low byte */
+		{
+			.tx_buf = read_all_tx_array+8,
+			.rx_buf = st->rx_buff+8,
+			.bits_per_word = 16,
+			.len = 2,
+		},
+		/* z high byte */
+		{
+			.tx_buf = read_all_tx_array+10,
+			.rx_buf = st->rx_buff+10,
+			.bits_per_word = 16,
+			.len = 2,
+		},
+	};
+	struct spi_message msg;
+	int ret;
+	memset(st->rx_buff, 0, sizeof st->rx_buff);
+	/* After these are trasmitted, the rx_buff should have 
+	 * values in alternate bytes */
+	spi_message_init(&msg);
+	
+	spi_message_add_tail(&xfers[0], &msg);
+	spi_message_add_tail(&xfers[2], &msg);
+	spi_message_add_tail(&xfers[4], &msg);
+	spi_message_add_tail(&xfers[1], &msg);
+	spi_message_add_tail(&xfers[3], &msg);
+	spi_message_add_tail(&xfers[5], &msg);
+	ret = spi_sync(st->us, &msg);
+	if(ret)	{
+		dev_err(&st->us->dev, "problem with get all accels");
+		goto err_ret;
+	}
+err_ret:
+	return ret;
+}
+
+#ifdef CONFIG_SPI_LIS3L02DQ_GPIO_INTERRUPT
+/* A fairly inellegant way of ripping the contents of the 
+ * ring buffer and ensuring only a valid set of readings are output */
+static ssize_t LIS3L02DQ_rip_buffer(struct device* dev, 
+				    struct device_attribute *attr, 
+				    char *buf)
+{
+	int len = 0, elements, i, dead_offset = 0;
+	uint8_t data_dump[LIS3L02DQ_BUFFER_LENGTH*6];
+	uint8_t *initial_read_p, *initial_write_p, 
+		*current_read_p, *end_read_p;
+	struct LIS3L02DQ_state *st = dev_get_drvdata(dev);
+	uint16_t temp;
+	
+	/* Get a consistent pair of read and write pointers */
+	initial_read_p = st->read_pointer;
+	
+	/* Occurs if nothing has yet been placed in the ring buffer */
+	if(unlikely(initial_read_p == 0))
+		goto err;
+	
+	initial_write_p = st->write_pointer;
+	while( initial_read_p != st->read_pointer 
+	       || initial_write_p != st->write_pointer)	{
+		initial_read_p = st->read_pointer;
+		initial_write_p = st->write_pointer;
+	}
+	if ( initial_write_p > initial_read_p ) { 
+		elements = (initial_write_p - initial_read_p); 
+		memcpy(data_dump, initial_read_p, elements);
+	} else {
+		elements = st->ring_buffer 
+			+ LIS3L02DQ_BUFFER_LENGTH*6 
+			- initial_read_p;
+
+		memcpy(data_dump, initial_read_p, elements);
+		
+		memcpy(data_dump+elements, 
+		       st->ring_buffer, 
+		       initial_write_p - st->ring_buffer);
+		elements += initial_write_p - st->ring_buffer;
+	}
+	
+	end_read_p = st->read_pointer;
+	
+	if( initial_read_p <= end_read_p )
+		dead_offset = end_read_p - initial_read_p;
+	else
+		dead_offset = st->ring_buffer 
+			+ LIS3L02DQ_BUFFER_LENGTH*6 - initial_read_p 
+			+ end_read_p - st->ring_buffer; 
+	
+	/* Possible issue here is the readpointer may have changed.
+	 * It could in theory have passed the initial write pointer.*/
+	st->read_pointer = initial_write_p;
+	
+	for(current_read_p = data_dump + dead_offset; 
+	    current_read_p < data_dump + elements;  
+	    current_read_p+=6) {
+		for(i = 0; i < 3; i++) {
+			temp = (((uint16_t)((current_read_p[2*i+1]))) << 8) 
+				| (uint16_t)(current_read_p[2*i]);
+			len += sprintf(len+buf, "%d ", *((int16_t*)(&temp)));
+		}	
+	}
+	len += sprintf(len+buf, "\n");
+	return len;
+err:
+	return 0;
+}
+#endif /* CONFIG_SPI_LIS3L02DQ_GPIO_INTERRUPT */
+
+
+/* If in interrupt triggered mode this sysfs function will output the latest 
+ * finished element from the ringbuffer.
+ *
+ * If in direct access mode it will simply read the output registers of the 
+ * device. 
+ * Be aware that the device may be in blocking mode so results are a little 
+ * unpredictable */
+#ifdef CONFIG_SPI_LIS3L02DQ_GPIO_INTERRUPT
+static ssize_t LIS3L02DQ_scan(struct device *dev, 
+			      struct device_attribute *attr, 
+			      char *buf)
+{
+	int i,len = 0;
+	uint16_t temp;
+	struct LIS3L02DQ_state *st = dev_get_drvdata(dev);
+	if(likely(st->last_written_pointer !=0)) {
+		/* conditions in which this may go wrong ?*/
+		uint8_t* written_p = st->last_written_pointer;
+		for(i = 0; i < 3; i++) {
+			temp = (((uint16_t)((written_p[2*i+1]))) << 8) 
+				| (uint16_t)(written_p[2*i]);
+			len += sprintf(len+buf, "%d ", *((int16_t*)(&temp)));
+		}
+	}
+	len += sprintf(len+buf, "\n");
+	return len;
+}
+
+#else 
+
+static ssize_t LIS3L02DQ_scan(struct device *dev, 
+			      struct device_attribute *attr, 
+			      char *buf)
+{
+	int i,len = 0;
+	uint16_t temp;
+	struct LIS3L02DQ_state *st = dev_get_drvdata(dev);
+	if(LIS3L02DQ_read_all(st) < 0)
+		goto err_ret;
+	
+
+	for(i = 0; i < 3; i++) {
+		temp = (((uint16_t)((st->rx_buff[4*i+2]))) << 8) 
+			| (uint16_t)(st->rx_buff[4*i]);
+		len += sprintf(len+buf, "%d ", *((int16_t*)(&temp)));
+	}
+
+	len += sprintf(len+buf, "\n");
+	return len;
+err_ret:
+	return 0;
+
+}
+#endif /* else CONFIG_SPI_LIS3L02DQ_GPIO_INTERRUPT */
+
+static int8_t LIS3L02DQ_read_register_int8_t(struct device *dev, 
+					     uint8_t reg_address)
+{
+	int8_t val, ret;
+	struct spi_message msg;
+	struct LIS3L02DQ_state *st = dev_get_drvdata(dev);
+	struct spi_transfer xfer = {
+		.tx_buf = st->tx_buff,
+		.rx_buf = st->rx_buff,
+		.bits_per_word = 16,
+		.len = 2,
+	};
+	st->tx_buff[1] = LIS3L02DQ_READ_REG(reg_address);
+	spi_message_init(&msg);
+	spi_message_add_tail(&xfer, &msg);
+	ret = spi_sync(st->us, &msg);
+	if( ret ) {
+		dev_err(&st->us->dev, "problem with get x offset");
+		goto err_ret;
+	}
+	val = st->rx_buff[0];
+	return val;
+	/* Unfortunately the result can be negative so passing error 
+	 * back not a good idea */
+err_ret:
+	return 0;  
+}
+
+/*Returns into to allow full 0/255 range with error codes in negative range */
+static int LIS3L02DQ_read_register_uint8_t(struct device *dev, 
+					       uint8_t reg_address)
+{
+	uint8_t val;
+	int8_t ret;
+	struct spi_message msg;
+	struct LIS3L02DQ_state *st = dev_get_drvdata(dev);
+	struct spi_transfer xfer = {
+		.tx_buf = st->tx_buff,
+		.rx_buf = st->rx_buff,
+		.bits_per_word = 16,
+		.len = 2,
+	};
+	st->tx_buff[1] = LIS3L02DQ_READ_REG(reg_address);
+	spi_message_init(&msg);
+	spi_message_add_tail(&xfer, &msg);
+	ret = spi_sync(st->us, &msg);
+	if( ret ) {
+		dev_err(&st->us->dev, "problem with get x offset");
+		goto err_ret;
+	}
+	val = st->rx_buff[0];
+	return val;
+	/* Unfortunately the result can be negative so passing error 
+	 * back not a good idea */
+err_ret:
+	return ret;  
+}
+
+static int LIS3L02DQ_write_register_int8_t(struct device* dev, 
+					   uint8_t reg_address, 
+					   int8_t value)
+{
+	struct spi_message msg;
+	struct LIS3L02DQ_state *st = dev_get_drvdata(dev);
+	struct spi_transfer xfer = {
+		.tx_buf = st->tx_buff,
+		.rx_buf = NULL,
+		.bits_per_word = 16,
+		.len = 2,
+	};
+	int ret;
+	st->tx_buff[1] = LIS3L02DQ_WRITE_REG(reg_address);
+	st->tx_buff[0] = value;
+	spi_message_init(&msg);
+	spi_message_add_tail(&xfer, &msg);
+	ret = spi_sync(st->us, &msg);
+	if( ret ) {
+		dev_err(&st->us->dev, "problem with writing 8 bit register");
+		goto err_ret;
+	}
+	return 0;
+err_ret:
+	return ret;
+}
+
+
+static int LIS3L02DQ_write_register_uint8_t(struct device* dev, 
+					    uint8_t reg_address, 
+					    uint8_t value)
+{
+	struct spi_message msg;
+	struct LIS3L02DQ_state *st = dev_get_drvdata(dev);
+	struct spi_transfer xfer = {
+		.tx_buf = st->tx_buff,
+		.rx_buf = NULL,
+		.bits_per_word = 16,
+		.len = 2,
+	};
+	int ret;
+	st->tx_buff[1] = LIS3L02DQ_WRITE_REG(reg_address);
+	st->tx_buff[0] = value;
+	spi_message_init(&msg);
+	spi_message_add_tail(&xfer, &msg);
+	ret = spi_sync(st->us, &msg);
+	if( ret ) {
+		dev_err(&st->us->dev, "problem with writing 8 bit register");
+		goto err_ret;
+	}
+	return 0;
+err_ret:
+	return ret;
+}
+
+static ssize_t LIS3L02DQ_read_x_offset(struct device *dev, 
+				       struct device_attribute *attr, 
+				       char *buf)
+{	
+	int val, len ;
+	val = LIS3L02DQ_read_register_int8_t(dev, 
+					     LIS3L02DQ_REG_OFFSET_X_ADDRESS);
+	len = sprintf(buf, "%d\n", val);
+	return len;
+}
+
+static ssize_t LIS3L02DQ_read_y_offset(struct device *dev, 
+				       struct device_attribute *attr, 
+				       char *buf)
+{
+	int val, len;
+	val = LIS3L02DQ_read_register_int8_t(dev, 
+					     LIS3L02DQ_REG_OFFSET_Y_ADDRESS);
+	len = sprintf(buf, "%d\n", val);
+	return len;
+}
+
+static ssize_t LIS3L02DQ_read_z_offset(struct device *dev, 
+				       struct device_attribute *attr, 
+				       char *buf)
+{
+	int val, len;
+	val = LIS3L02DQ_read_register_int8_t(dev, 
+					     LIS3L02DQ_REG_OFFSET_Z_ADDRESS);
+	len = sprintf(buf, "%d\n", val);
+	return len;
+}
+
+static ssize_t LIS3L02DQ_read_x_gain(struct device *dev, 
+				     struct device_attribute *attr, 
+				     char *buf)
+{
+	int val, len;
+	val = LIS3L02DQ_read_register_uint8_t(dev, 
+					     LIS3L02DQ_REG_GAIN_X_ADDRESS);
+	if(val < 0) {
+		dev_err(dev, "problem reading x gain");
+		goto err_ret;
+		}
+
+	len = sprintf(buf, "%d\n", val);
+	return len;
+err_ret:
+	return val;
+}
+
+static ssize_t LIS3L02DQ_read_y_gain(struct device *dev, 
+				     struct device_attribute *attr, 
+				     char *buf)
+{
+	int val, len;
+	val = LIS3L02DQ_read_register_uint8_t(dev, 
+					     LIS3L02DQ_REG_GAIN_Y_ADDRESS);
+	if(val < 0) {
+		dev_err(dev, "problem reading y gain");
+		goto err_ret;
+		}
+	len = sprintf(buf, "%d\n", val);
+	return len;
+err_ret:
+	return val;
+}
+
+static ssize_t LIS3L02DQ_read_z_gain(struct device *dev, 
+				     struct device_attribute *attr, 
+				     char *buf)
+{
+	int val, len;
+	val = LIS3L02DQ_read_register_uint8_t(dev, 
+					     LIS3L02DQ_REG_GAIN_Z_ADDRESS);
+	if(val < 0) {
+		dev_err(dev, "problem reading y gain");
+		goto err_ret;
+	}
+	len = sprintf(buf, "%d\n", val);
+	return len;
+err_ret:
+	return val;
+}
+
+static ssize_t LIS3L02DQ_write_x_offset(struct device *dev, 
+					struct device_attribute *attr, 
+					const char *buf, 
+					size_t len)
+{
+	int ret,val;
+	char *endp;
+	val = simple_strtol(buf, &endp, 0);
+	ret = LIS3L02DQ_write_register_int8_t(dev, 
+					      LIS3L02DQ_REG_OFFSET_X_ADDRESS, 
+					      val);
+	if( ret )
+		goto err_ret;
+	return len;
+err_ret:
+	return ret;
+}
+
+static ssize_t LIS3L02DQ_write_y_offset(struct device *dev, 
+					struct device_attribute *attr, 
+					const char *buf, 
+					size_t len)
+{
+	int ret,val;
+	char *endp;
+	val = simple_strtol(buf, &endp, 0);
+	ret = LIS3L02DQ_write_register_int8_t(dev, 
+					      LIS3L02DQ_REG_OFFSET_Y_ADDRESS, 
+					      val);
+	if( ret )
+		goto err_ret;
+	return len;
+err_ret:
+	return ret;
+
+}
+
+static ssize_t LIS3L02DQ_write_z_offset(struct device *dev, 
+					struct device_attribute *attr, 
+					const char *buf, 
+					size_t len)
+{
+	int ret,val;
+	char *endp;
+	val = simple_strtol(buf, &endp, 0);
+	ret = LIS3L02DQ_write_register_int8_t(dev, 
+					      LIS3L02DQ_REG_OFFSET_Z_ADDRESS, 
+					      val);
+	if( ret )
+		goto err_ret;
+	return len;
+err_ret:
+	return ret;
+}
+
+static ssize_t LIS3L02DQ_write_x_gain(struct device *dev, 
+				      struct device_attribute *attr, 
+				      const char *buf, 
+				      size_t len)
+{
+	int ret,val;
+	char *endp;
+	val = simple_strtol(buf, &endp, 0);
+	ret = LIS3L02DQ_write_register_uint8_t(dev, 
+					      LIS3L02DQ_REG_GAIN_X_ADDRESS, 
+					      val);
+	if( ret )
+		goto err_ret;
+	return len;
+err_ret:
+	return ret;
+}
+
+static ssize_t LIS3L02DQ_write_y_gain(struct device *dev, 
+				      struct device_attribute *attr, 
+				      const char *buf, 
+				      size_t len)
+{
+	int ret,val;
+	char *endp;
+	val = simple_strtol(buf, &endp, 0);
+	ret = LIS3L02DQ_write_register_uint8_t(dev, 
+					       LIS3L02DQ_REG_GAIN_Y_ADDRESS, 
+					       val);
+	if( ret )
+		goto err_ret;
+	return len;
+err_ret:
+	return ret;
+}
+
+static ssize_t LIS3L02DQ_write_z_gain(struct device *dev, 
+				      struct device_attribute *attr, 
+				      const char *buf, 
+				      size_t len)
+{
+	int ret,val;
+	char *endp;
+	val = simple_strtol(buf, &endp, 0);
+	ret = LIS3L02DQ_write_register_uint8_t(dev, 
+					       LIS3L02DQ_REG_GAIN_Z_ADDRESS, 
+					       val);
+	if( ret )
+		goto err_ret;
+	return len;
+err_ret:
+	return ret;
+}
+
+
+static int LIS3L02DQ_initial_setup(struct LIS3L02DQ_state* st)
+{
+	int ret;
+	memset(st->tx_buff, 0, sizeof st->tx_buff);
+	memset(st->rx_buff, 0, sizeof st->rx_buff);
+	st->us->mode = SPI_MODE_3;
+	spi_setup(st->us);
+	
+	/* Write suitable defaults to ctrl1 */
+	ret = LIS3L02DQ_write_register_int8_t(&st->us->dev, 
+					      LIS3L02DQ_REG_CTRL_1_ADDRESS, 
+					      LIS3L02DQ_DEFAULT_CTRL1);
+	if(ret)	{
+		dev_err(&st->us->dev, "problem with setup control register 1");
+		goto err_ret;
+	}
+	ret = LIS3L02DQ_write_register_int8_t(&st->us->dev, 
+					      LIS3L02DQ_REG_CTRL_2_ADDRESS, 
+					      LIS3L02DQ_DEFAULT_CTRL2);
+	if(ret)	{
+		dev_err(&st->us->dev, "problem with setup control register 2");
+		goto err_ret;
+	}
+err_ret:
+	return ret;
+}
+
+/* put pointers to these in a table to simplify adding / removing them? */
+static DEVICE_ATTR(scan,       S_IRUGO,           LIS3L02DQ_scan,          NULL);
+static DEVICE_ATTR(x_offset,   S_IWUSR | S_IRUGO, LIS3L02DQ_read_x_offset, LIS3L02DQ_write_x_offset);
+static DEVICE_ATTR(y_offset,   S_IWUSR | S_IRUGO, LIS3L02DQ_read_y_offset, LIS3L02DQ_write_y_offset);
+static DEVICE_ATTR(z_offset,   S_IWUSR | S_IRUGO, LIS3L02DQ_read_z_offset, LIS3L02DQ_write_z_offset);
+static DEVICE_ATTR(x_gain,     S_IWUSR | S_IRUGO, LIS3L02DQ_read_x_gain,   LIS3L02DQ_write_x_gain);
+static DEVICE_ATTR(y_gain,     S_IWUSR | S_IRUGO, LIS3L02DQ_read_y_gain,   LIS3L02DQ_write_y_gain);
+static DEVICE_ATTR(z_gain,     S_IWUSR | S_IRUGO, LIS3L02DQ_read_z_gain,   LIS3L02DQ_write_z_gain);
+#ifdef CONFIG_SPI_LIS3L02DQ_GPIO_INTERRUPT
+static DEVICE_ATTR(rip_buffer, S_IRUGO,           LIS3L02DQ_rip_buffer,    NULL);
+#endif 
+static struct device_attribute *LIS3L02DQ_attrs[] = {
+	&dev_attr_scan,
+	&dev_attr_x_offset,
+	&dev_attr_y_offset,
+	&dev_attr_z_offset,
+	&dev_attr_x_gain,
+	&dev_attr_y_gain,
+	&dev_attr_z_gain,
+#ifdef CONFIG_SPI_LIS3L02DQ_GPIO_INTERRUPT
+	&dev_attr_rip_buffer,
+#endif 
+};
+
+#ifdef CONFIG_SPI_LIS3L02DQ_GPIO_INTERRUPT
+static irqreturn_t interrupthandler(int irq, void* _state)
+{
+	struct LIS3L02DQ_state* st = _state;
+	disable_irq_nosync(irq);
+	schedule_work(&st->work);
+	st->inter = 1;
+	return IRQ_HANDLED;	
+}
+
+static void LIS3L02DQ_store_to_ring(struct LIS3L02DQ_state* st)
+{
+	int i;
+	bool initread = true;
+	/* First use of ring */
+	if(unlikely(st->write_pointer==0)) {
+		st->write_pointer = st->ring_buffer;
+		initread = false;
+	}
+	/*probably unnecessary */
+	barrier();
+	/*save data */
+	for(i = 0; i < 3; i++) {
+		st->write_pointer[i*2] = st->rx_buff[i*4];
+		st->write_pointer[i*2+1] = st->rx_buff[i*4+2]; 
+	}
+	barrier();
+	st->last_written_pointer = st->write_pointer;
+	barrier();
+	st->write_pointer += 6;
+	if(unlikely(st->write_pointer 
+		    == st->ring_buffer + 6*LIS3L02DQ_BUFFER_LENGTH))
+		st->write_pointer = st->ring_buffer;
+	
+	if(unlikely(st->read_pointer==0))
+		st->read_pointer = st->ring_buffer;
+	else if (st->write_pointer == st->read_pointer)	{
+		if(unlikely((st->read_pointer+6 
+			     == st->ring_buffer + 6*LIS3L02DQ_BUFFER_LENGTH)))
+			st->read_pointer = st->ring_buffer;
+		else 
+			st->read_pointer += 6;
+	}
+	return;
+}  
+
+static void LIS3L02DQ_data_ready_work(struct work_struct *work_s)
+{
+	
+	struct LIS3L02DQ_state* st 
+		= container_of(work_s, struct LIS3L02DQ_state, work);
+	struct LIS3L02DQ_platform_data* pdata = st->us->dev.platform_data;
+	
+	st->inter = 0;
+	if( LIS3L02DQ_read_all(st) >= 0)
+		LIS3L02DQ_store_to_ring(st);
+	
+try_again:
+	while(gpio_get_value(pdata->data_ready_gpio)) 
+		if( LIS3L02DQ_read_all(st) >= 0)
+			LIS3L02DQ_store_to_ring(st);
+	
+	/* If we are lucky gpio should not be set now 
+	 * Try reenabling interrupt. */
+	enable_irq(gpio_to_irq(pdata->data_ready_gpio));
+	/* verify that either the gpio has not risen or that 
+	 * the interrupt handler caught it */
+	if(gpio_get_value(pdata->data_ready_gpio))
+		if( st->inter == 0 ) {
+			disable_irq_nosync(gpio_to_irq(pdata
+						       ->data_ready_gpio));
+			goto try_again;
+		}	
+	return;
+}
+
+#endif /* CONFIG_SPI_LIS3L02DQ_GPIO_INTERRUPT */
+
+static int __devinit LIS3L02DQ_probe(struct spi_device *spi)
+{
+	struct LIS3L02DQ_state* st;
+	struct LIS3L02DQ_platform_data* pdata;
+	int ret,i ;
+	
+	pdata = spi->dev.platform_data;
+	st = kzalloc(sizeof(struct LIS3L02DQ_state), GFP_KERNEL);
+	st->us = spi;
+	
+	if(pdata == NULL) {
+		dev_err(&spi->dev, "no device data specified\n");
+		return -EINVAL;
+	}
+	for(i = 0; i < ARRAY_SIZE(LIS3L02DQ_attrs); i++) {
+		ret = device_create_file(&spi->dev, LIS3L02DQ_attrs[i]);
+		if (ret) {
+			dev_err(&spi->dev, "cannot create attribute\n");
+			goto err_status;
+		}
+	}
+	
+	spi_set_drvdata(spi, st);
+	
+
+#ifdef CONFIG_SPI_LIS3L02DQ_GPIO_INTERRUPT
+	INIT_WORK(&st->work, LIS3L02DQ_data_ready_work);
+	st->inter = 0;
+	/* enable an interrupt on the data ready line */
+	ret = request_irq(gpio_to_irq(pdata->data_ready_gpio),
+			  interrupthandler, 
+			  IRQF_DISABLED, 
+			  "LIS3L02DQ data ready", 
+			  st);
+	
+	set_irq_type(gpio_to_irq(pdata->data_ready_gpio), IRQT_RISING);
+#endif /* CONFIG_SPI_LIS3L02DQ_GPIO_INTERRUPT */	
+	/* This setup enables data ready generation (amongst other things)*/
+	ret = LIS3L02DQ_initial_setup(st);
+	
+	return ret;	
+	
+err_status:
+	
+	for(i = 0; i < ARRAY_SIZE(LIS3L02DQ_attrs); i++)
+		device_remove_file(&spi->dev, LIS3L02DQ_attrs[i]);
+	return ret;
+}
+
+static int LIS3L02DQ_remove(struct spi_device *spi)
+{
+	int i,ret;
+	struct LIS3L02DQ_state* st = spi_get_drvdata(spi);
+	struct LIS3L02DQ_platform_data* pdata = spi->dev.platform_data;
+	/* stop the device */
+	ret = LIS3L02DQ_write_register_int8_t(&st->us->dev, 
+					      LIS3L02DQ_REG_CTRL_1_ADDRESS, 
+					      0);
+	if ( ret ) {
+		dev_err(&st->us->dev, "problem with turning device off: ctrl1");
+		goto err_ret;
+	}
+	ret = LIS3L02DQ_write_register_int8_t(&st->us->dev,
+					      LIS3L02DQ_REG_CTRL_2_ADDRESS,
+					      0);
+	if ( ret ) {
+		dev_err(&st->us->dev, "problem with turning device off: ctrl2");
+		goto err_ret;
+	}
+	for(i = 0; i < ARRAY_SIZE(LIS3L02DQ_attrs); i++)
+		device_remove_file(&spi->dev, LIS3L02DQ_attrs[i]);
+#ifdef CONFIG_SPI_LIS3L02DQ_GPIO_INTERRUPT
+	flush_scheduled_work();
+	free_irq(gpio_to_irq(pdata->data_ready_gpio),st);
+#endif /* CONFIG_SPI_LIS3L02DQ_GPIO_INTERRUPT */
+	kfree(st);
+	return 0;
+
+err_ret:
+	return ret;
+
+}
+
+static struct spi_driver LIS3L02DQ_driver = {
+	.driver = {
+		.name = "LIS3L02DQ",
+		.owner = THIS_MODULE,
+	},
+	.probe = LIS3L02DQ_probe,
+	.remove = __devexit_p(LIS3L02DQ_remove),
+};
+
+static __init int LIS3L02DQ_init(void)
+{
+	return spi_register_driver(&LIS3L02DQ_driver);
+}
+
+static __exit void LIS3L02DQ_exit(void)
+{
+	spi_unregister_driver(&LIS3L02DQ_driver);
+	return;
+}
+
+module_init(LIS3L02DQ_init);
+module_exit(LIS3L02DQ_exit);
+
+MODULE_AUTHOR("Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>");
+MODULE_DESCRIPTION("ST LIS3L02DQ Accelerometer SPI driver");
+MODULE_LICENSE("GPL v2");


-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
