From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 3/4] spi: Add OF binding support for
	SPI busses
Date: Sat, 24 May 2008 00:13:27 -0700
Message-ID: <200805240013.28044.david-b@pacbell.net>
References: <20080516193054.28030.35126.stgit@trillian.secretlab.ca>
	<200805221926.24112.david-b@pacbell.net>
	<fa686aa40805232325w65d4f706i50798121a8cce263@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: fabrizio.garetto-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
	Segher Boessenkool <segher-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
To: "Grant Likely" <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <fa686aa40805232325w65d4f706i50798121a8cce263-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
> Very good point. =A0Okay, so we cannot assume any correlation between
> the number of CS lines and the number of child nodes to the SPI bus.

That wasn't what I was implying ... all the devices hooked
up to a given chipselect should be viewed as a single (albeit
composite) child node.

Now, the driver for that child node may want to expose lots
of substructure.  But that's no different from any other
complex device, whose protocol happens to embed some notion
of component addressing.

It's just that in the case I mentioned, that addressing is
a bit more externally visible than it is in some other cases.

- Dave


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
