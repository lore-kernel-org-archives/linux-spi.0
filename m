From: Trent Piepho <tpiepho-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi/xilinx: Use DT information for bits_per_word value,
	fix bus_num value
Date: Thu, 10 Oct 2013 14:44:28 -0700
Message-ID: <CA+7tXijruOwkDrbiva34m_HFFBkXNkYtwTRdZoaeytsLtDuYhg@mail.gmail.com>
References: <5256A186.5030708@efe-gmbh.de>
	<20131010141221.GN21581@sirena.org.uk>
	<5256BEBD.1090907@efe-gmbh.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Renaud Muller <muller-Xf229rFC5gsb1SvskN2V4Q@public.gmane.org>, Mark Brown <broonie-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>,
	Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
To: Jens Renner <renner-Xf229rFC5gsb1SvskN2V4Q@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <5256BEBD.1090907-Xf229rFC5gsb1SvskN2V4Q@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thu, Oct 10, 2013 at 7:50 AM, Jens Renner <renner-Xf229rFC5gsb1SvskN2V4Q@public.gmane.org> wrote:
> Am 10.10.2013 16:12, schrieb Mark Brown:
>> On Thu, Oct 10, 2013 at 02:45:58PM +0200, Jens Renner wrote:
>>
>>> +            of_property_read_u32(pdev->dev.of_node, "xlnx,num-transfer-bits",
>>> +                                    &bits_per_word);
>>
>> This new property needs to be documented in the binding document (and
>> sent to the DT maintainers for review though in this case it's probably
>> OK).
>
> So far there is no binding documentation for spi/xilinx at all, but I prepared
> a file spi-xilinx.txt which documents everything. I will send it to the DT
> maintainers.

In the normal Linux SPI layer, bits_per_word is a field for a
spi_device (slave).  Different slaves on the same master could use
different bits per word values, which can be changed by the slave for
different transfers.

It looks like maybe this master can only support one bits_per_word
value?  But unlike many devices that just support 8-bits, it can
support one of 8, 16, or 32 depending on "something", and that
something is specified in the device tree here?  No way to query the
device?

Because if you're just trying to set the default bits per word value
it shouldn't be a property of the master, but rather a generic slave
property like spi-max-frequency or spi-cs-high.

Anyway, the driver should use this device tree/platform data property
to set the master's bits_per_word_mask field.  Then you can remove the
bits_per_word checking code from the driver (in
xilinx_spi_setup_transfer()) since the spi core will do it for you.

BTW, you might consider what happens if a new version of the IP
supports multiple bits_per_words when deciding on how the DT property
should be design.  Maybe a list of values or a mask?

------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60134071&iu=/4140/ostg.clktrk
