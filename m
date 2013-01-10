From: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Subject: Re: [PATCH 1/3] spi: Add helper functions for setting up transfers
Date: Thu, 10 Jan 2013 10:55:09 +0100
Message-ID: <50EE8FFD.2000000@metafoo.de>
References: <1357752671-30222-1-git-send-email-lars@metafoo.de> <alpine.DEB.2.02.1301100951060.2063@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>,
	linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Julia Lawall <julia.lawall-L2FTfq7BK8M@public.gmane.org>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.DEB.2.02.1301100951060.2063-bi+AKbBUZKagILUCTcTcHdKyNwTtLsGr@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 01/10/2013 09:53 AM, Julia Lawall wrote:
>> +@r1@
>> +identifier fn;
>> +identifier xfers;
>> +@@
>> +fn(...)
>> +{
>> +	...
>> +(
>> +	struct spi_transfer xfers[...];
>> +|
>> +	struct spi_transfer xfers[];
>> +)
>> +	...
>> +}
> 
> Can it happen that there would be more than one spi_transfer or spi_message
> variable per function?  This semantic patch will only treat the case where
> there is only one, because the ... before an after the variable declaration
> won't match another declaration of the same form.
> 
> julia

I guess it could happen, but I would consider it to be very rare. There are
a few examples of multiple transfers in the kernel. But most of them look like

struct spi_message msg;
struct spi_transfer xfer_foo;
struct spi_transfer xfer_bar;

...
spi_message_add_tail(&xfer_foo, &msg);
spi_message_add_tail(&xfer_bar, &msg);

So the transformation can't be applied here anyway.

Do you have an idea how to change the rule to work with multiple
transfers/messages per function? If it would make the cocci file more
complex I wouldn't bother to take care of it, since it basically has no
practical use.

- Lars
