From: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Subject: Re: [lm-sensors] Accelerometer etc subsystem
	(Update on progress)
Date: Sat, 28 Jun 2008 16:34:33 +0100
Message-ID: <48665A09.9090705@cam.ac.uk>
References: <4832A211.4040206@gmail.com>	
	<20080520132817.03fb74ea@hyperion.delvare>
	<4863D97A.9090102@gmail.com>	
	<1214537367.8462.157.camel@moss.renham>
	<4864B6D6.3020509@cam.ac.uk> <1214642057.4265.7.camel@moss.renham>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: mgross-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, Dmitry Torokhov <dtor-JGs/UdohzUI@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LM Sensors <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>,
	Jonathan Cameron <Jonathan.Cameron-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Ben Nizette <bn-pV1zxKMKwgg3AZtZ2NlBNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1214642057.4265.7.camel-L9Ekdhw1/RnCa3F4uneLBw@public.gmane.org>
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

Hi Ben,
>>> union channel {
>>> 	char data[2];
>>> 	int16_t val;
>>> }
>> Good point, I'd forgotten you could do that with unions.
> 
> Cool, just watch endianness of course :-)
> 
That and the annoyance of alignment issues making that approach taking way more
space that you'd think.
>>> Incidentally, is there much that your ringbuffer can do which kfifo
>>> can't?  Apart from having a bunch of extra nice accessor-helpers sitting
>>> on the top.
>> Not sure, I'll look into it.
> 
> kfifo won't be a drop in replacement, it's just a very simple ring fifo.
> I suspect your higher level ring buffer accessors and allocators could
> live on top of it though.
Sure, but from my understanding of kfifo it takes a much more symmetric
approach to reading and writing with locking used to prevent them occuring
concurrently.  You obviously can use it without locking but I don't believe
that it provide any facility for coping with the nasty case, (buffer full
and hence during read attempts a certain amount of what is copied out may
have become invalid).  It maybe the case that, as you say suitable high level
functions on top of a kfifo would be a good way to proceed (afterall,  kfifo
is well tested etc), but I fear, given how little of kfifo's code would actually
be used it would be more likely to cause problems than not. 

It might be best to leave this decision until the exact requirements of the ring
buffer are actually known.

Jonathan

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
