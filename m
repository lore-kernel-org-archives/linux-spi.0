From: Harini Katakam <harinikatakamlinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 2/2] devicetree: Add devicetree bindings documentation
 for Cadence SPI
Date: Mon, 7 Apr 2014 13:16:47 +0530
Message-ID: <CAFcVECJN0g5L2wiOJFvESqu9Zd3zpcckhh8wbvwsiwxVfc=+Wg@mail.gmail.com>
References: <1396523431-14519-1-git-send-email-harinik@xilinx.com>
	<1396523431-14519-2-git-send-email-harinik@xilinx.com>
	<20140403213446.GB14763@sirena.org.uk>
	<CAFcVEC+mpHh_d2j6_sdhWS3d2KyXrDYUq6L6jO2Q=SS68Hda2g@mail.gmail.com>
	<20140404100919.GO14763@sirena.org.uk>
	<CAFcVECLDyfFSZFk9fzFKsr6pM=f1nwzGAhjX17z=NsbvWpiDew@mail.gmail.com>
	<20140404124637.GT14763@sirena.org.uk>
	<CAFcVEC+FAAxxxxA8PgcTzLU5UFu=pkDEM4Li06dRmEwA95sz_g@mail.gmail.com>
	<CAFcVECJYdW0=r425tWs8y6DJDNh3c75TAzg7+UCNRgLP8WHf+A@mail.gmail.com>
	<CAEgOgz56hhFCy6sjZmw+Wn6uT4rU8mXSpazscPG_uJ-==-uXLw@mail.gmail.com>
	<CAFcVEC+vWwepHgsCAP63YG2F_0ZXKMck1YYwi7XU3JQdpC9ZQw@mail.gmail.com>
	<CAEgOgz5XsOYXyPTpUzx_j=+Z19oksTT5TB8G3r9KbYakrQvgHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	"ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org" <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Peter Crosthwaite <peter.crosthwaite-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAEgOgz5XsOYXyPTpUzx_j=+Z19oksTT5TB8G3r9KbYakrQvgHw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Peter,

On Sun, Apr 6, 2014 at 5:13 AM, Peter Crosthwaite
<peter.crosthwaite-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org> wrote:
> On Sat, Apr 5, 2014 at 4:05 PM, Harini Katakam
> <harinikatakamlinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> Hi Peter,
>>
>> On Sat, Apr 5, 2014 at 4:44 AM, Peter Crosthwaite
>> <peter.crosthwaite-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org> wrote:
>>> On Sat, Apr 5, 2014 at 12:30 AM, Harini Katakam
>>> <harinikatakamlinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>>>> Hi,
>>>>
>>>> On Fri, Apr 4, 2014 at 7:38 PM, Harini Katakam
>>>> <harinikatakamlinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>>>>> Hi Mark,
>>>>>
>>>>> On Fri, Apr 4, 2014 at 6:16 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>>>>>> On Fri, Apr 04, 2014 at 05:44:23PM +0530, Harini Katakam wrote:
>>>>>>> On Fri, Apr 4, 2014 at 3:39 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>>>>>>> > On Fri, Apr 04, 2014 at 08:30:38AM +0530, Harini Katakam wrote:
>>>>>>
>>>>>>> >> This IP can drive 4 slaves.
>>>>>>> >> The sCS line to be driven is selected in spi device structure and
>>>>>>> >> that is driven by the software.
>>>>>>
>>>>>>> > So why specify this in the binding at all?  If the device always has the
>>>>>>> > same number of chip selects it's redundant.
>>>>>>
>>>>>>> I'm sorry, I should have explained that better.
>>>>>>> The IP can support upto 4 chip selects.
>>>>>>> The num-cs value here is the number of chip selects actually used on the board.
>>>
>>> Shouldnt it be a property of the controller not the board? How for
>>> example do we differentiate between different implementations of
>>> cadence SPI controller that only supports up to two CS lines? My
>>> thinking is that this property should always be present and = 4 in the
>>> Zynq case as the controller always has 4 physical CS lines coming out
>>> (before any decoders, pin muxes or slaves etc.).
>>>
>>>>>>
>>>>>> Why does that need to be configured?  Surely the presence of slaves is
>>>>>> enough information.
>>>
>>> And presence of slaves / board info is inferable from subnodes.
>>>
>>>>>
>>>>> OK. I understand.
>>>>> Can you comment on the case where a decoder is used?
>>>>>
>>>>> There is support for adding a decoder where extended slaves can be selected
>>>>> through the IP's control register.
>>>>> (This is not currently implemented in the driver but will be in the future.)
>>>>>
>>>
>>> I think thats seperate information. is-decoded-cs property of something.
>>>
>>>>> How should the driver know whether it is 4 or 16 select lines for example?
>>>>> This has to be written to master->num_chipselect.
>>>>>
>>>
>>> If you only have one property (== 4) how do you tell the difference
>>> between 4 un-decoded CS lines vs 2 decoded CS lines?
>>>
>>
>> If an SoC implements 2 CS and sets "decoder" property,
>> then we'd configure the register with "select decode" bit and write
>> 0b0011 to the slave select field to select 4th slave.
>>
>> If decoder property is not set, then we'd write 0b1000 to select 4th slave.
>>
>
> What are your proposed dt bindings for these differing options - what
> is num-cs in each case?

I think it will be better to have num-cs equal to the max slaves allowed and
the property to indicate if decoder is present helps driver configure the
register accordingly. (master->num_chipselect is written with "num-cs" value)

For ex.,
1. 4 slaves without decoder
num-cs = <4>
is-decoded-cs = <false>

2. 4 slaves driven through 2 to 4 decoder:
num-cs = <4>
is-decoded-cs = <true>

The other option is have num-cs reflect number of CS before decoder
but the above option makes more sense as num-cs directly reflects
the max valid slaves.

>
>> But yes, if the SoC only implements 2 CS, doesn't use decoder but
>> if there is an erroneous input to set_cs for 4th slave, it would be a problem.
>>
>
> Sure, that's an error condition though that should be caught by SPI
> because master->num_chipselect would only be 2 right?
>

Yes.

Regards,
Harini

> Regards,
> Peter
>
>>>
>>> I think num-cs has validity as the number of CS lines implemented in
>>> the controller. For any given SoC, it's constant but could differ
>>> between SoCs.
>>>
>>
>> I dint consider that this property will be useful to SoC's implementing <4 CS;
>> master->num_chipselect (when set to this property's value)
>> will be used to check error conditions.
>>
>> Regards,
>> Harini
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
