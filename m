From: "Grant Likely" <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 3/4] spi: Add OF binding support for
	SPI busses
Date: Sat, 24 May 2008 00:25:47 -0600
Message-ID: <fa686aa40805232325w65d4f706i50798121a8cce263@mail.gmail.com>
References: <20080516193054.28030.35126.stgit@trillian.secretlab.ca>
	<716a0f1b6c9a544b480c06a329072483@kernel.crashing.org>
	<fa686aa40805211233h72a258bpf8c945b9f662d6ee@mail.gmail.com>
	<200805221926.24112.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: fabrizio.garetto-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
	Segher Boessenkool <segher-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
To: "David Brownell" <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200805221926.24112.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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

On Thu, May 22, 2008 at 8:26 PM, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> wrote:
> On Wednesday 21 May 2008, Grant Likely wrote:
>> > spi-controller {
>> >        #address-cells = 2;
>> >        #size-cells = 0;
>> >        some-device@0,f000 { reg = < 0 f000 >; } // CS 0, SPI address f000
>> >        some-device@1,f000 { reg = < 1 f000 >; } // CS 1, SPI address f000
>> >        some-device@1,ff00 { reg = < 1 ff00 >; } // CS 1, SPI address ff00
>> > }
>>
>> For SPI the CS # *is* the address.  :-)
>>
>> Unlike I2C, SPI doesn't impose any protocol on the data.  It is all
>> anonymous data out, anonymous data in, a clock and a chip select.
>
> Very true ... but then there are SPI chips which embed addressing.
>
> I have in mind the mcp23s08 (and mcp23s17) GPIO expanders, which
> support up to four chips wired in parallel on a given chipselect.
> The devices are distinguished by how two address pins are wired;
> and two bits in the command byte must match them.  (I think they
> just recycled an I2C design into the SPI world.)

Very good point.  Okay, so we cannot assume any correlation between
the number of CS lines and the number of child nodes to the SPI bus.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
