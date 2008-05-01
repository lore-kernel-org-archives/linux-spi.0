From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 1/1] Initial support for ST
	Microelectronics lis3l02dq accelerometer via SPI
Date: Wed, 30 Apr 2008 18:04:24 -0700
Message-ID: <200804301804.24924.david-b@pacbell.net>
References: <481210CC.9080702@cam.ac.uk> <481226C4.9010806@cam.ac.uk>
	<4815D9A6.4040306@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <4815D9A6.4040306-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Content-Disposition: inline
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

On Monday 28 April 2008, Jonathan Cameron wrote:
> --- a/drivers/spi/Kconfig	2008-04-17 03:49:44.000000000 +0100
> +++ b/drivers/spi/Kconfig	2008-04-24 19:16:32.000000000 +0100
> @@ -239,6 +239,20 @@ config SPI_TLE62X0
>  	  sysfs interface, with each line presented as a kind of GPIO
>  	  exposing both switch control and diagnostic feedback.
>  
> +config SPI_LIS3L02DQ
> +       tristate "STMicroelectronics LIS3L02DQ Accelerometer" 

Accelerometer ... should this be a hwmon driver, or at least
build on some hwmon conventions?  I don't recall ever seeing
an accelerometer driver before.  After this is cleaned up a
bit more, I suggest you post this to LKML in case some folk
who have thought about how to talk to accelerometers have a
few insights to share with you.  (Shorten $SUBJECT to get
past our short attention spans too.  :)


Remove all whitespace at line-end from the stuff you add in your
patches ... that "tristate" line has that problem, as do numerous
others.  You should run "scripts/checkpatch.pl" on this patch,
and fix the ~280 little style problems (!) it tells you about.
That'll save some noise ... in fact, I'm going to avoid telling
you about things checkpatch.pl will tell you, this time around.

That LIS3L02DQ seems to be marked as obsolete on the ST site;
how close is this to the still-supported LIS3LV02DQ?


> +       depends on SPI_MASTER && SYSFS 
> +       help
> +         SPI driver for the STMicroelectrincs LIS3L02DQ 3-Axis 2g digital 
> +	 output linear accelerometer.  This provides a sysfs interface.

Documentation summarizing that interface would probably be
a Good Thing.  Here, you might summarize what functionality
it exposes to userspace.


> +
> +config SPI_LIS3L02DQ_GPIO_INTERRUPT
> +       bool "Use data ready interrupt in conjunction with a ring buffer"
> +       depends on SPI_LIS3L02DQ && GENERIC_GPIO

Looks to me like you can just #include <linux/gpio.h> and
all the other stuff you might need, an remove that config
variable ... then have your code test whether

	* gpio_is_valid(data_ready_gpio) to see if you should
	  try to use the IRQ ... you should be able to enable
	  driver support, but have it be disabled on the fly
	  if the target board doesn't provide a GPIO

	* gpio_to_irq(data_ready_gpio) is non-negative ... if not,
	  don't register the IRQ handler or expect to enable
	  that support

(I may be assuming some stuff that works best on 2.6.26-rc1;
be aware of that if you start doing these updates.)

Notice that both of those tests turn into compile-time constants
if GENERIC_GPIO isn't available.  That means you can rely on that
to eliminate big chunks of your code without all the #ifdeffery
you now have.

General policy:  don't have #ifdefs in the body of code.


> +       help
> +	 Select this option if you want to capture the maximum possible 
> +	 amount of data from you accelerometer.

Looks like your have some non-TAB indents mixed in there ...


> +       
>  #
>  # Add new SPI protocol masters in alphabetical order above this line
>  #
> --- a/drivers/spi/Makefile	2008-04-17 03:49:44.000000000 +0100
> +++ b/drivers/spi/Makefile	2008-04-25 19:13:51.000000000 +0100
> @@ -34,6 +34,7 @@ obj-$(CONFIG_SPI_SH_SCI)		+= spi_sh_sci.
>  obj-$(CONFIG_SPI_AT25)		+= at25.o
>  obj-$(CONFIG_SPI_SPIDEV)	+= spidev.o
>  obj-$(CONFIG_SPI_TLE62X0)	+= tle62x0.o
> +obj-$(CONFIG_SPI_LIS3L02DQ)     += LIS3L02DQ.o

