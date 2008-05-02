From: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Subject: Re: [PATCH 1/1] Initial support for ST
 Microelectronics lis3l02dq accelerometer via SPI
Date: Fri, 02 May 2008 09:55:05 +0100
Message-ID: <481AD6E9.1090201@cam.ac.uk>
References: <481210CC.9080702@cam.ac.uk>
	<481226C4.9010806@cam.ac.uk>	<4815D9A6.4040306@cam.ac.uk>	<200804301804.24924.david-b@pacbell.net>
	<4819FD27.7070600@cam.ac.uk> <481A01E2.8030309@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <481A01E2.8030309-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
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

Initial support for ST Microelectronics LIS3L02DQ accelerometer via SPI

Signed-off-by: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>

---
Resend of patch. Hopefully my email client shouldn't mangle it this time.

This patch includes a number of changes suggested by David Brownell.
Provides sysfs interface to set calibration parameters and read last value.
Two modes available, first gives direct on demand access to chip, second
utilizes a ring buffer and provides a rip_buffer sysfs element which gets
the new buffer contents. This is intended for use by a userspace program
that will check often enough that no data is lost.

The interrupt driver mode requires that the interrupt is from a gpioline
due to the nature of the data_ready signal from the chip.

Requires patch to fix missing gpio_is_valid() definitions.
(now in mainline since Monday)



--- a/drivers/spi/Kconfig    2008-04-17 03:49:44.000000000 +0100
+++ b/drivers/spi/Kconfig    2008-05-01 18:12:04.000000000 +0100
@@ -221,5 +221,17 @@ config SPI_AT25
       This driver can also be built as a module.  If so, the module
       will be called at25.

+config SPI_LIS3L02DQ
+       tristate "STMicroelectronics LIS3L02DQ Accelerometer"
+       depends on SPI_MASTER && SYSFS
+       help
+        SPI driver for the STMicroelectrincs LIS3L02DQ 3-Axis 2g digital
+        output linear accelerometer.  This provides a sysfs interface.
+         Calibration parameters may be read and controlled (gain / offset).
+         Last 3d accel reading obtained via scan attribute and a ring buffer
+         interrupt mode enabled allowing high frequency data to be obtained
+         via rip_buffer attribute.
+
+
config SPI_SPIDEV
     tristate "User mode SPI device driver support"
     depends on SPI_MASTER && EXPERIMENTAL
--- a/drivers/spi/Makefile    2008-04-17 03:49:44.000000000 +0100
+++ b/drivers/spi/Makefile    2008-05-01 11:55:56.000000000 +0100
@@ -32,8 +32,9 @@ obj-$(CONFIG_SPI_SH_SCI)        += spi_sh_sci.

# SPI protocol drivers (device/link on bus)
obj-$(CONFIG_SPI_AT25)        += at25.o
+obj-$(CONFIG_SPI_LIS3L02DQ)     += lis3l02dq.o
obj-$(CONFIG_SPI_SPIDEV)    += spidev.o
obj-$(CONFIG_SPI_TLE62X0)    += tle62x0.o
#     ... add above this line ...

