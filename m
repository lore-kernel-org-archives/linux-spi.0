From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH 2/2] spi: Add ADI driver for Spreadtrum platform
Date: Thu, 7 Sep 2017 19:21:10 +0800
Message-ID: <CAMz4ku+HVwEv0PsWivn5a-zOSZ9WF6ejcxzzU+LYHcqCqb=K5A@mail.gmail.com>
References: <ccbb0641fa123021249c7a51cbe2dcd975c41f39.1504677110.git.baolin.wang@spreadtrum.com>
 <c2faf18e6bbdac631963b22e5a4b5ee9be7f9e31.1504677110.git.baolin.wang@spreadtrum.com>
 <20170906150446.v7qqc24wxeykcwwk@sirena.co.uk> <CAMz4kuL1cDD0PTBJ9-7an3KnFyhE9iZOp4VU4MCsHcx8TG5DhQ@mail.gmail.com>
 <20170907101017.mcxfnm3u4osda7xr@sirena.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Baolin Wang <baolin.wang@spreadtrum.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170907101017.mcxfnm3u4osda7xr@sirena.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 7 September 2017 at 18:10, Mark Brown <broonie@kernel.org> wrote:
> On Thu, Sep 07, 2017 at 11:13:00AM +0800, Baolin Wang wrote:
>
>> >> +static int __init sprd_adi_init(void)
>> >> +{
>> >> +     return platform_driver_register(&sprd_adi_driver);
>> >> +}
>> >> +subsys_initcall(sprd_adi_init);
>
>> > Why is this subsys_initcall() and not module_platform_driver()?
>
>> Since ADI is one very fundamental driver for our SoC, many drivers
>> such as regulator need depend on ADI, and regulator need to regulate
>> core voltage as earlier as possible.
>
> That applies to huge numbers of systems - you should still just use
> regular init ordering in mainline, there are efforts to make things
> better there (look at Viresh's dependency stuff) so hopefully things
> will improve in the future and in the meantime the cost of probe
> deferral isn't *that* great and it's less fiddly than tweaking ordering.
> Practically speaking init ordering stuff can always be added in vendor
> kernels in the meantime.

Make sense. So I change back to module_platform_driver().

-- 
Baolin.wang
Best Regards