Repeating:  don't use uppercase in source file names.  Or
in the driver name, either!  And keep the Kconfig and Makefile
symbols in alphabetical order too, please...


>  # 	... add above this line ...
>  
>  # SPI slave controller drivers (upstream link)
> --- a/include/linux/spi/LIS3L02DQ.h	1970-01-01 01:00:00.000000000 +0100
> +++ b/include/linux/spi/LIS3L02DQ.h	2008-04-26 12:21:25.000000000 +0100
> @@ -0,0 +1,168 @@
> 	...

Almost all the definitions in that header belong elsewhere,
like register symbols in a drivers/spi/lis3l02dq.h header.
The reason to have something in a <linux/...> header is to
share it with code outside the driver.


> +/* SPI MODE */
> +#define LIS3L02DQ_SPI_MODE SPI_MODE_3

That hardly needs to be abstracted like that, does it?


> +struct LIS3L02DQ_platform_data
> +{
> +  unsigned data_ready_gpio;
> +};

At a quick glance, this is the only thing in this file that
seems like it *should* go into a <linux/spi/...> header.

Everthing else is driver-internal stuff.


> +
> +#define LIS3L02DQ_BUFFER_LENGTH 100
> +
> +
> +struct LIS3L02DQ_state {
> +	struct spi_device*     us;
> +	unsigned char          tx_buff[2*6];
> +	unsigned char          rx_buff[2*6];

I know I've been guilty of that idiom in the past, but
it's best to avoid it.  Instead of allocating DMA
buffers like that, just kmalloc() them separately.

(If you were using a pure PIO driver it wouldn't matter.
But with DMA, on systems without cache-coherent main
memory -- e.g. on most non-x86 systems! -- this can make
for data corruption problems.)


> +	
> +#ifdef CONFIG_SPI_LIS3L02DQ_GPIO_INTERRUPT
> +	struct work_struct     work;
> +	bool                   inter;
> +	uint8_t                ring_buffer[LIS3L02DQ_BUFFER_LENGTH*6];
> +	uint8_t*               read_pointer;
> +	uint8_t*               write_pointer;
> +	uint8_t*               last_written_pointer;
> +#endif /* CONFIG_SPI_LIS3L02DQ_GPIO_INTERRUPT */
> +};

That's very much driver-internal.  :)

> +
> +
> +#ifdef CONFIG_SPI_LIS3L02DQ_GPIO_INTERRUPT
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/gpio.h>
> +#include <linux/workqueue.h>
> +#endif /* CONFIG_SPI_LIS3L02DQ_GPIO_INTERRUPT */

Avoid #ifdeffing #includes; they can mask compilation problems
that show up only on particular platforms.  Likewise, avoid
code that's #ifdeffed ... if you make it so the compiler's dead
code removal does its job, you will make sure that most of the
driver gets compiled every time, and reduce opportunities for
configuration specific compilation problems to appear.


> +
> +
> +#endif /* _LIS3L02DQ_H_ */ 
> --- a/drivers/spi/LIS3L02DQ.c	1970-01-01 01:00:00.000000000 +0100
> +++ b/drivers/spi/LIS3L02DQ.c	2008-04-28 14:52:31.000000000 +0100
> @@ -0,0 +1,774 @@
> +/* 
> + * LISL02DQ.c -- support STMicroelectronics LISD02DQ 
> + *               3d 2g Linear Accelerometers via SPI
> + *
> + * Copyright (c) 2007 Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
> + *
> + * Loosely based upon tle62x0.c 
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This driver has two modes, one is interrupt based, the other on demand */

I strongly prefer to see the terminal "*/" on a line by itself.
Otherwise I need a double (or triple) take before I can find it
on the end of some previous line.  ;)

Some more explanation of the "two modes" would be useful...


