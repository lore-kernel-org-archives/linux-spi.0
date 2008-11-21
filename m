From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH v3] spi: Add PPC4xx SPI driver
Date: Thu, 20 Nov 2008 19:17:37 -0800
Message-ID: <200811201917.38148.david-b@pacbell.net>
References: <1225000124-29366-1-git-send-email-sr@denx.de>
	<20081029145305.GA3676@yoda.jdub.homelinux.org>
	<8f9e78f00810301624k5925a52ah924960f869388233@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>,
	Josh Boyer <jwboyer-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org
To: "Jason Hanna" <jason.m.hanna.at.coincident-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <8f9e78f00810301624k5925a52ah924960f869388233-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thursday 30 October 2008, Jason Hanna wrote:
> Also, any pointers to sample/test code incorporating a spi protocol
> driver would be incredibly helpful.

Look at Documentation/spi/*.c ... for user mode code
hooking up through "spidev".


> I'm very new to device driver 
> programming and don't really know what I'm doing yet. I seem to be
> getting the spi_ppc4xx and spi_bitbang modules loaded, but am unsure
> how to verify proper initialization and what next steps I need to
> follow in order to develop and associate a protocol driver.

Documentation/spi/spi-summary should help.
And sticking a 'scope on the outputs (as you
said you plan) is a decent place to start,
if you don't have something to talk to yet.

- dave

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
