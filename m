From: Harini Katakam <harinikatakamlinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH 2/2] spi: Add support for Zynq Ultrascale+ MPSoC GQSPI controller
Date: Fri, 29 May 2015 15:30:11 +0530
Message-ID: <CAFcVECLmVXprE8gjsM6bJ3M+TG4pTCtRWDXrsim6kYhsoUyM7Q@mail.gmail.com>
References: <1432106871-27232-1-git-send-email-ranjit.waghmode@xilinx.com>
	<1432106871-27232-2-git-send-email-ranjit.waghmode@xilinx.com>
	<20150522115854.GG21391@sirena.org.uk>
	<CAFcVECJRqebzAjU+rfAtUQFG=7-KoE1GiXet5XJB-4D3i0or6A@mail.gmail.com>
	<20150528150356.GA21577@sirena.org.uk>
	<03CA77BA8AF6F1469AEDFBDA1322A7B7495AA317@XAP-PVEXMBX02.xlnx.xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Ranjit Abhimanyu Waghmode <ranjitw-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	"ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org" <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Michal Simek <michals-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	Soren Brinkmann <sorenb-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"ran27jit-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <ran27jit-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Punnaiah Choudary Kalluri <punnaiah.choudary.kalluri-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <03CA77BA8AF6F1469AEDFBDA1322A7B7495AA317-4lKfpRxZ5ekkx2a1wsGfbYg+Gb3gawCHQz34XiSyOiE@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mark,

On Thu, May 28, 2015 at 9:11 PM, Punnaiah Choudary Kalluri
<punnaiah.choudary.kalluri-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org> wrote:
> Hi Mark,
>
>> -----Original Message-----
>> From: Mark Brown [mailto:broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org]
>> Sent: Thursday, May 28, 2015 8:34 PM
>> To: Harini Katakam
>> Cc: Ranjit Abhimanyu Waghmode; Rob Herring; Pawel Moll; Mark Rutland;
>> ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org; Kumar Gala; Michal Simek; Soren Brinkmann;
>> devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org; linux-
>> kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-spi; Punnaiah Choudary Kalluri;
>> ran27jit-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
>> Subject: Re: [RFC PATCH 2/2] spi: Add support for Zynq Ultrascale+ MPSoC
>> GQSPI controller
>>
>> On Fri, May 22, 2015 at 08:43:54PM +0530, Harini Katakam wrote:
>> > On Fri, May 22, 2015 at 5:28 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>> > > On Wed, May 20, 2015 at 12:57:51PM +0530, Ranjit Waghmode wrote:
>>
>> > > Why is there a default case here?  That's going to men we try to handle
>> > > any random chip select that gets passed in as pointing to this lower
>> > > device which doesn't seem right.  The fact that this is trying to handle
>> > > mirroring of the chip select to two devices is also raising alarm bells
>> > > here...
>>
>> > This SPI controller has two CS lines and two data bus.
>> > Two devices can be connected to these and either the upper or the
>> > lower or both (Explained below) can be selected.
>>
>> > When two flash devices are used, one of the HW configurations in
>> > which they can be connected is called "parallel" mode where they
>>
>> I know what wiring chip selects in parallel is but that's not the
>> question - the question is about the handling of the default case.
>
> Yes, we should not handle default case here. We will change this.
>

Yes, that's right. I was just elaborating the mirroring part.

>>
>> > >> +static void zynqmp_qspi_chipselect(struct spi_device *qspi, bool
>> is_high)
>> > >> +{
>>
>> > >> +     if (is_high) {
>> > >> +             /* Manually start the generic FIFO command */
>> > >> +             zynqmp_gqspi_write(xqspi, GQSPI_CONFIG_OFST,
>> > >> +                             zynqmp_gqspi_read(xqspi, GQSPI_CONFIG_OFST) |
>> > >> +                             GQSPI_CFG_START_GEN_FIFO_MASK);
>>
>> > > No, this is broken - setting the chip select should set the chip select,
>> > > it shouldn't have any impact on transfers.  Transfers should be started
>> > > in the transfer operations.
>>
>> > This is the only way to assert the CS. It doesn't start transferring any data.
>>
>> OK, then you can't implement a separate set_cs() operation and shouldn't
>> be trying to do so.  This will break in multiple ways when the framework
>> tries to use the operations separately.  You probably need to implement
>> a single flat transfer() operation.
>
> As we said it will not start any data transfer. In order to set chip select (chip select only) we need to
> 1. Frame a control word with following parameters like the chip select that we would like to set and hold time
>  2. Update the control word to fifo
>
> To have a performance advantage (may be not trivial) we are executing this fifo entry along with the first
>  Data transfer entry in transfer function so that we can avoid waiting for fifo empty in set_cs function.
>
>  We will ensure CS assert by waiting till the fifo empty in set_cs function and justify the what the
> Function supposed do.
>

Yes, if we wait for cs assert to be executed (which is just the time
controller takes to fetch this command
and execute), this set_cs will be independent as expected. The
framework can use it anytime.

Regards,
Harini
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
