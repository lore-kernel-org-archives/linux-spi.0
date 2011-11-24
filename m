From: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Subject: Re: [PATCH 3/5] SPI: Add helper macro for spi_driver boilerplate
Date: Thu, 24 Nov 2011 08:29:36 +0100
Message-ID: <4ECDF260.5030907@metafoo.de>
References: <1321434819-23678-1-git-send-email-lars@metafoo.de> <1321434819-23678-4-git-send-email-lars@metafoo.de> <CACxGe6tz0ppZj=a_e4rkgNxzhQ4MSCtXKXGk_dPov80QDU4MCg@mail.gmail.com> <20111124001342.GN19115@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
	Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>,
	Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>,
	Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Michael Hennerich <Michael.Hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>,
	linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20111124001342.GN19115-SMNkleLxa3Z6Wcw2j4pizdi2O/JbrIOy@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 11/24/2011 01:13 AM, Ben Dooks wrote:
> On Wed, Nov 16, 2011 at 10:12:54AM -0700, Grant Likely wrote:
>> On Wed, Nov 16, 2011 at 2:13 AM, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org> wrote:
>>> This patch introduces the module_spi_driver macro which is a convenience macro
>>> for SPI driver modules similar to module_platform_driver. It is intended to be
>>> used by drivers which init/exit section does nothing but register/unregister
>>> the SPI driver. By using this macro it is possible to eliminate a few lines of
>>> boilerplate code per SPI driver.
>>>
>>> Signed-off-by: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
>>
>> Acked-by: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
> 
> I'm begining to think we need to make some of these driver and device
> bits more generic... there seems to be so much similar but not quite
> the same code.
> 

I've been thinking the same. A good start would probably be consolidating
the platform/spi/i2c device id handling code. Since those are all name based
ids the code for handling them looks rather similar, though there are some
minor differences.

- Lars
