From: Ben Nizette <bn-pV1zxKMKwgg3AZtZ2NlBNQ@public.gmane.org>
Subject: Re: [lm-sensors] Accelerometer etc subsystem
	(Update on progress)
Date: Sat, 28 Jun 2008 18:34:17 +1000
Message-ID: <1214642057.4265.7.camel@moss.renham>
References: <4832A211.4040206@gmail.com>
	<20080520132817.03fb74ea@hyperion.delvare> <4863D97A.9090102@gmail.com>
	<1214537367.8462.157.camel@moss.renham>  <4864B6D6.3020509@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: mgross-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, Dmitry Torokhov <dtor-JGs/UdohzUI@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LM Sensors <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>,
	Jonathan Cameron <Jonathan.Cameron-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <4864B6D6.3020509-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
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


On Fri, 2008-06-27 at 10:45 +0100, Jonathan Cameron wrote:
> Ben Nizette wrote:
> > On Thu, 2008-06-26 at 19:01 +0100, Jonathan Cameron wrote:
> > 
> >> Sysfs -    Parameter Control - gain / offsets etc
> >>     State control, turn interrupts on and off etc.
> > 
> > As in turn userspace [interrupt] event notification on and off?  I would
> > have thought it'd be the kernel driver's responsibility to turn the
> > device's interrupt generation on and off according to needs for
> > data/events etc.
> Ok, there is a division here between interrupt handling on the host side
> which indeed should be turned on and off transparently by the driver 
> and actually telling the sensor which interrupts to generate.  In a sense
> this is simply a case of terminology and what is actually being requested
> is event notifications (which then match with those sent up to userspace).

Righteo, I suspected as much :-)

< snip good replies :-) >

> 
> > also:
> > 
> > +/* As the ring buffer contents are device dependent this functionality
> > + * must remain part of the driver and not the ring buffer subsystem */
> > +static ssize_t
> > +lis3l02dq_read_accel_from_ring(struct industrialio_ring_buffer *ring,
> > +			       int element, char *buf)
> > +{
> > +	int val, ret, len;
> > +	uint16_t temp;
> > +	char *data, *datalock;
> > +
> > +	data = kmalloc(8, GFP_KERNEL);
> > +	if (data == NULL) {
> > +		ret = -ENOMEM;
> > +		goto error_ret;
> > +	}
> > +	ret = industrialio_read_last_from_ring(ring, data);
> > +	datalock = data + 2*element;
> > 
> > I haven't looked deeply at the ringbuffer code but can you guarantee
> > that later elements are at higher addresses than the lower ones?  As in,
> > can one datum in the the ring buffer wrap to the beginning again?
> At the moment the ring buffer has to be a whole number of datums big.
> I'm inclined to keep it way and move more towards dynamic allocation
> such that it is true than to try handling split data reading sets.

Yup, agreed.  Just so long as your code thinks about :-)

>  
> > +	kfree(data);
> > 
> > You free the data before you use it?  Though you are using it through a
> > different pointer below.  I wouldn't be scared of allocating 8 bytes on
> > the stack rather than kmalloc'ing (unless you expect this to be called
> > in a deep callchain)
> Ouch.  That's an out and out bug!
> > 
> > +	temp = (((uint16_t)((datalock[1]))) << 8)
> > +		| (uint16_t)(datalock[0]);
> > +	val = *((int16_t *)(&temp));
> > 
> > All this data/datalock/bitshuffle nonsense would be nicer if you just
> > used structs and unions, yeah?
> > 
> > union channel {
> > 	char data[2];
> > 	int16_t val;
> > }
> Good point, I'd forgotten you could do that with unions.

Cool, just watch endianness of course :-)

> > 
> > struct datum {
> > 	union channel elements[3];
> > }
> > 
> > or something.
> > 
> > +	len = sprintf(buf, "ring %d\n", val);
> > +
> > +	return len;
> > +error_ret:
> > +	return ret;
> > +}
> Good approach, I'll switch to that.
> 
> > 
> > Incidentally, is there much that your ringbuffer can do which kfifo
> > can't?  Apart from having a bunch of extra nice accessor-helpers sitting
> > on the top.
> Not sure, I'll look into it.

kfifo won't be a drop in replacement, it's just a very simple ring fifo.
I suspect your higher level ring buffer accessors and allocators could
live on top of it though.

> > 
> > Overall looking good and useful, can't wait 'till it's done :-)
> Thanks for the comments.
> 
> Jonathan

np,
	--Ben.


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
