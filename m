From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: i.MX: GPIO based SPI chip selects question
Date: Sat, 29 Oct 2011 13:51:02 +0200
Message-ID: <20111029115102.GC22592@ponder.secretlab.ca>
References: <CAN=k24kKWd9TPDbkWTCOSn48FNOi9DUALGd9XmeQ_xOJ=Kxd9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Wayne Tams <wayne.tams-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAN=k24kKWd9TPDbkWTCOSn48FNOi9DUALGd9XmeQ_xOJ=Kxd9g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Fri, Oct 28, 2011 at 02:06:16PM +0100, Wayne Tams wrote:
> Hi,
> 
> Can I use GPIO pins on my i.mx53 for SPI chip select, I have found little
> on the web that can help me, I am hoping that it is straight-forward enough
> for me to implement it? Perhaps there is a macro that I can use in the
> spi_board_info structure that will let me declare the GPIO?

Yes, you can, but you may need to modify the spi driver to twiddle
gpios between transfers.  Not all drivers have it implemented.

Bonus points if you create a generic gpio ss handling hook that all
the spi drivers can use.

g.

> 
> If it is not possible, could anyone offer a suggestion on a solution for
> adding more chips selects, perhaps there is another platform out there that
> implements this sort of GPIO functionality?
> 
> Many thanks
> 
> Wayne
> ------------------------------------------------------------------------------
> The demand for IT networking professionals continues to grow, and the
> demand for specialized networking skills is growing even more rapidly.
> Take a complimentary Learning@Cisco Self-Assessment and learn 
> about Cisco certifications, training, and career opportunities. 
> http://p.sf.net/sfu/cisco-dev2dev
> _______________________________________________
> spi-devel-general mailing list
> spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/spi-devel-general

------------------------------------------------------------------------------
Get your Android app more play: Bring it to the BlackBerry PlayBook 
in minutes. BlackBerry App World&#153; now supports Android&#153; Apps 
for the BlackBerry&reg; PlayBook&#153;. Discover just how easy and simple 
it is! http://p.sf.net/sfu/android-dev2dev
