From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 3/4] spi: Add OF binding support for
	SPI busses
Date: Wed, 21 May 2008 18:16:10 -0700
Message-ID: <200805211816.10753.david-b@pacbell.net>
References: <20080516193054.28030.35126.stgit@trillian.secretlab.ca>
	<20080516224916.GA16702@zarina>
	<fa686aa40805162202m336aade4qd6cfa5b17d6f3892@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	fabrizio.garetto-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Grant Likely" <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <fa686aa40805162202m336aade4qd6cfa5b17d6f3892-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

On Friday 16 May 2008, Grant Likely wrote:
> In my mind; platform_data and the device tree are all about the same
> thing: representation. =A0In other words, how to describe the
> configuration of the hardware independent of the driver itself.

Platform_data isn't what I'd call independent of drivers.

The reason the data is there in the first place is that
the driver needs it ... and chose not to hard-wire it.


> One of the things I find rather interesting is just how frequently
> drivers using platform data structures have a big block of code which
> simply copy pdata fields into identically named fields in the device
> private data... =


... because platform data was designed as a partial template
for that driver, letting it do that.  (Sometimes without even
doing scale conversions.)  As drivers grow functionally, they
sometimes end up needing more platform data fields, to expose
data that previously didn't matter.

Whether that data can usefully be stored in flash (or ROM)
and handed out through the bootloader is something of a
manufacturing issue.

- Dave

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
