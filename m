From: "Jason Hanna" <jason.m.hanna.at.coincident-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3] spi: Add PPC4xx SPI driver
Date: Thu, 30 Oct 2008 19:24:43 -0400
Message-ID: <8f9e78f00810301624k5925a52ah924960f869388233@mail.gmail.com>
References: <1225000124-29366-1-git-send-email-sr@denx.de>
	<20081029145305.GA3676@yoda.jdub.homelinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>,
	linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org
To: "Josh Boyer" <jwboyer-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20081029145305.GA3676-JVa43G0qJ78RlTYtMZUE4cJ8OCA1ciLf@public.gmane.org>
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

On Wed, Oct 29, 2008 at 10:53 AM, Josh Boyer <jwboyer-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org> wrote:

> Also, do you have a patch for a DTS file that gives an example of how to
> instantiate the SPI stuff in the device tree?

I'll second that request. I've updated the device tree for my Kilauea
(405EX) board but am not sure I have everything correct.

Also, any pointers to sample/test code incorporating a spi protocol
driver would be incredibly helpful. I'm very new to device driver
programming and don't really know what I'm doing yet. I seem to be
getting the spi_ppc4xx and spi_bitbang modules loaded, but am unsure
how to verify proper initialization and what next steps I need to
follow in order to develop and associate a protocol driver.

I'd like to start quite simply - some test routines that would drive
data over the SPI connector on my Kilauea, using a spare GPIO pin as a
chip select. I've got a logic analyzer from which to verify the
results.

I've been reading through all the documentation I can find but am a
little stuck. A concrete example with a SPI protocol driver would be
quite useful.

Thanks,
-jmh

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
