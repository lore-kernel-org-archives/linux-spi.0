From: "Grant Likely" <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 3/4] spi: Add OF binding support for
	SPI busses
Date: Sat, 24 May 2008 00:24:32 -0600
Message-ID: <fa686aa40805232324k1505d02aj6790d0217482c732@mail.gmail.com>
References: <20080516193054.28030.35126.stgit@trillian.secretlab.ca>
	<20080516224916.GA16702@zarina>
	<fa686aa40805162202m336aade4qd6cfa5b17d6f3892@mail.gmail.com>
	<200805211816.10753.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	fabrizio.garetto-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "David Brownell" <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200805211816.10753.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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

On Wed, May 21, 2008 at 7:16 PM, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> wrote:
> On Friday 16 May 2008, Grant Likely wrote:
>> In my mind; platform_data and the device tree are all about the same
>> thing: representation.  In other words, how to describe the
>> configuration of the hardware independent of the driver itself.
>
> Platform_data isn't what I'd call independent of drivers.
>
> The reason the data is there in the first place is that
> the driver needs it ... and chose not to hard-wire it.

Oh, of course the driver needs it!  I'm not claiming otherwise.  More
what I mean is that the driver doesn't need to be loaded or even
configured in for the platform code to make use of pdata.

>> One of the things I find rather interesting is just how frequently
>> drivers using platform data structures have a big block of code which
>> simply copy pdata fields into identically named fields in the device
>> private data...
>
> ... because platform data was designed as a partial template
> for that driver, letting it do that.  (Sometimes without even
> doing scale conversions.)  As drivers grow functionally, they
> sometimes end up needing more platform data fields, to expose
> data that previously didn't matter.
>
> Whether that data can usefully be stored in flash (or ROM)
> and handed out through the bootloader is something of a
> manufacturing issue.

I do not dispute any of that.  My point, however, is that pdata is
typically used simply as a representation that is convenient for
platform code to pass that data into the driver and that often drivers
don't use that representation directly.  Instead, the data is
explicitly copied explicitly field by field into the driver at probe
time and is not touched again.  That says to me that driver developers
view pdata as somewhat decoupled from the internal workings of the
driver and in the case of many powerpc devices a different
representation is more convenient; namely a device tree node.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