> +
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#include <linux/spi/spi.h>
> +#include <linux/spi/LIS3L02DQ.h>
> +
> +static const char read_all_tx_array[] =
> +{
> +	0, LIS3L02DQ_READ_REG(LIS3L02DQ_REG_OUT_X_L_ADDRESS),
> +	0, LIS3L02DQ_READ_REG(LIS3L02DQ_REG_OUT_X_H_ADDRESS),
> +	0, LIS3L02DQ_READ_REG(LIS3L02DQ_REG_OUT_Y_L_ADDRESS),
> +	0, LIS3L02DQ_READ_REG(LIS3L02DQ_REG_OUT_Y_H_ADDRESS),
> +	0, LIS3L02DQ_READ_REG(LIS3L02DQ_REG_OUT_Z_L_ADDRESS),
> +	0, LIS3L02DQ_READ_REG(LIS3L02DQ_REG_OUT_Z_H_ADDRESS),	
> +};
> +
> +static int LIS3L02DQ_read_all(struct LIS3L02DQ_state* st)
> +{
> +	/* Sadly the device appears to require deselection between 
> +	 * reading the different registers - hence the somewhat
> +	 * convoluted nature of this transfer */

But you don't set the .cs_change flag, so it's staying
selected ... what looks odd to me is that you *could* do
this all in one shot, with spi_dev.bits_per_word == 16,
while instead you're using a much higher overhead scheme
with multiple transfers...


> +	struct spi_transfer xfers[] = {
> +		/* x low byte */
> +		{
> +			.tx_buf = read_all_tx_array,
> +			.rx_buf = st->rx_buff,
> +			.bits_per_word = 16,
> +			.len = 2,
> +		},
> +		/* x high byte */
> +		{
> +			.tx_buf = read_all_tx_array+2,
> +			.rx_buf = st->rx_buff+2,
> +			.bits_per_word = 16,
> +			.len = 2,
> +		},
> +		/* y low byte */
> +		{
> +			.tx_buf = read_all_tx_array+4,
> +			.rx_buf = st->rx_buff+4,
> +			.bits_per_word = 16,
> +			.len = 2,
> +		},
> +		/* y high byte */
> +		{
> +			.tx_buf = read_all_tx_array+6,
> +			.rx_buf = st->rx_buff+6,
> +			.bits_per_word = 16,
> +			.len = 2,
> +		},
> +		/* z low byte */
> +		{
> +			.tx_buf = read_all_tx_array+8,
> +			.rx_buf = st->rx_buff+8,
> +			.bits_per_word = 16,
> +			.len = 2,
> +		},
> +		/* z high byte */
> +		{
> +			.tx_buf = read_all_tx_array+10,
> +			.rx_buf = st->rx_buff+10,
> +			.bits_per_word = 16,
> +			.len = 2,
> +		},
> +	};
> +	struct spi_message msg;
> +	int ret;
> +	memset(st->rx_buff, 0, sizeof st->rx_buff);

Have a blank line between local variables and code...

> +	/* After these are trasmitted, the rx_buff should have 
> +	 * values in alternate bytes */
> +	spi_message_init(&msg);
> +	
> +	spi_message_add_tail(&xfers[0], &msg);
> +	spi_message_add_tail(&xfers[2], &msg);
> +	spi_message_add_tail(&xfers[4], &msg);
> +	spi_message_add_tail(&xfers[1], &msg);
> +	spi_message_add_tail(&xfers[3], &msg);
> +	spi_message_add_tail(&xfers[5], &msg);
> +	ret = spi_sync(st->us, &msg);
> +	if(ret)	{
> +		dev_err(&st->us->dev, "problem with get all accels");
> +		goto err_ret;
> +	}
> +err_ret:
> +	return ret;
> +}
> +
> +#ifdef CONFIG_SPI_LIS3L02DQ_GPIO_INTERRUPT
> +/* A fairly inellegant way of ripping the contents of the 
> + * ring buffer and ensuring only a valid set of readings are output */
> +static ssize_t LIS3L02DQ_rip_buffer(struct device* dev, 
> +				    struct device_attribute *attr, 
> +				    char *buf)

I'd have to read the chip spec to see what this is doing.

Failing that, some description of how the data shows up
in sysfs would be a good thing.  :)



> +/* If in interrupt triggered mode this sysfs function will output the latest 
> + * finished element from the ringbuffer.
> + *
> + * If in direct access mode it will simply read the output registers of the 
> + * device. 
> + * Be aware that the device may be in blocking mode so results are a little 
> + * unpredictable */

Then you should probably have a sysfs attribute exposing which
mode the device is in ... and probably letting the userspace
code change to the mode it wants.


