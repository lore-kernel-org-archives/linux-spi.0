From: Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] dt-bindings: spi: Add Spreadtrum ADI controller documentation
Date: Fri, 8 Sep 2017 09:57:17 +0800
Message-ID: <CAMz4kuK+jMBRtcO-0b3Lk_hnvDOxr6yyDLkMRc-VCk21bvz4WQ@mail.gmail.com>
References: <ccbb0641fa123021249c7a51cbe2dcd975c41f39.1504677110.git.baolin.wang@spreadtrum.com>
 <20170906145900.yesyfyruv5wd3wxj@sirena.co.uk> <CAMz4ku+hKaemHQdVtNEbCf0J_9CjqKouSygAaQsqf+hBzGd-mg@mail.gmail.com>
 <20170907095435.5yhybxz6oootp37h@sirena.co.uk> <CAMz4kuLGTCgppki=je9pE5SidRnYWJA-nJd1=RD7qdN1ZRww3Q@mail.gmail.com>
 <20170907114401.kz2rfss2bkslybtq@sirena.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Baolin Wang <baolin.wang-lxIno14LUO0EEoCn2XhGlw@public.gmane.org>,
        Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170907114401.kz2rfss2bkslybtq-7j8lgAiuQgnQXOPxS62xeg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 7 September 2017 at 19:44, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Thu, Sep 07, 2017 at 07:03:18PM +0800, Baolin Wang wrote:
>> On 7 September 2017 at 17:54, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>> > On Thu, Sep 07, 2017 at 11:29:05AM +0800, Baolin Wang wrote:
>
>> >> The hwspinlock name should be "adi", and I will make it clear in next version.
>
>> > So there's other drivers that might also be accessing this IP block?
>
>> Yes. Other drivers (like regulator, RTC or charger ... ) can access
>> analog chip (like PMIC) by ADI controller. But the hardware spinlock
>> is used to synchronize between the multiple subsystems, since we only
>> have one ADI controller.
>
> If it were other drivers then the kernel should already be doing that
> but...

Not only kernel drivers, but also other systems' drivers will access
ADI too. So here we need one hardware spinlock to protect, I will add
more documentation.

>
>> > So does this driver control all the channels or are there other drivers
>> > (or hardware components) that control some of the other channels?
>
>> The ADI driver only controls 2 software channels (read/write), and
>> other hardware channels can be controlled by hardware components if we
>> set the hardware config.
>
> ...if it can be configured to allow other things to use it independently
> then this is fine, just needs a bit more documentation so someone can
> understand how the bindings and hardware match up.

OK. Thanks for your comments.

-- 
Baolin.wang
Best Regards
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