# SPI slave controller drivers (upstream link)
--- a/drivers/spi/lis3l02dq.h    1970-01-01 01:00:00.000000000 +0100
+++ b/drivers/spi/lis3l02dq.h    2008-05-01 18:30:20.000000000 +0100
@@ -0,0 +1,168 @@
+/*
+ * LISL02DQ.h -- support STMicroelectronics LISD02DQ
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
+ * This driver has two modes, one is interrupt based, the other on demand
+ */
+#ifndef SPI_LIS3L02DQ_H_
+#define SPI_LIS3L02DQ_H_
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
+/* Enable Data Ready Generation - relationship with previous unclear in
docs */
+#define LIS3L02DQ_REG_CTRL_2_ENABLE_DATA_READY_GENERATION 0x04
+
+/* SPI 3 wire mode */
+#define LIS3L02DQ_REG_CTRL_2_THREE_WIRE_SPI_MODE 0x02
+
+/* Data alignment, default is 12 bit right justified
+ * - option for 16 bit left justified */
+#define LIS3L02DQ_REG_CTRL_2_DATA_ALIGNMENT_16_BIT_LEFT_JUSTIFIED 0x01
+
+/* Interupt related stuff */
+#define LIS3L02DQ_REG_WAKE_UP_CFG_ADDRESS 0x23
+
+/* Switch from or combination fo conditions to and */
+#define LIS3L02DQ_REG_WAKE_UP_CFG_BOOLEAN_AND 0x80
+
+/* Latch interupt request,
+ * if on ack must be given by reading the ack register */
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
+/* Register that gives description of what caused interupt
+ * - latched if set in CFG_ADDRES */
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
+/* Threshold values for all axes and both above and below thresholds
+ * - i.e. there is only one value */
+#define LIS3L02DQ_REG_THS_L_ADDRESS 0x2E
+#define LIS3L02DQ_REG_THS_H_ADDRESS 0x2D
+
+#define LIS3L02DQ_DEFAULT_CTRL1 (LIS3L02DQ_REG_CTRL_1_PD_ON          \
+                 | LIS3L02DQ_REG_CTRL_1_AXES_Z_ENABLE \
+                 | LIS3L02DQ_REG_CTRL_1_AXES_Y_ENABLE \
+                 | LIS3L02DQ_REG_CTRL_1_AXES_X_ENABLE \
+                 | LIS3L02DQ_REG_CTRL_1_DF_128)
+
+#define LIS3L02DQ_DEFAULT_CTRL2            \
+    (LIS3L02DQ_REG_CTRL_2_BLOCK_UPDATE)
+#define LIS3L02DQ_DIRECT_ONLY_MODE -1
+#define LIS3L02DQ_DIRECT_MODE       0
+#define LIS3L02DQ_INTERRUPT_MODE    1
+
+#define LIS3L02DQ_BUFFER_LENGTH 100
+
+
+struct LIS3L02DQ_state {
+    struct spi_device      *us;
+    unsigned char          *tx_buff;
+    unsigned char          *rx_buff;
+    int                     mode;
+    /* interrupt / ring buffer related elements */
+    struct work_struct     work;
+    bool                   inter;
+    uint8_t                ring_buffer[LIS3L02DQ_BUFFER_LENGTH*6];
+    uint8_t                *read_pointer;
+    uint8_t                *write_pointer;
+    uint8_t                *last_written_pointer;
+
+};
+#endif /* SPI_LIS3L02DQ_H_ */
--- a/drivers/spi/lis3l02dq.c    1970-01-01 01:00:00.000000000 +0100
+++ b/drivers/spi/lis3l02dq.c    2008-05-01 18:24:48.000000000 +0100
@@ -0,0 +1,790 @@
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
+ * This driver has two modes - INTERRUPT_MODE is only available if
+ * a gpio interrupt has been specified in the spi config.
+ *
+ * In DIRECT_MODE all of the sysfs interfaces communicate directly
+ * with the chip.
+ *
+ * In INTERRUPT_MODE the data ready interrupt of the chip is turned
+ * on and an interrupt handler (via workqueue) is used to save each
+ * reading from the chip into a local ring buffer.
+ *
+ * Two sysfs interfaces behave differently depending on the mode:
+ *
+ * scan - In direct mode a read will cause the chip to be queried
+ * whilst in interrupt mode the last fully stored reading
+ * will be retrieved from the ring buffer.
+ *
+ * rip_buffer - Designed to allow a userspace program to pull a copy
+ * of the ring buffer (new elements). In direct mode any left over
+ * elements from the last use of interrupt mode will be output.
+ * At the moment there is no overflow labeling of the ring buffer,
+ * with the userspace program assumed to check sufficiently often that
+ * the buffer does not overflow.
+ *
+ * Additional fairly self explanatory sysfs attributes are
+ * gain_x, gain_y, gain_z, offset_x, offset_y, offset_z
+ */
+
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/gpio.h>
+#include <linux/workqueue.h>
+
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/spi/spi.h>
+#include <linux/sysfs.h>
+#include "lis3l02dq.h"
+
+/* Equivalent of device_attribute with addition of address value */
+struct lis3l02dq_attribute {
+    struct attribute attr;
+    ssize_t (*show)(struct device *dev, struct attribute *attr,
+            char *buf);
+    ssize_t (*store)(struct device *dev, struct attribute *attr,
+             const char *buf, size_t count);
+    uint8_t addr;
+};
+
+#define LIS3L02DQ_ATTR(_name, _mode, _show, _store, _address)        \
+    struct lis3l02dq_attribute lis3l02dq_attr_##_name = {        \
+        .attr = {.name = __stringify(_name), .mode = _mode },    \
+        .show    = _show,                    \
+        .store    = _store,                    \
+        .addr = _address,                    \
+    }
+
+static const char read_all_tx_array[] =
+{
+    0, LIS3L02DQ_READ_REG(LIS3L02DQ_REG_OUT_X_L_ADDRESS),
+    0, LIS3L02DQ_READ_REG(LIS3L02DQ_REG_OUT_X_H_ADDRESS),
+    0, LIS3L02DQ_READ_REG(LIS3L02DQ_REG_OUT_Y_L_ADDRESS),
+    0, LIS3L02DQ_READ_REG(LIS3L02DQ_REG_OUT_Y_H_ADDRESS),
+    0, LIS3L02DQ_READ_REG(LIS3L02DQ_REG_OUT_Z_L_ADDRESS),
+    0, LIS3L02DQ_READ_REG(LIS3L02DQ_REG_OUT_Z_H_ADDRESS),
+};
+
+static int LIS3L02DQ_read_all(struct LIS3L02DQ_state *st)
+{
+    /* Sadly the device appears to require deselection between
+     * reading the different registers - hence the somewhat
+     * convoluted nature of this transfer */
+    struct spi_transfer xfers[] = {
+        /* x low byte */
+        {
+            .tx_buf = read_all_tx_array,
+            .rx_buf = st->rx_buff,
+            .bits_per_word = 16,
+            .len = 2,
+            .cs_change = 1,
+        },
+        /* x high byte */
+        {
+            .tx_buf = read_all_tx_array+2,
+            .rx_buf = st->rx_buff+2,
+            .bits_per_word = 16,
+            .len = 2,
+            .cs_change = 1,
+        },
+        /* y low byte */
+        {
+            .tx_buf = read_all_tx_array+4,
+            .rx_buf = st->rx_buff+4,
+            .bits_per_word = 16,
+            .len = 2,
+            .cs_change = 1,
+        },
+        /* y high byte */
+        {
+            .tx_buf = read_all_tx_array+6,
+            .rx_buf = st->rx_buff+6,
+            .bits_per_word = 16,
+            .len = 2,
+            .cs_change = 1,
+        },
+        /* z low byte */
+        {
+            .tx_buf = read_all_tx_array+8,
+            .rx_buf = st->rx_buff+8,
+            .bits_per_word = 16,
+            .len = 2,
+            .cs_change = 1,
+        },
+        /* z high byte */
+        {
+            .tx_buf = read_all_tx_array+10,
+            .rx_buf = st->rx_buff+10,
+            .bits_per_word = 16,
+            .len = 2,
+            .cs_change = 0,
+        },
+    };
+    struct spi_message msg;
+    int ret;
+
+    memset(st->rx_buff, 0, sizeof st->rx_buff);
+    /* After these are trasmitted, the rx_buff should have
+     * values in alternate bytes */
+    spi_message_init(&msg);
+    spi_message_add_tail(&xfers[0], &msg);
+    spi_message_add_tail(&xfers[2], &msg);
+    spi_message_add_tail(&xfers[4], &msg);
+    spi_message_add_tail(&xfers[1], &msg);
+    spi_message_add_tail(&xfers[3], &msg);
+    spi_message_add_tail(&xfers[5], &msg);
+    ret = spi_sync(st->us, &msg);
+    if (ret) {
+        dev_err(&st->us->dev, "problem with get all accels");
+        goto err_ret;
+    }
+
+err_ret:
+    return ret;
+}
+
+/* A fairly inellegant way of ripping the contents of the
+ * ring buffer and ensuring only a valid set of readings are output */
+static ssize_t LIS3L02DQ_rip_buffer(struct device *dev,
+                    struct device_attribute *attr,
+                    char *buf)
+{
+    int len = 0, elements, i, dead_offset = 0;
+    uint8_t data_dump[LIS3L02DQ_BUFFER_LENGTH*6];
+    uint8_t *initial_read_p, *initial_write_p,
+        *current_read_p, *end_read_p;
+    struct LIS3L02DQ_state *st = dev_get_drvdata(dev);
+    uint16_t temp;
+
+    /* Get a consistent pair of read and write pointers */
+    initial_read_p = st->read_pointer;
+
+    /* Occurs if nothing has yet been placed in the ring buffer */
+    if (unlikely(initial_read_p == 0))
+        goto err;
+
+    initial_write_p = st->write_pointer;
+    while (initial_read_p != st->read_pointer
+           || initial_write_p != st->write_pointer) {
+        initial_read_p = st->read_pointer;
+        initial_write_p = st->write_pointer;
+    }
+    if (initial_write_p > initial_read_p) {
+        elements = (initial_write_p - initial_read_p);
+        memcpy(data_dump, initial_read_p, elements);
+    } else {
+        elements = st->ring_buffer
+            + LIS3L02DQ_BUFFER_LENGTH*6
+            - initial_read_p;
+
+        memcpy(data_dump, initial_read_p, elements);
+        memcpy(data_dump+elements,
+               st->ring_buffer,
+               initial_write_p - st->ring_buffer);
+        elements += initial_write_p - st->ring_buffer;
+    }
+
+    end_read_p = st->read_pointer;
+
+    if (initial_read_p <= end_read_p)
+        dead_offset = end_read_p - initial_read_p;
+    else
+        dead_offset = st->ring_buffer
+            + LIS3L02DQ_BUFFER_LENGTH*6 - initial_read_p
+            + end_read_p - st->ring_buffer;
+
+    /* Possible issue here is the readpointer may have changed.
+     * It could in theory have passed the initial write pointer.*/
+    st->read_pointer = initial_write_p;
+
+    for (current_read_p = data_dump + dead_offset;
+        current_read_p < data_dump + elements;
+        current_read_p += 6) {
+        for (i = 0; i < 3; i++) {
+            temp = (((uint16_t)((current_read_p[2*i+1]))) << 8)
+                | (uint16_t)(current_read_p[2*i]);
+            len += sprintf(len+buf, "%d ", *((int16_t *)(&temp)));
+        }
+    }
+    len += sprintf(len+buf, "\n");
+
+    return len;
+
+err:
+    return 0;
+}
+
+
+
+/* If in interrupt triggered mode this sysfs function will output the
latest
+ * finished element from the ringbuffer.
+ *
+ * If in direct access mode it will simply read the output registers of the
+ * device.
+ * Be aware that the device may be in blocking mode so results are a little
+ * unpredictable */
+
+static ssize_t LIS3L02DQ_scan(struct device *dev,
+                  struct device_attribute *attr,
+                  char *buf)
+{
+    int i, len = 0;
+    uint16_t temp;
+    uint8_t *written_p;
+    struct LIS3L02DQ_state *st = dev_get_drvdata(dev);
+
+    if (st->mode != LIS3L02DQ_INTERRUPT_MODE) {
+        if (LIS3L02DQ_read_all(st) < 0)
+            goto err_ret;
+
+        for (i = 0; i < 3; i++) {
+            temp = (((uint16_t)((st->rx_buff[4*i+2]))) << 8)
+                | (uint16_t)(st->rx_buff[4*i]);
+            len += sprintf(len+buf, "%d ", *((int16_t *)(&temp)));
+        }
+    } else     if (likely(st->last_written_pointer != 0)) {
+        written_p = st->last_written_pointer;
+        for (i = 0; i < 3; i++) {
+            temp = (((uint16_t)((written_p[2*i+1]))) << 8)
+                | (uint16_t)(written_p[2*i]);
+            len += sprintf(len+buf, "%d ", *((int16_t *)(&temp)));
+        }
+    }
+    len += sprintf(len+buf, "\n");
+
+    return len;
+err_ret:
+    return 0;
+}
+
+
+static int LIS3L02DQ_read_register_int8_t(struct device *dev,
+                      uint8_t reg_address,
+                      int8_t *val)
+{
+    int ret;
+    struct spi_message msg;
+    struct LIS3L02DQ_state *st = dev_get_drvdata(dev);
+    struct spi_transfer xfer = {
+        .tx_buf = st->tx_buff,
+        .rx_buf = st->rx_buff,
+        .bits_per_word = 16,
+        .len = 2,
+    };
+
+    st->tx_buff[1] = LIS3L02DQ_READ_REG(reg_address);
+    spi_message_init(&msg);
+    spi_message_add_tail(&xfer, &msg);
+    ret = spi_sync(st->us, &msg);
+    if (ret) {
+        dev_err(&st->us->dev, "problem with get x offset");
+        goto err_ret;
+    }
+    *val = st->rx_buff[0];
+
+    return ret;
+err_ret:
+    return 0;
+}
+
+/*Returns into to allow full 0/255 range with error codes in negative
range */
+static int LIS3L02DQ_read_register_uint8_t(struct device *dev,
+                           uint8_t reg_address)
+{
+    uint8_t val;
+    int8_t ret;
+    struct spi_message msg;
+    struct LIS3L02DQ_state *st = dev_get_drvdata(dev);
+    struct spi_transfer xfer = {
+        .tx_buf = st->tx_buff,
+        .rx_buf = st->rx_buff,
+        .bits_per_word = 16,
+        .len = 2,
+    };
+
+    st->tx_buff[1] = LIS3L02DQ_READ_REG(reg_address);
+    spi_message_init(&msg);
+    spi_message_add_tail(&xfer, &msg);
+    ret = spi_sync(st->us, &msg);
+    if (ret) {
+        dev_err(&st->us->dev, "problem with get x offset");
+        goto err_ret;
+    }
+    val = st->rx_buff[0];
+
+    return val;
+err_ret:
+    return ret;
+}
+
+static int LIS3L02DQ_write_register_int8_t(struct device *dev,
+                       uint8_t reg_address,
+                       int value)
+{
+    struct spi_message msg;
+    struct LIS3L02DQ_state *st = dev_get_drvdata(dev);
+    struct spi_transfer xfer = {
+        .tx_buf = st->tx_buff,
+        .rx_buf = NULL,
+        .bits_per_word = 16,
+        .len = 2,
+    };
+    int ret;
+
+    st->tx_buff[1] = LIS3L02DQ_WRITE_REG(reg_address);
+    st->tx_buff[0] = value;
+    spi_message_init(&msg);
+    spi_message_add_tail(&xfer, &msg);
+    ret = spi_sync(st->us, &msg);
+    if (ret) {
+        dev_err(&st->us->dev, "problem with writing 8 bit register");
+        goto err_ret;
+    }
+    return 0;
+err_ret:
+    return ret;
+}
+
+
+
+static ssize_t LIS3L02DQ_read_signed(struct device *dev,
+                     struct attribute *attr,
+                     char *buf)
+{
+    int len, ret;
+    int8_t val;
+    struct lis3l02dq_attribute *this_attr
+        = container_of(attr,
+                   struct lis3l02dq_attribute,
+                   attr);
+
+    ret = LIS3L02DQ_read_register_int8_t(dev,
+                         this_attr->addr,
+                         &val);
+    if (ret < 0)
+        goto err_ret;
+    len = sprintf(buf, "%d\n", val);
+
+    return len;
+
+err_ret:
+    return ret;
+}
+
+static ssize_t LIS3L02DQ_read_unsigned(struct device *dev,
+                       struct attribute *attr,
+                       char *buf)
+{
+    int val, len;
+    struct lis3l02dq_attribute *this_attr
+        = container_of(attr,
+                   struct lis3l02dq_attribute,
+                   attr);
+
+    val = LIS3L02DQ_read_register_uint8_t(dev,
+                          this_attr->addr);
+    if (val < 0) {
+        dev_err(dev, "problem reading x gain");
+        goto err_ret;
+    }
+
+    len = sprintf(buf, "%d\n", val);
+    return len;
+err_ret:
+    return val;
+}
+
+static ssize_t LIS3L02DQ_write_signed(struct device *dev,
+                      struct attribute *attr,
+                      const char *buf,
+                      size_t len)
+{
+    long val;
+    int ret;
+    struct lis3l02dq_attribute *this_attr
+        = container_of(attr,
+                   struct lis3l02dq_attribute,
+                   attr);
+
+    ret = strict_strtol(buf, 10, &val);
+    if (ret)
+        goto err_ret;
+
+    ret = LIS3L02DQ_write_register_int8_t(dev,
+                          this_attr->addr,
+                          val);
+    if (ret)
+        goto err_ret;
+
+    return len;
+
+err_ret:
+    return ret;
+}
+
+static ssize_t LIS3L02DQ_write_unsigned(struct device *dev,
+                    struct attribute *attr,
+                    const char *buf,
+                    size_t len)
+{
+    int ret;
+    ulong val;
+    struct lis3l02dq_attribute *this_attr
+        = container_of(attr,
+                   struct lis3l02dq_attribute,
+                   attr);
+
+    val = strict_strtoul(buf, 10, &val);
+    ret = LIS3L02DQ_write_register_int8_t(dev,
+                          this_attr->addr,
+                          val);
+    if (ret)
+        goto err_ret;
+    return len;
+err_ret:
+    return ret;
+}
+
+static int LIS3L02DQ_initial_setup(struct LIS3L02DQ_state *st)
+{
+    int ret;
+
+    memset(st->tx_buff, 0, sizeof st->tx_buff);
+    memset(st->rx_buff, 0, sizeof st->rx_buff);
+    st->us->mode = SPI_MODE_3;
+    spi_setup(st->us);
+
+    /* Write suitable defaults to ctrl1 */
+    ret = LIS3L02DQ_write_register_int8_t(&st->us->dev,
+                          LIS3L02DQ_REG_CTRL_1_ADDRESS,
+                          LIS3L02DQ_DEFAULT_CTRL1);
+    if (ret) {
+        dev_err(&st->us->dev, "problem with setup control register 1");
+        goto err_ret;
+    }
+    ret = LIS3L02DQ_write_register_int8_t(&st->us->dev,
+                          LIS3L02DQ_REG_CTRL_2_ADDRESS,
+                          LIS3L02DQ_DEFAULT_CTRL2);
+    if (ret) {
+        dev_err(&st->us->dev, "problem with setup control register 2");
+        goto err_ret;
+    }
+err_ret:
+    return ret;
+}
+
+static irqreturn_t interrupthandler(int irq, void *_state)
+{
+    struct LIS3L02DQ_state *st = _state;
+
+    disable_irq_nosync(irq);
+    schedule_work(&st->work);
+    st->inter = 1;
+    return IRQ_HANDLED;
+}
+
+static int LIS3L02DQ_set_mode(struct device *dev, int val)
+{
+    int ret;
+    uint8_t tmp;
+    const uint8_t addr_ctrl2 = LIS3L02DQ_REG_CTRL_2_ADDRESS;
+    struct LIS3L02DQ_state *st = dev_get_drvdata(dev);
+
+    if (st->mode == val
+        || st->mode == LIS3L02DQ_DIRECT_ONLY_MODE)
+        return 0;
+
+    switch (val) {
+    case 0:
+        /* disable interrupt generation */
+        ret = LIS3L02DQ_write_register_int8_t(&st->us->dev,
+                              addr_ctrl2,
+                              LIS3L02DQ_DEFAULT_CTRL2);
+        if (ret)    {
+            dev_err(&st->us->dev,
+                "problem with setup control register 2");
+            goto err_ret;
+        }
+
+        flush_scheduled_work();
+        free_irq(st->us->irq, st);
+        break;
+
+    case 1:
+        /* quick read to ensure that the interrupt line is low */
+        LIS3L02DQ_read_all(st);
+        ret = request_irq(st->us->irq,
+                  interrupthandler,
+                  IRQF_TRIGGER_RISING,
+                  "lis3l02dq",
+                  st);
+        if (ret < 0) {
+            dev_err(&st->us->dev, "Could not obtain irq ");
+            goto err_ret;
+        }
+        /* enable interrupt generation */
+    tmp =  LIS3L02DQ_DEFAULT_CTRL2
+            |  LIS3L02DQ_REG_CTRL_2_ENABLE_DATA_READY_GENERATION;
+        ret = LIS3L02DQ_write_register_int8_t(&st->us->dev,
+                              addr_ctrl2,
+                              tmp);
+        if (ret) {
+            dev_err(&st->us->dev,
+                "problem with setup control register 2");
+            goto err_ret;
+        }
+        break;
+    default:
+        ret = -EINVAL;
+        goto err_ret;
+        break;
+    };
+    st->mode = val;
+
+    return 0;
+err_ret:
+    return ret;
+}
+
+static ssize_t LIS3L02DQ_read_mode(struct device *dev,
+                   struct device_attribute *attr,
+                   char *buf)
+{
+    int len = 0;
+
+    struct LIS3L02DQ_state *st = dev_get_drvdata(dev);
+    len += sprintf(buf + len, "%d\n", st->mode);
+
+    return len;
+}
+
+static ssize_t LIS3L02DQ_write_mode(struct device *dev,
+                    struct device_attribute *attr,
+                    const char *buf,
+                    size_t len)
+{
+    int ret;
+    long val;
+
+    ret = strict_strtol(buf, 10, &val);
+    if (ret < 0)
+        goto err_ret;
+    ret = LIS3L02DQ_set_mode(dev, val);
+    if (ret < 0)
+        goto err_ret;
+    return len;
+err_ret:
+    return ret;
+
+
+}
+
+static DEVICE_ATTR(mode, S_IWUSR | S_IRUGO, LIS3L02DQ_read_mode,
+           LIS3L02DQ_write_mode);
+
+static DEVICE_ATTR(scan, S_IRUGO,           LIS3L02DQ_scan,          NULL);
+
+static LIS3L02DQ_ATTR(x_offset,   S_IWUSR | S_IRUGO, LIS3L02DQ_read_signed,
+              LIS3L02DQ_write_signed, LIS3L02DQ_REG_OFFSET_X_ADDRESS);
+
+static LIS3L02DQ_ATTR(y_offset,   S_IWUSR | S_IRUGO, LIS3L02DQ_read_signed,
+              LIS3L02DQ_write_signed, LIS3L02DQ_REG_OFFSET_Y_ADDRESS);
+
+static LIS3L02DQ_ATTR(z_offset,   S_IWUSR | S_IRUGO, LIS3L02DQ_read_signed,
+              LIS3L02DQ_write_signed, LIS3L02DQ_REG_OFFSET_Z_ADDRESS);
+
+static LIS3L02DQ_ATTR(x_gain,     S_IWUSR | S_IRUGO,
LIS3L02DQ_read_unsigned,
+              LIS3L02DQ_write_unsigned, LIS3L02DQ_REG_GAIN_X_ADDRESS);
+
+static LIS3L02DQ_ATTR(y_gain,     S_IWUSR | S_IRUGO,
LIS3L02DQ_read_unsigned,
+              LIS3L02DQ_write_unsigned, LIS3L02DQ_REG_GAIN_Y_ADDRESS);
+
+static LIS3L02DQ_ATTR(z_gain,     S_IWUSR | S_IRUGO,
LIS3L02DQ_read_unsigned,
+              LIS3L02DQ_write_unsigned, LIS3L02DQ_REG_GAIN_Z_ADDRESS);
+
+static DEVICE_ATTR(rip_buffer, S_IRUGO, LIS3L02DQ_rip_buffer, NULL);
+
+static void LIS3L02DQ_store_to_ring(struct LIS3L02DQ_state *st)
+{
+    int i;
+    bool initread = true;
+
+    /* First use of ring */
+    if (unlikely(st->write_pointer == 0)) {
+        st->write_pointer = st->ring_buffer;
+        initread = false;
+    }
+    /*probably unnecessary */
+    barrier();
+    /*save data */
+    for (i = 0; i < 3; i++) {
+        st->write_pointer[i*2] = st->rx_buff[i*4];
+        st->write_pointer[i*2+1] = st->rx_buff[i*4+2];
+    }
+    barrier();
+    st->last_written_pointer = st->write_pointer;
+    barrier();
+    st->write_pointer += 6;
+    if (unlikely(st->write_pointer
+             == st->ring_buffer + 6*LIS3L02DQ_BUFFER_LENGTH))
+        st->write_pointer = st->ring_buffer;
+
+    if (unlikely(st->read_pointer == 0))
+        st->read_pointer = st->ring_buffer;
+    else if (st->write_pointer == st->read_pointer)    {
+        if (unlikely((st->read_pointer+6
+                  == st->ring_buffer + 6*LIS3L02DQ_BUFFER_LENGTH)))
+            st->read_pointer = st->ring_buffer;
+        else
+            st->read_pointer += 6;
+    }
+    return;
+}
+
+static void LIS3L02DQ_data_ready_work(struct work_struct *work_s)
+{
+    struct LIS3L02DQ_state *st
+        = container_of(work_s, struct LIS3L02DQ_state, work);
+
+    st->inter = 0;
+    if (LIS3L02DQ_read_all(st) >= 0)
+        LIS3L02DQ_store_to_ring(st);
+
+try_again:
+    while (gpio_get_value(irq_to_gpio(st->us->irq)))
+        if (LIS3L02DQ_read_all(st) >= 0)
+            LIS3L02DQ_store_to_ring(st);
+    /* If we are lucky gpio should not be set now
+     * Try reenabling interrupt. */
+    enable_irq(st->us->irq);
+    /* verify that either the gpio has not risen or that
+     * the interrupt handler caught it */
+    if (gpio_get_value(irq_to_gpio(st->us->irq)))
+        if (st->inter == 0) {
+            disable_irq_nosync(st->us->irq);
+            goto try_again;
+        }
+    return;
+}
+
+static struct attribute *lis3l02dq_attributes[] = {
+    &lis3l02dq_attr_x_offset.attr,
+    &lis3l02dq_attr_y_offset.attr,
+    &lis3l02dq_attr_z_offset.attr,
+    &lis3l02dq_attr_x_gain.attr,
+    &lis3l02dq_attr_y_gain.attr,
+    &lis3l02dq_attr_z_gain.attr,
+    &dev_attr_scan.attr,
+    &dev_attr_rip_buffer.attr,
+    &dev_attr_mode.attr,
+    NULL
+};
+
+static const struct attribute_group lis3l02dq_attribute_group = {
+    .attrs = lis3l02dq_attributes,
+};
+
+static int __devinit LIS3L02DQ_probe(struct spi_device *spi)
+{
+    struct LIS3L02DQ_state *st;
+    int ret;
+
+
+    st = kzalloc(sizeof(struct LIS3L02DQ_state), GFP_KERNEL);
+    st->tx_buff = kmalloc(12, GFP_KERNEL);
+    st->rx_buff = kmalloc(12, GFP_KERNEL);
+    st->us = spi;
+
+    ret = sysfs_create_group(&spi->dev.kobj,  &lis3l02dq_attribute_group);
+    if (ret) {
+        dev_err(&spi->dev, "Failed to register sysfs hooks\n");
+        return -EINVAL;
+    }
+    spi_set_drvdata(spi, st);
+    /* establish whether interrupt mode possible */
+    if (spi->irq) {
+        if (gpio_is_valid(irq_to_gpio(spi->irq)) > 0) {
+            INIT_WORK(&st->work, LIS3L02DQ_data_ready_work);
+            st->inter = 0;
+        } else
+            st->mode = LIS3L02DQ_DIRECT_ONLY_MODE;
+    } else
+        st->mode = LIS3L02DQ_DIRECT_ONLY_MODE;
+
+    /* This setup enables data ready generation (amongst other things)*/
+    ret = LIS3L02DQ_initial_setup(st);
+
+    return ret;
+}
+
+static int LIS3L02DQ_remove(struct spi_device *spi)
+{
+    int ret;
+    struct LIS3L02DQ_state *st = spi_get_drvdata(spi);
+    kfree(st->tx_buff);
+    kfree(st->rx_buff);
+    /* stop the device */
+    ret = LIS3L02DQ_write_register_int8_t(&st->us->dev,
+                          LIS3L02DQ_REG_CTRL_1_ADDRESS,
+                          0);
+    if (ret) {
+        dev_err(&st->us->dev, "problem with turning device off: ctrl1");
+        goto err_ret;
+    }
+    ret = LIS3L02DQ_write_register_int8_t(&st->us->dev,
+                          LIS3L02DQ_REG_CTRL_2_ADDRESS,
+                          0);
+    if (ret) {
+        dev_err(&st->us->dev, "problem with turning device off: ctrl2");
+        goto err_ret;
+    }
+    sysfs_remove_group(&spi->dev.kobj, &lis3l02dq_attribute_group);
+
+    if (st->mode == LIS3L02DQ_INTERRUPT_MODE) {
+        flush_scheduled_work();
+        free_irq(st->us->irq, st);
+    }
+
+    kfree(st);
+    return 0;
+
+err_ret:
+    return ret;
+}
+
+static struct spi_driver LIS3L02DQ_driver = {
+    .driver = {
+        .name = "lis3l02dq",
+        .owner = THIS_MODULE,
+    },
+    .probe = LIS3L02DQ_probe,
+    .remove = __devexit_p(LIS3L02DQ_remove),
+};
+
+static __init int LIS3L02DQ_init(void)
+{
+    return spi_register_driver(&LIS3L02DQ_driver);
+}
+
+static __exit void LIS3L02DQ_exit(void)
+{
+    spi_unregister_driver(&LIS3L02DQ_driver);
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