> +static int8_t LIS3L02DQ_read_register_int8_t(struct device *dev, 
> +					     uint8_t reg_address)
> +{
> +	int8_t val, ret;
> +	struct spi_message msg;
> +	struct LIS3L02DQ_state *st = dev_get_drvdata(dev);
> +	struct spi_transfer xfer = {
> +		.tx_buf = st->tx_buff,
> +		.rx_buf = st->rx_buff,
> +		.bits_per_word = 16,
> +		.len = 2,
> +	};
> +	st->tx_buff[1] = LIS3L02DQ_READ_REG(reg_address);
> +	spi_message_init(&msg);
> +	spi_message_add_tail(&xfer, &msg);
> +	ret = spi_sync(st->us, &msg);
> +	if( ret ) {
> +		dev_err(&st->us->dev, "problem with get x offset");
> +		goto err_ret;
> +	}
> +	val = st->rx_buff[0];
> +	return val;
> +	/* Unfortunately the result can be negative so passing error 
> +	 * back not a good idea */

If the result is signed, then you should have some alternate calling
convention...


> +err_ret:
> +	return 0;  
> +}
> +
> +/*Returns into to allow full 0/255 range with error codes in negative range */
> +static int LIS3L02DQ_read_register_uint8_t(struct device *dev, 
> +					       uint8_t reg_address)

> +static int LIS3L02DQ_write_register_int8_t(struct device* dev, 
> +					   uint8_t reg_address, 
> +					   int8_t value)

... I think you only need one function to write an 8 bit value,
not separate ones for signed and unsigned values.  Just pass
the value as "int", and the 8 bits get stuffed into a buffer ...



> +static int LIS3L02DQ_write_register_uint8_t(struct device* dev, 
> +					    uint8_t reg_address, 
> +					    uint8_t value)



> +static ssize_t LIS3L02DQ_read_x_gain(struct device *dev, 
> +				     struct device_attribute *attr, 
> +				     char *buf)


> +static ssize_t LIS3L02DQ_read_y_gain(struct device *dev, 
> +				     struct device_attribute *attr, 
> +				     char *buf)


> +static ssize_t LIS3L02DQ_read_z_gain(struct device *dev, 
> +				     struct device_attribute *attr, 
> +				     char *buf)

You can save some code here by wrapping your attributes in a
struct that holds the relevant "read register" commands.  The
output code is the same ... the only difference is that command.

So my_attribute = container_of(attr, ...) and read that command
from that field.  You will eliminate at least two copies of each
read routine.  (One works for signed values, one unsigned.)

The same should be true on the write side too.

The minor cost:  you can't use the DEVICE_ATTR macros to declare
things; you'd use __ATTR() and friends directly.  No prob ... and
a lot less needless code duplication!



> +static struct device_attribute *LIS3L02DQ_attrs[] = {
> +	&dev_attr_scan,
> +	&dev_attr_x_offset,
> +	&dev_attr_y_offset,
> +	&dev_attr_z_offset,
> +	&dev_attr_x_gain,
> +	&dev_attr_y_gain,
> +	&dev_attr_z_gain,
> +#ifdef CONFIG_SPI_LIS3L02DQ_GPIO_INTERRUPT
> +	&dev_attr_rip_buffer,
> +#endif 
> +};

Then what you should do is use an attribute_group here,
which lets you register (then later, unregister) all the
attributes in one call ... with no funky partial cleanup
error recovery needed.


