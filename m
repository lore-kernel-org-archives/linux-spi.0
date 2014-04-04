From: Harini Katakam <harinikatakamlinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] SPI: Add support for Zynq Quad SPI controller
Date: Fri, 4 Apr 2014 17:56:47 +0530
Message-ID: <CAFcVECLLcVEh+P1EELAZEZhRhUFM--t3pmytv2y10pwCkoxFJA@mail.gmail.com>
References: <1396544587-10876-1-git-send-email-punnaia@xilinx.com>
	<203181a5-626f-437e-8efe-983a9d78ec5d@AM1EHSMHS017.ehs.local>
	<20140403212940.GY14763@sirena.org.uk>
	<CAFcVECJiSm8MMJ37c-Qfsu-UE0jgEYRmeGZ8OQG97wyRMaJ1LQ@mail.gmail.com>
	<20140404110837.GS14763@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Punnaiah Choudary Kalluri <punnaiah.choudary.kalluri-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	"ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org" <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	Punnaiah Choudary <kpc528-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	punnaiah choudary kalluri <kalluripunnaiahchoudary-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Punnaiah Choudary Kalluri <punnaia-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140404110837.GS14763-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Mark,

On Fri, Apr 4, 2014 at 4:38 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Fri, Apr 04, 2014 at 08:59:47AM +0530, Harini Katakam wrote:
>> On Fri, Apr 4, 2014 at 2:59 AM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>
>> > Why would a transfer be being set up without a transfer being provided?
>
>> The setup function calls this function before a transfer is initiated.
>> In this case NULL is passed to setup_transfer (see below) and
>> SPI is initialized with default clock configuration.
>> This initialization is necessary because otherwise this clock config
>> would be done
>> only after SPI is enabled in prepare_hardware, which is wrong.
>> (I'm checking for master->busy in setup to address your previous
>> comment on SPI).
>
> The requirement for setup() to work when other transfers are in progress
> is clear and unambiguous, it really isn't acceptable to reconfigure
> hardware in use by a runing transfer in setup().
>

OK. I'll remove setup_transfer here and handle clock configuration elsewhere.

>> I explained the same in SPI v2 changes and this valid there too.
>
> This is v2?
>

No. This "Zynq QSPI" patch is v1.
I was referring to "Cadence SPI" v2 patch in which you pointed to these
comments.

Sorry for the confusion.

<snip>

>> >> +static int __maybe_unused zynq_qspi_suspend(struct device *_dev)
>> >> +{
>> >> +     struct platform_device *pdev = container_of(_dev,
>> >> +                     struct platform_device, dev);
>> >> +     struct spi_master *master = platform_get_drvdata(pdev);
>> >> +
>> >> +     spi_master_suspend(master);
>> >> +
>> >> +     zynq_unprepare_transfer_hardware(master);
>
>> > Why are you unpreparing the hardware - the framework should be doing
>> > that for you if the device is active, if it's not you've got an extra
>> > clock disable here?
>
>> I called unprepare_hardware  becuase it does the things necessary
>> after master suspend - disable clock and controller.
>> (I thought this was your suggestion for SPI?)
>
> Why are these things required after the core has already idled the
> device (using exactly the same function)?

Ok. It's unecessary I'll remove it.

Regards,
Harini
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
