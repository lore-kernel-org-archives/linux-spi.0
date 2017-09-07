From: Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: Add ADI driver for Spreadtrum platform
Date: Thu, 7 Sep 2017 11:13:00 +0800
Message-ID: <CAMz4kuL1cDD0PTBJ9-7an3KnFyhE9iZOp4VU4MCsHcx8TG5DhQ@mail.gmail.com>
References: <ccbb0641fa123021249c7a51cbe2dcd975c41f39.1504677110.git.baolin.wang@spreadtrum.com>
 <c2faf18e6bbdac631963b22e5a4b5ee9be7f9e31.1504677110.git.baolin.wang@spreadtrum.com>
 <20170906150446.v7qqc24wxeykcwwk@sirena.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Baolin Wang <baolin.wang-lxIno14LUO0EEoCn2XhGlw@public.gmane.org>,
        Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170906150446.v7qqc24wxeykcwwk-7j8lgAiuQgnQXOPxS62xeg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Mark,

On 6 September 2017 at 23:04, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Wed, Sep 06, 2017 at 02:10:44PM +0800, Baolin Wang wrote:
>
> This looks like a nice, clean driver.  A few fairly small issues though:
>
>> +config SPI_SPRD_ADI
>> +     tristate "Spreadtrum ADI controller"
>> +     depends on ARCH_SPRD
>> +     help
>> +       ADI driver based on SPI for Spreadtrum SoCs.
>> +
>
> I can't see any hard dependencies on the architecture - can you add an
> || COMPILE_TEST for more coverage?

Yes.

>
>> +     ret = devm_spi_register_controller(&pdev->dev, ctlr);
>> +     if (ret) {
>> +             dev_err(&pdev->dev, "failed to register SPI controller\n");
>> +             goto free_hwlock;
>> +     }
>
>> +     spi_controller_put(ctlr);
>
> You used devm_ to register the controller, no need to free it
> explicitly.

Indeed.

>
>> +static int __init sprd_adi_init(void)
>> +{
>> +     return platform_driver_register(&sprd_adi_driver);
>> +}
>> +subsys_initcall(sprd_adi_init);
>
> Why is this subsys_initcall() and not module_platform_driver()?

Since ADI is one very fundamental driver for our SoC, many drivers
such as regulator need depend on ADI, and regulator need to regulate
core voltage as earlier as possible.
Very appreciated for your comments.

-- 
Baolin.wang
Best Regards
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
