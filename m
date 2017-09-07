From: Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] dt-bindings: spi: Add Spreadtrum ADI controller documentation
Date: Thu, 7 Sep 2017 11:29:05 +0800
Message-ID: <CAMz4ku+hKaemHQdVtNEbCf0J_9CjqKouSygAaQsqf+hBzGd-mg@mail.gmail.com>
References: <ccbb0641fa123021249c7a51cbe2dcd975c41f39.1504677110.git.baolin.wang@spreadtrum.com>
 <20170906145900.yesyfyruv5wd3wxj@sirena.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Baolin Wang <baolin.wang-lxIno14LUO0EEoCn2XhGlw@public.gmane.org>,
        Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170906145900.yesyfyruv5wd3wxj-7j8lgAiuQgnQXOPxS62xeg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mark,

On 6 September 2017 at 22:59, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Wed, Sep 06, 2017 at 02:10:43PM +0800, Baolin Wang wrote:
>
>> +- hwlocks: Reference to a phandle of a hwlock provider node.
>> +- hwlock-names: Reference to hwlock name strings defined in the same order
>> +     as the hwlocks.
>
> What are these hwlocks protecting, and what names are expected?

I made one explanation in above sentence, I assume it is not clear.
Since we have multi-subsystems will use ADI to access analog chip,
when one system is reading/writing data by ADI, which should be under
one hardware spinlock protection to prevent other systems from
reading/writing data by ADI at the same time, or two parallel routine
of setting ADI registers will get incorrect results.

The hwspinlock name should be "adi", and I will make it clear in next version.

>
>> +Optional properties:
>> +- sprd,hw-channels: Specify the hardware channel number and mapped address
>> +     for hardware channel accessing.
>
> What do these mean and how are the numbers and how will the binding be
> interpreted?

I also gave one explanation in above sentence, is it not clear? I try again.

ADI controller has 50 channels including 2 software read/write
channels and 48 hardware channels to access analog chip. For 2
software read/write channels, which means we should set ADI registers
to access analog chip. But For hardware channels, we can just mapped
one analog chip address to one hardware channel, then user can access
analog chip by hardware channel without setting ADI registers.

For this "sprd,hw-channels" property, the first value specifies the
channel id, and the second value specifies the address which is mapped
into analog chip space.

-- 
Baolin.wang
Best Regards
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
