From: Peter Crosthwaite <peter.crosthwaite-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 2/2] devicetree: Add devicetree bindings documentation
 for Cadence SPI
Date: Sat, 5 Apr 2014 09:14:48 +1000
Message-ID: <CAEgOgz56hhFCy6sjZmw+Wn6uT4rU8mXSpazscPG_uJ-==-uXLw@mail.gmail.com>
References: <1396523431-14519-1-git-send-email-harinik@xilinx.com>
	<1396523431-14519-2-git-send-email-harinik@xilinx.com>
	<20140403213446.GB14763@sirena.org.uk>
	<CAFcVEC+mpHh_d2j6_sdhWS3d2KyXrDYUq6L6jO2Q=SS68Hda2g@mail.gmail.com>
	<20140404100919.GO14763@sirena.org.uk>
	<CAFcVECLDyfFSZFk9fzFKsr6pM=f1nwzGAhjX17z=NsbvWpiDew@mail.gmail.com>
	<20140404124637.GT14763@sirena.org.uk>
	<CAFcVEC+FAAxxxxA8PgcTzLU5UFu=pkDEM4Li06dRmEwA95sz_g@mail.gmail.com>
	<CAFcVECJYdW0=r425tWs8y6DJDNh3c75TAzg7+UCNRgLP8WHf+A@mail.gmail.com>
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
To: Harini Katakam <harinikatakamlinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAFcVECJYdW0=r425tWs8y6DJDNh3c75TAzg7+UCNRgLP8WHf+A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Sat, Apr 5, 2014 at 12:30 AM, Harini Katakam
<harinikatakamlinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Hi,
>
> On Fri, Apr 4, 2014 at 7:38 PM, Harini Katakam
> <harinikatakamlinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> Hi Mark,
>>
>> On Fri, Apr 4, 2014 at 6:16 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>>> On Fri, Apr 04, 2014 at 05:44:23PM +0530, Harini Katakam wrote:
>>>> On Fri, Apr 4, 2014 at 3:39 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>>>> > On Fri, Apr 04, 2014 at 08:30:38AM +0530, Harini Katakam wrote:
>>>
>>>> >> This IP can drive 4 slaves.
>>>> >> The CS line to be driven is selected in spi device structure and
>>>> >> that is driven by the software.
>>>
>>>> > So why specify this in the binding at all?  If the device always has the
>>>> > same number of chip selects it's redundant.
>>>
>>>> I'm sorry, I should have explained that better.
>>>> The IP can support upto 4 chip selects.
>>>> The num-cs value here is the number of chip selects actually used on the board.

Shouldnt it be a property of the controller not the board? How for
example do we differentiate between different implementations of
cadence SPI controller that only supports up to two CS lines? My
thinking is that this property should always be present and = 4 in the
Zynq case as the controller always has 4 physical CS lines coming out
(before any decoders, pin muxes or slaves etc.).

>>>
>>> Why does that need to be configured?  Surely the presence of slaves is
>>> enough information.

And presence of slaves / board info is inferable from subnodes.

>>
>> OK. I understand.
>> Can you comment on the case where a decoder is used?
>>
>> There is support for adding a decoder where extended slaves can be selected
>> through the IP's control register.
>> (This is not currently implemented in the driver but will be in the future.)
>>

I think thats seperate information. is-decoded-cs property of something.

>> How should the driver know whether it is 4 or 16 select lines for example?
>> This has to be written to master->num_chipselect.
>>

If you only have one property (== 4) how do you tell the difference
between 4 un-decoded CS lines vs 2 decoded CS lines?

>> Regards,
>> Harini
>
> Just adding to my above comment.
> Alternately, I could not use the "num-cs" property and add another
> optional property to be used only when required.

I think num-cs has validity as the number of CS lines implemented in
the controller. For any given SoC, it's constant but could differ
between SoCs.

Regards,
Peter

> The driver sets a default value already.
>
> Regards,
> Harini
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
