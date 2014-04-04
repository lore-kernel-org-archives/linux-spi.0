From: Harini Katakam <harinikatakamlinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 2/2] devicetree: Add devicetree bindings documentation
 for Cadence SPI
Date: Fri, 4 Apr 2014 17:44:23 +0530
Message-ID: <CAFcVECLDyfFSZFk9fzFKsr6pM=f1nwzGAhjX17z=NsbvWpiDew@mail.gmail.com>
References: <1396523431-14519-1-git-send-email-harinik@xilinx.com>
	<1396523431-14519-2-git-send-email-harinik@xilinx.com>
	<20140403213446.GB14763@sirena.org.uk>
	<CAFcVEC+mpHh_d2j6_sdhWS3d2KyXrDYUq6L6jO2Q=SS68Hda2g@mail.gmail.com>
	<20140404100919.GO14763@sirena.org.uk>
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
In-Reply-To: <20140404100919.GO14763-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mark,

On Fri, Apr 4, 2014 at 3:39 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Fri, Apr 04, 2014 at 08:30:38AM +0530, Harini Katakam wrote:
>> On Fri, Apr 4, 2014 at 3:04 AM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>> > On Thu, Apr 03, 2014 at 04:40:31PM +0530, Harini Katakam wrote:
>
>> >> +Optional properties:
>> >> +- num-cs             : Number of chip selects used.
>
>> > How does this translate to the hardware?
>
>> This IP can drive 4 slaves.
>> The CS line to be driven is selected in spi device structure and
>> that is driven by the software.
>
> So why specify this in the binding at all?  If the device always has the
> same number of chip selects it's redundant.

I'm sorry, I should have explained that better.
The IP can support upto 4 chip selects.
The num-cs value here is the number of chip selects actually used on the board.

>
>> >> +             num-cs = /bits/ 16 <4>;
>
>> > What's going on with the /bits/ - is this something that's required for
>> > the property?
>
>> The master->num-chipselect property is 16 bit but writing <4> here directly
>> leads to 0 being read in of_property_read (because it's big endian).
>> Instead using of property read u32 and then copying, we decided to do this.
>> This was discussed on v2 between Michal and Rob:
>
> No, don't do that.  You're contorting the binding to serve Linux's
> implementation needs and you've not documented this requirement either.
> If there *was* a need to have the number be 16 bits you'd need to
> document that reqirement in the binding, though like I say I don't think
> the number needs to be there at all.

OK. I'll remove the /bits/ 16 and handle it in the driver.

Regards,
Harini
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
