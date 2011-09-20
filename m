From: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Subject: Re: [PATCH V3 1/5] i2c: Add irq_gpio field to struct i2c_client,
 i2c_board_info.
Date: Tue, 20 Sep 2011 09:54:48 +0100
Message-ID: <4E7854D8.7000603@cam.ac.uk>
References: <1314914676-28397-1-git-send-email-swarren@nvidia.com> <20110902085620.4ad918c4@endymion.delvare> <20110920041629.GC30517@ponder.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>,
	Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>,
	Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>,
	Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>,
	Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>,
	Andrew Chew <achew-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	devel-gWbeCf7V1WCQmaza687I9mD2FQJk+8+b@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110920041629.GC30517-e0URQFbLeQY2iJbIjFUEsiwD8/FfD2ys@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 09/20/11 05:16, Grant Likely wrote:
> On Fri, Sep 02, 2011 at 08:56:20AM +0200, Jean Delvare wrote:
>> Stephen,
>>
>> Can you please fix your e-mail client / system / whatever so that your
>> patch series are no longer sent duplicated?
>>
>> On Thu,  1 Sep 2011 16:04:27 -0600, Stephen Warren wrote:
>>> Some devices use a single pin as both an IRQ and a GPIO. In that case,
>>> irq_gpio is the GPIO ID for that pin. Not all drivers use this feature.
>>> Where they do, and the use of this feature is optional, and the system
>>> wishes to disable this feature, this field must be explicitly set to a
>>> defined invalid GPIO ID, such as -1.
>>>
>>> Signed-off-by: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>>> ---
>>> v3: Also add the field to i2c_board_info, and copy the field from
>>>     i2c_board_info to i2c_client upon instantiation
>>
>> I don't get the idea. The i2c core doesn't make any use of the field,
>> and that field will only be used by a few drivers amongst the 420+
>> i2c drivers in the tree. This looks like a waste of memory. What's wrong
>> with including the new field in the private platform or arch data
>> structure for drivers which need it?
> 
> I have to second the concern; but for a different reason.  This
> shouldn't even remotely be necessary.  If the pin is used as an
> interrupt, then interrupt controller driver (which I would assume is
> also the gpio controller driver) should be responsible for setting up
> the pin so that it can be used correctly as a irq line.  Why does the
> gpio number need to be explicitly passed?
The particular driver covered here is somewhat of a false positive.
It really ought to be rewritten to do everything 'properly' with
interrupts.  Right now no one with the inclination has the hardware
to fix it up.

The nasty case we are trying to cover is peripherals that use level
interrupts talking to gpio chips that only do edge triggered ones.
We use the pin as an irq but have to query it as a gpio to discover
if the sneaky chip raised it again without it actually going low.

There are sometimes work arounds involving polling registers on
the device to check if the interrupt is active, but give the bus is
slow, pinging the gpio to find out it's state is often much faster.

So it's a dirty hack for dirty hardware.  Having said that I agree
that it's a niche case and certainly shouldn't be part of any core
code, unless it is done right at the core in the generic interrupt
code and previous discussions suggest that is tricky to say the least!
