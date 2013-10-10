From: Trent Piepho <tpiepho-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi/xilinx: Use DT information for bits_per_word value,
	fix bus_num value
Date: Thu, 10 Oct 2013 16:15:25 -0700
Message-ID: <CA+7tXiiHFPj1-UZFKXrcxRMpHL8JCqbOUPWbsE-JF3ASHBQ_Gg@mail.gmail.com>
References: <5256A186.5030708@efe-gmbh.de>
	<20131010141221.GN21581@sirena.org.uk>
	<5256BEBD.1090907@efe-gmbh.de>
	<CA+7tXijruOwkDrbiva34m_HFFBkXNkYtwTRdZoaeytsLtDuYhg@mail.gmail.com>
	<20131010225147.GX21581@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Jens Renner <renner-Xf229rFC5gsb1SvskN2V4Q@public.gmane.org>, Renaud Muller <muller-Xf229rFC5gsb1SvskN2V4Q@public.gmane.org>,
	Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	"spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: Mark Brown <broonie-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20131010225147.GX21581-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Oct 10, 2013 3:51 PM, "Mark Brown" <broonie-GFdadSzt00ze9xe1eoZjHA@public.gmane.org> wrote:
>
> On Thu, Oct 10, 2013 at 02:44:28PM -0700, Trent Piepho wrote:
>
> > It looks like maybe this master can only support one bits_per_word
> > value?  But unlike many devices that just support 8-bits, it can
> > support one of 8, 16, or 32 depending on "something", and that
> > something is specified in the device tree here?  No way to query the
> > device?
>
> I have to say that (not having looked at the driver or the patch really)
> I'd have hoped that this was giving a maximum not a fixed number, if the
> hardware is wired to only support a single value that's anything other
> than 8 bits per word most devices won't work.

>From my look at the driver, it's definitely a single fixed value.  I don't
know this hardware, but my guess is it's chosen when a FPGA image is
designed.  So the hardware itself is not strictly fixed, but Linux is stuck
with whatever the IP core was configured as when the image was made.  Maybe
someone from Xilinx can clarify.

>
> > Because if you're just trying to set the default bits per word value
> > it shouldn't be a property of the master, but rather a generic slave
> > property like spi-max-frequency or spi-cs-high.
>
> It shouldn't be a property at all I'd expect, I'd expect it to be
> something that's hard coded into the client driver mostly - unless the
> controller really is brain dead.

Probably why no one's needed the property.  There is spidev, which wouldn't
know what value to use, but that can be set via ioctl, which makes more
sense.
------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60134071&iu=/4140/ostg.clktrk