> +static int __devinit LIS3L02DQ_probe(struct spi_device *spi)
> +{
> +	struct LIS3L02DQ_state* st;
> +	struct LIS3L02DQ_platform_data* pdata;
> +	int ret,i ;
> +	
> +	pdata = spi->dev.platform_data;
> +	st = kzalloc(sizeof(struct LIS3L02DQ_state), GFP_KERNEL);
> +	st->us = spi;
> +	
> +	if(pdata == NULL) {
> +		dev_err(&spi->dev, "no device data specified\n");
> +		return -EINVAL;
> +	}
> +	for(i = 0; i < ARRAY_SIZE(LIS3L02DQ_attrs); i++) {
> +		ret = device_create_file(&spi->dev, LIS3L02DQ_attrs[i]);
> +		if (ret) {
> +			dev_err(&spi->dev, "cannot create attribute\n");
> +			goto err_status;
> +		}
> +	}

That could become just a simple sysfs_create_group() call..
.
> +	
> +	spi_set_drvdata(spi, st);
> +	
> +
> +#ifdef CONFIG_SPI_LIS3L02DQ_GPIO_INTERRUPT
> +	INIT_WORK(&st->work, LIS3L02DQ_data_ready_work);
> +	st->inter = 0;
> +	/* enable an interrupt on the data ready line */
> +	ret = request_irq(gpio_to_irq(pdata->data_ready_gpio),
> +			  interrupthandler, 
> +			  IRQF_DISABLED, 
> +			  "LIS3L02DQ data ready", 
> +			  st);
> +	
> +	set_irq_type(gpio_to_irq(pdata->data_ready_gpio), IRQT_RISING);

Instead of calling set_irq_type, pass the right IRQF_* flag
into request_irq().  And as a general policy, please avoid
using IRQ labels with spaces in them.  Plain "lis3l02dq" is
just fine here (i.e. driver->name).


> +#endif /* CONFIG_SPI_LIS3L02DQ_GPIO_INTERRUPT */	
> +	/* This setup enables data ready generation (amongst other things)*/
> +	ret = LIS3L02DQ_initial_setup(st);
> +	
> +	return ret;	
> +	
> +err_status:
> +	
> +	for(i = 0; i < ARRAY_SIZE(LIS3L02DQ_attrs); i++)
> +		device_remove_file(&spi->dev, LIS3L02DQ_attrs[i]);
> +	return ret;
> +}
> +
> +static int LIS3L02DQ_remove(struct spi_device *spi)
> +{
> +	int i,ret;
> +	struct LIS3L02DQ_state* st = spi_get_drvdata(spi);
> +	struct LIS3L02DQ_platform_data* pdata = spi->dev.platform_data;
> +	/* stop the device */

Conventionally, there should be a blank line after all local
variable declarations and before any code (including comments).

I've omitted that comment in a *LOT* of places it should apply...


> +	ret = LIS3L02DQ_write_register_int8_t(&st->us->dev, 
> +					      LIS3L02DQ_REG_CTRL_1_ADDRESS, 
> +					      0);
> +	if ( ret ) {
> +		dev_err(&st->us->dev, "problem with turning device off: ctrl1");
> +		goto err_ret;
> +	}
> +	ret = LIS3L02DQ_write_register_int8_t(&st->us->dev,
> +					      LIS3L02DQ_REG_CTRL_2_ADDRESS,
> +					      0);
> +	if ( ret ) {
> +		dev_err(&st->us->dev, "problem with turning device off: ctrl2");
> +		goto err_ret;
> +	}
> +	for(i = 0; i < ARRAY_SIZE(LIS3L02DQ_attrs); i++)
> +		device_remove_file(&spi->dev, LIS3L02DQ_attrs[i]);
> +#ifdef CONFIG_SPI_LIS3L02DQ_GPIO_INTERRUPT
> +	flush_scheduled_work();
> +	free_irq(gpio_to_irq(pdata->data_ready_gpio),st);
> +#endif /* CONFIG_SPI_LIS3L02DQ_GPIO_INTERRUPT */
> +	kfree(st);
> +	return 0;
> +
> +err_ret:
> +	return ret;
> +
> +}
> +
> +static struct spi_driver LIS3L02DQ_driver = {
> +	.driver = {
> +		.name = "LIS3L02DQ",

Lowercase ...

> +		.owner = THIS_MODULE,
> +	},
> +	.probe = LIS3L02DQ_probe,
> +	.remove = __devexit_p(LIS3L02DQ_remove),
> +};
> +
> +static __init int LIS3L02DQ_init(void)
> +{
> +	return spi_register_driver(&LIS3L02DQ_driver);
> +}
> +
> +static __exit void LIS3L02DQ_exit(void)
> +{
> +	spi_unregister_driver(&LIS3L02DQ_driver);
> +	return;

Strike that needless return.


> +}
> +
> +module_init(LIS3L02DQ_init);
> +module_exit(LIS3L02DQ_exit);
> +
> +MODULE_AUTHOR("Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>");
> +MODULE_DESCRIPTION("ST LIS3L02DQ Accelerometer SPI driver");
> +MODULE_LICENSE("GPL v2");
> 

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
