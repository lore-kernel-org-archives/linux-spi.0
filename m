From: Harini Katakam <harinikatakamlinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 2/2] devicetree: Add devicetree bindings documentation
 for Cadence SPI
Date: Fri, 4 Apr 2014 08:30:38 +0530
Message-ID: <CAFcVEC+mpHh_d2j6_sdhWS3d2KyXrDYUq6L6jO2Q=SS68Hda2g@mail.gmail.com>
References: <1396523431-14519-1-git-send-email-harinik@xilinx.com>
	<1396523431-14519-2-git-send-email-harinik@xilinx.com>
	<20140403213446.GB14763@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	"ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org" <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140403213446.GB14763-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mark,

On Fri, Apr 4, 2014 at 3:04 AM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Thu, Apr 03, 2014 at 04:40:31PM +0530, Harini Katakam wrote:
>
>> +Optional properties:
>> +- num-cs             : Number of chip selects used.
>
> How does this translate to the hardware?

This IP can drive 4 slaves.
The CS line to be driven is selected in spi device structure and
that is driven by the software.

>
>> +             num-cs = /bits/ 16 <4>;
>
> What's going on with the /bits/ - is this something that's required for
> the property?

The master->num-chipselect property is 16 bit but writing <4> here directly
leads to 0 being read in of_property_read (because it's big endian).
Instead using of property read u32 and then copying, we decided to do this.
This was discussed on v2 between Michal and Rob:
>>>> +               num-chip-select = /bits/ 16 <4>;
>>
>> I was expecting you will comment this a little bit. :-)
>> Because all just reading this num-cs as 32bit and then
>> assigning this value to master->num_chipselect which is 16bit.
>
> Well, everyone else has that problem then. Obviously it takes a bit
> more care than just reading into a u32, but that is a kernel problem
> and not a problem of the binding.
They are not reading it directly with read_u32 but they are using
intermediate u32 value which is assigned to u16 which is fine.
This pattern is in most drivers(maybe all).
The point is if binding should or can't simplify driver code.
And from your reaction above I expect that it is up to driver
owner and binding doc how you want to do it.

Regards,
Harini
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
