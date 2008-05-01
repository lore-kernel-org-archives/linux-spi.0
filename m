From: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Subject: Re: [PATCH 1/1] Initial support for ST
 Microelectronics lis3l02dq accelerometer via SPI
Date: Thu, 01 May 2008 18:25:59 +0100
Message-ID: <4819FD27.7070600@cam.ac.uk>
References: <481210CC.9080702@cam.ac.uk> <481226C4.9010806@cam.ac.uk>
	<4815D9A6.4040306@cam.ac.uk>
	<200804301804.24924.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200804301804.24924.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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


> Accelerometer ... should this be a hwmon driver, or at least
> build on some hwmon conventions? 
I did wonder that myself. Guess your suggestion of posting to lkml
should get me a few opinions.
> That LIS3L02DQ seems to be marked as obsolete on the ST site;
> how close is this to the still-supported LIS3LV02DQ?
>   
Based on the data sheet, I think this driver should work with a subset 
of the functionality
of that chip, but without one to actually test against I'd rather not 
commit to it doing so.

The reason I'm interested in the older chip is that it's what crossbow 
(xbow.com) have
used on their imote2 sensor board, which means there are quite a few out 
there
+ importantly a reasonable number of linux users.

I'm actually interested in writing quite a few similar drivers for other 
inertial sensors,
but as I had to start somewhere I went with this one.
> (I may be assuming some stuff that works best on 2.6.26-rc1;
> be aware of that if you start doing these updates.)
>   
Indeed, I ran into gpio_is_valid not being defined for the pxa arch. The 
relevant
is in the main tree by 2.6.25-git17 (I haven't tracked down exactly when 
it was fixed).
> Notice that both of those tests turn into compile-time constants
> if GENERIC_GPIO isn't available.  That means you can rely on that
> to eliminate big chunks of your code without all the #ifdeffery
> you now have.
>
> General policy:  don't have #ifdefs in the body of code.
>   
The new patch does exactly that.
>> +struct LIS3L02DQ_platform_data
>> +{
>> +  unsigned data_ready_gpio;
>> +};
>>     
>
> At a quick glance, this is the only thing in this file that
> seems like it *should* go into a <linux/spi/...> header.
>
> Everthing else is driver-internal stuff.
>
>   
I've removed the necessity for any platform data (via you spi->irq 
suggestion)
However, I do require that the irq is a gpio. This is because the chip 
raises and holds
high the data ready line until a read has occurred. Thus it is possible 
for the interrupt
bottom half to be delayed past the next data_ready signal. This doesn't 
happen often,
but it will freeze the driver it does. Hence, the need to verify that 
the line is either
low immediately after re enabling interrupts or that the interrupt 
handler caught it.

Thus I'm using irq_to_gpio to get the gpio number to check.
>> +
>> +#define LIS3L02DQ_BUFFER_LENGTH 100
>> +
>> +
>> +struct LIS3L02DQ_state {
>> +	struct spi_device*     us;
>> +	unsigned char          tx_buff[2*6];
>> +	unsigned char          rx_buff[2*6];
>>     
>
> I know I've been guilty of that idiom in the past, but
> it's best to avoid it.  Instead of allocating DMA
> buffers like that, just kmalloc() them separately.
>
> (If you were using a pure PIO driver it wouldn't matter.
> But with DMA, on systems without cache-coherent main
> memory -- e.g. on most non-x86 systems! -- this can make
> for data corruption problems.)
>   
I'm afraid I don't fully understand this (not having much familiarity 
with dma),
is this fixed by the patch? (which will follow - basically allocates 
tx_buff and rx_buff
dynamically)
>   
>> +static ssize_t LIS3L02DQ_read_z_gain(struct device *dev, 
>> +				     struct device_attribute *attr, 
>> +				     char *buf)
>>     
>
> You can save some code here by wrapping your attributes in a
> struct that holds the relevant "read register" commands.  The
> output code is the same ... the only difference is that command.
>
> So my_attribute = container_of(attr, ...) and read that command
> from that field.  You will eliminate at least two copies of each
> read routine.  (One works for signed values, one unsigned.)
>
> The same should be true on the write side too.
>
> The minor cost:  you can't use the DEVICE_ATTR macros to declare
> things; you'd use __ATTR() and friends directly.  No prob ... and
> a lot less needless code duplication!
>   
I've had a go at this, but didn't end up with terribly elegant code.
Any suggestions how how to clean it up would be welcome.

I have implemented all your other suggestions.

Patch to follow shortly

Thanks again for your help,

--

Jonathan Cameron


-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
