From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH/RFC] spi: Change modalias from a
	pointer to a character array
Date: Mon, 12 May 2008 15:56:39 -0700
Message-ID: <200805121556.40042.david-b@pacbell.net>
References: <20080509173146.2932.16141.stgit@trillian.secretlab.ca>
	<20080512151805.4c2763b9.akpm@linux-foundation.org>
	<fa686aa40805121520y979ee37ga83221b74b35afe1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Grant Likely" <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <fa686aa40805121520y979ee37ga83221b74b35afe1-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

On Monday 12 May 2008, Grant Likely wrote:
> >
> > =A0I'm not really able to work out if this is a needed-in-2.6.26 thing.=
 =A0I
> > =A0assumed "not".
> =

> That's correct. =A0I'm also not even 100% sure that this is the best
> approach. =A0I'm waiting/hoping for feedback from David.

You'll get some.  Unlike your other patch, this one wasn't
obvious and required me to burn a few grey cells ... ones
which have been otherwise occupied.  ;)

- dave


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft =

Defy all challenges. Microsoft(R) Visual Studio 2008. =

http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
