From: Segher Boessenkool <segher-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH 3/4] spi: Add OF binding support for
	SPI busses
Date: Wed, 21 May 2008 21:11:42 +0200
Message-ID: <716a0f1b6c9a544b480c06a329072483@kernel.crashing.org>
References: <20080516193054.28030.35126.stgit@trillian.secretlab.ca>
	<20080516193613.28030.13950.stgit@trillian.secretlab.ca>
	<Pine.LNX.4.64.0805191446530.27140@axis700.grange>
	<fa686aa40805190857u317d3304ie75d11870e109fc5@mail.gmail.com>
	<Pine.LNX.4.64.0805191811510.29559@axis700.grange>
	<fa686aa40805192213y485c4ba2u750748f8201e0377@mail.gmail.com>
	<Pine.LNX.4.64.0805201650280.5283@axis700.grange>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: fabrizio.garetto-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.64.0805201650280.5283-0199iw4Nj15frtckUFj5Ag@public.gmane.org>
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

> Ok, elegance apart:-) You can use the SPI-bridge construct to also
> describe simple SPI-chipselect configurations. But is it really a good
> idea? Wouldn't it be better to handle these two cases separately?

It would be best to handle all these things that are specific to
a certain SPI controller (like how CSs work) in the binding for
that SPI controller, and not try to shoehorn all of this into some
artificial generic framework.

If you can have identical addresses on the SPI bus going to different
devices based on which CS is asserted, you'll have to make the CS part
of the "reg".  Example:

spi-controller {
	#address-cells = 2;
	#size-cells = 0;
	some-device@0,f000 { reg = < 0 f000 >; } // CS 0, SPI address f000
	some-device@1,f000 { reg = < 1 f000 >; } // CS 1, SPI address f000
	some-device@1,ff00 { reg = < 1 ff00 >; } // CS 1, SPI address ff00
}

SPI-to-SPI bridges can (and should!) be handled the same way as
anything-to-anything-else bridges are handled as well: either there
is a nice simple one-to-one matching (and you can use "ranges") or
you need a driver for that bridge that knows how to make it work (or
both, "ranges" isn't always enough, the bridge might require some
specific handling for some special situations -- error handling,
suspend, whatever).


Segher


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
