From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 3/4] spi: Add OF binding support for
	SPI busses
Date: Sat, 24 May 2008 09:50:43 -0700
Message-ID: <200805240950.43394.david-b@pacbell.net>
References: <20080516193054.28030.35126.stgit@trillian.secretlab.ca>
	<200805221915.59878.david-b@pacbell.net>
	<fa686aa40805232331p1bf2c1bcn8c46c21a094ef01e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: "Grant Likely" <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <fa686aa40805232331p1bf2c1bcn8c46c21a094ef01e-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Friday 23 May 2008, Grant Likely wrote:
> On Thu, May 22, 2008 at 8:15 PM, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> wrote:
> > On Friday 16 May 2008, you wrote:
> >> +               prop = of_get_property(nc, "max-speed", &len);
> >> +               if (prop && len >= sizeof(*prop))
> >> +                       spi->max_speed_hz = *prop;
> >> +               else
> >> +                       spi->max_speed_hz = 100000;
> >
> > This isn't I2C; I suggest a default more appropriate to SPI!
> > Maybe 10 MHz, rather than 100 KHz; or if you want folk to use
> > this *a lot* then maybe 1 MHz.  I'd consider it a bug to have
> > folk rely on this very much, though.
> 
> Yeah, I thought it a little stinky when I wrote it, but I wanted to
> put *something* in for the case where the driver sets it's own value
> for max_speed and it can be omitted from the device tree.

That is, this is just so the spi_setup() from spi_new_device()
doesn't fail?

Thing is, drivers playing with max_speed are rare.  They just
can't know the board-specific factors involved in making some
speed fail, even when the chip might handle it on other boards.
(Factors like lower voltage and higher capacitance tend to
reduce the speeds that will work.)

The only driver I know which mucks with max_speed_hz is the
MMC-over-SPI driver, and that's because the cards themselves
report various ranges that can work ... and even there, the
driver remembers the board-specific maximum (which may be
less than the card can handle).


> Maybe it 
> would just be better to leave it as 0 if the max-speed property is
> non-existent.

Which would usually cause spi_setup() to fail, and thus cause
the device not to be listed ...


> What do you think?

Technically, spi_setup() with max_speed set to 0 isn't what
I'd call well specified ... the issue rarely came up before.
"Max" of zero basically means "off", and there's not really
any such state in the spi_device lifecycle.  Those are good
reasons to avoid such boundary cases; also, it's easy to oops
in divider calculations when zero is used.

Instead, board init code has set up nonzero speeds, so the
spi_new_device() call to spi_setup() hasn't had ar eason
to fail because max_speed was illegal/unsupportable.

If it's worth avoiding, that may mean it's worth defaulting
it in core code (e.g. spi_new_device) not OF platform glue...
but I basically think of that speed as a value that board
setup code *must* provide.

- Dave


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
